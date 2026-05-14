**free

///
/// Program: HELLOADV - Advanced Hello World
///
/// Description: Advanced Hello World demonstrating modern RPG best practices
///              including main procedure pattern, interactive user input, and
///              professional program structure. This example builds upon the
///              basic Hello World to show real-world programming patterns.
///
/// Purpose: Educational example demonstrating:
///   - Main procedure pattern (no RPG cycle overhead)
///   - Interactive user prompts with validation
///   - Local variable scoping within procedures
///   - Professional code organization and structure
///   - Copybook includes for standardization
///
/// Features:
///   - Modern main(mainline) control option
///   - Interactive DSPLY with user response validation
///   - DO-UNTIL loop for input validation
///   - Case-insensitive input handling with %UPPER
///   - PCML embedding for web service integration
///   - Version tracking via copyright option
///
/// Control Options:
///   - main(mainline): Eliminates RPG cycle, uses main procedure
///   - pgminfo(*pcml:*module): Embeds parameter metadata
///   - copyright: Version info accessible via DSPPGM
///
/// Usage: CALL HELLOADV
///
/// User Interaction:
///   1. Displays "Hello World!" message
///   2. Prompts user to press Y to continue
///   3. Validates input and repeats until Y is entered
///
/// Copybooks Required:
///   - header.rpgleinc: Standard control options
///
/// Modification History:
///   V.000 2020.03.14 | Nick Litten | Initial creation
///   2026-04-02 | Bob AI | Added comprehensive documentation
///

/include 'header.rpgleinc'

ctl-opt
  copyright('HelloAdvanced | V.000 | Sample Stylised RPG Program')
  ;
// Procedure: mainline
// Description: Main entry point for the program.
Dcl-Proc mainline;
  Dcl-Pi mainline;
  end-pi;

  Dcl-S msg char(50);
  Dcl-S reply char(1);

  msg = 'Hello World!';
  dsply msg;

  msg = 'Press Y to continue';
  Dou (%upper(reply) = 'Y');
    dsply msg '' reply;
  enddo;

  Return;

end-proc;