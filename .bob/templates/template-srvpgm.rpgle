**free
///
/// Service Program: {SRVPGM_NAME} - {BRIEF_DESCRIPTION}
/// Description: {DETAILED_DESCRIPTION}
///
/// Exported Procedures:
///   - {PROCEDURE_1}() - {DESCRIPTION_1}
///   - {PROCEDURE_2}() - {DESCRIPTION_2}
///
/// Purpose:
///   - {PURPOSE_1}
///   - {PURPOSE_2}
///   - {PURPOSE_3}
///
/// Features:
///   - {FEATURE_1}
///   - {FEATURE_2}
///   - {FEATURE_3}
///
/// Compilation:
///   CRTRPGMOD MODULE(LIB/{SRVPGM_NAME}) SRCFILE(LIB/QRPGLESRC)
///   CRTSRVPGM SRVPGM(LIB/{SRVPGM_NAME}) MODULE(LIB/{SRVPGM_NAME}) +
///             EXPORT(*ALL) BNDDIR(LIB/BNDDIR)
///
/// Author: Nick Litten
///
/// Modification History:
/// v.001 {CURRENT_DATE} - Nick Litten - Initial creation
///

ctl-opt nomain
        option(*nodebugio:*srcstmt:*nounref)
        copyright('v.001 - {BRIEF_DESCRIPTION}');

// ------------------------------------------------------------------------------
// CONSTANTS
// ------------------------------------------------------------------------------


// ------------------------------------------------------------------------------
// GLOBAL DATA STRUCTURES
// ------------------------------------------------------------------------------


// ------------------------------------------------------------------------------
// PROTOTYPES
// ------------------------------------------------------------------------------


// ------------------------------------------------------------------------------
// PROCEDURE: {PROCEDURE_NAME}
// ------------------------------------------------------------------------------
// Description: {PROCEDURE_DESCRIPTION}
//
// Parameters:
//   p_input1  - {TYPE} const - {DESCRIPTION}
//   p_output1 - {TYPE} options(*nopass:*omit) - {DESCRIPTION}
//
// Returns:
//   {RETURN_TYPE} - {RETURN_DESCRIPTION}
//
// Error Handling:
//   - {ERROR_HANDLING_1}
//   - {ERROR_HANDLING_2}
//
// Example Usage:
//   dcl-s result {RETURN_TYPE};
//   result = {PROCEDURE_NAME}({PARAM1});
//   if result;
//      // Success
//   endif;
//
// Notes:
//   - Thread-safe (no static variables)
//   - {NOTE_1}
// ------------------------------------------------------------------------------
Dcl-Proc {PROCEDURE_NAME} export;
   Dcl-Pi *n {RETURN_TYPE};
      p_input1 {TYPE} const;
      p_output1 {TYPE} options(*nopass:*omit);
   end-pi;
   
   // Local variables
   Dcl-S result {RETURN_TYPE};
   
   // Procedure implementation
   
   Return result;
   
end-proc;