**free

///
/// Program: FREERPG3 - Cozzi Converter Example
///
/// Description: Example of RPG code converted using Bob Cozzi's RPG IV to Free
///              converter tool. Shows the output from this popular automated
///              conversion tool with its characteristic patterns.
///
/// Purpose: Educational example demonstrating:
///   - Bob Cozzi's RPG IV to Free converter results
///   - Automated conversion tool output
///   - Converter-generated comments and patterns
///   - Comparison with other conversion tools
///
/// Features:
///   - Shows Cozzi converter output style
///   - Demonstrates "Calc Spec work field" comments
///   - Highlights automated conversion patterns
///   - Educational comparison tool
///
/// Return Codes:
///   - '1': Partner mismatch - returns actual partner found
///   - '2': Record not found
///   - '3': File empty
///
/// Reference:
/// https://www.nicklitten.com/course/visual-studio-code-extension-cozzi-rpg-iv-to-free/
///
/// Modification History:
///   V.000 1994-05-01 | Nick Litten | Initial creation
///   V.001 2007-05-25 | Nick Litten | Video RPG Upgrade Tour example
///   V.002 2014-03-10 | Nick Litten | Converted using Cozzi RPG IV to Free
///

ctl-opt copyright('FREERPG3 | V.002 | Cozzi Converter Example');

// --------------------------------------------------------------------------
// File Declarations
// --------------------------------------------------------------------------
/free
       dcl-f QTXTSRC rename('QTXTSRC':'RECTXT');

// Calc Spec work field
Dcl-S FILE char(10);
// Calc Spec work field
Dcl-S PART char(10);
// Calc Spec work field
Dcl-S IDF char(8);
// Calc Spec work field
Dcl-S RTN char(1);

Dcl-Ds DATA;
   RECORD char(92) pos(1);
   FLAG char(4) pos(1);
   FILEN char(10) pos(11);
   PARTN char(10) pos(26);
   IDFN char(8) pos(40);
end-ds;
/end-free
plist *ENTRY;
parm   FILE;
parm   PART;
parm   IDF;
parm   RTN;

// rtn=2 if record not found
RTN = '2';

// first time read - rtn=4 if file empty
read  QTXTSRC;
If *IN50        = '1';
   RTN = '3';
   goto  ENDPGM;
EndIf;

DOW (*IN50 = *OFF);
   RECORD = SRCDTA;

   // rtn=1 if partner mismatch - return partner found
   If FLAG = '/*@@';
      If FILE = FILEN;
         If PART <> PARTN;
            PART = PARTN;
            RTN = '1';
            goto  ENDPGM;
         EndIf;
      EndIf;
   EndIf;

   // read ahead
   read  QTXTSRC;
enddo;

// program exit point
tag ENDPGM;
*INLR = *ON;