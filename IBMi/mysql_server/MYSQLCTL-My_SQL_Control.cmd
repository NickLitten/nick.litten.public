/* -------------------------------------------------------------------------- */
/* Command: MYSQLCTL - MariaDB/MySQL Service Control                          */
/* Description: Controls MySQL/MariaDB database service operations            */
/*                                                                            */
/* Purpose: Utility command demonstrating:                                    */
/*   - Service control command definition                                    */
/*   - Restricted parameter values                                           */
/*   - Service management operations                                         */
/*                                                                            */
/* Parameters:                                                                */
/*   ACTION - Service action to perform (START or STOP)                      */
/*                                                                            */
/* Usage Examples:                                                            */
/*   MYSQLCTL ACTION(START)  - Start MariaDB service                         */
/*   MYSQLCTL ACTION(STOP)   - Stop MariaDB service                          */
/*                                                                            */
/* Processing Program: MYSQLCTL                                               */
/*                                                                            */
/* Reference:                                                                 */
/*   - MariaDB on IBM i Documentation                                        */
/*   - systemctl Command Reference                                           */
/*   - https://www.nicklitten.com/ibm-i-mariadb-setup/                       */
/*                                                                            */
/* Modification History:                                                      */
/* v.001 2026-03-09 - Nick Litten - Created                                   */
/* v.002 2026-05-14 - Bob AI - Added comprehensive documentation              */
/* -------------------------------------------------------------------------- */

             CMD        PROMPT('Control MySQL/MariaDB Server')

             PARM       KWD(ACTION) +
                          TYPE(*CHAR) +
                          LEN(10) +
                          RSTD(*YES) +
                          VALUES(START STOP) +
                          MIN(1) +
                          PROMPT('Action')