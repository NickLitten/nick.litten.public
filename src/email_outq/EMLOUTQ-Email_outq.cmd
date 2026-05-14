/******************************************************************************/
/* Command: EMLOUTQ - Email Output Queue                                     */
/* Description: Emails all spooled files from a specified output queue       */
/*                                                                            */
/* Parameters:                                                                */
/*   OUTQ      - Output queue name and library                               */
/*   FLR       - Working IFS folder for PDF conversion                       */
/*   RCP       - Email recipient address                                     */
/*   SUBJECT   - Email subject line                                          */
/*   ATTACH    - Format of spooled file attachment (*PDF or *TXT)            */
/*   IGNOREHLD - Ignore spooled files with STATUS(HLD)                       */
/*   DELETE    - Delete spooled files after emailing                         */
/*                                                                            */
/* Usage Examples:                                                            */
/*   EMLOUTQ OUTQ(QPRINT) RCP('user@example.com')                            */
/*   EMLOUTQ OUTQ(MYLIB/MYOUTQ) RCP('admin@company.com') ATTACH(*PDF)        */
/*                                                                            */
/* Modification History:                                                      */
/* v.001 2024 - Nick Litten - Created                                         */
/******************************************************************************/

             CMD        PROMPT('Email Output Queue')

/* Output queue parameter with library qualifier */
             PARM       KWD(OUTQ) TYPE(OUTQ) MIN(1) +
                          PROMPT('Output queue')

OUTQ:        QUAL       TYPE(*NAME) LEN(10) MIN(1) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL *LIBL) (*CURLIB *CURLIB)) +
                          PROMPT('Library name')

/* Working folder for PDF conversion */
             PARM       KWD(FLR) TYPE(*CHAR) LEN(100) DFT(*TMP) +
                          SPCVAL((*TMP '/tmp')) EXPR(*YES) +
                          CASE(*MIXED) PMTCTL(*PMTRQS) +
                          PROMPT('Working IFS Folder for *PDF')

/* Email recipient address */
             PARM       KWD(RCP) TYPE(*CHAR) LEN(100) MIN(1) +
                          EXPR(*YES) CASE(*MIXED) +
                          PROMPT('Email Address')

/* Email subject line */
             PARM       KWD(SUBJECT) TYPE(*CHAR) LEN(100) +
                          DFT('EMAIL FROM IBM i POWER SYSTEM') +
                          ALWVAR(*YES) EXPR(*YES) CASE(*MIXED) +
                          PMTCTL(*PMTRQS) PROMPT('Email Subject')

/* Attachment format */
             PARM       KWD(ATTACH) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*TXT) VALUES(*PDF *TXT) EXPR(*YES) +
                          PMTCTL(*PMTRQS) +
                          PROMPT('Format of *SPLF attachment')

/* Ignore held spooled files */
             PARM       KWD(IGNOREHLD) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*NO) VALUES(*YES *NO) +
                          EXPR(*YES) PMTCTL(*PMTRQS) +
                          PROMPT('Ignore *SPLF with STATUS(HLD)')

/* Delete spooled files after emailing */
             PARM       KWD(DELETE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO) EXPR(*YES) +
                          PMTCTL(*PMTRQS) +
                          PROMPT('Delete *SPLF after emailing')