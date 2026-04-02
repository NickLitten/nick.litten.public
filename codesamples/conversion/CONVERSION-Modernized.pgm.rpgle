**free
// ------------------------------------------------------------------------------
// Program: CONVERSION
// Description: Convert EBCDIC data to ASCII data (80-byte records)
// Author: Nick Litten
// Created: 2026-03-25
// ------------------------------------------------------------------------------

ctl-opt dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt);

// File Declarations
dcl-f filein disk(*ext) usage(*input) keyed;
dcl-f fileout disk(*ext) usage(*output);

dcl-c RECORD_LENGTH 80;
dcl-c TRANSLATION_TABLE 'QTCPASC';

// Global Variables
dcl-s recordData char(RECORD_LENGTH);
dcl-s outputData char(RECORD_LENGTH);
dcl-s endOfFile ind inz(*off);
dcl-s recordsProcessed packed(9:0) inz(0);

// Prototypes
dcl-pr Translate extpgm('QDCXLATE');
  length packed(5:0) const;
  data char(32766) options(*varsize);
  table char(10) const;
end-pr;

// ------------------------------------------------------------------------------
// Main Processing Logic
// ------------------------------------------------------------------------------

// Read and process each record until end of file
read filein;
dow not %eof(filein);
  convertAndWriteRecord();
  recordsProcessed += 1;
  read filein;
enddo;

// Normal termination
*inlr = *on;
return;


// ------------------------------------------------------------------------------
// Convert single record from EBCDIC to ASCII and write to output
// ------------------------------------------------------------------------------
dcl-proc convertAndWriteRecord;
  
  dcl-ds fileInRec extname('FILEIN') qualified end-ds;
  dcl-ds fileOutRec extname('FILEOUT') qualified end-ds;
  
  // Clear work areas
  recordData = *blanks;
  outputData = *blanks;
  
  // Get input record data
  recordData = fileInRec.record;
  
  // Perform EBCDIC to ASCII translation
  Translate(RECORD_LENGTH: recordData: TRANSLATION_TABLE);
  
  // Prepare output record
  outputData = recordData;
  fileOutRec.out = outputData;
  
  // Write converted record to output file
  write fileout fileOutRec;
  
end-proc;
