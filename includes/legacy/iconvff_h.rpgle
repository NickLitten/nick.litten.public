**free

//   /*-                                                                            +
//    * Copyright (c) 2006-2020 Scott C. Klement                                    +
//    * All rights reserved.                                                        +
//    *                                                                             +
//    * Redistribution and use in source and binary forms, with or without          +
//    * modification, are permitted provided that the following conditions          +
//    * are met:                                                                    +
//    * 1. Redistributions of source code must retain the above copyright           +
//    *    notice, this list of conditions and the following disclaimer.            +
//    * 2. Redistributions in binary form must reproduce the above copyright        +
//    *    notice, this list of conditions and the following disclaimer in the      +
//    *    documentation and/or other materials provided with the distribution.     +
//    *                                                                             +
//    * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND      +
//    * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE       +
//    * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  +
//    * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE     +
//    * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL  +
//    * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS     +
//    * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)       +
//    * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT  +
//    * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY   +
//    * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF      +
//    * SUCH DAMAGE.                                                                +
//    *                                                                             +
//    */                                                                            +

dcl-ds QtqCode_t qualified template;
  CCSID    int(10) inz;
  ConvAlt  int(10) inz;
  SubsAlt  int(10) inz;
  ShiftAlt int(10) inz;
  InpLenOp int(10) inz;
  ErrorOpt int(10) inz;
  Reserved char(8) inz(*allx'00');
end-ds;

dcl-ds iconv_t qualified template;
  return_value int(10) inz;
  cd           int(10) dim(12) inz;
end-ds;

dcl-pr QtqIconvOpen likeds(iconv_t) extproc(*dclcase);
  toCode   likeds(QtqCode_t) const;
  fromCode likeds(QtqCode_t) const;
end-pr;

dcl-pr iconv uns(10) extproc(*dclcase);
  cd           likeds(iconv_t) value;
  inbuf        pointer;
  inbytesleft  uns(10);
  outbuf       pointer;
  outbytesleft uns(10);
end-pr;

dcl-c ICONV_FAIL CONST(4294967295);

dcl-pr iconv_close int(10) extproc(*dclcase);
  cd likeds(iconv_t) value;
end-pr;

dcl-pr QlgTransformUCSData uns(10) extproc(*dclcase);
  xformtype    int(10) value;
  inbuf        pointer;
  inbytesleft  uns(10);
  outbuf       pointer;
  outbytesleft uns(10);
  outspacereq  uns(10);
end-pr; 
