**free
///
/// Program: {PROGRAM_NAME} - {BRIEF_DESCRIPTION}
/// Description: {DETAILED_DESCRIPTION}
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
/// Usage:
///   CALL {PROGRAM_NAME} PARM({PARM1} {PARM2})
///
/// Parameters:
///   parm1 - {TYPE} - {DESCRIPTION}
///   parm2 - {TYPE} - {DESCRIPTION}
///
/// Returns:
///   {RETURN_DESCRIPTION}
///
/// Dependencies:
///   - {DEPENDENCY_1}
///   - {DEPENDENCY_2}
///
/// Compilation:
///   CRTRPGMOD MODULE(LIB/{PROGRAM_NAME}) SRCFILE(LIB/QRPGLESRC)
///   CRTPGM PGM(LIB/{PROGRAM_NAME}) MODULE(LIB/{PROGRAM_NAME})
///
/// Author: Nick Litten
///
/// Modification History:
/// v.001 {CURRENT_DATE} - Nick Litten - Initial creation
///

ctl-opt dftactgrp(*no) actgrp(*new)
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
// MAIN PROCEDURE
// ------------------------------------------------------------------------------

// Program parameters
Dcl-Pi *n;
   // Define parameters here
end-pi;

// Local variables
Dcl-S success ind inz(*on);

// Main processing
monitor;
   // Your code here
   
on-error;
   success = *off;
endmon;

*inlr = *on;
Return;