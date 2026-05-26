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
      /if defined(SHM_H_DEFINED)
      /eof
      /endif
      /define SHM_H_DEFINED

     D IPC_PRIVATE     C                   0
     D IPC_CREAT       C                   x'0200'
     D IPC_EXCL        C                   x'0400'
     D IPC_NOWAIT      C                   x'0800'
     D IPC_RMID        C                   0
     D IPC_SET         C                   1
     D IPC_STAT        C                   2

     D SHM_RDONLY      C                   x'001000'
     D SHM_RND         C                   x'002000'
     D SHM_DEST        C                   x'000400'
     D SHM_TS_NP       C                   x'010000'
     D SHM_RESIZE_NP   C                   x'040000'
     D SHM_MAP_FIXED_NP...
     D                 C                   x'100000'
     D SHM_SIZE        C                   6

     D shmat           pr              *   extproc('shmat')
     D    shmid                      10i 0 value
     D    shmaddr                      *   value
     D    shmflg                     10i 0 value

     D shmctl          pr            10i 0 extproc('shmctl')
     D    shmid                      10i 0 value
     D    cmd                        10i 0 value
     D    buf                              likeds(shmtablentry_t)
     D                                     options(*omit)

     D shmdt           pr            10i 0 extproc('shmdt')
     D    shmaddr                      *   value

      /if defined(TERASPACE)
     D shmget          pr            10i 0 extproc('qp0zShmgetTs')
      /else
     D shmget          pr            10i 0 extproc('shmget')
      /endif
     D    key                        10i 0 value
     D    size                       10u 0 value
     D    shmflg                     10i 0 value

     D ipc_perm_t      ds                  qualified
     D                                     based(Template)
     D   uid                         10u 0
     D   gid                         10u 0
     D   cuid                        10u 0
     D   cgid                        10u 0
     D   mode                        10u 0

     D shmtablentry_t  ds                  qualified
     D                                     based(Template)
     D   shm_perm                          likeds(ipc_perm_t)
     D   shm_segsz                   10u 0
     D   shm_lpid                    10i 0
     D   shm_cpid                    10i 0
     D   shm_nattch                  10i 0
     D   shm_atime                   10u 0
     D   shm_dtime                   10u 0
     D   shm_ctime                   10u 0
