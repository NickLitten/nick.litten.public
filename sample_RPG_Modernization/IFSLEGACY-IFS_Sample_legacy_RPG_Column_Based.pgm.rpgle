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

     c                   exsr      MakeFile
     c                   exsr      EditFile
     c                   exsr      ShowFile
     c                   eval      *inlr = *on


     C**************************************************************
     C* Write some text to a text file
     C**************************************************************
     CSR   MakeFile      begsr
     C*------------------------
     c                   eval      fd = open('/ifstest/ch5_file.txt':
     c                                  O_TRUNC+O_CREAT+O_WRONLY:
     c                                  S_IWUSR+S_IRUSR+S_IRGRP+S_IROTH)
     c                   if        fd < 0
     c                   callp     die('open(): ' + %str(strerror(errno)))
     c                   endif

     c                   eval      line = 'Dear Cousin,'
     c                   eval      len = %len(%trimr(line))
     c                   callp     writeline(fd: %addr(line): len)

     c                   eval      line = ' '
     c                   eval      len = 0
     c                   callp     writeline(fd: %addr(line): len)

     c                   eval      line = 'I love the way you make' +
     c                               ' cheese fondue.'
     c                   eval      len = %len(%trimr(line))
     c                   callp     writeline(fd: %addr(line): len)

     c                   eval      line = ' '
     c                   eval      len = 0
     c                   callp     writeline(fd: %addr(line): len)

     c                   eval      line = 'Thank you for being so cheesy!'
     c                   eval      len = %len(%trimr(line))
     c                   callp     writeline(fd: %addr(line): len)

     c                   eval      line = ' '
     c                   eval      len = 0
     c                   callp     writeline(fd: %addr(line): len)

     c                   eval      line = 'Sincerely,'
     c                   eval      len = %len(%trimr(line))
     c                   callp     writeline(fd: %addr(line): len)

     c                   eval      line = '     Richard M. Nixon'
     c                   eval      len = %len(%trimr(line))
     c                   callp     writeline(fd: %addr(line): len)

     c                   callp     close(fd)
     C*------------------------
     CSR                 endsr


     C**************************************************************
     C*  Call the OS/400 text editor, and let the user change the
     C*  text around.
     C**************************************************************
     CSR   EditFile      begsr
     C*------------------------
     c                   callp     cmd('EDTF STMF(''/ifstest/' +
     c                                           'ch5_file.txt'')': 200)
     C*------------------------
     CSR                 endsr


     C**************************************************************
     C*  Read file, line by line, and dsply what fits
     C*  (DSPLY has a lousy 52-byte max... blech)
     C**************************************************************
     CSR   ShowFile      begsr
     C*------------------------
     c                   eval      fd = open('/ifstest/ch5_file.txt':
     c                                  O_RDONLY)
     c                   if        fd < 0
     c                   callp     die('open(): ' + %str(strerror(errno)))
     c                   endif

     c                   dow       readline(fd: %addr(line): %size(line))>=0
     c                   eval      Msg = line
     c     Msg           dsply
     c                   enddo

     c                   callp     close(fd)

     c                   eval      Msg = 'Press ENTER to continue'
     c                   dsply                   Msg
     C*------------------------
     CSR                 endsr

      /DEFINE ERRNO_LOAD_PROCEDURE
      /include 'legacy/errno_h.rpgleinc'