     /*-                                                                            +
      * Copyright (c) 2008 Scott C. Klement                                         +
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
      /if defined(QP2USER_H_DEFINED)
      /eof
      /endif
      /define QP2USER_H_DEFINED


      *********************************************************
      * PASE argument (parameter) types for constructing
      *      a signature
      *********************************************************
     D Qp2_arg_type_t  s              5i 0 based(Template)
     D QP2_ARG_END     C                   0
     D QP2_ARG_WORD    C                   -1
     D QP2_ARG_DWORD   C                   -2
     D QP2_ARG_FLOAT32...
     D                 C                   -3
     D QP2_ARG_FLOAT64...
     D                 C                   -4
     D QP2_ARG_PTR32...
     D                 C                   -5
     D QP2_ARG_PTR64...
     D                 C                   -6


      *********************************************************
      * PASE result types
      *********************************************************
     D Qp2_Result_Type_t...
     D                 s              5i 0 based(Template)
     D QP2_RESULT_VOID...
     D                 c                   0
     D QP2_RESULT_WORD...
     D                 c                   -1
     D QP2_RESULT_DWORD...
     D                 c                   -2
     D QP2_RESULT_FLOAT64...
     D                 c                   -4
     D QP2_RESULT_PTR32...
     D                 c                   -5
     D QP2_RESULT_PTR64...
     D                 c                   -6


      *********************************************************
      * Qp2RunPase() special return values
      *********************************************************
     D QP2RUNPASE_ERROR...
     D                 C                   -1
     D QP2RUNPASE_RETURN_NOEXIT...
     D                 C                   -2


      *********************************************************
      *  data types allowed in the PASE environment
      *********************************************************
     D Qp2_word_t      s             10u 0
     D Qp2_dword_t     s             20u 0
     D Qp2_float32_t   s              4f
     D Qp2_float64_t   s              8f
     D Qp2_ptr32_t     s             10u 0
     D Qp2_ptr64_t     s             20u 0


      *********************************************************
      *  Special value for argument pointer into stack
      *********************************************************
     D QP2_ARG_PTR_TOSTACK...
     D                 c                   x'0fff0000'

      *********************************************************
      *  Qp2CallPase/Qp2CallaAse2 return values
      *********************************************************
     D QP2CALLPASE_NORMAL...
     D                 C                   0
     D QP2CALLPASE_RESULT_ERROR...
     D                 C                   1
     D QP2CALLPASE_ENVIRON_ERROR...
     D                 C                   2
     D QP2CALLPASE_ARG_ERROR...
     D                 C                   4
     D QP2CALLPASE_TERMINATING...
     D                 C                   6
     D QP2CALLPASE_RETURN_NOEXIT...
     D                 C                   7


      *********************************************************
      * Qp2EndPase():  End the currently running PASE Program
      *
      *  returns 0 if successful, nonzero upon error
      *********************************************************
     D Qp2EndPase      pr            10i 0 extproc('Qp2EndPase')



      *********************************************************
      * Qp2CallPase(): Call a procedure (e.g. a C function) in
      *   a PASE program or library that's currently loaded
      *   or running in the PASE environment.
      *
      *   target = (input) function descriptor for the proc.
      *  arglist = (input) fun, eh?
      *
      *  returns 0 if successful, nonzero upon error
      *********************************************************
     D Qp2CallPase     pr            10i 0 extproc('Qp2CallPase')
     D   target                        *   value
     D   arglist                       *   value
     D   signature                         like(Qp2_arg_type_t) const
     D   result_type                       like(Qp2_result_type_t) value
     D   buf                           *   value

     D Qp2CallPase2    pr            10i 0 extproc('Qp2CallPase2')
     D   target                        *   value
     D   arglist                       *   value
     D   signature                         like(Qp2_arg_type_t) const
     D   result_type                       like(Qp2_result_type_t) value
     D   buf                           *   value
     D   bufLenIn                     5i 0 value

     D Qp2RunPase      PR            10i 0 extproc('Qp2RunPase')
     D   PathName                      *   value options(*string)
     D   symbolName                    *   value
     D   symData                       *   value
     D   symDataLen                  10u 0 value
     D   ccsid                       10i 0 value
     D   argv                          *   dim(32767) options(*varsize)
     D   env                           *   dim(32767) options(*varsize)

     D Qp2SignalPase   PR            10i 0 extproc('Qp2SignalPase')
     D   signo                       10i 0 value

     D Qp2ptrsize      PR            10u 0 extproc('Qp2ptrsize')

     D Qp2paseCCSID    PR            10i 0 extproc('Qp2paseCCSID')

     D Qp2jobCCSID     PR            10i 0 extproc('Qp2jobCCSID')

     D Qp2errnop       PR              *   extproc('Qp2errnop')

     D Qp2malloc       PR              *   extproc('Qp2malloc')
     D   size                              like(QP2_dword_t) value
     D   mem_pase                          like(QP2_ptr64_t) options(*omit)

     D Qp2free         PR            10i 0 extproc('Qp2free')
     D   mem                           *   value

     D Qp2dlopen       PR                  like(QP2_ptr64_t)
     D                                     extproc('Qp2dlopen')
     D   path                          *   value options(*string)
     D   flags                       10i 0 value
     D   ccsid                       10i 0 value

     D Qp2dlsym        PR              *   extproc('Qp2dlsym')
     D   id                                like(QP2_ptr64_t) value
     D   name                          *   value options(*string)
     D   ccsid                       10i 0 value
     D   sym_pase                          like(QP2_ptr64_t)

     D Qp2dlclose      PR            10i 0 extproc('Qp2dlclose')
     D   id                                like(QP2_ptr64_t) value

     D Qp2dlerror      PR              *   extproc('Qp2dlclose')
     D   id                                like(QP2_ptr64_t) value

     D QP2_RTLD_NOW    c                   x'00000002'
     D QP2_RTLD_LAZY   c                   x'00000004'
     D QP2_RTLD_GLOBAL...
     D                 c                   x'00010000'
     D QP2_RTLD_NOAUTODEFER...
     D                 c                   x'00020000'
     D QP2_RTLD_MEMBER...
     D                 c                   x'00040000'
     D QP2_RTLD_LOCAL...
     D                 c                   x'00080000'
