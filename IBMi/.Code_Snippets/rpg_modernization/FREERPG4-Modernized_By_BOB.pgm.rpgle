**free

///
/// Program: FREERPG4 - Submit File to Remote System using CFT (Fully Modernized)
///
/// Description: Searches QTXTSRC source file for matching file and partner
///              records. This version demonstrates fully modernized RPG with
///              best practices including named constants, qualified data
///              structures, and proper error handling.
///
/// Purpose: Educational example demonstrating:
///   - Complete RPG modernization with best practices
///   - Named constants instead of magic values
///   - Qualified data structures
///   - Proper control options
///   - Clear return code patterns
///   - Modern file handling
///
/// Features:
///   - Uses named constants for all return codes
///   - Qualified data structure for record parsing
///   - Proper activation group management
///   - Clear, self-documenting code
///   - No indicators or GOTO statements
///
/// Return Codes:
///   - '0': Success - Record found and partner matches
///   - '1': Partner mismatch - Returns actual partner found
///   - '2': Record not found
///   - '3': File empty (no records to process)
///
/// Usage: CALL FREERPG4 PARM(fileName partnerName identifier returnCode)
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
///   V.001 2007-05-25 | Nick Litten | Video RPG upgrade tour
///   V.002 2014-03-10 | Nick Litten | Converted to free format RPG
///   V.003 2026-04-01 | Nick Litten | Fully modernized with best practices
///

ctl-opt
  dftactgrp(*no)
  actgrp(*caller)
  option(*nodebugio:*srcstmt)
  copyright('FREERPG4 | V.003 | Fully Modernized CFT File Submission')
  ;

// --------------------------------------------------------------------------
// File Declarations
// --------------------------------------------------------------------------
dcl-f qtxtsrc disk(*ext) usage(*input) keyed usropn;

// Data structures
Dcl-Ds sourceRecord qualified;
   fullRecord char(92) pos(1);
   flag char(4) pos(1);
   fileName char(10) pos(11);
   partnerName char(10) pos(26);
   identifier char(8) pos(40);
end-ds;

// Constants for return codes
Dcl-C RC_SUCCESS '0';
Dcl-C RC_PARTNER_MISMATCH '1';
Dcl-C RC_NOT_FOUND '2';
Dcl-C RC_FILE_EMPTY '3';
Dcl-C RECORD_FLAG '/*@@';

// Program parameters
Dcl-Pi *n;
   pFileName char(10);
   pPartnerName char(10);
   pIdentifier char(8);
   pReturnCode char(1);
end-pi;

// Local variables
Dcl-S endOfFile ind inz(*off);

// Main processing
main();

// ------------------------------------------------------------------------------
// Main procedure
// ------------------------------------------------------------------------------
Dcl-Proc main;
  
   // Initialize return code to "not found"
   pReturnCode = RC_NOT_FOUND;
  
   // Open file and check if empty
   open qtxtsrc;
  
   read qtxtsrc sourceRecord;
   If (%eof(qtxtsrc));
      pReturnCode = RC_FILE_EMPTY;
      close qtxtsrc;
      Return;
   EndIf;
  
   // Process records until match found or end of file
   dow (not %eof(qtxtsrc));
    
      // Check if this is a control record with matching file
      If (sourceRecord.flag = RECORD_FLAG 
       and sourceRecord.fileName = pFileName);
      
         // Check if partner matches
         If (pPartnerName <> sourceRecord.partnerName);
            // Partner mismatch - return actual partner found
            pPartnerName = sourceRecord.partnerName;
            pReturnCode = RC_PARTNER_MISMATCH;
            close qtxtsrc;
            Return;
         Else;
            // Success - file and partner match
            pReturnCode = RC_SUCCESS;
            close qtxtsrc;
            Return;
         EndIf;
      
      EndIf;
    
      // Read next record
      read qtxtsrc sourceRecord;
    
   enddo;
  
   // End of file reached without finding match
   close qtxtsrc;
  
end-proc;