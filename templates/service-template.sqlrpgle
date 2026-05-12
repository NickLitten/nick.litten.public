**free

///
/// Service Program: {SERVICE_NAME}
///
/// Description: {DESCRIPTION}
///
/// Purpose: Reusable service program providing:
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
///   dcl-pr {PROCEDURE_1} extproc(*dclcase);
///     parm1 char(10) const;
///     parm2 packed(15:2);
///   end-pr;
///
/// Dependencies:
///   - Binder source: {SERVICE_NAME}.BND
///   - Binding directory: NICKLITTEN
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
ctl-opt bnddir('NICKLITTEN');

// ---------------------------------------------------------------------------
// Prototypes
// ---------------------------------------------------------------------------

// Public procedures (exported)
dcl-pr {PROCEDURE_1} export;
   parm1 char(10) const;
   parm2 packed(15:2);
end-pr;

dcl-pr {PROCEDURE_2} export;
   parm1 char(10) const;
end-pr;

// Private procedures (internal use only)
dcl-pr validateInput ind;
   input char(10) const;
end-pr;

// ---------------------------------------------------------------------------
// Global Variables (module scope)
// ---------------------------------------------------------------------------

Dcl-S initialized ind inz(*off);
Dcl-S errorMessage char(256);

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

   // Initialize if needed
   If not initialized;
      initialize();
   EndIf;

   // Validate input
   If not validateInput(parm1);
      parm2 = 0;
      Return;
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
/// Returns: Nothing
///
Dcl-Proc {PROCEDURE_2} export;
   Dcl-Pi *n;
      parm1 char(10) const;
   end-pi;

   // Local variables
   Dcl-S localVar char(10);

   // Process logic here
   localVar = %trim(parm1);

end-proc;

// ---------------------------------------------------------------------------
// Private Procedures
// ---------------------------------------------------------------------------

///
/// Procedure: validateInput
/// Description: Validates input parameters
/// Parameters:
///   - input: Value to validate
/// Returns: *on if valid, *off if invalid
///
Dcl-Proc validateInput;
   Dcl-Pi *n ind;
      input char(10) const;
   end-pi;

   // Validation logic
   If %trim(input) = '';
      Return *off;
   EndIf;

   Return *on;

end-proc;

///
/// Procedure: initialize
/// Description: Initialize service program resources
/// Parameters: None
/// Returns: Nothing
///
Dcl-Proc initialize;
   Dcl-Pi *n end-pi;

   // Initialization logic
   errorMessage = '';
   initialized = *on;

end-proc;