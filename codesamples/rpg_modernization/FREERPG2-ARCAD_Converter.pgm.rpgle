      // author: nick litten                                       
      // Submit file to remote system using CFT
      // rtn=1 if partner mismatch - return partner found          
      // rtn=2 if record not found                                 
      // rtn=3 if file empty                                       
      // written  : may 1994                                          
      // modified :
      // 10.03.14 njl converted to free format RPG    
      // 25.05.07 njl played with as part of a Video RPG Upgrade Tour
      // https://www.nicklitten.com/course/visual-studio-code-extension-arcad-rpg-transformer/                                  
      /free
       dcl-f QTXTSRC;

       dcl-ds DATA;
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