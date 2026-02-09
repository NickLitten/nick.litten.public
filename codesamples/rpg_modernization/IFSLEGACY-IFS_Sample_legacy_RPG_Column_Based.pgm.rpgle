      * CH5TEXT: Example of creating/reading a text file in the IFS
      *  (From Chap 5)
      *
      * To compile:
      *   CRTBNDRPG CH5TEXT SRCFILE(xxx/QRPGLESRC) DBGVIEW(*LIST)
      *
     H DFTACTGRP(*NO) ACTGRP(*NEW) BNDDIR('QC2LE') BNDDIR('IFSTEXT')

     D/include 'legacy/ifsio_h.rpgleinc'
     D/include 'legacy/errno_h.rpgleinc'
     D/include 'legacy/ifstext_h.rpgleinc'

     D Cmd             PR                  ExtPgm('QCMDEXC')
     D   command                    200A   const
     D   len                         15P 5 const

     D fd              S             10I 0
     D line            S            100A
     D len             S             10I 0
     D msg             S             52A

     C                   exsr      MakeFile
     C                   exsr      EditFile
     C                   exsr      ShowFile
     C                   eval      *inlr = *on


     C**************************************************************
     C* Write some text to a text file
     C**************************************************************
     CSR   MakeFile      begsr
     C*------------------------
     C                   eval      fd = open('/ifstest/ch5_file.txt':
     C                                  O_TRUNC+O_CREAT+O_WRONLY:
     C                                  S_IWUSR+S_IRUSR+S_IRGRP+S_IROTH)
     C                   if        fd < 0
     C                   callp     die('open(): ' + %str(strerror(errno)))
     C                   endif

     C                   eval      line = 'Dear Cousin,'
     C                   eval      len = %len(%trimr(line))
     C                   callp     writeline(fd: %addr(line): len)

     C                   eval      line = ' '
     C                   eval      len = 0
     C                   callp     writeline(fd: %addr(line): len)

     C                   eval      line = 'I love the way you make' +
     C                               ' cheese fondue.'
     C                   eval      len = %len(%trimr(line))
     C                   callp     writeline(fd: %addr(line): len)

     C                   eval      line = ' '
     C                   eval      len = 0
     C                   callp     writeline(fd: %addr(line): len)

     C                   eval      line = 'Thank you for being so cheesy!'
     C                   eval      len = %len(%trimr(line))
     C                   callp     writeline(fd: %addr(line): len)

     C                   eval      line = ' '
     C                   eval      len = 0
     C                   callp     writeline(fd: %addr(line): len)

     C                   eval      line = 'Sincerely,'
     C                   eval      len = %len(%trimr(line))
     C                   callp     writeline(fd: %addr(line): len)

     C                   eval      line = '     Richard M. Nixon'
     C                   eval      len = %len(%trimr(line))
     C                   callp     writeline(fd: %addr(line): len)

     C                   callp     close(fd)
     C*------------------------
     CSR                 endsr


     C**************************************************************
     C*  Call the OS/400 text editor, and let the user change the
     C*  text around.
     C**************************************************************
     CSR   EditFile      begsr
     C*------------------------
     C                   callp     cmd('EDTF STMF(''/ifstest/' +
     C                                           'ch5_file.txt'')': 200)
     C*------------------------
     CSR                 endsr


     C**************************************************************
     C*  Read file, line by line, and dsply what fits
     C*  (DSPLY has a lousy 52-byte max... blech)
     C**************************************************************
     CSR   ShowFile      begsr
     C*------------------------
     C                   eval      fd = open('/ifstest/ch5_file.txt':
     C                                  O_RDONLY)
     C                   if        fd < 0
     C                   callp     die('open(): ' + %str(strerror(errno)))
     C                   endif

     C                   dow       readline(fd: %addr(line): %size(line))>=0
     C                   eval      Msg = line
     C     Msg           dsply
     C                   enddo

     C                   callp     close(fd)

     C                   eval      Msg = 'Press ENTER to continue'
     C                   dsply                   Msg
     C*------------------------
     CSR                 endsr

      /DEFINE ERRNO_LOAD_PROCEDURE
      /include 'legacy/errno_h.rpgleinc'