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
        copyright('| CONVERT3 V1.0 - ASCII-EBCDIC Conversion with CCSID') 
        dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt);

// File Declarations
dcl-f filein  usage(*input) usropn keyed;
dcl-f fileout usage(*output) usropn;

// Data Structures for file I/O
Dcl-Ds ds_filein likerec(rfilein:*input);
Dcl-Ds ds_fileout likerec(rfileout:*output);

Dcl-C RECORD_LENGTH 80;


// ------------------------------------------------------------------------------
/// @title Main Processing Logic
/// @description Main entry point for the conversion program. Opens input and
///              output files, reads EBCDIC records from FILEIN, converts each
///              record to ASCII using the convertAndWriteRecord procedure, and
///              writes the converted data to FILEOUT. Tracks the number of
///              records processed and ensures proper file closure on completion.
/// @return void
// ------------------------------------------------------------------------------
Dcl-Proc mainline;
   Dcl-Pi *n;
   end-pi;

   Dcl-S recordsProcessed packed(9:0) inz(0);

   open filein;
   open fileout;

   // Read and process each record until end of file
   read filein ds_filein;
   dow (not %eof(filein));
      convertAndWriteRecord(ds_filein.indata);
      recordsProcessed += 1;
      read filein ds_filein;
   enddo;

   // Normal termination
   close filein;
   close fileout;

   Return;

end-proc;

// ------------------------------------------------------------------------------
/// @title Convert and Write Record
/// @description Converts a single 80-byte EBCDIC record to ASCII format using
///              CCSID-based automatic character set conversion. The procedure
///              accepts EBCDIC data, assigns it to a CCSID 37 variable, then
///              assigns to a CCSID 819 variable (triggering automatic conversion),
///              and writes the converted ASCII data to the output file.
/// @param p_data char(80) - Input EBCDIC data to be converted
/// @return void
// ------------------------------------------------------------------------------
Dcl-Proc convertAndWriteRecord;
   Dcl-Pi *n;
      p_data char(RECORD_LENGTH);
   end-pi;

   Dcl-C EBCDIC_CCSID 37;    // EBCDIC US/Canada
   Dcl-S ebcdicData char(RECORD_LENGTH) ccsid(EBCDIC_CCSID);

   Dcl-C ASCII_CCSID 819;    // ISO 8859-1 (Latin-1)
   Dcl-S asciiData char(RECORD_LENGTH) ccsid(ASCII_CCSID);
  
   // Get input record data (EBCDIC)
   ebcdicData = p_data;
  
   // Automatic conversion happens via CCSID assignment
   asciiData = ebcdicData;
  
   // Prepare and write output record
   ds_fileout.outdata = asciiData;
   
   write rfileout ds_fileout;
  
end-proc;

