**free

/// Program: HELLOADV - Advanced Hello World
///
/// Description: Advanced "Hello World" program demonstrating modern RPG
///              programming patterns including main procedure, error handling
///              with MONITOR/ON-ERROR, and ON-EXIT section with PSDS for
///              comprehensive error reporting.
///
/// Purpose: Educational example demonstrating:
///   - Main procedure pattern with main(mainline)
///   - Program Status Data Structure (PSDS) for error handling
///   - MONITOR/ON-ERROR/ON-EXCP exception handling
///   - ON-EXIT section for cleanup and error reporting
///   - Interactive DSPLY with reply parameter
///   - DOU loop for user confirmation
///   - Global error flag pattern
///
/// Features:
///   - Uses copybook includes for standardization
///   - Main procedure entry point (not RPG cycle)
///   - Comprehensive error handling framework
///   - PSDS captures program status and error details
///   - ON-EXIT ensures error reporting before termination
///   - Interactive user prompting with loop control
///   - Demonstrates production-ready error patterns
///
/// Usage: CALL HELLOADV
///        Displays: 'Hello World!'
///        Prompts: 'Press Y to continue'
///        Waits for user to enter 'Y' or 'y'
///        Reports any errors via PSDS on exit
///
/// Error Handling:
///   - MONITOR block catches runtime exceptions
///   - ON-EXCP catches specific exception conditions
///   - ON-ERROR catches general errors
///   - ON-EXIT reports errors using PSDS data
///   - Displays program name, status, message ID, and data
///
/// Dependencies:
///   - Include: header.rpgleinc
///
/// Reference:
///   https://www.ibm.com/docs/en/i/7.5?topic=procedures-main
///   https://www.ibm.com/docs/en/i/7.5?topic=structures-program-status-data-structure
///
/// Modification History:
///   1.0 2020-03-14 | Nick Litten | Initial creation
///   1.1 2026-05-15 | Nick Litten | Added on-exit error handler with PSDS
///

ctl-opt
  dftactgrp(*no)
  actgrp(*caller)
  bnddir('MYBNDDIR')
  main(mainline)
  copyright('Hello Advanced | 1.1 - Sample Stylised RPG Program');

// ---
// Program Status Data Structure for error handling
// ---
Dcl-Ds pgmStatus psds qualified;
   pgmName *proc;
   status *status;
   msgId char(7) pos(40);
   msgData char(80) pos(91);
End-Ds;

// ---
// Global error flag
// ---
Dcl-S errorOccurred ind inz(*off);

// ---
// Procedure: mainline
// Description: Main entry point for the program.
// ---
Dcl-Proc mainline;
   Dcl-Pi mainline;
   end-pi;

   Dcl-S msg char(50);
   Dcl-S reply char(1);

   monitor;

      msg = 'Hello World!';
      dsply msg;

      msg = 'Press Y to continue';
      Dou (%upper(reply) = 'Y');
         dsply msg '' reply;
      enddo;

   on-error;
      errorOccurred = *on;
   endmon;

   // ---
   // On-Exit Section: Error Handler
   // ---
   On-Exit;
      If (errorOccurred or pgmStatus.status >= 100);
         Dsply ('Error in ' + %trim(pgmStatus.pgmName));
         Dsply ('Status: ' + %char(pgmStatus.status));
         If (pgmStatus.msgId <> *blanks);
            Dsply ('Message ID: ' + pgmStatus.msgId);
            Dsply ('Message Data: ' + %trim(pgmStatus.msgData));
         EndIf;
      EndIf;

      Return;
end-proc;