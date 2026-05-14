**free

///
/// Program: {PROGRAM_NAME}
///
/// Description: {DESCRIPTION}
///
/// Purpose: {PURPOSE}
///   - {PURPOSE_ITEM_1}
///   - {PURPOSE_ITEM_2}
///   - {PURPOSE_ITEM_3}
///
/// Features:
///   - {FEATURE_1}
///   - {FEATURE_2}
///   - {FEATURE_3}
///
/// Usage: {USAGE_EXAMPLE}
///
/// Parameters:
///   - {PARAM_1}: {PARAM_1_DESC}
///   - {PARAM_2}: {PARAM_2_DESC}
///
/// Dependencies:
///   - {DEPENDENCY_1}
///   - {DEPENDENCY_2}
///
/// Reference:
///   {REFERENCE_URL}
///
/// Modification History:
///   {VERSION} {DATE} | {AUTHOR} | {CHANGE_DESCRIPTION}
///

/include 'header.rpgleinc'

ctl-opt
  copyright('PROGNAME | V.000 | Brief description')
  ;

// --------------------------------------------------------------------------
// File Declarations
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Named Constants
// --------------------------------------------------------------------------
Dcl-C CONSTANT_NAME 'value';

// --------------------------------------------------------------------------
// Data Structures
// --------------------------------------------------------------------------
Dcl-Ds DataStructureName qualified;
   field1 char(10);
   field2 packed(7:2);
end-ds;

// --------------------------------------------------------------------------
// Standalone Variables
// --------------------------------------------------------------------------
Dcl-S variableName char(10);

// --------------------------------------------------------------------------
// Main Program Logic
// --------------------------------------------------------------------------
Dcl-Proc mainline;
  
   // Program logic here
  
   *inlr = *on;
   Return;
  
end-proc;

// --------------------------------------------------------------------------
// Procedure: ProcedureName
// Description: What this procedure does
// Parameters:
//   - parm1: Description
// Returns: Description of return value
// --------------------------------------------------------------------------
Dcl-Proc ProcedureName;
  
   Dcl-Pi *n;
      pParameter1 char(10) const;
      pParameter2 packed(7:2);
   end-pi;
  
   // Local variables
   Dcl-S errorMsg varchar(256);
  
   // Procedure logic with error handling
   Monitor;
      
      // Main procedure logic here
      
   On-Error;
      // Log error details
      errorMsg = 'Error in ProcedureName: ' + %trim(%char(%error));
      // Handle error appropriately
      // - Log to job log
      // - Return error indicator
      // - Throw exception to caller
      
      On-Exit;
         // Cleanup operations that run regardless of success or error
         // - Close files
         // - Release locks
         // - Free allocated resources
         // - Log procedure exit
      EndMon;
  
end-proc;