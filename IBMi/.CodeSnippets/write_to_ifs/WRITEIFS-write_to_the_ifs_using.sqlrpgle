**free

/// Program: WRITEIFS
/// Description: Write data to IFS using SQL IFS_WRITE service
///
/// Purpose:
/// - Demonstrate SQL cursor processing with IFS file operations
/// - Show proper use of QSYS2.IFS_WRITE stored procedure
/// - Illustrate REPLACE vs APPEND file writing strategies
/// - Example of SQL error handling with SQLCODE checking
///
/// Features:
/// - Uses SQL cursor to read database records
/// - Writes each record as a line to IFS file
/// - First write uses REPLACE to clear file, subsequent writes APPEND
/// - UTF-8 (CCSID 1208) output with CRLF line endings
/// - Comprehensive SQL error handling
/// - Monitor/on-error exception handling
///
/// Usage:
///   CALL WRITEIFS
///
/// Compile:
///   CRTSQLRPGI OBJ(NICKLITTEN/WRITEIFS) +
///     SRCSTMF('/home/nicklitten/source/writeifs.sqlrpgle') +
///     COMMIT(*NONE) OBJTYPE(*PGM) DBGVIEW(*SOURCE)
///
/// Author: Nick Litten
///
/// Modification History:
/// 2020-06-31 V1.0 Initial creation - Nick Litten
/// ---

ctl-opt
  main(WRITEIFS)
  option(*srcstmt:*nodebugio:*noshowcpy:*sqlcursorstay)
  /if defined(*CRTSQLRPGI)
    dftactgrp(*no) actgrp('NICKLITTEN')
  /endif
  copyright('V1.0 - Write data to IFS using SQL IFS_WRITE service');

Dcl-Proc WRITEIFS;
   Dcl-Pi WRITEIFS end-pi;

   // Status Message string for humans
   Dcl-S stsMsg char(50);

   // IFS Location where the data will be written
   Dcl-S ifsFile varchar(255) inz('/home/nicklitten/myfile.txt');
   Dcl-S ifsData varchar(255);
   Dcl-S overwrite varchar(10) inz('REPLACE');

   monitor;

      // Set SQL option, mainly to force cursor to close at endmodule
      exec sql
           set option naming = *sys,
           commit = *none,
           usrprf = *user,
           dynusrprf = *user,
           datfmt = *iso,
           closqlcsr = *endmod;

      exec sql
           declare c1 cursor for
           select MYDATA
           from MYFILE;

      exec sql open c1;

      // Keep reading until end of file (or an error occurs)
      dou (sqlCode <> 0);

         exec sql fetch c1 into :ifsData;

         Select;
            When (sqlcode = 0);

               exec sql CALL QSYS2.IFS_WRITE
                        (PATH_NAME =>:ifsFile,
                         LINE => :ifsData,
                         :OVERWRITE => :overwrite,
                         FILE_CCSID => 1208,
                         END_OF_LINE => 'CRLF');

               // the first write is OVERWRITE to clear the file
               // but all others lets APPEND so we add new lines
               overwrite = 'APPEND';

               stsMsg = 'Completed normally - read next row';

            When (sqlcode = 100);
               stsMsg = 'No data found';
               leave;

            When (sqlcode > 0);
               stsMsg = 'Completed with warning';
               leave;

            When (sqlcode < 0);
               stsMsg = 'Did not complete normally';
               leave;

         EndSl;

      enddo;

      // close the cursor
      exec sql close c1;

   on-error ;
      dump(a);
      dsply ('*** WRITEIFS has failed!');
   endmon ;

   Return;

end-proc;