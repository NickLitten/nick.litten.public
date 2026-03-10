/* Command: MYSQLCTL - MariaDB/MySQL Service Control                                     */
/* Purpose: Control MySQL/MariaDB database service (start, stop, status, restart)        */
/* Author:  Nick Litten                                                                  */
/* Date:    2026-03-09                                                                   */

             CMD        PROMPT('Control MySQL/MariaDB Server')

             PARM       KWD(ACTION) +
                          TYPE(*CHAR) +
                          LEN(10) +
                          RSTD(*YES) +
                          VALUES(START STOP) +
                          MIN(1) +
                          PROMPT('Action')