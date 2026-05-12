**free

///
/// Module: {MODULE_NAME}
///
/// Description: {DESCRIPTION}
///
/// Purpose: Reusable module providing:
///   - {PURPOSE_ITEM_1}
///   - {PURPOSE_ITEM_2}
///   - {PURPOSE_ITEM_3}
///
/// Features:
///   - {FEATURE_1}
///   - {FEATURE_2}
///   - {FEATURE_3}
///
/// Exported Procedures:
///   - {PROCEDURE_1}: {PROCEDURE_1_DESC}
///   - {PROCEDURE_2}: {PROCEDURE_2_DESC}
///
/// Usage:
///   This module is compiled separately and bound into programs or service programs.
///   Include the procedure prototypes in calling programs.
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

ctl-opt copyright('{VERSION} - {DESCRIPTION}');
ctl-opt nomain;
ctl-opt option(*srcstmt: *nodebugio);

// ---------------------------------------------------------------------------
// Prototypes
// ---------------------------------------------------------------------------

// Public procedures (exported)
dcl-pr {PROCEDURE_1} export;
   parm1 char(10) const;
   parm2 packed(15:2);
end-pr;

dcl-pr {PROCEDURE_2} export char(10);
   parm1 char(10) const;
end-pr;

// Private procedures (internal use only)
dcl-pr internalHelper ind;
   input char(10) const;
end-pr;

// ---------------------------------------------------------------------------
// Global Variables (module scope)
// ---------------------------------------------------------------------------

Dcl-S moduleInitialized ind inz(*off);

// ---------------------------------------------------------------------------
// Public Procedures
// ---------------------------------------------------------------------------

///
/// Procedure: {PROCEDURE_1}
/// Description: {PROCEDURE_1_DESC}
/// Parameters:
///   - parm1: Input parameter description
///   - parm2: Output parameter description
/// Returns: Nothing (updates parm2)
///
Dcl-Proc {PROCEDURE_1} export;
   Dcl-Pi *n;
      parm1 char(10) const;
      parm2 packed(15:2);
   end-pi;

   // Local variables
   Dcl-S result packed(15:2);

   // Initialize module if needed
   If not moduleInitialized;
      initializeModule();
   EndIf;

   // Process logic here
   result = 0;

   // Return result
   parm2 = result;

end-proc;

///
/// Procedure: {PROCEDURE_2}
/// Description: {PROCEDURE_2_DESC}
/// Parameters:
///   - parm1: Input parameter description
/// Returns: Processed string value
///
Dcl-Proc {PROCEDURE_2} export;
   Dcl-Pi *n char(10);
      parm1 char(10) const;
   end-pi;

   // Local variables
   Dcl-S result char(10);

   // Process logic here
   result = %trim(parm1);

   Return result;

end-proc;

// ---------------------------------------------------------------------------
// Private Procedures
// ---------------------------------------------------------------------------

///
/// Procedure: internalHelper
/// Description: Internal helper procedure
/// Parameters:
///   - input: Value to process
/// Returns: *on if successful, *off if failed
///
Dcl-Proc internalHelper;
   Dcl-Pi *n ind;
      input char(10) const;
   end-pi;

   // Helper logic
   If %trim(input) = '';
      Return *off;
   EndIf;

   Return *on;

end-proc;

///
/// Procedure: initializeModule
/// Description: Initialize module resources
/// Parameters: None
/// Returns: Nothing
///
Dcl-Proc initializeModule;
   Dcl-Pi *n end-pi;

   // Initialization logic
   moduleInitialized = *on;

end-proc;