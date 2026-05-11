**free
// Program: CONVERT
// Description: Convert EBCDIC data to ASCII data using CCSID service program
// Author: Nick Litten
// Created: 2026-03-25
// Updated: 2026-03-26 - Rewritten to use CONVSRV service program

ctl-opt dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt) bnddir('CONVSRV');

// File Declarations
dcl-f filein  usage(*input)  usropn keyed;
dcl-f fileout usage(*output) usropn;

// Data Structures for file I/O
Dcl-Ds ds_filein likerec(rfilein:*input);
Dcl-Ds ds_fileout likerec(rfileout:*output);

// Constants
Dcl-C RECORD_LENGTH 80;

// Global Variables
Dcl-S recordsProcessed packed(9:0) inz(0);

// Main Processing Logic
open filein;
open fileout;

// Read and process each record until end of file
read filein ds_filein;
dow (not %eof(filein));
   convertAndWriteRecord();
   recordsProcessed += 1;
   read filein ds_filein;
enddo;

// Normal termination
close filein;
close fileout;

*inlr = *on;
Return;


// ------------------------------------------------------------------------------
/// Title Convert and Write Record
/// Description Converts a single 80-byte EBCDIC record to ASCII format using
///              the ConvertFixedEbcdicToAscii service program procedure. Reads
///              EBCDIC data from ds_filein, performs the conversion, stores the
///              result in ds_fileout, and writes the converted ASCII data to the
///              output file.
/// @return void
// ------------------------------------------------------------------------------
Dcl-Proc convertAndWriteRecord;
   Dcl-Pi *n;
   end-pi;

   // Prototype for Conversion Service Program
   dcl-pr ConvertFixedEbcdicToAscii char(32766);
      p_Data char(32766) const;
      dataLength int(10) const;
   end-pr;

   // Perform EBCDIC to ASCII conversion using service program
   ds_fileout.OUTDATA = ConvertFixedEbcdicToAscii(ds_filein.INDATA: RECORD_LENGTH);
  
   // Write converted record to output file
   write rfileout ds_fileout;
  
end-proc;
