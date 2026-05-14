**free

/// Program: BUGMERPG - Debugging Example
///
/// Description: Simple debugging example program based on Hello World that
///              receives a parameter, modifies its value, and returns it to
///              the caller. Designed for practicing debugging techniques such
///              as breakpoints, variable watches, and step-through execution
///              in RDi or other IBM i debuggers.
///
/// Purpose: Educational example demonstrating:
///   - Parameter passing and modification
///   - Main procedure pattern with parameters
///   - String manipulation with %TRIM
///   - Debugging workflow and techniques
///   - Return value modification patterns
///
/// Features:
///   - Accepts character parameter (100 bytes)
///   - Appends debug message to input string
///   - Trims whitespace before concatenation
///   - Returns modified value to caller
///   - Simple logic ideal for debugging practice
///   - Uses copybook includes for standardization
///
/// Usage: CALL BUGMERPG PARM('Test message')
///        Returns: 'Test message - (updated from BUGMERPG!)'
///
/// Parameters:
///   - incomingDebugMsg: char(100) - Input/output message to modify
///
/// Debugging Tips:
///   - Set breakpoint on line with %TRIM operation
///   - Watch incomingDebugMsg variable before and after modification
///   - Step through to observe string concatenation
///   - Practice conditional breakpoints
///
/// Dependencies:
///   - Include: header.rpgleinc
///
/// Control Options:
///   - main(mainline): Uses main procedure pattern
///   - pgminfo(*pcml:*module): Embeds parameter metadata
///   - copyright: Version info for tracking
///
/// Modification History:
/// 1.0 2025-03-27 | Nick Litten | Initial creation
/// 1.1 2026-04-02 | Bob AI | Added comprehensive triple-slash documentation

/include 'header.rpgleinc'

ctl-opt
  copyright('Bug Me RPG | V.000 | Sample RPG Program for Debug')
  ;
// Procedure: mainline
// Description: Main entry point for the program.
Dcl-Proc mainline;
   Dcl-Pi mainline;
      incomingDebugMsg char(100);
   end-pi;

   incomingDebugMsg = %trim(incomingDebugMsg) + ' - (updated from BUGMERPG!)';

   Return;

end-proc;