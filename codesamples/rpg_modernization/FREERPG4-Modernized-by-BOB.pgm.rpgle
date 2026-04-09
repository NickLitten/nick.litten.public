**free

// ------------------------------------------------------------------------------
// Program: FREERPG4 - Submit file to remote system using CFT
// Author: Nick Litten
// 
// Purpose: Search QTXTSRC for matching file/partner records
//
// Return Codes:
//   '0' = Success - Record found and partner matches
//   '1' = Partner mismatch - Returns actual partner found
//   '2' = Record not found
//   '3' = File empty (no records to process)
//
// History:
//   May 1994     - Original version
//   25.05.07 njl - Video RPG upgrade tour
//   10.03.14 njl - Converted to free format RPG
//   Apr 2026     - Fully modernized with best practices
// 
// Reference: https://www.nicklitten.com/course/adventures-in-automatic-rpg-upgrade-with-vscode/
// ------------------------------------------------------------------------------

ctl-opt dftactgrp(*no) actgrp(*caller) option(*nodebugio:*srcstmt);

// File declarations
dcl-f qtxtsrc disk(*ext) usage(*input) keyed usropn;

// Data structures
dcl-ds sourceRecord qualified;
  fullRecord char(92) pos(1);
  flag char(4) pos(1);
  fileName char(10) pos(11);
  partnerName char(10) pos(26);
  identifier char(8) pos(40);
end-ds;

// Constants for return codes
dcl-c RC_SUCCESS '0';
dcl-c RC_PARTNER_MISMATCH '1';
dcl-c RC_NOT_FOUND '2';
dcl-c RC_FILE_EMPTY '3';
dcl-c RECORD_FLAG '/*@@';

// Program parameters
dcl-pi *n;
  pFileName char(10);
  pPartnerName char(10);
  pIdentifier char(8);
  pReturnCode char(1);
end-pi;

// Local variables
dcl-s endOfFile ind inz(*off);

// Main processing
main();

// ------------------------------------------------------------------------------
// Main procedure
// ------------------------------------------------------------------------------
dcl-proc main;
  
  // Initialize return code to "not found"
  pReturnCode = RC_NOT_FOUND;
  
  // Open file and check if empty
  open qtxtsrc;
  
  read qtxtsrc sourceRecord;
  if %eof(qtxtsrc);
    pReturnCode = RC_FILE_EMPTY;
    close qtxtsrc;
    return;
  endif;
  
  // Process records until match found or end of file
  dow not %eof(qtxtsrc);
    
    // Check if this is a control record with matching file
    if sourceRecord.flag = RECORD_FLAG 
       and sourceRecord.fileName = pFileName;
      
      // Check if partner matches
      if pPartnerName <> sourceRecord.partnerName;
        // Partner mismatch - return actual partner found
        pPartnerName = sourceRecord.partnerName;
        pReturnCode = RC_PARTNER_MISMATCH;
        close qtxtsrc;
        return;
      else;
        // Success - file and partner match
        pReturnCode = RC_SUCCESS;
        close qtxtsrc;
        return;
      endif;
      
    endif;
    
    // Read next record
    read qtxtsrc sourceRecord;
    
  enddo;
  
  // End of file reached without finding match
  close qtxtsrc;
  
end-proc;