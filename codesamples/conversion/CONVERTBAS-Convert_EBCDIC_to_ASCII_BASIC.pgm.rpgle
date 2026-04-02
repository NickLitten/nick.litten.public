**free
// Program: CONVERT
// Description: Convert EBCDIC data to ASCII data using CCSID service program
// Author: Nick Litten
// Created: 2026-03-25
// Updated: 2026-03-26 - Rewritten to use CONVSRV service program

ctl-opt dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt);

// File Declarations
dcl-f filein disk(*ext) usage(*input) keyed;
dcl-f fileout disk(*ext) usage(*output);

// Constants
dcl-c RECORD_LENGTH 80;

// Global Variables
dcl-s recordsProcessed packed(9:0) inz(0);

// Prototype for Conversion Service Program
dcl-pr ConvertFixedEbcdicToAscii char(32766) extproc(*cwiden:'ConvertFixedEbcdicToAscii')
  options(*varsize);
  inputData char(32766) const options(*varsize);
  dataLength int(10) const;
end-pr;

// Main Processing Logic
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
  
  dcl-s recordData char(RECORD_LENGTH);
  dcl-s outputData char(RECORD_LENGTH);
  
  // Clear work areas
  recordData = *blanks;
  outputData = *blanks;
  
  // Get input record data
  recordData = fileInRec.record;
  
  // Perform EBCDIC to ASCII conversion using service program
  outputData = ConvertFixedEbcdicToAscii(recordData: RECORD_LENGTH);
  
  // Prepare output record
  fileOutRec.out = outputData;
  
  // Write converted record to output file
  write fileout fileOutRec;
  
end-proc;
