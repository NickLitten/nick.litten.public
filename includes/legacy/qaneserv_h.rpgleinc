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
      /if defined(QANESERV_H_DEFINED)
      /eof
      /endif
      /define QANESERV_H_DEFINED

     D Qane_SVRS0100_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   Struct_Len                  10I 0
     D   CmdParm_Off                 10I 0
     D   CmdParm_Len                 10I 0
     D   AppDta_Off                  10I 0
     D   AppDta_Len                  10I 0
     D   Cmd_Type                    10I 0
     D   Exit_Pgm                    10A
     D   Exit_Lib                    10A
     D   tgt_rls                      8A
     D   SR_Parms                 27715A
     D   App_Dta                   5000A

     D Qane_SRST0100_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   Bytes_Ret                   10I 0
     D   Bytes_Avl                   10I 0
     D   Trans_Time                  10I 0
     D   Blck_Size                   10I 0
     D   Blck_Mult                   10I 0
     D   Last_BlckSiz                10I 0
     D   Usrsp_Lib                   10A

     D QaneSava        pr                  extproc('QaneSava')
     D   UsrSpc                      20A   const
     D   UsrSpcFmt                    8A   const
     D   StatusFmt                    8A   const
     D   Status                            like(Qane_SrSt0100_t)
     D   StatusLen                   10I 0 const
     D   ErrorCode                32767A   options(*varsize)

     D QaneRsta        pr                  extproc('QaneRsta')
     D   UsrSpc                      20A   const
     D   UsrSpcFmt                    8A   const
     D   StatusFmt                    8A   const
     D   Status                            like(Qane_SrSt0100_t)
     D   StatusLen                   10I 0 const
     D   ErrorCode                32767A   options(*varsize)

     D QANE_SAV        C                   1
     D QANE_SAVOBJ     C                   2
     D QANE_SAVDLO     C                   3
     D QANE_SAVLIB     C                   4
     D QANE_SAVCHGOBJ  C                   5
     D QANE_QSRSAVE    C                   6

     D QANE_START      C                   1
     D QANE_XFER       C                   2
     D QANE_END        C                   3
     D QANE_ABEND      C                   4

     D QANE_GOOD       C                   0
     D QANE_ERROR      C                   1
