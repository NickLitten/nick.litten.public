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
/// Usage: CALL HELLOADV
///
/// Parameters:
///   None
///
/// Dependencies:
///   - header.rpgleinc: Standard control options
///
/// Reference:
///   https://www.ibm.com/docs/en/i/7.5?topic=programming-ile-rpg
///
/// Modification History:
///   1.0 2020-03-14 | Nick Litten | Initial creation
///   1.1 2026-04-02 | Nick Litten | Added comprehensive documentation
///

/include 'header.rpgleinc'

ctl-opt
  main(mainline)
  copyright('HelloAdvanced | 1.1 - Sample Stylised RPG Program');

// Include variables from a separate file
/include 'variables.rpgleinc'

// Procedure: mainline
// Description: Main entry point for the program.
Dcl-Proc mainline;
   Dcl-Pi mainline;
   end-pi;

   msg = 'Hello World!';
   dsply msg;

   msg = 'Press Y to continue';
   
   Dou (%upper(reply) = 'Y');
      dsply msg '' reply;
   enddo;

   // Indicate successful completion using 'success' which is defined in variables.rpgleinc
   success = *on;

   Return;

   on-exit success;

      If (not success);
         // Handle abnormal end
      Else;
         // do *normal* program closure items - close files, etc
      EndIf;

end-proc;