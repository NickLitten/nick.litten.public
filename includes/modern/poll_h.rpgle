          // -
          //  Copyright (c) 2007 Scott C. Klement
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
        /if defined(POLL_H_DEFINED)
        /eof
        /endif
        /define POLL_H_DEFINED

        /if not defined(*V5R4M0)
        /eof
        /endif

          // ***************************************************************

          //   Events you can request poll() to wait for, and poll()
          //   can return to you:

          //       POLLIN = Wait til socket can be read without blocking
          //      POLLOUT = Wait til socket cna be written without blocking
          //      POLLPRI = Wait til out-of-band data can be read

          //   Events you can't request, but poll() can return:

          //     POLLNVAL = Invalid descriptor
          //   POLLRDBAND = out-of-band data ready to read
          //   POLLWRBAND = You write out-of-band data.
          //      POLLERR = an error occurred
          //      POLLHUP = socket was disconnected

          // ***************************************************************

         dcl-c POLLIN CONST(1);
         dcl-c POLLNORM CONST(1);
         dcl-c POLLRDNORM CONST(16);
         dcl-c POLLOUT CONST(2);
         dcl-c POLLWRNORM CONST(2);
         dcl-c POLLPRI CONST(4);
         dcl-c POLLRDBAND CONST(32);
         dcl-c POLLWRBAND CONST(64);
         dcl-c POLLHUP CONST(8192);
         dcl-c POLLERR CONST(16384);
         dcl-c POLLNVAL CONST(32768);

          // ***************************************************************
          //  An array of the pollfd data structure is passed to the
          //  poll() API to tell it which descriptors to wait on, and
          //  which events to wait for:

          //       fd = descriptor to wait on
          //   events = events to wait for (%bitor of constants, above)
          //  revents = returned events for this descriptor
          // ***************************************************************
         dcl-ds pollfd INZ qualified based(Template);
         fd int(10);
         events int(5);
         revents int(5);
         end-ds pollfd;

          // ***************************************************************
          //  nfds_t = data type to indicate the number of sockets in
          //           a poll descriptor set.
          // ***************************************************************
        /if not defined(NFDS_T)
         dcl-s nfds_t uns(10)  based(Template);
        /define NFDS_T
        /endif

          // ***************************************************************
          //   poll():  Wait for events on multiple descriptors

          //      int poll(struct pollfd fds[],
          //               nfds_t nfds,
          //               int timeout)

          //       fds = (in/out) array of pollfd data structures to wait on
          //      nfds = (input) number of elements in "fds" parm.
          //   timeout = (input) timeout value in milliseconds
          //                     or 0 = no waiting.
          //                       -1 = wait indefinitely

          //  Returns -1 = API failed (check errno)
          //           0 = timeout occurred
          //          >0 = number of descriptors that have events returned
          // ***************************************************************
         dcl-pr poll int(10) extproc('poll');
         fds  like(pollfd) dim(32767) options(*varsize);
         nfds  like(nfds_t) value;
         timeout int(10) value;
         end-pr poll;
