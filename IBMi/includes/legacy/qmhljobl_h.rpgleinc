     /*-                                                                            +
      * Copyright (c) 2006 Scott C. Klement                                         +
      * All rights reserved.                                                        +
      *                                                                             +
      * Redistribution and use in source and binary forms, with or without          +
      * modification, are permitted provided that the following conditions          +
      * are met:                                                                    +
      * 1. Redistributions of source code must retain the above copyright           +
      *    notice, this list of conditions and the following disclaimer.            +
      * 2. Redistributions in binary form must reproduce the above copyright        +
      *    notice, this list of conditions and the following disclaimer in the      +
      *    documentation and/or other materials provided with the distribution.     +
      *                                                                             +
      * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND      +
      * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE       +
      * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  +
      * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE     +
      * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL  +
      * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS     +
      * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)       +
      * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT  +
      * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY   +
      * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF      +
      * SUCH DAMAGE.                                                                +
      *                                                                             +
      */                                                                            +
      /if defined(QMHLJOBL_H_DEFINED)
      /eof
      /endif
      /define QMHLJOBL_H_DEFINED

     D QMHLJOBL        PR                  ExtPgm('QMHLJOBL')
     D   UsrSpc                      20A   const
     D   Format                       8A   const
     D   MsgSel                   32767A   const options(*varsize)
     D   MsgSelSize                  10i 0 const
     D   SelFormat                    8a   const
     D   ErrorCode                32767A   const

     D QMHLJOBL_QualJob_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   Name                        10a
     D   User                        10a
     D   Nbr                          6a

     D JSLT0100_t      ds                  qualified
     D                                     based(Template)
     D   MaxMsgs                     10i 0
     D   Dir                         10a
     D   job                               likeds(QMHLJOBL_QualJob_t)
     D   IntJobId                    16a
     D   StrMsgKey                    4a
     D   MaxMsgLen                   10i 0
     D   MaxMsgHlp                   10i 0
     D   FieldIdOff                  10i 0
     D   FieldCount                  10i 0
     D   MsgQOff                     10i 0
     D   MsgQLen                     10i 0
     D   RtnFld                      10i 0 dim(50)
     D   MsgQName                  4096a

     D QMHLJOBL_Header_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   UsrSpc                      20a
     D   StrMsgKey                    4a
     D   EndMsgKey                    4a
     D   QualJob                           likeds(QMHLJOBL_QualJob_t)
     D                                2a
     D   CCSID                       10i 0

     D LJOB0100_t      ds                  based(Template)
     D                                     qualified
     D   next                        10i 0
     D   fldOffset                   10i 0
     D   fldCount                    10i 0
     D   msgSev                      10i 0
     D   msgId                        7a
     D   msgType                      2a
     D   msgKey                       4a
     D   msgFile                     10a
     D   msgFileLib                  10a
     D   dateSent                     7a
     D   timeSent                     6a
     D   microsec                     6a

     D LJOB0100_field_t...
     D                 ds                  based(Template)
     D                                     qualified
     D   next                        10i 0
     D   size                        10i 0
     D   id                          10i 0
     D   type                         1a
     D   status                       1a
     D                               14a
     D   len                         10i 0
     D   data                     32767a
