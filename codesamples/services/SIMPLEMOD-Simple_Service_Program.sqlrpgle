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
  thread(*serialize)
  copyright('SIMPLEMOD | V.001 | Simple service program example')
  ;

// ------------------------------------------------------------------------------
// Procedure: GetSystemName
// Description: Retrieves the current IBM i system name using SQL
/// Parameters:
//   - systemName: char(8) - Output parameter containing system name
// Returns: None (void procedure)
// ------------------------------------------------------------------------------
Dcl-Proc GetSystemName export;
   Dcl-Pi *n;
      systemName char(8);
   end-pi;
    
   exec sql
      VALUES CURRENT SERVER INTO :systemName ;

   Return;

end-proc;