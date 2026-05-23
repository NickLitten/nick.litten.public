**free

///
/// Program: FREERPG - Submit File to Remote System using CFT
///
/// Description: Searches QTXTSRC source file for matching file and partner
///              records, used for CFT (Cross File Transfer) operations to
///              remote systems.
///
/// Purpose: Educational example demonstrating:
///   - Legacy RPG modernization to free format
///   - File processing with EOF handling
///   - Return code patterns
///   - Data structure usage for record parsing
///
/// Features:
///   - Searches source file for specific file/partner combinations
///   - Returns different codes based on search results
///   - Handles empty files and missing records
///   - Partner mismatch detection
///
/// Return Codes:
///   - '1': Partner mismatch - returns actual partner found
///   - '2': Record not found
///   - '3': File empty
///
/// Usage: CALL FREERPG PARM(file partner idf rtn)
///
/// Parameters:
///   - file: char(10) - File name to search for
///   - part: char(10) - Partner name to match
///   - idf: char(8) - Identifier
///   - rtn: char(1) - Return code (output)
///
/// Reference:
/// https://www.nicklitten.com/course/forget-the-vscode-extensions-lets-upgrade-old-rpg-code-to-rpgle-manually/
///
/// Modification History:
///   V.000 1994-05-23 | Nick Litten | Initial creation
///   V.001 2007-10-03 | Nick Litten | Converted to free format RPG
///   V.002 2018-05-25 | Nick Litten | Video RPG Upgrade Tour example
///

ctl-opt copyright('FREERPG | V.002 | Submit File to Remote System using CFT');

// --------------------------------------------------------------------------
// File Declarations
// --------------------------------------------------------------------------

dcl-f QTXTSRC rename('QTXTSRC':'RECTXT');

Dcl-Pi *n;
   file char(10);
   part char(10);
   idf  char(8);
   rtn  char(1);
end-pi;

Dcl-Ds DATA;
   RECORD char(92) pos(1);
   FLAG   char(4)  pos(1);
   FILEN  char(10) pos(11);
   PARTN  char(10) pos(26);
   IDFN   char(8)  pos(40);
end-ds;

// rtn=2 if record not found
RTN = '2';

// first time read - rtn=3 if file empty
READ QTXTSRC;

If (%eof(QTXTSRC));
   RTN = '3';
Else;
   dow (not %eof(QTXTSRC));
      RECORD = SRCDTA;

      // rtn=1 if partner mismatch - return partner found
      If (FLAG = '/*@@' and FILE = FILEN and PART <> PARTN);
         PART = PARTN;
         RTN = '1';
         leave;
      EndIf;

      // read ahead
      READ QTXTSRC;
   enddo;
EndIf;

*INLR = *ON;
