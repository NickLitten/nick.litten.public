/******************************************************************************/
/* Command: PWDEXPMON - Password Expiration Monitor                          */
/* Description: Monitors user profiles for expiring passwords                */
/*                                                                            */
/* Parameters:                                                                */
/*   DAYS - Number of days to look ahead for expiring passwords              */
/*                                                                            */
/* Usage Examples:                                                            */
/*   PWDEXPMON DAYS(7)   - Check for passwords expiring in next 7 days       */
/*   PWDEXPMON DAYS(14)  - Check for passwords expiring in next 14 days      */
/*                                                                            */
/* Modification History:                                                      */
/* v.001 2026.02.03 - Nick Litten - Created                                   */
/******************************************************************************/

             CMD        PROMPT('Password Expiration Monitor')

             PARM       KWD(DAYS) TYPE(*DEC) LEN(3 0) DFT(7) +
                          MIN(0) MAX(1) PROMPT('Days until expiration')