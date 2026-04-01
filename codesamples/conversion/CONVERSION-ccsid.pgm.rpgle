**FREE
// Program: CONVERSION-CCSID
// Description: Convert EBCDIC data to ASCII data using CCSID (80-byte records)
// Author: Nick Litten
// Created: 2026-04-01
// Notes: Simplified version using CCSID instead of QDCXLATE API

ctl-opt dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt);

// File Declarations
dcl-f filein disk(*ext) usage(*input) keyed;
dcl-f fileout disk(*ext) usage(*output);

dcl-c RECORD_LENGTH 80;
dcl-c EBCDIC_CCSID 37;    // EBCDIC US/Canada
dcl-c ASCII_CCSID 819;    // ISO 8859-1 (Latin-1)

// Global Variables
dcl-s recordsProcessed packed(9:0) inz(0);

// Data structures with CCSID specifications
dcl-ds fileInRec extname('FILEIN') qualified end-ds;
dcl-ds fileOutRec extname('FILEOUT') qualified end-ds;

dcl-s ebcdicData char(RECORD_LENGTH) ccsid(EBCDIC_CCSID);
dcl-s asciiData char(RECORD_LENGTH) ccsid(ASCII_CCSID);

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


//------------------------------------------------------------------------------
// Convert single record from EBCDIC to ASCII and write to output
//------------------------------------------------------------------------------
dcl-proc convertAndWriteRecord;
  
  // Get input record data (EBCDIC)
  ebcdicData = fileInRec.record;
  
  // Automatic conversion happens via CCSID assignment
  asciiData = ebcdicData;
  
  // Prepare and write output record
  fileOutRec.out = asciiData;
  write fileout fileOutRec;
  
end-proc;