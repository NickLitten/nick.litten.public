/* --------------------------------------------------------- */
/* EMLCSVFILE *CMD - Email DB2 file as CSV attachment        */
/*                                                           */
/* CRTCMD CMD(LITTENN/EMLCSVFILE)                            */
/*        PGM(LITTENN/EMLCSVFILE)                            */
/*        SRCFILE(LITTENN/QCMDSRC)                           */
/*        SRCMBR(EMLCSVFILE)                                 */
/*        ALLOW(*IPGM *BPGM *IMOD *BMOD)                     */
/*        HLPPNLGRP(EMLCSVFILE)                              */
/*        HLPID(*CMD)                                        */
/* --------------------------------------------------------- */
/* Modification History                                      */
/* NJL01 Nick Litten 04/01/2022 Created                      */
/* NJL02 Nick Litten 02/05/2026 Enhanced with validation     */
/*       - Added parameter validation and ranges             */
/*       - Improved prompting and help text                  */
/*       - Added optional parameters with defaults           */
/*       - Enhanced file qualification handling              */
/* --------------------------------------------------------- */

CMD        PROMPT('Email DB2 file as CSV attachment')

/* --------------------------------------------------------- */
/* File to export - Required parameter                       */
/* --------------------------------------------------------- */
PARM       KWD(FILE) +
           TYPE(PF_FILE) +
           MIN(1) +
           PROMPT('Database file to export')

PF_FILE:   QUAL       TYPE(*NAME) +
                      LEN(10) +
                      MIN(1) +
                      EXPR(*YES) +
                      PROMPT('File name')
           QUAL       TYPE(*NAME) +
                      LEN(10) +
                      DFT(*LIBL) +
                      SPCVAL((*LIBL) (*CURLIB)) +
                      EXPR(*YES) +
                      PROMPT('Library')

/* --------------------------------------------------------- */
/* Email recipient - Required parameter                      */
/* Supports single email address                             */
/* --------------------------------------------------------- */
PARM       KWD(TOEML) +
           TYPE(*CHAR) +
           LEN(255) +
           MIN(1) +
           VARY(*YES *INT2) +
           CASE(*MIXED) +
           PROMPT('Recipient email address')

/* --------------------------------------------------------- */
/* Email subject - Required parameter                        */
/* --------------------------------------------------------- */
PARM       KWD(SUBJECT) +
           TYPE(*CHAR) +
           LEN(100) +
           MIN(1) +
           VARY(*YES *INT2) +
           CASE(*MIXED) +
           PROMPT('Email subject line')

/* --------------------------------------------------------- */
/* Email body - Required parameter                           */
/* --------------------------------------------------------- */
PARM       KWD(BODY) +
           TYPE(*CHAR) +
           LEN(500) +
           MIN(1) +
           VARY(*YES *INT2) +
           CASE(*MIXED) +
           PROMPT('Email message body')

/* --------------------------------------------------------- */
/* Optional: Delete CSV after sending                        */
/* --------------------------------------------------------- */
PARM       KWD(RMVSTMF) +
           TYPE(*CHAR) +
           LEN(4) +
           RSTD(*YES) +
           DFT(*YES) +
           VALUES(*YES *NO) +
           PROMPT('Remove stream file after send')

/* --------------------------------------------------------- */
/* Optional: Member name for multi-member files              */
/* --------------------------------------------------------- */
PARM       KWD(MBR) +
           TYPE(*NAME) +
           LEN(10) +
           DFT(*FIRST) +
           SPCVAL((*FIRST)) +
           PROMPT('Member name')

/* --------------------------------------------------------- */
/* Optional: Field delimiter for CSV                         */
/* --------------------------------------------------------- */
PARM       KWD(FLDDLM) +
           TYPE(*CHAR) +
           LEN(1) +
           DFT(',') +
           PROMPT('Field delimiter character')

/* --------------------------------------------------------- */
/* Optional: Include column headers                          */
/* --------------------------------------------------------- */
PARM       KWD(COLHDG) +
           TYPE(*CHAR) +
           LEN(4) +
           RSTD(*YES) +
           DFT(*YES) +
           VALUES(*YES *NO) +
           PROMPT('Include column headings')