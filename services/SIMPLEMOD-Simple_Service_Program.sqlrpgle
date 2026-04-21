**free

///
/// Service Program: SIMPLEMOD - Simple Service Program Example
///
/// Description: Educational example demonstrating a basic ILE service program
///              with a single exported procedure. This service program provides
///              a simple utility function to retrieve the current system name
///              using embedded SQL.
///
/// Purpose: Educational example demonstrating:
///   - Service program creation (NOMAIN)
///   - Exported procedure definition
///   - Embedded SQL in service programs
///   - CURRENT SERVER SQL function
///   - Basic procedure interface (PI) definition
///
/// Features:
///   - Single exported procedure: GetSystemName
///   - Uses embedded SQL for system information
///   - Thread-safe design
///   - Simple parameter passing
///   - No main procedure (NOMAIN)
///
/// Exported Procedures:
///   - GetSystemName: Returns the current IBM i system name
///
/// Usage Example:
///   dcl-pr GetSystemName extpgm('SIMPLEMOD');
///     systemName char(8);
///   end-pr;
///   
///   dcl-s mySystem char(8);
///   GetSystemName(mySystem);
///
/// Binding:
///   Create with binder source SIMPLESRV.bnd
///   CRTSRVPGM SRVPGM(library/SIMPLEMOD) MODULE(SIMPLEMOD) +
///             EXPORT(*SRCFILE) SRCFILE(QSRVSRC) SRCMBR(SIMPLESRV)
///
/// Reference:
/// https://www.nicklitten.com/blog/ile-service-programs/
///
/// Modification History:
///   V.000 2020-01-15 | Nick Litten | Initial creation
///   V.001 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

ctl-opt
     nomain
     option(*nodebugio:*srcstmt:*nounref)
     copyright('SIMPLEMOD | V.001 | Simple Service Program');

// ------------------------------------------------------------------------------
// Procedure: RtnSystemName
// Description: Returns the current IBM i system name using SQL CURRENT SERVER
//              special register. The system name is left-justified and padded
//              with blanks to 8 characters.
//
// Parameters:
//   systemname - Output parameter (char 8)
//                Returns the current system name, blank-padded to 8 characters.
//                On SQL error, returns blanks.
//
// Returns: None (void procedure)
//
// SQL Behavior:
//   - Uses CURRENT SERVER special register
//   - No SQL error handling implemented (relies on default *EVENTF behavior)
//   - SQLCODE/SQLSTATE available in calling program if needed
//
// Example Usage:
//   dcl-s mySystem char(8);
//   RtnSystemName(mySystem);
//   // mySystem now contains system name like 'MYSYSTEM'
//
// Notes:
//   - System name is typically 8 characters or less
//   - Consider adding error handling for production use
//   - Thread-safe (no static variables)
// ------------------------------------------------------------------------------
Dcl-Proc RtnSystemName export;
   Dcl-Pi *n char(8);
   end-pi;
  
   // Local variables
   Dcl-S systemname char(8) inz;
   Dcl-S sqlCode int(10);
   Dcl-S sqlState char(5);
    
   // Retrieve system name using SQL special register
   exec sql
    VALUES CURRENT SERVER INTO :systemname;
  
   Return systemname;

end-proc;