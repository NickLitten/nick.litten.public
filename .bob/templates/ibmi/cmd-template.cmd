/* ------------------------------------------------------------------------ */
/*                                                                          */
/* Command: {COMMAND_NAME}                                                  */
/*                                                                          */
/* Description: {DESCRIPTION}                                               */
/*                                                                          */
/* Purpose: {PURPOSE}                                                       */
/*   - {PURPOSE_ITEM_1}                                                     */
/*   - {PURPOSE_ITEM_2}                                                     */
/*   - {PURPOSE_ITEM_3}                                                     */
/*                                                                          */
/* Features:                                                                */
/*   - {FEATURE_1}                                                          */
/*   - {FEATURE_2}                                                          */
/*   - {FEATURE_3}                                                          */
/*                                                                          */
/* Usage:                                                                   */
/*   {USAGE_EXAMPLE}                                                        */
/*                                                                          */
/* Parameters:                                                              */
/*   {PARAM_1} - {PARAM_1_DESC}                                             */
/*   {PARAM_2} - {PARAM_2_DESC}                                             */
/*                                                                          */
/* Processing Program: {PROCESSING_PROGRAM}                                 */
/*                                                                          */
/* Modification History:                                                    */
/*   {VERSION} {DATE} | {AUTHOR} | {CHANGE_DESCRIPTION}                     */
/*                                                                          */
/* ------------------------------------------------------------------------ */

             CMD        PROMPT('{COMMAND_PROMPT}')


/* Parameter 1 */
             PARM       KWD({PARAM_1}) TYPE(*CHAR) LEN(10) +
                          PROMPT('{PARAM_1_PROMPT}')

/* Parameter 2 */
             PARM       KWD({PARAM_2}) TYPE(*CHAR) LEN(10) +
                          DFT(*NONE) SPCVAL((*NONE)) +
                          PROMPT('{PARAM_2_PROMPT}')