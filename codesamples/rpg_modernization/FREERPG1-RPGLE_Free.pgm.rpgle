       // author: nick litten
       // Submit file to remote system using CFT
       // rtn=1 if partner mismatch - return partner found
       // rtn=2 if record not found
       // rtn=3 if file empty
      // written  : may 1994                                          
      // modified :
      // 10.03.14 njl converted to free format RPG    
      // 25.05.07 njl played with as part of a Video RPG Upgrade Tour
      // https://www.nicklitten.com/course/visual-studio-code-extension-rpgle-free/
       dcl-f QTXTSRC;

       dcl-ds DATA;
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
       IF *IN50        = '1';
     C                   Movel     '3'           RTN
     C                   Goto      ENDPGM
       ENDIF;

       Dow *IN50 = *OFF;
     C                   Movel     SRCDTA        RECORD

         // rtn=1 if partner mismatch - return partner found
         IF FLAG = '/*@@';
           IF FILE = FILEN;
             IF PART <> PARTN;
     C                   Movel     PARTN         PART
     C                   MOVEL     '1'           RTN
     C                   Goto      ENDPGM
             ENDIF;
           ENDIF;
         ENDIF;

         // read ahead
         READ QTXTSRC ;
       *in50 = %eof();
       ENDDO;

       // program exit point
     C     ENDPGM        Tag
       *INLR = *ON;