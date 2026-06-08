**FREE

/// ----------------------------------------------------------------------------
/// Program: JSNIFSSQL1
/// Description: JSON_TABLE Decode JSON using SQL - Proof of Concept
/// ----------------------------------------------------------------------------
///
/// Purpose:
/// - Demonstrates reading JSON data from an IFS file
/// - Parsing JSON using SQL JSON_TABLE functions
/// - Loading JSON data into data structures for processing
///
/// Features:
/// - Uses IBM i IFS APIs (open, read, close) to load JSON file
/// - SQL JSON_TABLE function to parse JSON into relational format
/// - Cursor-based processing of JSON array elements
/// - Error handling for IFS file operations
///
/// Usage:
///   CALL JSNIFSSQL1
///
/// Compilation:
///   CRTSQLRPGI OBJ(NICKLITTEN/JSNIFSSQL1) SRCSTMF('path/to/file')
///              OBJTYPE(*MODULE) DBGVIEW(*SOURCE)
///
/// Author: Nick Litten
///
/// Modification History:
/// Date       Version  Author        Description
/// ---------- -------- ------------- ----------------------------------------
/// 2017-07-17 1.0      Nick Litten   Created
/// 2021-06-20 1.1      Nick Litten   Removed unused variables for clarity
/// 2026-06-08 1.2      Nick Litten   Applied comment standards
/// ----------------------------------------------------------------------------

ctl-opt dftactgrp(*no) actgrp('NICKLITTEN')
 option(*nodebugio:*srcstmt:*nounref:*sqlcursorstay)
 datfmt(*ISO) decedit('0.')
 copyright('1.2 - JSON_TABLE Decode JSON using SQL');

// ------------------------------------------------------
// Constants
// ------------------------------------------------------

// IFS file with JSON code that we will be reading and decoding
Dcl-C IFS const('/home/nicklitten/getwebjsn.json');

// ------------------------------------------------------
// Data Structures
// ------------------------------------------------------

Dcl-Ds jsonFields qualified;
   USERID varchar(100);
   FIRSTNAME varchar(100);
   LASTNAME varchar(100);
   INITIALS varchar(100);
   COMPANY int(10);
   DIVISION int(10);
   DEPARTMENT int(10);
end-ds;

Dcl-Ds result qualified;
   success ind;
   errmsg varchar(500);
   jsonArray likeds(jsonFields) dim(9999);
end-ds;

Dcl-Ds ErrorCode;
   BytesProv int(10) inz(0);
   BytesAvail int(10) inz(0);
end-ds;

// ------------------------------------------------------
// Prototypes - IBM i IFS APIs
// ------------------------------------------------------

dcl-pr open int(10) extproc('open');
   *n pointer value options(*string); // filename
   *n int(10) value; // openflags
   *n uns(10) value options(*nopass); // mode
   *n uns(10) value options(*nopass); // codepage
end-pr;

dcl-pr read int(10) extproc('read');
   *n int(10) value; // filehandle
   *n pointer value; // datareceived
   *n uns(10) value; // nbytes
end-pr;

dcl-pr close int(10) extproc('close');
   *n int(10) value; // filehandle
end-pr;

// ------------------------------------------------------
// Variables
// ------------------------------------------------------

Dcl-S Count int(10);
Dcl-S Handle int(10);
Dcl-S json sqltype(clob:16000000);
Dcl-S ifsData char(16000000);
Dcl-S ifsDataLen int(10);
Dcl-S rc int(10);
Dcl-S O_RDONLY int(10) inz(1);
Dcl-S O_TEXTDATA int(10) inz(16777216);
Dcl-S lineCounter int(10);

// ------------------------------------------------------
// Main Processing
// ------------------------------------------------------

// Open the stream file
Handle = open(%trim(IFS):O_RDONLY + O_TEXTDATA);

// Loop to read the stream file into variable "ifsData"
dou (ifsDataLen<1);
   Count += 1;
   ifsDataLen = read(Handle:%addr(ifsData):%size(ifsData));
enddo;

// Close the stream file
rc = close(Handle);

If (ifsData <> *blanks);

   // Load IFS data into SQL CLOB and process using JSON_TABLE
   exec sql
  set option naming = *sys,
  commit = *none,
  usrprf = *user,
  dynusrprf = *user,
  datfmt = *iso,
  closqlcsr = *endmod;
 
   exec sql
  declare c1 cursor for
  select *
  from json_table (:json, '$'
  columns (nested '$.users[*]' columns (userid varchar(100) path
  '$.userID', firstname varchar(100) path '$.firstName', lastname
  varchar(100) path '$.lastName', initials varchar(100) path
  '$.initials', company int path '$.company', division int path
  '$.division', department int path '$.department'))) as x;
 
   exec sql :open c1;
 
   exec sql fetch next from c1 into :jsonfields;
 
   dow (sqlstt='00000' or %subst(sqlstt:1:2)='01');
 
      lineCounter += 1;
  
      // Store Datastructure values in next element of 'return array'
      result.jsonArray(lineCounter) = jsonFields;
  
      // Fetch next row from cursor
      exec sql fetch next from c1 into :jsonfields;
 
   enddo;
 
   exec sql :close c1;
 
   result.success = *on;
 
Else;

   // If unable to load JSON data from the IFS then report error
   result.success = *off;
   result.errmsg = 'Unable to read IFS file';

EndIf;

*inlr = *on;