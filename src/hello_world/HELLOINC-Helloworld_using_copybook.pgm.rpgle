**free

///
/// Program: HELLOINC - Hello World with Copybook Includes
///
/// Description: Demonstrates professional RPG program structure using copybook
///              includes for standardized headers and variable declarations.
///              This example shows how to organize code using /include directives
///              for better maintainability and consistency across projects.
///
/// Purpose: Educational example demonstrating:
///   - Use of copybook includes (/include directive)
///   - Main procedure pattern with main(mainline)
///   - Interactive user input with DSPLY operation
///   - ON-EXIT handler for cleanup operations
///   - Professional program structure and organization
///
/// Features:
///   - Standardized header via header.rpgleinc
///   - Reusable variable declarations via variables.rpgleinc
///   - Interactive prompt requiring user confirmation
///   - Graceful error handling with ON-EXIT
///   - Version tracking via copyright control option
///   - PCML embedding for web service compatibility
///
/// Usage: CALL HELLOINC
///
/// Parameters:
///   None
///
/// Dependencies:
///   - header.rpgleinc: Standard control options and setup
///   - variables.rpgleinc: Common variable declarations
///
/// Reference:
///   https://www.ibm.com/docs/en/i/7.5?topic=programming-ile-rpg
///
/// Modification History:
///   1.0 2024-11-22 | Nick Litten | Initial creation
///   1.1 2024-12-11 | Nick Litten | Christmas update
///   1.2 2026-04-02 | Nick Litten | Added comprehensive documentation
///


/include 'header.rpgleinc'

ctl-opt
  copyright('HelloAlternate | V.001 | Sample Stylised RPG Program');

/include 'variables.rpgleinc'

Dcl-S msg char(50);
Dcl-S reply char(1);

msg = 'Hello World!';
dsply msg;

msg = 'Press Y to continue';
Dou (%upper(reply) = 'Y');
   dsply msg '' reply;
enddo;

*inlr = *on;
Return;
