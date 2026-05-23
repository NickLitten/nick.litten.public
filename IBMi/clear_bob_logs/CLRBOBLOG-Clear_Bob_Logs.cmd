/******************************************************************************/
/* Command: CLRBOBLOG - Clear Bob Log Files                                  */
/* Description: Lists and deletes specific log files from a home directory   */
/*                                                                            */
/* Parameters:                                                                */
/*   HOMEDIR   - Home directory path (e.g., /home/nicklitten)                */
/*                                                                            */
/* Files Deleted:                                                             */
/*   - core.*                                                                 */
/*   - javacore.*                                                             */
/*   - jitdump.*                                                              */
/*   - Snap.*                                                                 */
/*                                                                            */
/* Usage Examples:                                                            */
/*   CLRBOBLOG HOMEDIR('/home/nicklitten')                                   */
/*   CLRBOBLOG HOMEDIR('/home/myuser')                                       */
/*                                                                            */
/* Reference:                                                                 */
/*   - IBM i IFS Programming Guide                                           */
/*   - QSH Command Reference                                                 */
/*   - https://www.nicklitten.com/ibm-i-ifs-cleanup/                         */
/*                                                                            */
/* Modification History:                                                      */
/*   1.0 2026-02-20 | Nick Litten | Initial creation                         */
/*   2.0 2026-02-21 | Nick Litten | Added HOMEDIR parameter                  */
/*   3.0 2026-05-14 | Nick Litten | Added Reference section                  */
/*   3.1 2026-05-23 | Nick Litten | Standardized documentation format        */
/******************************************************************************/

             CMD        PROMPT('Clear Bob Log Files')

/* Home directory parameter */
             PARM       KWD(HOMEDIR) TYPE(*CHAR) LEN(256) +
                          DFT('/home/nicklitten') EXPR(*YES) +
                          CASE(*MIXED) PROMPT('Home directory path')