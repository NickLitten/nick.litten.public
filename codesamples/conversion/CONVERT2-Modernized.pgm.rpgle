**free
// ------------------------------------------------------------------------------
// Program: CONVERSION
// Description: Convert EBCDIC data to ASCII data (80-byte records)
// Author: Nick Litten
// Created: 2026-03-25
// ------------------------------------------------------------------------------

ctl-opt dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt);

// File Declarations
dcl-f filein  disk(*ext) usage(*input) keyed;
dcl-f fileout disk(*ext) usage(*output);

Dcl-C RECORD_LENGTH 80;
Dcl-C TRANSLATION_TABLE 'QTCPASC';

// Global Variables
Dcl-S recordsProcessed packed(9:0) inz(0);

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
dow (not %eof(filein));
   
   // Perform EBCDIC to ASCII translation
   Translate(RECORD_LENGTH: indata: TRANSLATION_TABLE);
  
   // Prepare output record
   outData = indata;
  
   // Write converted record to output file
   write rfileout;

   recordsProcessed += 1;
   
   read filein;
enddo;

// Normal termination
*inlr = *on;
Return;