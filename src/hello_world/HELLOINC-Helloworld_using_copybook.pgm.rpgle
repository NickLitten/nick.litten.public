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
/// Control Options:
///   - main(mainline): Uses modern main procedure pattern
///   - pgminfo(*pcml:*module): Embeds parameter info for IWS
///   - copyright: Stores version info accessible via DSPPGM
///
/// Usage: CALL HELLOINC
///
/// Copybooks Required:
///   - header.rpgleinc: Standard control options and setup
///   - variables.rpgleinc: Common variable declarations
///
/// Modification History:
///   V.000 2024.11.22 | Nick Litten | Initial creation
///   V.001 2024.12.11 | Nick Litten | Christmas update
///   2026-04-02 | Bob AI | Added comprehensive documentation
///

/include 'header.rpgleinc'

ctl-opt
  copyright('HelloAlternate | V.001 | Sample Stylised RPG Program');

/include 'variables.rpgleinc'

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

   on-exit success;

      If not success;
         // Handle abnormal end
      Else;
         // do *normal* program closure items - close files, etc
      EndIf;

end-proc;