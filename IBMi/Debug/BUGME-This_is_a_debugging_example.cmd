/* -------------------------------------------------------------------------- */
/* Command: BUGME - Debugging Example Command                                 */
/* Description: Simple command for testing and debugging CL programs          */
/*                                                                            */
/* Purpose: Educational example demonstrating:                                */
/*   - Basic command definition                                              */
/*   - Single parameter with default value                                   */
/*   - Command prompting                                                     */
/*                                                                            */
/* Parameters:                                                                */
/*   DEBUGPARM - Character parameter for testing (default: 'NICHOLAS')       */
/*                                                                            */
/* Usage Examples:                                                            */
/*   BUGME                          - Uses default value                     */
/*   BUGME DEBUGPARM('TEST')        - Passes custom value                    */
/*                                                                            */
/* Processing Program: BUGMERPG or BUGMECL                                    */
/*                                                                            */
/* Reference:                                                                 */
/*   - IBM i CL Programming Guide                                            */
/*   - Command Definition Reference                                          */
/*   - https://www.nicklitten.com/ibm-i-debugging/                           */
/*                                                                            */
/* Modification History:                                                      */
/* v.001 2024-xx-xx - Nick Litten - Created                                   */
/* v.002 2026-05-14 - Bob AI - Added comprehensive documentation              */
/* -------------------------------------------------------------------------- */

CMD PROMPT('This is a debugging example')
PARM KWD(DEBUGPARM) TYPE(*CHAR) LEN(100) DFT('NICHOLAS') PROMPT('This is a debugging example')