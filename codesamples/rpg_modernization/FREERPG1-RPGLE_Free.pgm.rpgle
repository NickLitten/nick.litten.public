**free

///
/// Program: FREERPG1 - Submit File to Remote System using CFT (Partially Converted)
///
/// Description: Searches QTXTSRC source file for matching file and partner
///              records. This version shows a partial conversion from fixed
///              format to free format RPG, demonstrating the transition process.
///
/// Purpose: Educational example demonstrating:
///   - Partial RPG modernization (mixed fixed/free format)
///   - Legacy PLIST and PARM usage
///   - Indicator-based logic (*IN50)
///   - GOTO statements (legacy pattern)
///   - File processing with EOF handling
///
/// Features:
///   - Shows intermediate conversion stage
///   - Mixes free format declarations with fixed format logic
///   - Uses legacy C-specs for some operations
///   - Demonstrates what NOT to do in modern RPG
///
/// Return Codes:
///   - '1': Partner mismatch - returns actual partner found
///   - '2': Record not found
///   - '3': File empty
///
/// Usage: CALL FREERPG1 PARM(file partner idf rtn)
///
/// Parameters:
///   - FILE: char(10) - File name to search for
///   - PART: char(10) - Partner name to match
///   - IDF: char(8) - Identifier
///   - RTN: char(1) - Return code (output)
///
/// Reference:
/// https://www.nicklitten.com/course/visual-studio-code-extension-rpgle-free/
///
/// Modification History:
///   V.000 1994-05-01 | Nick Litten | Initial creation
///   V.001 2014-03-10 | Nick Litten | Partial conversion to free format RPG
///   V.002 2007-05-25 | Nick Litten | Video RPG Upgrade Tour example
///

ctl-opt copyright('FREERPG1 | V.002 | Partial Free Format Conversion Example');

// --------------------------------------------------------------------------
// File Declarations
// --------------------------------------------------------------------------

dcl-f QTXTSRC rename('QTXTSRC':'RECTXT');

Dcl-Ds DATA;
   RECORD char(92) pos(1);
   FLAG char(4) pos(1);
   FILEN char(10) pos(11);
   PARTN char(10) pos(26);
   IDFN char(8) pos(40);
end-ds;

     C     *ENTRY        Plist
     C                   Parm                    FILE             10
     C                   Parm                    PART             10
     C                   Parm                    IDF               8
     C                   Parm                    RTN               1
     
       // rtn=2 if record not found
     C                   Movel     '2'           RTN               1

       // first time read - rtn=4 if file empty
       READ QTXTSRC ;
*in50 = %eof();
If *IN50        = '1';
   C                   Movel     '3'           RTN
     C                   Goto      ENDPGM
       ENDIF;

   Dow (*IN50 = *OFF);
     C                   Movel     SRCDTA        RECORD

         // rtn=1 if partner mismatch - return partner found
         IF FLAG = '/*@@';
      If FILE = FILEN;
         If PART <> PARTN;
            C                   Movel     PARTN         PART
     C                   MOVEL     '1'           RTN
     C                   Goto      ENDPGM
             ENDIF;
         EndIf;
      EndIf;

      // read ahead
      READ QTXTSRC ;
      *in50 = %eof();
   ENDDO;

   // program exit point
   C     ENDPGM        Tag
       *INLR = *ON;