     /*-                                                                            +
      * Copyright (c) 2004 Scott C. Klement                                         +
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
      /if defined(SENDMAIL_H)
      /eof
      /endif
      /define SENDMAIL_H

     D QtmmSendMail    PR                  ExtProc('QtmmSendMail')
     D   FileName                   255A   const options(*varsize)
     D   FileNameLen                 10I 0 const
     D   MsgFrom                    256A   const options(*varsize)
     D   MsgFromLen                  10I 0 const
     D   RecipBuf                          likeds(ADDTO0100)
     D                                     dim(32767)
     D                                     options(*varsize)
     D   NumRecips                   10I 0 const
     D   ErrorCode                 8000A   options(*varsize)

     D ADDTO0100       ds                  qualified
     D                                     based(Template)
     D   NextOffset                  10I 0
     D   AddrLen                     10I 0
     D   AddrFormat                   8A
     D   DistType                    10I 0
     D   Reserved                    10I 0
     D   SmtpAddr                   256A

     D ADDR_NORMAL     C                   CONST(0)
     D ADDR_CC         C                   CONST(1)
     D ADDR_BCC        C                   CONST(2)
