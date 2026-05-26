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
      /if defined(QSNAPI_H)
      /eof
      /endif
      /define QSNAPI_H

      *-------------------------------------------------------------
      * Simple data types
      *-------------------------------------------------------------
     D Q_Handle_T      s             10I 0 based(Template)
     D Qsn_Cmd_Buf_T   s                   like(Q_Handle_T) based(Template)
     D Qsn_Inp_Buf_T   s                   like(Q_Handle_T) based(Template)
     D Qsn_Env_T       s                   like(Q_Handle_T) based(Template)
     D QSN_FAIL        c                   -1

      *-------------------------------------------------------------
      * QsnCrtCmdBuf(): Create command buffer
      *-------------------------------------------------------------
     D QsnCrtCmdBuf    PR            10I 0 extproc('QsnCrtCmdBuf')
     D   InitSize                    10I 0 const
     D   IncrAmt                     10I 0 const options(*omit)
     D   MaxSize                     10I 0 const options(*omit)
     D   Handle                      10I 0 options(*omit)
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      * QsnCrtInpBuf(): Create Input Buffer
      *-------------------------------------------------------------
     D QsnCrtInpBuf    PR            10I 0 extproc('QsnCrtInpBuf')
     D   BufSize                     10I 0 const
     D   IncrAmt                     10I 0 const options(*omit)
     D   MaxSize                     10I 0 const options(*omit)
     D   Handle                      10I 0 options(*omit)
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      * QsnClrBuf(): Clear/Reset Buffer (any type)
      *-------------------------------------------------------------
     D QsnClrBuf       PR            10I 0 extproc('QsnClrBuf')
     D   BufHandle                   10I 0 const
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      * QsnDltBuf(): Delete buffer (any type)
      *-------------------------------------------------------------
     D QsnDltBuf       PR            10I 0 extproc('QsnDltBuf')
     D   BufHandle                   10I 0 const
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      * QsnClrScr():  Clear screen
      *-------------------------------------------------------------
     D QsnClrScr       PR            10I 0 extproc('QsnClrScr')
     D   mode                         1A   const options(*omit)
     D   cmdbuf                      10I 0 const options(*omit)
     D   LowEnvHandle                10I 0 const options(*omit)
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      * QsnWrtDta():  Write data to the display
      *-------------------------------------------------------------
     D QsnWrtDta       PR            10I 0 extproc('QsnWrtDta')
     D   Data                     32767A   const options(*varsize)
     D   DataLen                     10I 0 const
     D   FieldID                     10I 0 const options(*omit)
     D   Row                         10I 0 const options(*omit)
     D   Column                      10I 0 const options(*omit)
     D   StrMonoAttr                  1A   const options(*omit)
     D   EndMonoAttr                  1A   const options(*omit)
     D   StrColorAttr                 1A   const options(*omit)
     D   EndColorAttr                 1A   const options(*omit)
     D   CmdBufHandle                10I 0 const options(*omit)
     D   LowEnvHandle                10I 0 const options(*omit)
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      * QsnSetFld():  Add a field to the display
      *-------------------------------------------------------------
     D QsnSetFld       PR            10I 0 extproc('QsnSetFld')
     D   FieldID                     10I 0 const options(*omit)
     D   FieldLen                    10I 0 const options(*omit)
     D   Row                         10I 0 const options(*omit)
     D   Column                      10I 0 const options(*omit)
     D   FFW                          2A   const options(*omit)
     D   FCW                          2A   const dim(32767)
     D                                     options(*omit: *varsize)
     D   NumOfFCW                    10I 0 const options(*omit)
     D   MonoAttr                     1A   const options(*omit)
     D   ColorAttr                    1A   const options(*omit)
     D   CmdBufHandle                10I 0 const options(*omit)
     D   LowEnvHandle                10I 0 const options(*omit)
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      * QsnReadInp(): Read data and wait for AID key
      *-------------------------------------------------------------
     D QsnReadInp      PR            10I 0 extproc('QsnReadInp')
     D   CC1                          1A   const
     D   CC2                          1A   const
     D   DataBytes                   10I 0 options(*omit)
     D   InpBufHandle                10I 0 options(*omit)
     D   CmdBufHandle                10I 0 options(*omit)
     D   LowEnvHandle                10I 0 options(*omit)
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      * QsnReadMDT(): Read modified fields only
      *-------------------------------------------------------------
     D QsnReadMDT      PR            10I 0 extproc('QsnReadMDT')
     D   CC1                          1A   const
     D   CC2                          1A   const
     D   FldCount                    10I 0 options(*omit)
     D   InpBufHandle                10I 0 options(*omit)
     D   CmdBufHandle                10I 0 options(*omit)
     D   LowEnvHandle                10I 0 options(*omit)
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      * QsnPutGetBuf():  Send command output buffer to terminal
      *                  then wait for input buffer from terminal
      *-------------------------------------------------------------
     D QsnPutGetBuf    PR            10I 0 extproc('QsnPutGetBuf')
     D   CmdBufHandle                10I 0 const
     D   InpBufHandle                10I 0 const
     D   LowEnvHandle                10I 0 const options(*omit)
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      * QsnRtvDta(): Get pointer to input data in input buffer
      *-------------------------------------------------------------
     D QsnRtvDta       PR              *   extproc('QsnRtvDta')
     D   InpBufHandle                10I 0 const
     D   PtrToData                     *   const options(*omit)
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      * QsnRtvDtaLen(): Get length of input data in input buffer
      *-------------------------------------------------------------
     D QsnRtvDtaLen    PR            10I 0 extproc('QsnRtvDtaLen')
     D   InpBufHandle                10I 0 const
     D   DataLen                     10I 0 const options(*omit)
     D   ErrorCode                32767A   options(*omit: *varsize)

      *-------------------------------------------------------------
      *
      *-------------------------------------------------------------
     D Qsn_Env_Desc_T...
     D                 DS                  qualified based(Template)
     D  color_support                 1A
     D  CDRA                          1A
     D  CDRA_3F                       1A
     D  DBCS_support                  1A
     D  coexist                       1A
     D  alt_help                      1A
     D  tgt_dev                      10A
     D  disp_file                    20A
     D  invite_active                 1A
     D  prevent_ovrd                  1A

      *-------------------------------------------------------------
      *
      *-------------------------------------------------------------
     D Qsn_Env_Rtv_Desc_T...
     D                 DS                  qualified based(Template)
     D  bytes_rtn                    10I 0
     D  bytes_avail                  10I 0
     D  color_support                 1A
     D  CDRA                          1A
     D  CDRA_3F                       1A
     D  DBCS_support                  1A
     D  coexist                       1A
     D  alt_help                      1A
     D  tgt_dev                      10A
     D  dsp_file                     20A
     D  invite_active                 1A
     D  prevent_ovrd                  1A

      *-------------------------------------------------------------
      * Constants used for creating/querying the environment
      *-------------------------------------------------------------
     D QSN_COLOR_NO...
     D                 C                   '1'
     D QSN_COLOR_YES...
     D                 C                   '2'
     D QSN_COLOR_SELECT...
     D                 C                   '3'

     D QSN_CDRA_STD...
     D                 C                   '1'
     D QSN_CDRA_CNVT...
     D                 C                   '2'
     D QSN_DBCS_STD...
     D                 C                   '1'
     D QSN_DBCS_ONLY...
     D                 C                   '2'
     D QSN_DBCS_EITHER...
     D                 C                   '3'
     D QSN_DBCS_MIXED...
     D                 C                   '4'
     D QSN_COEXIST_YES...
     D                 C                   '1'
     D QSN_COEXIST_NO...
     D                 C                   '2'
     D QSN_ALTHELP_NO...
     D                 C                   '1'
     D QSN_TGT_REQ...
     D                 C                   '*REQUESTER'
     D QSN_INVITE_NO...
     D                 C                   '1'
     D QSN_INVITE_YES...
     D                 C                   '2'
     D QSN_PREVENT_OVERRIDE_NO...
     D                 C                   '1'
     D QSN_PREVENT_OVERRIDE_YES...
     D                 C                   '2'

     D QSN_SAME        C                   '0'
     D QSN_DSP03       C                   '3'
     D QSN_DSP04       C                   '4'

      *-------------------------------------------------------------
      * AID keys (function keys, et al)
      *-------------------------------------------------------------
     D Qsn_F1          C                   X'31'
     D Qsn_F2          C                   X'32'
     D Qsn_F3          C                   X'33'
     D Qsn_F4          C                   X'34'
     D Qsn_F5          C                   X'35'
     D Qsn_F6          C                   X'36'
     D Qsn_F7          C                   X'37'
     D Qsn_F8          C                   X'38'
     D Qsn_F9          C                   X'39'
     D Qsn_F10         C                   X'3A'
     D Qsn_F11         C                   X'3B'
     D Qsn_F12         C                   X'3C'
     D Qsn_F13         C                   X'B1'
     D Qsn_F14         C                   X'B2'
     D Qsn_F15         C                   X'B3'
     D Qsn_F16         C                   X'B4'
     D Qsn_F17         C                   X'B5'
     D Qsn_F18         C                   X'B6'
     D Qsn_F19         C                   X'B7'
     D Qsn_F20         C                   X'B8'
     D Qsn_F21         C                   X'B9'
     D Qsn_F22         C                   X'BA'
     D Qsn_F23         C                   X'BB'
     D Qsn_F24         C                   X'BC'
     D Qsn_SLP         C                   X'3F'
     D Qsn_FET         C                   X'50'
     D Qsn_PA1         C                   X'6C'
     D Qsn_PA2         C                   X'6E'
     D Qsn_PA3         C                   X'6B'
     D Qsn_Clear       C                   X'BD'
     D Qsn_Enter       C                   X'F1'
     D Qsn_Help        C                   X'F3'
     D Qsn_RollDown    C                   X'F4'
     D Qsn_RollUp      C                   X'F5'
     D Qsn_PageUp      C                   X'F4'
     D Qsn_PageDown    C                   X'F5'
     D Qsn_Print       C                   X'F6'
     D Qsn_RecBS       C                   X'F8'

     DQsn5250QY        C                   '1'
     DQsn5250QN        C                   '2'
     DQsn5250QF        C                   '3'

      *-------------------------------------------------------------
      * Control Characters ( CC1 & CC2 )
      *-------------------------------------------------------------
     D QSN_CC1_NULL...
     D                 C                   X'00'
     D QSN_CC1_LOCKBD...
     D                 C                   X'20'
     D QSN_CC1_MDTNBY...
     D                 C                   X'40'
     D QSN_CC1_MDTALL...
     D                 C                   X'60'
     D QSN_CC1_CLRMOD...
     D                 C                   X'80'
     D QSN_CC1_MDTNBY_CLRALL...
     D                 C                   X'A0'
     D QSN_CC1_MDTNBY_CLRMOD...
     D                 C                   X'C0'
     D QSN_CC1_MDTALL_CLRALL...
     D                 C                   X'E0'

     D QSN_CC2_NULL...
     D                 C                   X'00'
     D QSN_CC2_NO_IC...
     D                 C                   X'40'
     D QSN_CC2_RST_CSR_BL...
     D                 C                   X'20'
     D QSN_CC2_SET_CSR_BL...
     D                 C                   X'10'
     D QSN_CC2_UNLOCKBD...
     D                 C                   X'08'
     D QSN_CC2_ALARM...
     D                 C                   X'04'
     D QSN_CC2_MSG_OFF...
     D                 C                   X'02'
     D QSN_CC2_MSG_ON...
     D                 C                   X'01'

      *-------------------------------------------------------------
      *  Screen Attributes
      *-------------------------------------------------------------
     D QSN_NO_SA...
     D                 C                   X'00'
     D QSN_SA_NORM...
     D                 C                   X'20'
     D QSN_SA_CS...
     D                 C                   X'30'
     D QSN_SA_BL...
     D                 C                   X'28'
     D QSN_SA_UL...
     D                 C                   X'24'
     D QSN_SA_HI...
     D                 C                   X'22'
     D QSN_SA_RI...
     D                 C                   X'21'
     D QSN_SA_ND...
     D                 C                   X'27'

     D QSN_SA_GRN...
     D                 C                   X'20'
     D QSN_SA_GRN_RI...
     D                 C                   X'21'
     D QSN_SA_WHT...
     D                 C                   X'22'
     D QSN_SA_WHT_RI...
     D                 C                   X'23'
     D QSN_SA_GRN_UL...
     D                 C                   X'24'
     D QSN_SA_GRN_UL_RI...
     D                 C                   X'25'
     D QSN_SA_WHT_UL...
     D                 C                   X'26'
     D QSN_SA_RED...
     D                 C                   X'28'
     D QSN_SA_RED_RI...
     D                 C                   X'29'
     D QSN_SA_RED_BL...
     D                 C                   X'2A'
     D QSN_SA_RED_RI_BL...
     D                 C                   X'2B'
     D QSN_SA_RED_UL...
     D                 C                   X'2C'
     D QSN_SA_RED_UL_RI...
     D                 C                   X'2D'
     D QSN_SA_RED_UL_BL...
     D                 C                   X'2E'
     D QSN_SA_ND_2F...
     D                 C                   X'2F'
     D QSN_SA_TRQ_CS...
     D                 C                   X'30'
     D QSN_SA_TRQ_CS_RI...
     D                 C                   X'31'
     D QSN_SA_YLW_CS...
     D                 C                   X'32'
     D QSN_SA_YLW_CS_RI...
     D                 C                   X'33'
     D QSN_SA_TRQ_UL...
     D                 C                   X'34'
     D QSN_SA_TRQ_UL_RI...
     D                 C                   X'35'
     D QSN_SA_YLW_UL...
     D                 C                   X'36'
     D QSN_SA_ND_37...
     D                 C                   X'37'
     D QSN_SA_PNK...
     D                 C                   X'38'
     D QSN_SA_PNK_RI...
     D                 C                   X'39'
     D QSN_SA_BLU...
     D                 C                   X'3A'
     D QSN_SA_BLU_RI...
     D                 C                   X'3B'
     D QSN_SA_PNK_UL...
     D                 C                   X'3C'
     D QSN_SA_PNK_UL_RI...
     D                 C                   X'3D'
     D QSN_SA_BLU_UL...
     D                 C                   X'3E'
     D QSN_SA_ND_3F...
     D                 C                   X'3F'

      *-------------------------------------------------------------
      * Ideographic shift-in and shift-out
      *-------------------------------------------------------------
     D QSN_SO          C                   X'0E'
     D QSN_SI          C                   X'0F'

      *-------------------------------------------------------------
      *  Field Format Words
      *-------------------------------------------------------------
     D QSN_NO_FFW      C                   X'0000'
     D QSN_FFW_BYPASS  C                   X'6000'
     D QSN_FFW_DUP     C                   X'5000'
     D QSN_FFW_MDT     C                   X'4800'
     D QSN_FFW_ALPHA_SHIFT...
     D                 C                   X'4000'
     D QSN_FFW_ALPHA_ONLY...
     D                 C                   X'4100'
     D QSN_FFW_NUM_SHIFT...
     D                 C                   X'4200'
     D QSN_FFW_NUM_ONLY...
     D                 C                   X'4300'
     D QSN_FFW_KATA...
     D                 C                   X'4400'
     D QSN_FFW_DIGIT_ONLY...
     D                 C                   X'4500'
     D QSN_FFW_IO...
     D                 C                   X'4600'
     D QSN_FFW_SIGNED_NUMERIC...
     D                 C                   X'4700'
     D QSN_FFW_AUTO_ENTER...
     D                 C                   X'4080'
     D QSN_FFW_FER...
     D                 C                   X'4040'
     D QSN_FFW_AUTO_FER...
     D                 C                   X'4040'
     D QSN_FFW_MONOCASE...
     D                 C                   X'4020'
     D QSN_FFW_AUTO_MONOCASE...
     D                 C                   X'4020'
     D QSN_FFW_ME...
     D                 C                   X'4008'
     D QSN_FFW_NOADJUST...
     D                 C                   X'4000'
     D QSN_FFW_RA_ZERO...
     D                 C                   X'4005'
     D QSN_FFW_RA_BLANK...
     D                 C                   X'4006'
     D QSN_FFW_MF...
     D                 C                   X'4007'

     D QSN_FCW_RESEQ...
     D                 C                   X'8000'
     D QSN_FCW_MSR...
     D                 C                   X'8101'
     D QSN_FCW_SLP...
     D                 C                   X'8102'
     D QSN_FCW_MSR_SLP...
     D                 C                   X'8103'
     D QSN_FCW_SLP_SA...
     D                 C                   X'8106'
     D QSN_FCW_DBCS_ONLY...
     D                 C                   X'8200'
     D QSN_FCW_DBCS_PURE...
     D                 C                   X'8220'
     D QSN_FCW_DBCS_EITHER...
     D                 C                   X'8240'
     D QSN_FCW_DBCS_OPEN...
     D                 C                   X'8280'
     D QSN_FCW_DBCS_OPEN_CO...
     D                 C                   X'82C0'
     D QSN_FCW_TRANSPARENT...
     D                 C                   X'8400'
     D QSN_FCW_FET...
     D                 C                   X'8501'
     D QSN_FCW_CONT_FIRST...
     D                 C                   X'8601'
     D QSN_FCW_CONT_LAST...
     D                 C                   X'8602'
     D QSN_FCW_CONT_MIDDLE...
     D                 C                   X'8603'
     D QSN_FCW_CP...
     D                 C                   X'8800'
     D QSN_FCW_HL...
     D                 C                   X'8900'
     D QSN_FCW_PDS...
     D                 C                   X'8A00'
     D QSN_FCW_MOD11...
     D                 C                   X'B140'
     D QSN_FCW_MOD10...
     D                 C                   X'B1A0'

     D QSN_READ_INP...
     D                 C                   X'42'
     D QSN_READ_MDT...
     D                 C                   X'52'
     D QSN_READ_IMM...
     D                 C                   X'72'
     D QSN_READ_MDT_ALT...
     D                 C                   X'82'


      /if defined(TO_BE_CONVERTED_LATER)
      *
      * Structure definitions.
      *

     DQsnEnvExtI       DS
      * Data structure for QsnCrtEnv API.
     D  QsnEEDta                       *
     D  QsnEEChg                       *   procptr
     D  QsnEEDlt                       *   procptr

     DQsnEnvWM         DS
      * Data structures for QsnSetEnvWinMod API.
     D  QsnEWAtrC                     1A
     D  QsnEWULR                     10I 0
     D  QsnEWULC                     10I 0
     D  QsnEWNumR                    10I 0
     D  QsnEWNumC                    10I 0

     DQsnREnvWM        DS
      * Data structures for QsnRtvEnvWinMod API.
     D  QsnREWRet                    10I 0
     D  QsnREWAvl                    10I 0
     D  QsnREWMode                    1A
     D  QsnREWAtr                     1A
     D  QsnREWULR                    10I 0
     D  QsnREWULC                    10I 0
     D  QsnREWNumR                   10I 0
     D  QsnREWNumC                   10I 0

     DQsnQ5250         DS
      * Data structure for QsnQry5250 API.
     D  QsnQ5Ret                     10I 0
     D  QsnQ5Avl                     10I 0
     D  QsnQ5Stat                     1A
     D  QsnQ5Wkstn                    4B 0
     D  QsnQ5CLvl                     3A
     D  QsnQ5R1                      16A
     D  QsnQ5WType                    1A
     D  QsnQ5MType                    4A
     D  QsnQ5Model                    3A
     D  QsnQ5KbdID                    1A
     D  QsnQ5EKbd                     1A
     D  QsnQ5PcKbd                    1A
     D  QsnQ5SNum                     4A
     D  QsnQ5MaxIn                    4B 0
     D  QsnQ5WSCSp                    2A
     D  QsnQ5R2                       1A
     D  QsnQ5WSCB1                    1A
     D  QsnQ5WSCB2                    1A
     D  QsnQ5WSCB3                    1A
     D  QsnQ5WSCB4                    1A
     D  QsnQ5WSCB5                    1A
     D  QsnQ5R3                       5A
     D  QsnQ5Prt                      1A
     D  QsnQ5R4                       1A
     D  QsnQ5GrdBf                    1A
     D  QsnQ5R5                       9A
      *Note: this may be expanded in the future

     DQsnReadInf       DS
      * Data structure for QsnRtvReadInf API.
     D  QsnRIRet                     10I 0
     D  QsnRIAvl                     10I 0
     D  QsnRIR1                       8A
     D  QsnRIDta                       *
     D  QsnRIFDta                      *
     D  QsnRIDtaL                    10I 0
     D  QsnRIFDtaL                   10I 0
     D  QsnRINumF                    10I 0
     D  ReadLen                      10I 0
     D  QsnRIRow                     10I 0
     D  QsnRICol                     10I 0
     D  QsnRIAID                      1A
     D  QsnRIR2                       7A

     DQsnFldInf        DS
      * Data structure for QsnRtvFldInf API.
     D  QsnFIRet                     10I 0
     D  QsnFIAvl                     10I 0
     D  QsnFIType                     1A
     D  QsnFIRow                     10I 0
     D  QsnFICol                     10I 0
     D  QsnFIFDtaL                   10I 0
     D  QsnFIR1                      11A
     D  QsnFIDta                       *

     DQsnWinExtI       DS
      * Data structure for QsnCrtWin API
     D  QsnWEDta                       *
     D  QsnWEChg                       *   procptr
     D  QsnWEDlt                       *   procptr
     D  QsnWECoord                     *   procptr
     D  QsnWEDraw                      *   procptr
     D  QsnWECur                       *   procptr

     DQsnWinD          DS
      * Data structures for QsnCrtWin and QsnChgWin APIs.
     D  QsnWTopR                     10I 0
     D  QsnWLeftC                    10I 0
     D  QsnWNumR                     10I 0
     D  QsnWNumC                     10I 0
     D  QsnWMinR                     10I 0
     D  QsnWMinC                     10I 0
     D  QsnWMaxR                     10I 0
     D  QsnWMaxC                     10I 0
     D  QsnWFS                        1A
     D  QsnWAtrM1                     1A
     D  QsnWAtrM2                     1A
     D  QsnWAtrM3                     1A
     D  QsnWAtrC1                     1A
     D  QsnWAtrC2                     1A
     D  QsnWAtrC3                     1A
     D  QsnWShowB                     1A
     D  QsnWShowBA                    1A
     D  QsnWShowLA                    1A
     D  QsnWShowRA                    1A
     D  QsnWMsgL                      1A
     D  QsnWULCh                      1A
     D  QsnWTopCh                     1A
     D  QsnWURCh                      1A
     D  QsnWLCh                       1A
     D  QsnWRCh                       1A
     D  QsnWLLCh                      1A
     D  QsnWBotCh                     1A
     D  QsnWLRCh                      1A
     D  QsnWGUI                       1A
     D  QsnWFlg1                      1A
     D  QsnWFlg2                      1A
     D  QsnWR1                        1A
     D  QsnWBdrF                      1A
     D  QsnWTtlF                      1A
     D  QsnWTAtrM                     1A
     D  QsnWTAtrC                     1A
     D  QsnWR2                        1A
     D  QsnWR3                        3A
     D  QsnWTtlO                     10I 0
     D  QsnWTtlL                     10I 0
     D  QsnWR4                       10I 0

     DQsnRWinD         DS
      * Data structure for QsnRtvWinD API.
     D  QsnRWRet                     10I 0
     D  QsnRWAvl                     10I 0
     D  QsnRWTopR                    10I 0
     D  QsnRWLeftC                   10I 0
     D  QsnRWNumR                    10I 0
     D  QsnRWNumC                    10I 0
     D  QsnRWMinR                    10I 0
     D  QsnRWMinC                    10I 0
     D  QsnRWMaxR                    10I 0
     D  QsnRWMaxC                    10I 0
     D  QsnRWFS                       1A
     D  QsnRWAtrM1                    1A
     D  QsnRWAtrM2                    1A
     D  QsnRWAtrM3                    1A
     D  QsnRWAtrC1                    1A
     D  QsnRWAtrC2                    1A
     D  QsnRWAtrC3                    1A
     D  QsnRWShwB                     1A
     D  QsnRWShwBA                    1A
     D  QsnRWShwLA                    1A
     D  QsnRWShwRA                    1A
     D  QsnRWMsgL                     1A
     D  QsnRWULCh                     1A
     D  QsnRWTopCh                    1A
     D  QsnRWURCh                     1A
     D  QsnRWLCh                      1A
     D  QsnRWRCh                      1A
     D  QsnRWLLCh                     1A
     D  QsnRWBotCh                    1A
     D  QsnRWLRCh                     1A
     D  QsnRWGUI                      1A
     D  QsnRWFlg1                     1A
     D  QsnRWFlg2                     1A
     D  QsnRWR1                       1A
     D  QsnRWBdrF                     1A
     D  QsnRWTtlF                     1A
     D  QsnRWTAtrM                    1A
     D  QsnRWTAtrC                    1A
     D  QsnRWR2                       1A
     D  QsnRWR3                       3A
     D  QsnRWTtlO                    10I 0
     D  QsnRWTtlL                    10I 0
     D  QsnRWR4                      10I 0

     DQsnSsnExtI       DS
      * Data structure for QsnCrtSsn API
     D  QsnSEDta                       *
     D  QsnSEChg                       *   procptr
     D  QsnSEDlt                       *   procptr
     D  QsnSECoord                     *   procptr
     D  QsnSEDraw                      *   procptr
     D  QsnSECur                       *   procptr

     DQsnSsnD          DS
      * Data structure for QsnCrtSsn and QsnChgSsn APIs
     D  QsnSActn                       *   procptr Dim(24)
     D  QsnSTRow                     10I 0
     D  QsnSLCol                     10I 0
     D  QsnSNRows                    10I 0
     D  QsnSNCols                    10I 0
     D  QsnSRollA                    10I 0
     D  QsnSShftA                    10I 0
     D  QsnSISize                    10I 0
     D  QsnSMSize                    10I 0
     D  QsnSIncr                     10I 0
     D  QsnSIRows                    10I 0
     D  QsnSR1                        1A
     D  QsnSWrap                      1A
     D  QsnSR2                        1A
     D  QsnEBCDIC                     1A
     D  QsnSEcho                      1A
     D  QsnSLDsp                      1A
     D  QsnSCDsp                      1A
     D  QsnSShowC                     1A
     D  QsnSCmdAM                     1A
     D  QsnSCmdAC                     1A
     D  QsnSInLAM                     1A
     D  QsnSInLAC                     1A
     D  QsnSPmtO                     10I 0
     D  QsnSPmtL                     10I 0
     D  QsnSCmdO1                    10I 0
     D  QsnSCmdL1                    10I 0
     D  QsnSCmdO2                    10I 0
     D  QsnSCmdL2                    10I 0
     D  QsnSR4                       20A

     DQsnRSsnD         DS
      * Data structure for QsnRtvSsnD APIs
     D  QsnRSRet                     10I 0
     D  QsnRSAvl                     10I 0
     D  QsnRSR1                       8A
     D  QsnRSActn                      *   procptr Dim(24)
     D  QsnRSTRow                    10I 0
     D  QsnRSLCol                    10I 0
     D  QsnRSNRows                   10I 0
     D  QsnRSNCols                   10I 0
     D  QsnRSRollA                   10I 0
     D  QsnRSShftA                   10I 0
     D  QsnRSISize                   10I 0
     D  QsnRSMSize                   10I 0
     D  QsnRSIncr                    10I 0
     D  QsnRSIRows                   10I 0
     D  QsnRSR2                       1A
     D  QsnRSWrap                     1A
     D  QsnRSR3                       1A
     D  QsnREBCDIC                    1A
     D  QsnRSEcho                     1A
     D  QsnRSLDsp                     1A
     D  QsnRSCDsp                     1A
     D  QsnRSShowC                    1A
     D  QsnRSCmdAM                    1A
     D  QsnRSCmdAC                    1A
     D  QsnRSInLAM                    1A
     D  QsnRSInLAC                    1A
     D  QsnRSPmtO                    10I 0
     D  QsnRSPmtL                    10I 0
     D  QsnRSCmdO1                   10I 0
     D  QsnRSCmdL1                   10I 0
     D  QsnRSCmdO2                   10I 0
     D  QsnRSCmdL2                   10I 0
     D  QsnRSR5                      20A
      /endif
