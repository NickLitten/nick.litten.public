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
/* Modification History:                                                      */
/* v.001 2026-02-20 - IBM Bob - Created                                       */
/* v.002 2026-02-21 - IBM Bob - Added HOMEDIR parameter                      */
/******************************************************************************/

             CMD        PROMPT('Clear Bob Log Files')

/* Home directory parameter */
             PARM       KWD(HOMEDIR) TYPE(*CHAR) LEN(256) +
                          DFT('/home/nicklitten') EXPR(*YES) +
                          CASE(*MIXED) PROMPT('Home directory path')