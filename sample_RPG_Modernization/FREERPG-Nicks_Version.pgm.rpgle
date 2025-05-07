**free
// ----------------------------------------------------------
// author: nick litten
// Submit file to remote system using CFT
// rtn=1 if partner mismatch - return partner found
// rtn=2 if record not found
// rtn=3 if file empty
// ----------------------------------------------------------
// written  : may 1994
// modified : 2010.03.14 njl converted to free format RPG
// ----------------------------------------------------------

dcl-f QTXTSRC;

dcl-pi *n;
    file char(10);
    part char(10);
    idf  char(8);
    rtn  char(1);
end-pi;

dcl-ds DATA;
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

if %eof();
    RTN = '3';
else;
    dow not %eof(QTXTSRC);
        RECORD = SRCDTA;

        // rtn=1 if partner mismatch - return partner found
        if FLAG = '/*@@' and FILE = FILEN and PART <> PARTN;
            PART = PARTN;
            RTN = '1';
            leave;
        endif;

        // read ahead
        READ QTXTSRC;
    enddo;
endif;

// program exit point
*INLR = *ON;
