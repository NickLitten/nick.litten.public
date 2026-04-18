**free

///
/// Program: PROGNAME - Brief Program Title
///
/// Description: Comprehensive explanation of the program's purpose and
///              functionality. Use multiple lines as needed with proper
///              indentation for readability.
///
/// Purpose: Educational/Production utility demonstrating:
///   - Key concept or pattern #1
///   - Key concept or pattern #2
///   - Key concept or pattern #3
///   - Additional concepts as needed
///
/// Features:
///   - Specific capability #1
///   - Specific capability #2
///   - Design pattern or best practice demonstrated
///   - Performance considerations
///   - Integration points
///
/// Control Options:
///   - main(mainline): Eliminates RPG cycle overhead
///   - optimize(*full): Maximum optimization
///   - option(*nodebugio:*srcstmt:*nounref): Debug and compile options
///   - pgminfo(*pcml:*module): Embeds parameter metadata
///   - actgrp(*new/*caller): Activation group strategy
///   - indent('| '): Code indentation character
///
/// Usage: CALL PROGNAME or detailed usage instructions
///
/// Parameters (if applicable):
///   - parm1: type - Description of parameter
///   - parm2: type - Description of parameter
///
/// Dependencies:
///   - Required files, service programs, or APIs
///   - External resources needed
///
/// Copybooks Required:
///   - header.rpgleinc: Standard control options
///   - Other includes as needed
///
/// Reference:
/// https://www.nicklitten.com/relevant-blog-post-url
///
/// Modification History:
///   V.000 YYYY-MM-DD | Nick Litten | Initial creation
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
  
   // Procedure logic
  
end-proc;