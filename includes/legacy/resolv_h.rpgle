     /*-                                                                            +
      * Copyright (c) 2005 Scott C. Klement                                         +
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
     D res_search      pr            10I 0 extproc('res_search')
     D   domain                        *   value options(*string)
     D   class                       10I 0 value
     D   type                        10I 0 value
     D   answer                   32767A   options(*varsize)
     D   anslen                      10I 0 value

     D dn_expand       pr            10I 0 extproc('dn_expand')
     D   msgstr                        *   value
     D   msgend                        *   value
     D   comp_dn                       *   value
     D   exp_dn                        *   value
     D   exp_size                    10I 0 value

     D dn_skipname     pr            10I 0 extproc('dn_skipname')
     D   comp_dn                       *   value
     D   msgend                        *   value

     D NS_MAXDNAME     C                   const(256)
     D NS_PACKETSZ     C                   const(512)
     D NS_HFIXEDSZ     C                   const(12)
     D NS_QFIXEDSZ     C                   const(4)
     D NS_RRFIXEDSZ    C                   const(10)
     D NS_MAXCDNAME    C                   consT(255)
     D NS_MAXLABEL     c                   const(63)
     D NS_INDIR_MASK   c                   const(x'c0')
     D MAXDNSRCH       c                   const(6)
     D MAXNS           c                   const(3)
     D MAXRESOLVSORT   C                   const(10)

     D NS_HEADER       ds                  qualified
     D                                     based(Template)
     D   id                           5U 0
     D   flags                        5U 0
     D   qdcount                      5U 0
     D   ancount                      5U 0
     D   nscount                      5U 0
     D   arcount                      5U 0

     D res_state_t     ds                  qualified
     d                                     align
     d                                     based(Template)
     D   retrans                     10I 0
     D   retry                       10I 0
     D   options                     10I 0
     D   nscount                     10I 0
     D   nsaddr_list                 16A   dim(MAXNS)
     D   id                           5U 0
     D   defdname                   256A
     D   reserved0                    1A
     D   reserved1                   13A
     D   dnsrch                        *   dim(MAXDNSRCH)
     D   sort_list                    8A   dim(MAXRESOLVSORT)
     D   res_h_errno                 10I 0
     D   extended_error...
     D                               10I 0
     D   bits                         1A
     D   state_data                  27A
     D   internal_use                10I 0 dim(4)
     D   reserved                   444A

     D RES_AAONLY      C                   const(1)
     D RES_DEFNAMES    C                   const(2)
     D RES_DNSRCH      C                   const(4)
     D RES_IGNTC       C                   const(8)
     D RES_INIT        C                   const(16)
     D RES_RECURSE     C                   const(32)
     D RES_STAYOPEN    C                   const(64)
     D RES_USEVC       C                   const(128)
     D RES_XINIT       C                   const(256)
     D RES_INSECURE1   C                   const(512)
     D RES_INSECURE2   C                   const(1024)
     D RES_NOALIASES   C                   const(2048)
     D RES_ROTATE      C                   const(4096)
     D RES_NOCHECKNAME...
     D                 C                   const(8192)
     D RES_KEEPTSIG    C                   const(16384)
     D RES_NOCACHE     C                   const(32768)
     D RES_CP850       C                   const(1048576)
     D RES_RETRYTCP    C                   const(2097152)
     D RES_NSADDRONLY  C                   const(4194304)
     D RES_DEFAULT     C                   const(38)

     D res_ninit       pr            10I 0 extproc('res_ninit')
     D   res                               like(res_state_t)
     D res_nclose      pr                  extproc('res_nclose')
     D   res                               like(res_state_t)
     D res_nsearch     pr            10I 0 extproc('res_nsearch')
     D   res                               like(res_state_t)
     D   domain                        *   value options(*string)
     D   class                       10I 0 value
     D   type                        10I 0 value
     D   answer                   32767A   options(*varsize)
     D   anslen                      10I 0 value
