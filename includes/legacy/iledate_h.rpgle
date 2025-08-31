     /*-                                                                            +
      * Copyright (c) 2007 Scott C. Klement                                         +
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
      /if defined(ILEDATE_H_DEFINED)
      /eof
      /endif
      /define ILEDATE_H_DEFINED

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * CEEDAYS(): Convert character date into lilian
      *
      *   InputDate = (input) character string containing date
      *     picture = (input) picture string describing date fmt
      *      lilian = (output) the returned lilian date
      *    feedback = (i/o) error code (or *OMIT)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D CEEDAYS         PR                  opdesc
     D   InputDate                65535A   const options(*varsize)
     D   picture                  65535A   const options(*varsize)
     D   Lilian                      10i 0
     D   Feedback                    12a   options(*omit)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * CEEDATE(): Convert lilian date into character
      *
      *      Lilian = (input) Lilian date to format
      *     picture = (input) picture string describing output fmt
      *  OutputDate = (output) the returned character string
      *    feedback = (i/o) error code (or *OMIT)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D CEEDATE         PR                  opdesc
     D   Lilian                      10i 0
     D   picture                  65535A   const options(*varsize)
     D   OutputDate               65535A   const options(*varsize)
     D   Feedback                    12a   options(*omit)
