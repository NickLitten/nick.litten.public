**free
/title Simple RPG program to write to the IFS using SQL

// ----------------------------------------------------------
//
// Service - WRITEIFS.RPGLE
//
// Function - Simple RPG program to write to the IFS using SQL
//
// COMPILE NOTES:
//
// Obviously change the source location to match yours:
//
// CRTSQLRPGI OBJ(NICKLITTEN/WRITEIFS)
// SRCSTMF('/home/nicklitten/source/writeifs.sqlrpgle')
// COMMIT(*NONE)
// OBJTYPE(*PGM)
// DBGVIEW(*SOURCE)
// CVTCCSID(*JOB)
//
// Modification History:
// 2020-06-31 V1.0 Created by Nick Litten
// ----------------------------------------------------------
ctl-opt
  main(WRITEIFS)
  option(*srcstmt:*nodebugio:*noshowcpy)
  /if defined(*CRTSQLRPGI)
    dftactgrp(*no) actgrp('NICKLITTEN')
  /endif
  copyright('WRITEIFS.SQLRPGLE: Version 1.0 June 2020');

dcl-proc WRITEIFS;
dcl-pi WRITEIFS end-pi;

// Status Message string for humans
dcl-s stsMsg char(50);

// IFS Location where the data will be written
dcl-s ifsFile varchar(255) inz('/home/nicklitten/myfile.txt');
dcl-s ifsData varchar(255);
dcl-s overwrite varchar(10) inz('REPLACE');

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
dou sqlCode <> 0;

 exec sql fetch c1 into :ifsData;

 Select;
  when sqlcode = 0;

    exec sql CALL QSYS2.IFS_WRITE
             (PATH_NAME =>:ifsFile,
              LINE => :ifsData,
              OVERWRITE => :overwrite,
              FILE_CCSID => 1208,
              END_OF_LINE => 'CRLF');

    // the first write is OVERWRITE to clear the file
    // but all others lets APPEND so we add new lines
    overwrite = 'APPEND';

    stsMsg = 'Completed normally - read next row';

  when sqlcode = 100;
    stsMsg = 'No data found';
    leave;

  when sqlcode > 0;
    stsMsg = 'Completed with warning';
    leave;

  when sqlcode < 0;
    stsMsg = 'Did not complete normally';
    leave;

 endsl;

enddo;

// close the cursor
exec sql close c1;

on-error ;
 dump(a);
 dsply ('*** WRITEIFS has failed!');
endmon ;

return;

end-proc;