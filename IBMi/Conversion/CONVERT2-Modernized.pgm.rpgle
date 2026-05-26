**free

///
/// Program: CONVERT2 - EBCDIC to ASCII Conversion (Modernized)
///
/// Description: Converts EBCDIC data to ASCII using the QDCXLATE API.
///              Reads 80-byte fixed-length records from an input file and
///              writes converted ASCII records to an output file. This is
///              a modernized version of the original fixed-format program.
///
/// Purpose: Educational example demonstrating:
///   - Modern free-format RPG syntax
///   - File processing with keyed input files
///   - QDCXLATE API for character conversion
///   - DO-WHILE loop for file processing
///   - Record counting and processing metrics
///
/// Features:
///   - Free-format RPG syntax
///   - Uses QDCXLATE API with QTCPASC translation table
///   - Processes 80-byte fixed-length records
///   - Tracks number of records processed
///   - Clean activation group management
///
/// Usage: CALL CONVERT2
///        (Reads from FILEIN, writes to FILEOUT)
///
/// Parameters:
///   None
///
/// Dependencies:
///   - Input file: FILEIN (80-byte EBCDIC records)
///   - Output file: FILEOUT (80-byte ASCII records)
///   - QDCXLATE API (system program)
///
/// Reference:
///   https://www.ibm.com/docs/en/i/7.5?topic=ssw_ibm_i_75/apis/qdcxlate.html
///
/// Modification History:
///   1.0 2026-03-25 | Nick Litten | Initial modernized version
///


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