/*****************************************************************************/
/* Command: CHKSBSACT - Check if Subsystem is Active                         */
/* Purpose: Determines if a specified subsystem is currently active          */
/* Returns: YES if active, NO if inactive/not found, ERR on error            */
/* Author:  Nick Litten                                                      */
/* Created: 2024                                                             */
/*****************************************************************************/

             CMD        PROMPT('Check if subsystem is active')

/* Subsystem name parameter with validation */
             PARM KWD(SBS) TYPE(*NAME) LEN(10) PROMPT('Subsystem name')

/* Library parameter with special values and validation */
             PARM KWD(LIB) TYPE(*NAME) LEN(10) DFT(QSYS) PROMPT('Subsystem library')

/* Return value parameter - restricted to valid values */
             PARM KWD(RESULT) TYPE(*CHAR) LEN(3) RTNVAL(*YES) PROMPT('Result (YES/NO)')