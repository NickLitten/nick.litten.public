**free

/// Program: WRITEIFS2
/// Description: Write data to IFS using traditional C APIs (Pure RPGLE)
///
/// Purpose:
/// - Demonstrate IFS file operations using C APIs (open/write/close)
/// - Show proper file descriptor management
/// - Illustrate file creation with permissions and CCSID
/// - Example of error handling with errno checking
/// - Pure RPGLE approach without SQL
///
/// Features:
/// - Uses native RPG file I/O to read database records
/// - Opens IFS file with C open() API
/// - Writes each record using write() API
/// - Proper file descriptor cleanup
/// - UTF-8 (CCSID 1208) output with explicit line endings
/// - Comprehensive error handling with errno
/// - Monitor/on-error exception handling
///
/// Usage:
///   CALL WRITEIFS2
///
/// Compile:
///   CRTBNDRPG PGM(NICKLITTEN/WRITEIFS2) +
///     SRCSTMF('/home/nicklitten/source/writeifs2.rpgle') +
///     DBGVIEW(*SOURCE)
///
/// Author: Nick Litten
///
/// Modification History:
/// 2026-06-03 V1.0 Initial creation - Nick Litten
/// ---

ctl-opt
  main(WRITEIFS2)
  option(*srcstmt:*nodebugio:*noshowcpy)
  dftactgrp(*no) actgrp('NICKLITTEN')
  bnddir('QC2LE')
  copyright('V1.0 - Write data to IFS using traditional C APIs');

/INCLUDE '/modern/ifsio_h.rpgleinc'
/INCLUDE '/modern/errno_h.rpgleinc'

// Database file definition
Dcl-F MYFILE disk(*ext) usage(*input) keyed;

Dcl-Proc WRITEIFS2;
   Dcl-Pi WRITEIFS2 end-pi;

   // Status Message string for humans
   Dcl-S stsMsg char(50);

   // IFS Location where the data will be written
   Dcl-S ifsFile varchar(255) inz('/home/nicklitten/myfile2.txt');
   Dcl-S lineData varchar(257);  // Data + CRLF
   
   // File descriptor and operation variables
   Dcl-S fd int(10) inz(-1);
   Dcl-S flags int(10);
   Dcl-S mode uns(10);
   Dcl-S bytesWritten int(10);
   Dcl-S recordCount int(10) inz(0);

   monitor;

      // Open IFS file for writing
      // O_WRONLY = Write only
      // O_CREAT = Create if doesn't exist
      // O_TRUNC = Truncate to zero length if exists
      // O_CCSID = Use CCSID parameter
      flags = O_WRONLY + O_CREAT + O_TRUNC + O_CCSID;
      
      // Mode: Owner=RW, Group=R, Public=R (0644 in octal)
      mode = S_IRUSR + S_IWUSR + S_IRGRP + S_IROTH;
      
      // Open file with UTF-8 encoding
      fd = open(ifsFile: flags: mode: CP_UTF8);
      
      If (fd < 0);
         stsMsg = 'Failed to open IFS file';
         dsply stsMsg;
         dsply ('Error: ' + %char(errno()));
         Return;
      EndIf;

      // Read all records from database file
      read MYFILE;
      
      dow (not %eof(MYFILE));
         
         recordCount += 1;
         
         // Add CRLF line ending (Windows-style)
         lineData = %trim(MYDATA) + x'0D25';
         
         // Write data to IFS file
         bytesWritten = write(fd: %addr(lineData): %len(%trim(lineData)));
         
         If (bytesWritten < 0);
            stsMsg = 'Write failed';
            dsply stsMsg;
            dsply ('Error: ' + %char(errno()));
            leave;
         EndIf;
         
         // Read next record
         read MYFILE;
         
      enddo;
      
      // Close the IFS file
      If (fd >= 0);
         close(fd);
         fd = -1;
      EndIf;
      
      stsMsg = 'Wrote ' + %char(recordCount) + ' records';
      dsply stsMsg;

   on-error ;
      // Ensure file is closed on error
      If (fd >= 0);
         close(fd);
      EndIf;
      dump(a);
      dsply ('*** WRITEIFS2 has failed!');
   endmon ;

   Return;

end-proc;