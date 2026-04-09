**free

// ------------------------------------------------------------------------------
// Program: FREERPG5 - Submit file to remote system using CFT (SQL Version)
// Author: Nick Litten
// 
// Purpose: Search QTXTSRC for matching file/partner records using SQL
//
// Return Codes:
//   '0' = Success - Record found and partner matches
//   '1' = Partner mismatch - Returns actual partner found
//   '2' = Record not found
//   '3' = File empty (no records to process)
//   '9' = SQL error occurred
//
// History:
//   May 1994     - Original version
//   10.03.14 njl - Converted to free format RPG
//   25.05.07 njl - Video RPG upgrade tour
//   Apr 2026     - Fully modernized with SQL embedded
// 
// Reference: https://www.nicklitten.com/course/adventures-in-automatic-rpg-upgrade-with-vscode/
// ------------------------------------------------------------------------------

ctl-opt dftactgrp(*no) actgrp(*caller) option(*nodebugio:*srcstmt);

// Data structures for SQL result
dcl-ds sourceRecord qualified;
  flag char(4);
  fileName char(10);
  partnerName char(10);
  identifier char(8);
  fullRecord char(92);
end-ds;

// Constants for return codes
dcl-c RC_SUCCESS '0';
dcl-c RC_PARTNER_MISMATCH '1';
dcl-c RC_NOT_FOUND '2';
dcl-c RC_FILE_EMPTY '3';
dcl-c RC_SQL_ERROR '9';
dcl-c RECORD_FLAG '/*@@';

// Program parameters
dcl-pi *n;
  pFileName char(10);
  pPartnerName char(10);
  pIdentifier char(8);
  pReturnCode char(1);
end-pi;

// Local variables
dcl-s sqlState char(5);
dcl-s recordCount int(10);

// Main processing
main();

// ------------------------------------------------------------------------------
// Main procedure - SQL-based implementation
// ------------------------------------------------------------------------------
dcl-proc main;
  
  // Initialize return code to "not found"
  pReturnCode = RC_NOT_FOUND;
  
  // First, check if file has any records
  exec sql
    select count(*)
      into :recordCount
      from qtxtsrc;
  
  if sqlState <> '00000';
    pReturnCode = RC_SQL_ERROR;
    return;
  endif;
  
  if recordCount = 0;
    pReturnCode = RC_FILE_EMPTY;
    return;
  endif;
  
  // Search for matching record using SQL cursor for efficiency
  exec sql
    declare c1 cursor for
      select substr(srcdta, 1, 4) as flag,
             substr(srcdta, 11, 10) as fileName,
             substr(srcdta, 26, 10) as partnerName,
             substr(srcdta, 40, 8) as identifier,
             srcdta as fullRecord
        from qtxtsrc
       where substr(srcdta, 1, 4) = :RECORD_FLAG
         and substr(srcdta, 11, 10) = :pFileName
       order by srcdta
       fetch first 1 row only;
  
  exec sql
    open c1;
  
  if sqlState <> '00000';
    pReturnCode = RC_SQL_ERROR;
    return;
  endif;
  
  exec sql
    fetch c1 into :sourceRecord;
  
  // Check if record was found
  if sqlState = '02000';  // No data found
    pReturnCode = RC_NOT_FOUND;
    exec sql close c1;
    return;
  endif;
  
  if sqlState <> '00000';
    pReturnCode = RC_SQL_ERROR;
    exec sql close c1;
    return;
  endif;
  
  // Record found - check partner match
  if %trim(pPartnerName) <> %trim(sourceRecord.partnerName);
    // Partner mismatch - return actual partner found
    pPartnerName = sourceRecord.partnerName;
    pReturnCode = RC_PARTNER_MISMATCH;
  else;
    // Success - file and partner match
    pReturnCode = RC_SUCCESS;
  endif;
  
  exec sql
    close c1;
  
end-proc;