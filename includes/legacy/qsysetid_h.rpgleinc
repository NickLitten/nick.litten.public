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
      /if defined(QSYSETID_H)
      /eof
      /endif
      /define QSYSETID_H

     D uid_t           s             10U 0 based(template)
     D gid_t           s             10U 0 based(template)

     D QSYSETID_NOCHANGE...
     D                 c                   const(4294967295)

     D qsysetuid       PR            10I 0 extproc('qsysetuid')
     D   uid                               like(uid_t) value

     D qsyseteuid      PR            10I 0 extproc('qsyseteuid')
     D   uid                               like(uid_t) value

     D qsysetreuid     PR            10I 0 extproc('qsysetreuid')
     D   ruid                              like(uid_t) value
     D   euid                              like(uid_t) value

     D qsysetgid       PR            10I 0 extproc('qsysetgid')
     D   gid                               like(gid_t) value

     D qsysetegid      PR            10I 0 extproc('qsysetegid')
     D   gid                               like(gid_t) value

     D qsysetregid     PR            10I 0 extproc('qsysetregid')
     D   rgid                              like(gid_t) value
     D   egid                              like(gid_t) value

     D qsygetgroups    PR            10I 0 extproc('qsygetgroups')
     D   gidsize                     10I 0 value
     D   grouplist                         like(gid_t)
     D                                     dim(32767)
     D                                     options(*varsize)

     D qsysetgroups    PR            10I 0 extproc('qsysetgroups')
     D   gidsize                     10I 0 value
     D   grouplist                         like(gid_t)
     D                                     dim(32767)
     D                                     const
     D                                     options(*varsize)
