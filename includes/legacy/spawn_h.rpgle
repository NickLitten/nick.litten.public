      /if defined(SPAWN_H)
      /eof
      /endif
      /define SPAWN_H

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


      * This source member contains all of the prototypes, data
      * structures and constants needed for calling the spawn() API.
      *
      *                                   Scott Klement, July 22, 2004
      *

      *-----------------------------------------------------------------
      *  Constants used by the spawn() API
      *-----------------------------------------------------------------
     D SPAWN_SETSIGMASK...
     D                 C                   2
     D SPAWN_SETSIGDEF...
     D                 C                   4
     D SPAWN_SETPGROUP...
     D                 C                   8
     D SPAWN_SETTHREAD_NP...
     D                 C                   16
     D SPAWN_SETPJ_NP...
     D                 C                   32
     D SPAWN_SETCOMPMSG_NP...
     D                 C                   64
     D SPAWN_SETJOBNAMEPARENT_NP...
     D                 C                   128
     D SPAWN_FDCLOSED...
     D                 C                   -1
     D SPAWN_NEWPGROUP...
     D                 C                   -1
     D SPAWN_MAX_NUM_ARGS...
     D                 C                   255

      /if defined(*V5R3M0)
     D SPAWN_SETJOBNAMEARGV_NP...
     D                 C                   x'0100'
     D SPAWN_SETLOGJOBMSGABN_NP...
     D                 C                   x'0200'
     D SPAWN_SETLOGJOBMSGNONE_NP...
     D                 C                   x'0400'
     D SPAWN_SETAFFINITYID_NP...
     D                 C                   x'0800'
     D SPAWN_SETTHREADRUNPTY_NP...
     D                 C                   x'1000'
      /endif

      *-----------------------------------------------------------------
      * Flag used for the "options" parameter of the waitpid() API.
      *-----------------------------------------------------------------
     D WNOHANG         C                   1

      *-----------------------------------------------------------------
      * The inheritance structure tells the spawn() API which attributes
      * should be inherited in the new job.
      *
      *  struct inheritance {
      *     flagset_t  flags;
      *     int        pgroup;
      *     sigset_t   sigmask;
      *     sigset_t   sigdefault;
      *  };
      *-----------------------------------------------------------------
     D flagset_t       S             10U 0 based(Template)
     D pid_t           S             10I 0 based(Template)
      /if not defined(SIGSET_T)
     D sigset_t        s             20U 0 based(Template)
      /define SIGSET_T
      /endif

     D inheritance_t   DS                  based(Template)
     D   flags                             like(flagset_t)
     D   pgroup                            like(pid_t)
     D   sigmask                           like(sigset_t)
     D   sigdefault                        like(sigset_t)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * spawn(): create a child process with inherited attributes
      *
      *     pid_t spawn( const char                *path,
      *                  const int                 fd_count,
      *                  const int                 fd_map[],
      *                  const struct inheritance  *inherit,
      *                  char * const              argv[],
      *                  char * const              envp[]);
      *
      * Returns the child's PID or -1 upon error
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D spawn           PR                  extproc('spawn') like(pid_t)
     D   path                          *   value options(*string)
     D   fd_count                    10I 0 value
     D   fd_map                      10I 0 dim(256) options(*varsize:*omit)
     D   inherit                           likeds(inheritance_t)
     D   argv                          *   dim(SPAWN_MAX_NUM_ARGS)
     D                                     options(*varsize)
     D   envp                          *   dim(256) options(*varsize)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * spawnp(): create a child process with inherited attributes,
      *           find the child process using a PATH.
      *
      *     pid_t spawnp( const char                *path,
      *                   const int                 fd_count,
      *                   const int                 fd_map[],
      *                   const struct inheritance  *inherit,
      *                   char * const              argv[],
      *                   char * const              envp[]);
      *
      * Returns the child's PID or -1 upon error
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D spawnp          PR                  extproc('spawnp') like(pid_t)
     D   path                          *   value options(*string)
     D   fd_count                    10I 0 value
     D   fd_map                      10I 0 dim(256) options(*varsize:*omit)
     D   inherit                           likeds(inheritance_t)
     D   argv                          *   dim(SPAWN_MAX_NUM_ARGS)
     D                                     options(*varsize)
     D   envp                          *   dim(256) options(*varsize)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * waitpid(): Wait for specific child process
      *
      *    pid_t waitpid(pid_t pid, int *stat_loc, int options)
      *
      *  This allows you to check the status of a spawned process, or
      *  wait for it to complete.
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D waitpid         PR                  extproc('waitpid') like(pid_t)
     D   pid                               like(pid_t) value
     D   stat_loc                    10I 0
     D   options                     10I 0 value

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *  pipe()--Create an Interprocess Channel
      *
      *  int pipe(int fildes[2]);
      *
      *  returns 0 if successful, -1 if there's an error (errno is set)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      /if not defined(PIPE_PROTOTYPE)
     d pipe            PR            10I 0 ExtProc('pipe')
     d   fildes                      10I 0 dim(2)
      /define PIPE_PROTOTYPE
      /endif

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *  Qp0zPipe()--Create an Interprocess Channel (with sockets)
      *
      *  Note: The difference between this and the pipe() API is that
      *        this uses sockets, and therefore establishes a
      *        bidirectional channel and can be accessed with the
      *        send() and recv() APIs.
      *
      *  int Qp0zPipe(int fildes[2]);
      *
      *  returns 0 if successful, -1 if there's an error (errno is set)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     d Qp0zPipe        PR            10I 0 ExtProc('Qp0zPipe')
     d   fildes                      10I 0 dim(2)
