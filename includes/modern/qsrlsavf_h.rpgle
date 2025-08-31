          // -
          //  Copyright (c) 2008 Scott C. Klement
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
        /if defined(QSRLSAVF_H_DEFINED)
        /eof
        /endif
        /define QSRLSAVF_H_DEFINED

         dcl-pr QSRLSAVF  ExtPgm('QSRLSAVF');
         UsrSpc char(20) const;
         Format char(8) const;
         QualSavf char(20) const;
         Filter char(10) const;
         Contin char(36) const;
         ErrorCode char(16) const;
         end-pr QSRLSAVF;

         dcl-ds SAVF0100_t INZ qualified based(Template);
         library char(10);
         savecmd char(10);
         savets char(8);
         Asp int(10);
         Records int(10);
         Objects int(10);
         AccPath int(10);
         Active char(10);
         Release char(6);
         DtaCpr char(1);
         SysSrl char(8);
         AspDev char(3);
         Mbrs char(2);
         Splfs int(10);
         end-ds SAVF0100_t;

         dcl-ds SAVF0200_t INZ qualified based(Template);
         object char(10);
         SavLib char(10);
         ObjType char(10);
         ExtAttr char(10);
         SavedTs char(8);
         ObjSize int(10);
         SizeMult int(10);
         Asp int(10);
         Data char(1);
         Owner char(10);
         DLO char(20);
         Folder char(63);
         Text char(50);
         AspDev char(10);
         end-ds SAVF0200_t;

         dcl-ds SAVF0300_t INZ qualified based(Template);
         file char(10);
         lib char(10);
         mbr char(10);
         extattr char(10);
         savets char(8);
         mbrs int(10);
         end-ds SAVF0300_t;
