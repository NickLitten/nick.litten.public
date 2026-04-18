/*                                                                        */
/* Command: CMDNAME - Brief Command Title                                 */
/*                                                                        */
/* Description: Comprehensive explanation of the command's purpose and    */
/*              functionality. Use multiple lines as needed.              */
/*                                                                        */
/* Purpose: Command demonstrating:                                        */
/*   - Parameter validation                                               */
/*   - Command processing program integration                             */
/*   - User-friendly interface                                            */
/*                                                                        */
/* Parameters:                                                            */
/*   - PARM1: Description of parameter 1                                  */
/*   - PARM2: Description of parameter 2                                  */
/*   - RESULT: Description of result parameter                            */
/*                                                                        */
/* Usage: CMDNAME PARM1(value1) PARM2(value2)                             */
/*                                                                        */
/* Processing Program: CMDNAMECL or CMDNAMERPG                            */
/*                                                                        */
/* Modification History:                                                  */
/* V.000 YYYY-MM-DD | Author Name | Initial creation                      */
/*                                                                        */

             CMD        PROMPT('Brief Command Description')

             PARM       KWD(PARM1) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Parameter 1 Description')

             PARM       KWD(PARM2) TYPE(*CHAR) LEN(10) +
                          DFT(*NONE) SPCVAL((*NONE)) +
                          PROMPT('Parameter 2 Description')

             PARM       KWD(RESULT) TYPE(*CHAR) LEN(3) +
                          RTNVAL(*YES) PROMPT('Result Value')

@REM Made with Bob
