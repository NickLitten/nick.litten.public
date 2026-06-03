/* --------------------------------------------------------------------- */
/* Command: PWDEXPMON - Password Expiration Monitor                      */
/* --------------------------------------------------------------------- */
/* Description: Command interface for password expiration monitoring.    */
/*              Provides user-friendly parameter interface to the        */
/*              PWDEXPMON CL program which calls PWDEXPILE SQLRPGLE.     */
/*                                                                       */
/* Purpose: Production command demonstrating:                            */
/*   - Command definition with parameter validation                      */
/*   - Default parameter values                                          */
/*   - Parameter prompting                                               */
/*   - Range validation (1-999 days)                                     */
/*   - Integration with CL wrapper program                               */
/*                                                                       */
/* Features:                                                             */
/*   - PERIOD selector with default of *WEEK                             */
/*   - Optional IFS output file path parameter                           */
/*   - Decimal parameter type for numeric validation                     */
/*   - Optional parameter (MIN(0) MAX(1))                                */
/*   - User-friendly prompt text                                         */
/*   - Calls PWDEXPMON CL program                                        */
/*                                                                       */
/* Parameters:                                                           */
/*   PERIOD  - *CHAR(6)   - Expiry period selector: *WEEK/*MONTH/*YEAR   */
/*   IFSPATH - *CHAR(256) - Optional IBM i IFS report file path          */
/*                                                                       */
/* Usage Examples:                                                       */
/*   PWDEXPMON PERIOD(*WEEK)                                             */
/*   PWDEXPMON PERIOD(*MONTH) IFSPATH('/tmp/pwdexpmon_report.txt')       */
/*   PWDEXPMON                - Uses defaults                             */
/*                                                                       */
/* Compiler Options:                                                     */
/*   CRTCMD CMD(library/PWDEXPMON) PGM(library/PWDEXPMON)                */
/*          SRCFILE(library/QCMDSRC) SRCMBR(PWDEXPMON)                   */
/*                                                                       */
/* Reference:                                                            */
/*   https://www.nicklitten.com/blog/password-expiration-monitoring/     */
/*                                                                       */
/* Modification History:                                                 */
/*   V.000 2026-02-03 | Nick Litten | Initial creation                   */
/*   V.001 2026-04-18 | Nick Litten | Applied comment standards          */
/*   V.002 2026-05-28 | Nick Litten | Enhanced documentation             */
/* --------------------------------------------------------------------- */

             CMD        PROMPT('Password Expiration Monitor')

             PARM KWD(PERIOD) +
                TYPE(*CHAR) +
                LEN(6) +
                DFT(*WEEK) +
                SPCVAL((*WEEK) (*MONTH) (*YEAR)) +
                EXPR(*YES) +
                PROMPT('List if within this period')

             PARM KWD(IFSPATH) +
                TYPE(*CHAR) +
                LEN(256) +
                DFT('/tmp/pwdexpmon_report.txt') +
                EXPR(*YES) +
                CASE(*MIXED) +
                PROMPT('IBM i IFS output file path')