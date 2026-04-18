**free

///
/// Program: PROGNAME - Brief Program Title
///
/// Description: Comprehensive explanation of the program's purpose and
///              functionality. Use multiple lines as needed with proper
///              indentation for readability.
///
/// Purpose: Educational/Production utility demonstrating:
///   - SQL embedded in RPG for data access
///   - Key concept or pattern #1
///   - Key concept or pattern #2
///   - Additional concepts as needed
///
/// Features:
///   - SQL cursor operations for efficient data retrieval
///   - Specific capability #1
///   - Specific capability #2
///   - Design pattern or best practice demonstrated
///   - Performance considerations
///
/// Control Options:
///   - main(mainline): Eliminates RPG cycle overhead
///   - optimize(*full): Maximum optimization
///   - option(*nodebugio:*srcstmt:*nounref): Debug and compile options
///   - pgminfo(*pcml:*module): Embeds parameter metadata
///   - actgrp(*new/*caller): Activation group strategy
///   - indent('| '): Code indentation character
///   - alwnull(*usrctl): Allow null-capable fields
///
/// SQL Options:
///   - commit(*none): No commitment control
///   - closqlcsr(*endmod): Close cursors at module end
///
/// Usage: CALL PROGNAME or detailed usage instructions
///
/// Parameters (if applicable):
///   - parm1: type - Description of parameter
///   - parm2: type - Description of parameter
///
/// Dependencies:
///   - Database tables or views accessed
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
Dcl-C SQL_SUCCESS '00000';
Dcl-C SQL_NOT_FOUND '02000';
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
// SQL Variables
// --------------------------------------------------------------------------
Dcl-S sqlVariable varchar(100);

// --------------------------------------------------------------------------
// Main Program Logic
// --------------------------------------------------------------------------
Dcl-Proc mainline;
  
   // Set SQL options
   exec sql set option commit = *none, closqlcsr = *endmod;
  
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
  
   // Procedure logic with SQL
   exec sql
    select FIELD1, FIELD2
    into :variableName, :sqlVariable
    from TABLE_NAME
    where KEY_FIELD = :pParameter1;
  
   // Check SQL state
   If (SQLSTATE = SQL_SUCCESS);
      // Process successful query
   ElseIf (SQLSTATE = SQL_NOT_FOUND);
      // Handle not found
   Else;
      // Handle other SQL errors
   EndIf;
  
end-proc;