**free

///
/// Program: FREERPG2 - ARCAD Converter Example
///
/// Description: Example of RPG code converted using ARCAD RPG Transformer tool.
///              Shows the output from automated conversion tools with mixed
///              /free and fixed format code.
///
/// Purpose: Educational example demonstrating:
///   - ARCAD RPG Transformer conversion results
///   - Mixed /free and fixed format code
///   - Automated conversion tool limitations
///   - What still needs manual cleanup after conversion
///
/// Features:
///   - Shows ARCAD converter output
///   - Demonstrates partial conversion
///   - Highlights areas needing manual intervention
///   - Educational comparison with other converters
///
/// Return Codes:
///   - '1': Partner mismatch - returns actual partner found
///   - '2': Record not found
///   - '3': File empty
///
/// Reference:
/// https://www.nicklitten.com/course/visual-studio-code-extension-arcad-rpg-transformer/
///
/// Modification History:
///   V.000 1994-05-01 | Nick Litten | Initial creation
///   V.001 2014-03-10 | Nick Litten | Converted using ARCAD RPG Transformer
///   V.002 2007-05-25 | Nick Litten | Video RPG Upgrade Tour example
///

ctl-opt copyright('FREERPG2 | V.002 | ARCAD Converter Example');

// --------------------------------------------------------------------------
// File Declarations
// --------------------------------------------------------------------------
/free
       dcl-f QTXTSRC rename('QTXTSRC':'RECTXT');

Dcl-Ds DATA;
   RECORD char(92) pos(1);
   FLAG char(4) pos(1);
   FILEN char(10) pos(11);
   PARTN char(10) pos(26);
   IDFN char(8) pos(40);
end-ds;
/end-free
     C     *ENTRY        Plist
     C                   Parm                    FILE             10
     C                   Parm                    PART             10
     C                   Parm                    IDF               8
     C                   Parm                    RTN               

      // rtn=2 if record not found
     C                   Movel     '2'           RTN               1

      // first time read - rtn=4 if file empty
     C                   Read      QTXTSRC                                50
     C                   If        *IN50        = '1'
     C                   Movel     '3'           RTN
     C                   Goto      ENDPGM
     C                   Endif

     C     *IN50         Doweq     *OFF
     C                   Movel     SRCDTA        RECORD

      // rtn=1 if partner mismatch - return partner found
     C                   If        FLAG = '/*@@' 
     C                   If        FILE = FILEN
     C                   If        PART <> PARTN
     C                   Movel     PARTN         PART
     C                   MOVEL     '1'           RTN
     C                   Goto      ENDPGM
     C                   Endif
     C                   Endif
     C                   Endif

      // read ahead
     C                   Read      QTXTSRC                                50
     C                   Enddo

      // program exit point
     C     ENDPGM        Tag
     C                   Eval      *INLR = *ON