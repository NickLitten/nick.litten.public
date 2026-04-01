     *********************************************************************
     **  convert ebcdic to ascii
     *********************************************************************

     Ffilein    if   f   80        disk
     Ffileout   o    f   80        disk

     D data            s             80a
     D out             s             80a

     D Translate       PR                  ExtPgm('QDCXLATE')
     D   Length                       5P 0 const
     D   Data                     32766A   options(*varsize)
     D   Table                       10A   const

     Ifilein    ns  98
     I                                  1   80  record

     C                   eval      *in97 = *off
     C     read          tag
     C                   read      filein                                 97
     C                   if        *in97 = *on
     C                   goto      end
     C                   endif
     C                   exsr      convrt
     C                   if        *in97 = *off
     C                   goto      read
     C                   endif
     C     end           tag
     C                   eval      *inlr = *on
     C     convrt        begsr
     C                   eval      data = *blanks
     C                   eval      out = *blanks
     C                   eval      data = record
     C                   callp     Translate(80: Data: 'QTCPASC')
     C                   eval      out = data
     C                   except    recout
     C                   endsr
     Ofileout   e            recout
     O                       out                 80