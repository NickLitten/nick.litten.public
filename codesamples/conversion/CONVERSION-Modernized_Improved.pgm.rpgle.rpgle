**free

/// Program: CONVERSION - EBCDIC to ASCII Conversion (Modernized & Improved)
///
/// Description: Converts EBCDIC data to ASCII using CCSID specifications for
///              automatic character set conversion. Reads 80-byte records from
///              an input file and writes converted ASCII records to an output
///              file. This modernized version eliminates the need for the
///              QDCXLATE API by leveraging RPG's built-in CCSID support.
///
/// Purpose: Educational example demonstrating:
///   - Character set conversion using CCSID specifications
///   - Modern RPG file processing with USROPN
///   - Procedure-based program structure with MAIN
///   - Separation of concerns (main logic vs conversion logic)
///   - Automatic EBCDIC to ASCII conversion via variable assignment
///   - Clean resource management with file open/close
///
/// Features:
///   - Uses CCSID for automatic character conversion
///   - Processes 80-byte fixed-length records
///   - EBCDIC (CCSID 37) to ASCII (CCSID 819) conversion
///   - Modular design with separate conversion procedure
///   - Tracks number of records processed
///   - No external API calls required
///   - Simplified error handling
///
/// Usage: CALL CONVERSION
///        (Reads from FILEIN, writes to FILEOUT)
///
/// Parameters: None
///
/// Dependencies:
///   - Input file: FILEIN (80-byte EBCDIC records)
///   - Output file: FILEOUT (80-byte ASCII records)
///   - Both files must be defined with appropriate record formats
///
/// Control Options:
///   - main(mainline): Specifies main procedure entry point
///   - dftactgrp(*no): Required for procedures and modern RPG
///   - actgrp(*new): Creates new activation group per call
///   - option(*nodebugio): Disables debug I/O for performance
///   - option(*srcstmt): Includes source statements in debug view
///
/// Modification History:
/// 1.0 2026-04-01 | Nick Litten | Created simplified CCSID version
/// 1.1 2026-04-02 | Bob AI | Added comprehensive triple-slash documentation

ctl-opt main(mainline) 
        copyright('| C_IMPROV1 V1.0 - ASCII-EBCDIC Conversion with CCSID') 
        dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt);

// File Declarations
dcl-f filein disk(*ext) usage(*input) usropn keyed;
dcl-f fileout disk(*ext) usage(*output) usropn;

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

// ------------------------------------------------------------------------------
// Main Processing Logic
// ------------------------------------------------------------------------------
Dcl-Proc mainline;

open filein;
open fileout;

// Read and process each record until end of file
read filein;
dow not %eof(filein);
  convertAndWriteRecord();
  recordsProcessed += 1;
  read filein;
enddo;

// Normal termination
close filein;
close fileout;

return;

end-proc;

// ------------------------------------------------------------------------------
// Convert single record from EBCDIC to ASCII and write to output
// ------------------------------------------------------------------------------
dcl-proc convertAndWriteRecord;
  
  // Get input record data (EBCDIC)
  ebcdicData = fileInRec.record;
  
  // Automatic conversion happens via CCSID assignment
  asciiData = ebcdicData;
  
  // Prepare and write output record
  fileOutRec.out = asciiData;
  write fileout fileOutRec;
  
end-proc;
