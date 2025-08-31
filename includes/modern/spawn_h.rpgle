        /if defined(SPAWN_H)
        /eof
        /endif
        /define SPAWN_H

          // -
          //  Copyright (c) 2004 Scott C. Klement
          //  All rights reserved.

          //  Redistribution and use in source and binary forms, with or without
          //  modification, are permitted provided that the following conditions
          //  are met:
          //  1. Redistributions of source code must retain the above copyright
          //     notice, this list of conditions and the following disclaimer.
          //  2. Redistributions in binary form must reproduce the above copyright
          //     notice, this list of conditions and the following disclaimer in the
          //     documentation and/or other materials provided with the distribution.

          //  THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
          //  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
          //  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPO
          //  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
          //  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTI
          //  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
          //  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
          //  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRI
          //  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WA
          //  OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
          //  SUCH DAMAGE.

          // /


          //  This source member contains all of the prototypes, data
          //  structures and constants needed for calling the spawn() API.

          //                                    Scott Klement, July 22, 2004


          // -----------------------------------------------------------------
          //   Constants used by the spawn() API
          // -----------------------------------------------------------------
         dcl-c SPAWN_SETSIGMASK 2;
         dcl-c SPAWN_SETSIGDEF 4;
         dcl-c SPAWN_SETPGROUP 8;
         dcl-c SPAWN_SETTHREAD_NP 16;
         dcl-c SPAWN_SETPJ_NP 32;
         dcl-c SPAWN_SETCOMPMSG_NP 64;
         dcl-c SPAWN_SETJOBNAMEPARENT_NP 128;
         dcl-c SPAWN_FDCLOSED -1;
         dcl-c SPAWN_NEWPGROUP -1;
         dcl-c SPAWN_MAX_NUM_ARGS 255;

        /if defined(*V5R3M0)
         dcl-c SPAWN_SETJOBNAMEARGV_NP x'0100';
         dcl-c SPAWN_SETLOGJOBMSGABN_NP x'0200';
         dcl-c SPAWN_SETLOGJOBMSGNONE_NP x'0400';
         dcl-c SPAWN_SETAFFINITYID_NP x'0800';
         dcl-c SPAWN_SETTHREADRUNPTY_NP x'1000';
        /endif

          // -----------------------------------------------------------------
          //  Flag used for the "options" parameter of the waitpid() API.
          // -----------------------------------------------------------------
         dcl-c WNOHANG 1;

          // -----------------------------------------------------------------
          //  The inheritance structure tells the spawn() API which attributes
          //  should be inherited in the new job.

          //   struct inheritance {
          //      flagset_t  flags;
          //      int        pgroup;
          //      sigset_t   sigmask;
          //      sigset_t   sigdefault;
          //   };
          // -----------------------------------------------------------------
         dcl-s flagset_t uns(10)  based(Template);
         dcl-s pid_t int(10)  based(Template);
        /if not defined(SIGSET_T)
         dcl-s sigset_t uns(20)  based(Template);
        /define SIGSET_T
        /endif

         dcl-ds inheritance_t INZ based(Template);
         flags  like(flagset_t);
         pgroup  like(pid_t);
         sigmask  like(sigset_t);
         sigdefault  like(sigset_t);
         end-ds inheritance_t;


          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //  spawn(): create a child process with inherited attributes

          //      pid_t spawn( const char                *path,
          //                   const int                 fd_count,
          //                   const int                 fd_map[],
          //                   const struct inheritance  *inherit,
          //                   char * const              argv[],
          //                   char * const              envp[]);

          //  Returns the child's PID or -1 upon error
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr spawn  extproc('spawn') like(pid_t);
         path pointer value options(*string);
         fd_count int(10) value;
         fd_map int(10) dim(256) options(*varsize:*omit);
         inherit  likeds(inheritance_t);
         argv pointer dim(SPAWN_MAX_NUM_ARGS) options(*varsize);
         envp pointer dim(256) options(*varsize);
         end-pr spawn;


          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //  spawnp(): create a child process with inherited attributes,
          //            find the child process using a PATH.

          //      pid_t spawnp( const char                *path,
          //                    const int                 fd_count,
          //                    const int                 fd_map[],
          //                    const struct inheritance  *inherit,
          //                    char * const              argv[],
          //                    char * const              envp[]);

          //  Returns the child's PID or -1 upon error
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr spawnp  extproc('spawnp') like(pid_t);
         path pointer value options(*string);
         fd_count int(10) value;
         fd_map int(10) dim(256) options(*varsize:*omit);
         inherit  likeds(inheritance_t);
         argv pointer dim(SPAWN_MAX_NUM_ARGS) options(*varsize);
         envp pointer dim(256) options(*varsize);
         end-pr spawnp;

          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //  waitpid(): Wait for specific child process

          //     pid_t waitpid(pid_t pid, int *stat_loc, int options)

          //   This allows you to check the status of a spawned process, or
          //   wait for it to complete.
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr waitpid  extproc('waitpid') like(pid_t);
         pid  like(pid_t) value;
         stat_loc int(10);
         options int(10) value;
         end-pr waitpid;

          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //   pipe()--Create an Interprocess Channel

          //   int pipe(int fildes[2]);

          //   returns 0 if successful, -1 if there's an error (errno is set)
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        /if not defined(PIPE_PROTOTYPE)
         dcl-pr pipe int(10) ExtProc('pipe');
         fildes int(10) dim(2);
         end-pr pipe;
        /define PIPE_PROTOTYPE
        /endif

          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //   Qp0zPipe()--Create an Interprocess Channel (with sockets)

          //   Note: The difference between this and the pipe() API is that
          //         this uses sockets, and therefore establishes a
          //         bidirectional channel and can be accessed with the
          //         send() and recv() APIs.

          //   int Qp0zPipe(int fildes[2]);

          //   returns 0 if successful, -1 if there's an error (errno is set)
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr Qp0zPipe int(10) ExtProc('Qp0zPipe');
         fildes int(10) dim(2);
         end-pr Qp0zPipe;
