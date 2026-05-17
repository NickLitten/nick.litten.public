**free

/// Program: HELLOINC - Hello World Using Copybook
///
/// Description: Enhanced "Hello World" program demonstrating the use of
///              copybook includes for standardized program structure. Shows
///              interactive user prompting with DSPLY and loop control.
///
/// Purpose: Educational example demonstrating:
///   - Copybook inclusion (/include directive)
///   - Standard header and variable includes
///   - Interactive DSPLY with reply parameter
///   - DOU loop for user confirmation
///   - String manipulation with %UPPER
///   - Proper program termination with *INLR
///
/// Features:
///   - Uses standard header.rpgleinc for control options
///   - Uses variables.rpgleinc for common declarations
///   - Interactive user prompting
///   - Loop until user confirms with 'Y'
///   - Case-insensitive input handling
///   - Demonstrates copybook standardization
///
/// Usage: CALL HELLOINC
///        Displays: 'Hello World!'
///        Prompts: 'Press Y to continue'
///        Waits for user to enter 'Y' or 'y'
///
/// Dependencies:
///   - Include: header.rpgleinc
///   - Include: variables.rpgleinc
///
/// Reference:
///   https://www.ibm.com/docs/en/i/7.5?topic=definitions-include
///
/// Modification History:
///   1.0 2024-11-22 | Nick Litten | Initial creation
///   1.1 2024-12-11 | Nick Litten | Christmas update
///

/include 'header.rpgleinc'

/include 'variables.rpgleinc'

Dcl-S msg char(50);
Dcl-S reply char(1);

msg = 'Hello World!';
dsply msg;

msg = 'Press Y to continue';
dou (%upper(reply) = 'Y');
   dsply msg '' reply;
enddo;

*inlr = *on;
Return;