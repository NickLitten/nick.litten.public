      // author: nick litten                                       
      // submit file to remote system using cft
      // rtn=1 if partner mismatch - return partner found          
      // rtn=2 if record not found                                 
      // rtn=3 if file empty                                       
      // written  : may 1994                                          
      // modified :
      // 10.03.14 njl converted to free format rpg    
      // 25.05.07 njl played with as part of a video rpg upgrade tour
      // https://www.nicklitten.com/course/adventures-in-automatic-rpg-upgrade-with-vscode/                                      
      /free
       dcl-f qtxtsrc;

       dcl-ds data;
        record char(92) pos(1);
        flag char(4) pos(1);
        filen char(10) pos(11);
        partn char(10) pos(26);
        idfn char(8) pos(40);
       end-ds;
      /end-free
     c     *entry        plist
     c                   parm                    file             10
     c                   parm                    part             10
     c                   parm                    idf               8
     c                   parm                    rtn               1

      // rtn=2 if record not found
     c                   movel     '2'           rtn               1

      // first time read - rtn=4 if file empty
     c                   read      qtxtsrc                                50
     c                   if        *in50        = '1'
     c                   movel     '3'           rtn
     c                   goto      endpgm
     c                   endif

     c     *in50         doweq     *off
     c                   movel     srcdta        record

      // rtn=1 if partner mismatch - return partner found
     c                   if        flag = '/*@@' 
     c                   if        file = filen
     c                   if        part <> partn
     c                   movel     partn         part
     c                   movel     '1'           rtn
     c                   goto      endpgm
     c                   endif
     c                   endif
     c                   endif

      // read ahead
     c                   read      qtxtsrc                                50
     c                   enddo

      // program exit point
     c     endpgm        tag
     c                   eval      *inlr = *on