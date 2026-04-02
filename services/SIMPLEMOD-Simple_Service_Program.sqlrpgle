**free
//
// Service Program: SIMPLEMOD - Simple Service Program
// Description: Provides basic system information procedures
//
// Exports:
//   - getsystemname() - Returns the current IBM i system name
//
// Modification History:
// v.001 2026.04.02 - Nick Litten - Created simple service program example
//

ctl-opt
     nomain
     option(*nodebugio:*srcstmt:*nounref)
     copyright('SIMPLEMOD | V.001 | Simple Service Program');

// ------------------------------------------------------------------------------
// Procedure: getsystemname
// Description: Retrieves the current IBM i system name using SQL CURRENT SERVER
// Parameters:
//   systemname - Output: System name (8 chars, blank-filled on error)
// Returns: System name via output parameter
// Example:
//   dcl-s mySystem char(8);
//   getsystemname(mySystem);
// ------------------------------------------------------------------------------
dcl-proc getsystemname export;
  dcl-pi getsystemname;
    systemname char(8);
  end-pi;
    
  exec sql
      VALUES CURRENT SERVER INTO :systemname ;

  return;

end-proc;