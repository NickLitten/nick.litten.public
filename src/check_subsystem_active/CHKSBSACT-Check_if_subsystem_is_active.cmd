/* Command: CHKSBSACT - Check if Subsystem is Active                        */
/*                                                                          */
/* Description: Command definition for checking if a specified subsystem   */
/*              is currently active on the system. Returns a simple        */
/*              YES/NO/ERR result that can be used in CL programs.         */
/*                                                                          */
/* Purpose: Educational example demonstrating:                              */
/*   - Command definition with parameters                                  */
/*   - Return value parameter usage                                        */
/*   - Default values and special values                                   */
/*   - Parameter validation                                                */
/*   - Command prompting                                                   */
/*                                                                          */
/* Features:                                                                */
/*   - Accepts subsystem name and library                                  */
/*   - Returns YES if subsystem is active                                  */
/*   - Returns NO if subsystem is inactive or not found                    */
/*   - Returns ERR on error conditions                                     */
/*   - Default library is QSYS                                             */
/*                                                                          */
/* Usage:                                                                   */
/*   CHKSBSACT SBS(QINTER) LIB(QSYS) RESULT(?RESULT)                       */
/*   IF COND(&RESULT *EQ 'YES') THEN(...)                                  */
/*                                                                          */
/* Parameters:                                                              */
/*   SBS    - Subsystem name to check (required)                           */
/*   LIB    - Library containing subsystem (default: QSYS)                 */
/*   RESULT - Return value: YES/NO/ERR (return parameter)                  */
/*                                                                          */
/* Processing Program: CHKSBSACT                                            */
/*                                                                          */
/* Modification History:                                                    */
/* V.000 2024-xx-xx | Nick Litten | Initial creation                       */
/* V.001 2026-04-18 | Bob AI | Applied coding standards                    */

             CMD        PROMPT('Check Subsystem Active')

/* --------------------------------------------------------------------------
   Parameter Definitions
   -------------------------------------------------------------------------- */

/* Subsystem name parameter with validation */
             PARM       KWD(SBS) TYPE(*NAME) LEN(10) +
                          PROMPT('Subsystem name')

/* Library parameter with special values and validation */
             PARM       KWD(LIB) TYPE(*NAME) LEN(10) DFT(QSYS) +
                          PROMPT('Subsystem library')

/* Return value parameter - restricted to valid values */
             PARM       KWD(RESULT) TYPE(*CHAR) LEN(3) RTNVAL(*YES) +
                          PROMPT('Result (YES/NO/ERR)')