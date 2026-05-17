**free

///
/// Program: CONVERT4 - EBCDIC to ASCII Conversion with Service Program
///
/// Description: Converts EBCDIC data to ASCII using the CONVSRV service program.
///              Reads 80-byte fixed-length records from an input file and writes
///              converted ASCII records to an output file. Demonstrates proper
///              service program integration and modular design patterns.
///
/// Purpose: Educational example demonstrating:
///   - Service program integration via BNDDIR
///   - Modular conversion using external procedures
///   - Modern file processing with USROPN
///   - Separation of concerns (main logic vs conversion)
///   - Clean resource management
///
/// Features:
///   - Uses CONVSRV service program for conversion
///   - Processes 80-byte fixed-length records
///   - Modular procedure-based design
///   - Tracks number of records processed
///   - Proper file open/close management
///
/// Usage: CALL CONVERT4
///        (Reads from FILEIN, writes to FILEOUT)
///
/// Parameters:
///   None
///
/// Dependencies:
///   - Input file: FILEIN (80-byte EBCDIC records)
///   - Output file: FILEOUT (80-byte ASCII records)
///   - Service program: CONVSRV (character conversion utilities)
///   - Binding directory: CONVSRV
///
/// Reference:
///   https://www.ibm.com/docs/en/i/7.5?topic=programs-service
///
/// Modification History:
///   1.0 2026-03-25 | Nick Litten | Initial creation
///   1.1 2026-03-26 | Nick Litten | Rewritten to use CONVSRV service program
///


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
