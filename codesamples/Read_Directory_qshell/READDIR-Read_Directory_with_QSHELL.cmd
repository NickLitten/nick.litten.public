/***********************************************************************************/
/* Program Name: READDIR - Read Directory with QSHELL                              */
/* Description:  Command definition to list IFS directory contents using           */
/*               QSHELL utilities                                                  */
/*                                                                                 */
/* Parameters:                                                                     */
/*   DIR    - IFS directory path to list (e.g., /home/bob)                         */
/*   FILTER - File filter pattern (e.g., *.CSV) - defaults to '.' (all)            */
/*                                                                                 */
/* Usage Example:                                                                  */
/*   READDIR DIR('/home/bob') FILTER('*.CSV')                                      */
/*                                                                                 */
/* Author:       Nick Litten                                                       */
/* Created:      [Date]                                                            */
/* Modified:     2026-02-10 - Added header documentation                           */
/* https://www.nicklitten.com/course/list-all-files-in-an-ifs-folder-with-qshell   */
/***********************************************************************************/

CMD        PROMPT('List IFS with QSHELL')

PARM       KWD(DIR) +
           TYPE(CHAR) +
           LEN(255) +
           EXPR(YES) +
           PROMPT('IFS Folder Name ie: /home/bob')

PARM       KWD(FILTER) +
           TYPE(CHAR) +
           LEN(30) +
           DFT('.') +
           EXPR(YES) +
           PROMPT('Filter files (ie: *.CSV)')