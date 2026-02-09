      // author: nick litten                                       
      // Submit file to remote system using CFT
      // rtn=1 if partner mismatch - return partner found          
      // rtn=2 if record not found                                 
      // rtn=3 if file empty                                       
      // written  : may 1994                                          
      // modified :
      // 10.03.14 njl converted to free format RPG    
      // 25.05.07 njl played with as part of a Video RPG Upgrade Tour
      // https://www.nicklitten.com/course/visual-studio-code-extension-cozzi-rpg-iv-to-free/
      /free
       dcl-f QTXTSRC;

          // Calc Spec work field
          dcl-s FILE char(10);
          // Calc Spec work field
          dcl-s PART char(10);
          // Calc Spec work field
          dcl-s IDF char(8);
          // Calc Spec work field
          dcl-s RTN char(1);

       dcl-ds DATA;
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
          if *IN50        = '1';
          RTN = '3';
          goto  ENDPGM;
          endif;

          DOW *IN50 = *OFF;
          RECORD = SRCDTA;

      // rtn=1 if partner mismatch - return partner found
          if FLAG = '/*@@';
          if FILE = FILEN;
          if PART <> PARTN;
          PART = PARTN;
          RTN = '1';
          goto  ENDPGM;
          endif;
          endif;
          endif;

      // read ahead
          read  QTXTSRC;
          enddo;

      // program exit point
          tag ENDPGM;
          *INLR = *ON;