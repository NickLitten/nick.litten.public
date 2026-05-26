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
      /if defined(QTVAPI_H_DEFINED)
      /eof
      /endif
      /define QTVAPI_H_DEFINED

      *------------------------------------------------
      * Virtual Terminal Handle (used by all APIs)
      *------------------------------------------------
     D Qtv_Handle_t    s             16A   based(Template)

      *------------------------------------------------
      * Supported Terminal Types
      *------------------------------------------------
     D QTV_5251_11     c                   const(1)
     D QTV_5291_1      c                   const(2)
     D QTV_5292_2      c                   const(3)
     D QTV_5555_B01    c                   const(4)
     D QTV_3196_A1     c                   const(5)
     D QTV_3979_2      c                   const(6)
     D QTV_3180_2      c                   const(7)
     D QTV_3477_FC     c                   const(8)
     D QTV_3477_FG     c                   const(9)
     D QTV_5555_C01    c                   const(10)
     D QTV_5555_G01    c                   const(11)
     D QTV_5555_G02    c                   const(12)
     D QTV_3486_BA     c                   const(13)
     D QTV_3487_HA     c                   const(14)
     D QTV_3487_HC     c                   const(15)


      *------------------------------------------------
      * Open Feedback Information (QtvOpnVT API)
      *------------------------------------------------
     D Qtv_OpnFdbk_t   ds                  qualified
     D                                     based(Template)
     D   BytesAvail                  10I 0
     D   BytesRtn                    10I 0
     D   Reason                      10I 0
     D   DevName                     10A
     D                                4A

      *------------------------------------------------
      * Session Initiation Info (QtvOpnVT API)
      *
      *   The "data" part is made up of variable-len
      *   Qtv_SessRec_t structures.
      *------------------------------------------------
     D Qtv_SessionInit_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   RecCount                    10I 0
     D   Data                     32763A

     D Qtv_SessRec_t   ds                  qualified
     D                                     based(Template)
     D   Key                         10I 0
     D   Len                         10I 0
     D   Data                       172A

     D Qtv_Auto_SignOn_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   Len                         10I 0
     D   pwCCSID                     10I 0
     D   pwOffset                    10I 0
     D   pwLen                       10I 0
     D   cSeed                        8A
     D   sSeed                        8A
     D   UsrPrf                      10A
     D                                2A
     D   Passphrase                 128A


      *------------------------------------------------
      * Data queue info used by QtvRdVt/QtvWrtVt
      *------------------------------------------------
     D Qtv_DtaRec_t    ds                  qualified
     D                                     based(Template)
     D   Type                        10A
     D   ID                           2A
     D   Handle                            like(Qtv_Handle_t)
     D   Reserved                    52A
     D   Key                        256A


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * QtvOpnVt():  Open Virtual Terminal
      *
      *       Handle = (output) Handle to new terminal instance
      *      KbdLang = (input) language of keyboard (blanks=default)
      *      CharSet = (input) character set (0=Default)
      *     CodePage = (input) code page (0=Default)
      *   WrkStnType = (input) Type/Model of workstation (see above)
      *     QualDtaQ = (input) qualified data queue to which async
      *                        notifications are sent.
      *       KeyVal = (input) Key to be used with data queue
      *    KeyValLen = (input) Length of KeyVal parm, or 0=No Key
      *    ErrorCode = (i/o)   Standard API Error code structure
      *
      *  Optional Group 1:
      *     OpenInfo = (input) Whether PC text-assist is supported
      *                  '0' = Yes, '1' = No
      *
      *  Optional Group 2:
      *     SessInit = (input) Session initiation info.
      *
      *  Optional Group 3:
      *       OpnFbk = (i/o)   Open Feedback Information
      *    OpnFbkLen = (input) size of OpnFbk parameter
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D QtvOpnVt        PR                  extpgm('QTVOPNVT')
     D    Handle                           like(Qtv_Handle_t)
     D    KbdLang                     3A   const
     D    CharSet                    10I 0 const
     D    CodePage                   10I 0 const
     D    WrkStnType                 10I 0 const
     D    QualDtaQ                   20A   const
     D    KeyVal                  32767A   const options(*varsize)
     D    KeyValLen                  10I 0 const
     D    ErrorCode               32767A   const options(*varsize)
      * Opt Grp 1
     D    OpenInfo                   10A   const options(*nopass)
      * Opt Grp 2
     D    SessInit                         like(Qtv_SessionInit_t)
     D                                     const options(*nopass)
      * Opt Grp 3
     D    OpnFbk                           like(Qtv_OpnFdBk_t)
     D                                     options(*nopass)
     D    OpnFbkLen                  10I 0 const options(*nopass)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * QtvRdVt(): Read Virtual Terminal
      *
      *     Handle = (input)  Session handle
      *   ReadInfo = (output) Info about the read operation performed
      *     Buffer = (output) data sent to terminal
      *    BufSize = (input)  %size() of Buffer variable
      *  BytesRead = (output) bytes placed in Buffer
      *  ErrorCode = (i/o)    standard API error code structure
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D QtvRdVt         PR                  extpgm('QTVRDVT')
     D    Handle                           like(Qtv_Handle_t) const
     D    ReadInfo                   10A
     D    Buffer                  32767A   options(*varsize)
     D    BufSize                    10I 0 const
     D    BytesRead                  10I 0
     D    ErrorCode               32767A   const options(*varsize)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * QtvCloVt(): Close Virtual Terminal
      *
      *     Handle = (input) Session handle
      *  ErrorCode = (i/o)   Standard API error code structure
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D QtvCloVt        PR                  extpgm('QTVCLOVT')
     D    Handle                           like(Qtv_Handle_t) const
     D    ErrorCode               32767A   const options(*varsize)
