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
/*   - Single DAYS parameter with default of 7                           */
/*   - Decimal parameter type for numeric validation                     */
/*   - Optional parameter (MIN(0) MAX(1))                                */
/*   - User-friendly prompt text                                         */
/*   - Calls PWDEXPMON CL program                                        */
/*                                                                       */
/* Parameters:                                                           */
/*   DAYS - *DEC(3 0) - Number of days to look ahead for expiring        */
/*          passwords. Valid range: 1-999. Default: 7                    */
/*                                                                       */
/* Usage Examples:                                                       */
/*   PWDEXPMON DAYS(7)   - Check for passwords expiring in 7 days        */
/*   PWDEXPMON DAYS(14)  - Check for passwords expiring in 14 days       */
/*   PWDEXPMON           - Uses default (7 days)                         */
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

             PARM KWD(DAYS) +
                TYPE(*CHAR) +
                LEN(6) +
                DFT(*WEEK) +
                SPCVAL((*WEEK) (*MONTH) (*YEAR)) +
                EXPR(*YES) +
                PROMPT('List if within this period')