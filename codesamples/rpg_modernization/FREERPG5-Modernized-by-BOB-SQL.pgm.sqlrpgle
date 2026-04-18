**free

///
/// Program: FREERPG5 - Submit File to Remote System using CFT (SQL Version)
///
/// Description: Searches QTXTSRC source file for matching file and partner
///              records using embedded SQL instead of native file I/O. This
///              version demonstrates SQL integration in RPG for file access.
///
/// Purpose: Educational example demonstrating:
///   - Embedded SQL in RPG for file access
///   - SQL cursor operations
///   - SQL error handling with SQLSTATE
///   - Modern SQL/RPG integration patterns
///   - Comparison with native file I/O approach
///
/// Features:
///   - Uses SQL SELECT instead of READ operations
///   - SQL cursor for record processing
///   - SQLSTATE checking for error handling
///   - Named constants for return codes
///   - Qualified data structures
///
/// Return Codes:
///   - '0': Success - Record found and partner matches
///   - '1': Partner mismatch - Returns actual partner found
///   - '2': Record not found
///   - '3': File empty (no records to process)
///   - '9': SQL error occurred
///
/// Usage: CALL FREERPG5 PARM(fileName partnerName identifier returnCode)
///
/// Parameters:
///   - pFileName: char(10) - File name to search for
///   - pPartnerName: char(10) - Partner name to match
///   - pIdentifier: char(8) - Identifier
///   - pReturnCode: char(1) - Return code (output)
///
/// Reference:
/// https://www.nicklitten.com/course/adventures-in-automatic-rpg-upgrade-with-vscode/
///
/// Modification History:
///   V.000 1994-05-01 | Nick Litten | Initial creation
///   V.001 2014-03-10 | Nick Litten | Converted to free format RPG
///   V.002 2007-05-25 | Nick Litten | Video RPG upgrade tour
///   V.003 2026-04-01 | Nick Litten | Fully modernized with embedded SQL
///

ctl-opt
  dftactgrp(*no)
  actgrp(*caller)
  option(*nodebugio:*srcstmt)
  copyright('FREERPG5 | V.003 | CFT File Submission with SQL')
  ;

// --------------------------------------------------------------------------
// Data Structures for SQL Result
// --------------------------------------------------------------------------
Dcl-Ds sourceRecord qualified;
   flag char(4);
   fileName char(10);
   partnerName char(10);
   identifier char(8);
   fullRecord char(92);
end-ds;

// Constants for return codes
Dcl-C RC_SUCCESS '0';
Dcl-C RC_PARTNER_MISMATCH '1';
Dcl-C RC_NOT_FOUND '2';
Dcl-C RC_FILE_EMPTY '3';
Dcl-C RC_SQL_ERROR '9';
Dcl-C RECORD_FLAG '/*@@';

// Program parameters
Dcl-Pi *n;
   pFileName char(10);
   pPartnerName char(10);
   pIdentifier char(8);
   pReturnCode char(1);
end-pi;

// Local variables
Dcl-S sqlState char(5);
Dcl-S recordCount int(10);

// Main processing
main();

// ------------------------------------------------------------------------------
// Main procedure - SQL-based implementation
// ------------------------------------------------------------------------------
Dcl-Proc main;
  
   // Initialize return code to "not found"
   pReturnCode = RC_NOT_FOUND;
  
   // First, check if file has any records
   exec sql
    select count(*)
      into :recordCount
      from qtxtsrc;
  
   If (sqlState <> '00000');
      pReturnCode = RC_SQL_ERROR;
      Return;
   EndIf;
  
   If (recordCount = 0);
      pReturnCode = RC_FILE_EMPTY;
      Return;
   EndIf;
  
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
  
   If (sqlState <> '00000');
      pReturnCode = RC_SQL_ERROR;
      Return;
   EndIf;
  
   exec sql
    fetch c1 into :sourceRecord;
  
   // Check if record was found
   If (sqlState = '02000');  // No data found
      pReturnCode = RC_NOT_FOUND;
      exec sql close c1;
      Return;
   EndIf;
  
   If (sqlState <> '00000');
      pReturnCode = RC_SQL_ERROR;
      exec sql close c1;
      Return;
   EndIf;
  
   // Record found - check partner match
   If (%trim(pPartnerName) <> %trim(sourceRecord.partnerName));
      // Partner mismatch - return actual partner found
      pPartnerName = sourceRecord.partnerName;
      pReturnCode = RC_PARTNER_MISMATCH;
   Else;
      // Success - file and partner match
      pReturnCode = RC_SUCCESS;
   EndIf;
  
   exec sql
    close c1;
  
end-proc;