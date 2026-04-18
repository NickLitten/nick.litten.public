**free
///
/// Service Program: NICKMOD - Service Program for Lessons
/// Description: This is an ever growing example service program filled with
/// useful procedures and sample code for various scenarios.
///
///
/// Modification History:
/// v.001 2026.04.02 - Nick Litten - Created simple service program example
///

ctl-opt
     nomain
     option(*nodebugio:*srcstmt:*nounref)
     copyright('Service Program for Lessons');

// ------------------------------------------------------------------------------
// Procedure: ReturnSystemName
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
//   ReturnSystemName(mySystem);
//   // mySystem now contains system name like 'MYSYSTEM'
//
// Notes:
//   - System name is typically 8 characters or less
//   - Consider adding error handling for production use
//   - Thread-safe (no static variables)
// ------------------------------------------------------------------------------
dcl-proc ReturnSystemName export;
  dcl-pi *n char(8);
  end-pi;
  
  // Local variables
  dcl-s systemname char(8) inz;
  dcl-s sqlCode int(10);
  dcl-s sqlState char(5);
    
  // Retrieve system name using SQL special register
  exec sql
    VALUES CURRENT SERVER INTO :systemname;
  
  // Capture SQL diagnostics for potential logging/debugging
  // SQLCODE and SQLSTATE are automatically available in embedded SQL
  exec sql
    SET :sqlCode = SQLCODE;
  exec sql
    SET :sqlState = SQLSTATE;
  
  // Comprehensive SQLSTATE error handling
  select;
    // Class 00: Successful completion
    when sqlState = '00000';
      // Success - No error occurred
      // Continue normal processing
      
    // Class 01: Warning
    when sqlState = '01003';
      // Warning - Null values eliminated in set function
      systemname = *blanks;
    when sqlState = '01004';
      // Warning - String data, right truncation occurred
      // Data may be truncated but operation succeeded
    when sqlState = '01503';
      // Warning - Number of result columns is larger than number of host variables
      // Some columns were not retrieved
    when sqlState = '01504';
      // Warning - UPDATE or DELETE without WHERE clause
      // All rows affected
    when sqlState = '01505';
      // Warning - Statement not executed because it is unacceptable in this environment
      systemname = *blanks;
    when sqlState = '01506';
      // Warning - Adjustment made to DECFLOAT or FLOAT value
      // Precision may have been adjusted
    when sqlState = '01517';
      // Warning - Character conversion cannot be performed
      systemname = *blanks;
    when sqlState = '01522';
      // Warning - Constraint violation was ignored
      // Data integrity may be compromised
    when sqlState = '01526';
      // Warning - Isolation level escalated
      // Lock level was increased for consistency
    when sqlState = '01527';
      // Warning - Too many host variables specified
      // Extra variables ignored
    when sqlState = '01528';
      // Warning - WHERE NOT NULL is ignored
      // Clause had no effect
    when sqlState = '01532';
      // Warning - An undefined object name was detected
      systemname = *blanks;
    when sqlState = '01543';
      // Warning - Connection is successful but only supports a limited SQL mode
      // Some features may not be available
    when sqlState = '01565';
      // Warning - Empty string used in arithmetic operation
      // Treated as zero
    when sqlState = '01594';
      // Warning - Insufficient number of entries in an SQL Descriptor Area
      // Some data not retrieved
    when sqlState = '016xx';
      // Warning - Various XQuery warnings (01601-01699)
      // XQuery operation completed with warnings
      
    // Class 02: No data
    when sqlState = '02000';
      // No data - No row found for FETCH, UPDATE, or DELETE
      // Or result of query is empty table
      systemname = *blanks;
    when sqlState = '02001';
      // No data - No additional result sets returned
      // All result sets have been processed
      
    // Class 07: Dynamic SQL error
    when sqlState = '07001';
      // Error - Wrong number of host variables specified
      systemname = *blanks;
    when sqlState = '07002';
      // Error - Host variable list does not match number of parameters
      systemname = *blanks;
    when sqlState = '07003';
      // Error - Cursor specification cannot be executed
      systemname = *blanks;
    when sqlState = '07005';
      // Error - Cursor not open
      systemname = *blanks;
    when sqlState = '07006';
      // Error - Invalid conversion requested
      systemname = *blanks;
    when sqlState = '07009';
      // Error - Invalid descriptor index
      systemname = *blanks;
      
    // Class 08: Connection exception
    when sqlState = '08001';
      // Error - Application server unable to establish connection
      systemname = *blanks;
    when sqlState = '08002';
      // Error - Connection already exists
      systemname = *blanks;
    when sqlState = '08003';
      // Error - Connection does not exist
      systemname = *blanks;
    when sqlState = '08004';
      // Error - Application server rejected establishment of connection
      systemname = *blanks;
    when sqlState = '08006';
      // Error - Connection failure
      systemname = *blanks;
    when sqlState = '08007';
      // Error - Transaction resolution unknown
      systemname = *blanks;
      
    // Class 21: Cardinality violation
    when sqlState = '21000';
      // Error - Scalar subquery or SELECT INTO returned more than one row
      systemname = *blanks;
      
    // Class 22: Data exception
    when sqlState = '22001';
      // Error - Character data, right truncation
      systemname = *blanks;
    when sqlState = '22002';
      // Error - Null value, no indicator variable supplied
      systemname = *blanks;
    when sqlState = '22003';
      // Error - Numeric value out of range
      systemname = *blanks;
    when sqlState = '22004';
      // Error - Null value not allowed
      systemname = *blanks;
    when sqlState = '22005';
      // Error - Error in assignment
      systemname = *blanks;
    when sqlState = '22007';
      // Error - Invalid datetime format
      systemname = *blanks;
    when sqlState = '22008';
      // Error - Datetime field overflow
      systemname = *blanks;
    when sqlState = '22011';
      // Error - Substring error
      systemname = *blanks;
    when sqlState = '22012';
      // Error - Division by zero
      systemname = *blanks;
    when sqlState = '22018';
      // Error - Invalid character value for cast
      systemname = *blanks;
    when sqlState = '22019';
      // Error - Invalid escape character
      systemname = *blanks;
    when sqlState = '22021';
      // Error - Character not in repertoire
      systemname = *blanks;
    when sqlState = '22023';
      // Error - Invalid parameter value
      systemname = *blanks;
    when sqlState = '22024';
      // Error - Unterminated C string
      systemname = *blanks;
    when sqlState = '22025';
      // Error - Invalid escape sequence
      systemname = *blanks;
    when sqlState = '22027';
      // Error - Trim error
      systemname = *blanks;
      
    // Class 23: Integrity constraint violation
    when sqlState = '23000';
      // Error - Integrity constraint violation (generic)
      systemname = *blanks;
    when sqlState = '23001';
      // Error - Restrict violation
      systemname = *blanks;
    when sqlState = '23502';
      // Error - Not null violation
      systemname = *blanks;
    when sqlState = '23503';
      // Error - Foreign key violation
      systemname = *blanks;
    when sqlState = '23504';
      // Error - Check constraint violation
      systemname = *blanks;
    when sqlState = '23505';
      // Error - Unique constraint violation
      systemname = *blanks;
    when sqlState = '23511';
      // Error - Parent key in a parent row cannot be updated
      systemname = *blanks;
    when sqlState = '23512';
      // Error - Delete or update of parent key prevented by NO ACTION
      systemname = *blanks;
    when sqlState = '23513';
      // Error - Row in parent table has dependent rows
      systemname = *blanks;
      
    // Class 24: Invalid cursor state
    when sqlState = '24000';
      // Error - Invalid cursor state
      systemname = *blanks;
    when sqlState = '24501';
      // Error - Cursor not open
      systemname = *blanks;
    when sqlState = '24502';
      // Error - Cursor already open
      systemname = *blanks;
    when sqlState = '24504';
      // Error - Cursor not positioned on locked row
      systemname = *blanks;
    when sqlState = '24506';
      // Error - Cursor position prevents FETCH of current row
      systemname = *blanks;
    when sqlState = '24507';
      // Error - Cursor position prevents UPDATE or DELETE
      systemname = *blanks;
    when sqlState = '24513';
      // Error - FETCH not valid, cursor not scrollable
      systemname = *blanks;
      
    // Class 25: Invalid transaction state
    when sqlState = '25000';
      // Error - Invalid transaction state
      systemname = *blanks;
    when sqlState = '25001';
      // Error - Active SQL transaction
      systemname = *blanks;
    when sqlState = '25006';
      // Error - Read-only SQL transaction
      systemname = *blanks;
      
    // Class 26: Invalid SQL statement identifier
    when sqlState = '26000';
      // Error - Invalid SQL statement identifier
      systemname = *blanks;
      
    // Class 28: Invalid authorization specification
    when sqlState = '28000';
      // Error - Invalid authorization specification
      systemname = *blanks;
      
    // Class 2D: Invalid transaction termination
    when sqlState = '2D000';
      // Error - Invalid transaction termination
      systemname = *blanks;
      
    // Class 2E: Invalid connection name
    when sqlState = '2E000';
      // Error - Invalid connection name
      systemname = *blanks;
      
    // Class 34: Invalid cursor name
    when sqlState = '34000';
      // Error - Invalid cursor name
      systemname = *blanks;
      
    // Class 38: External routine exception
    when sqlState = '38000';
      // Error - External routine exception (generic)
      systemname = *blanks;
    when sqlState = '38001';
      // Error - Containing SQL not permitted
      systemname = *blanks;
    when sqlState = '38002';
      // Error - Modifying SQL-data not permitted
      systemname = *blanks;
    when sqlState = '38003';
      // Error - Prohibited SQL statement attempted
      systemname = *blanks;
    when sqlState = '38004';
      // Error - Reading SQL-data not permitted
      systemname = *blanks;
      
    // Class 39: External routine invocation exception
    when sqlState = '39000';
      // Error - External routine invocation exception (generic)
      systemname = *blanks;
    when sqlState = '39001';
      // Error - Invalid SQLSTATE returned
      systemname = *blanks;
    when sqlState = '39004';
      // Error - Null value not allowed
      systemname = *blanks;
      
    // Class 3B: Savepoint exception
    when sqlState = '3B000';
      // Error - Savepoint exception (generic)
      systemname = *blanks;
    when sqlState = '3B001';
      // Error - Invalid savepoint specification
      systemname = *blanks;
    when sqlState = '3B002';
      // Error - Too many savepoints
      systemname = *blanks;
      
    // Class 40: Transaction rollback
    when sqlState = '40000';
      // Error - Transaction rollback (generic)
      systemname = *blanks;
    when sqlState = '40001';
      // Error - Serialization failure
      systemname = *blanks;
    when sqlState = '40002';
      // Error - Integrity constraint violation
      systemname = *blanks;
    when sqlState = '40003';
      // Error - Statement completion unknown
      systemname = *blanks;
      
    // Class 42: Syntax error or access rule violation
    when sqlState = '42000';
      // Error - Syntax error or access rule violation (generic)
      systemname = *blanks;
    when sqlState = '42501';
      // Error - Authorization failure
      systemname = *blanks;
    when sqlState = '42502';
      // Error - Object does not exist or authorization failure
      systemname = *blanks;
    when sqlState = '42601';
      // Error - SQL syntax error
      systemname = *blanks;
    when sqlState = '42602';
      // Error - Invalid name
      systemname = *blanks;
    when sqlState = '42603';
      // Error - Invalid column name
      systemname = *blanks;
    when sqlState = '42604';
      // Error - Invalid numeric literal
      systemname = *blanks;
    when sqlState = '42605';
      // Error - Number of arguments does not match
      systemname = *blanks;
    when sqlState = '42607';
      // Error - Operation not allowed on system object
      systemname = *blanks;
    when sqlState = '42612';
      // Error - Statement contains unrelated columns
      systemname = *blanks;
    when sqlState = '42704';
      // Error - Undefined object or constraint name
      systemname = *blanks;
    when sqlState = '42710';
      // Error - Duplicate object or constraint name
      systemname = *blanks;
    when sqlState = '42723';
      // Error - Routine already exists with same signature
      systemname = *blanks;
    when sqlState = '42803';
      // Error - Column not in GROUP BY
      systemname = *blanks;
    when sqlState = '42804';
      // Error - Data type mismatch
      systemname = *blanks;
    when sqlState = '42805';
      // Error - Integer in SELECT list not valid
      systemname = *blanks;
    when sqlState = '42809';
      // Error - Object is not the type required
      systemname = *blanks;
    when sqlState = '42810';
      // Error - Base table not specified
      systemname = *blanks;
    when sqlState = '42815';
      // Error - Data type not comparable
      systemname = *blanks;
    when sqlState = '42820';
      // Error - Floating point literal too long
      systemname = *blanks;
    when sqlState = '42824';
      // Error - Operand of LIKE not a string
      systemname = *blanks;
    when sqlState = '42825';
      // Error - Rows from UNION, INTERSECT, or EXCEPT do not match
      systemname = *blanks;
    when sqlState = '42826';
      // Error - Rows from UNION, INTERSECT, or EXCEPT not compatible
      systemname = *blanks;
    when sqlState = '42827';
      // Error - Cannot UPDATE or INSERT into a view
      systemname = *blanks;
    when sqlState = '42828';
      // Error - Cannot modify target table of MERGE
      systemname = *blanks;
    when sqlState = '42829';
      // Error - FOR UPDATE specified for read-only cursor
      systemname = *blanks;
    when sqlState = '42830';
      // Error - Invalid foreign key definition
      systemname = *blanks;
    when sqlState = '42831';
      // Error - Duplicate column name in key definition
      systemname = *blanks;
    when sqlState = '42832';
      // Error - Operation not allowed on system object
      systemname = *blanks;
    when sqlState = '42834';
      // Error - SET NULL not allowed, column cannot contain null
      systemname = *blanks;
    when sqlState = '42836';
      // Error - Recursive common table expression not valid
      systemname = *blanks;
    when sqlState = '42837';
      // Error - Cycle detected in recursive common table expression
      systemname = *blanks;
    when sqlState = '42841';
      // Error - Parameter marker cannot have CAST specification
      systemname = *blanks;
    when sqlState = '42846';
      // Error - Cast not supported between data types
      systemname = *blanks;
    when sqlState = '42866';
      // Error - Data type cannot be specified for parameter marker
      systemname = *blanks;
    when sqlState = '42872';
      // Error - FETCH not valid, cursor not scrollable
      systemname = *blanks;
    when sqlState = '42879';
      // Error - Distinct type cannot be created on this data type
      systemname = *blanks;
    when sqlState = '42880';
      // Error - CAST FROM cannot be specified
      systemname = *blanks;
    when sqlState = '42881';
      // Error - CAST TO cannot be specified
      systemname = *blanks;
    when sqlState = '42882';
      // Error - Specific instance of function does not exist
      systemname = *blanks;
    when sqlState = '42883';
      // Error - No routine found with matching signature
      systemname = *blanks;
    when sqlState = '42884';
      // Error - No routine found with only one specific instance
      systemname = *blanks;
    when sqlState = '42885';
      // Error - Number of elements does not match
      systemname = *blanks;
    when sqlState = '42886';
      // Error - Parameter name required
      systemname = *blanks;
    when sqlState = '42887';
      // Error - Function not defined with RETURNS clause
      systemname = *blanks;
    when sqlState = '42888';
      // Error - Table does not have matching parent key
      systemname = *blanks;
    when sqlState = '42889';
      // Error - Table already has primary key
      systemname = *blanks;
    when sqlState = '42890';
      // Error - Column list required for CREATE VIEW
      systemname = *blanks;
    when sqlState = '42891';
      // Error - Duplicate column name in object definition
      systemname = *blanks;
    when sqlState = '42893';
      // Error - Object or constraint name is reserved for system use
      systemname = *blanks;
    when sqlState = '42894';
      // Error - Default value not valid
      systemname = *blanks;
      
    // Class 44: WITH CHECK OPTION violation
    when sqlState = '44000';
      // Error - WITH CHECK OPTION violation
      systemname = *blanks;
      
    // Class 51: Invalid application state
    when sqlState = '51002';
      // Error - Commit or rollback not allowed
      systemname = *blanks;
    when sqlState = '51003';
      // Error - CONNECT not allowed
      systemname = *blanks;
    when sqlState = '51004';
      // Error - SQL statement not allowed
      systemname = *blanks;
    when sqlState = '51009';
      // Error - CONNECT not allowed in XA environment
      systemname = *blanks;
    when sqlState = '51015';
      // Error - Local program attempted to use remote object
      systemname = *blanks;
    when sqlState = '51021';
      // Error - Constraint cannot be dropped
      systemname = *blanks;
    when sqlState = '51030';
      // Error - Distributed request not supported
      systemname = *blanks;
      
    // Class 53: Insufficient resources
    when sqlState = '53000';
      // Error - Insufficient resources (generic)
      systemname = *blanks;
    when sqlState = '53035';
      // Error - Maximum number of concurrent LOB locators exceeded
      systemname = *blanks;
      
    // Class 54: SQL or product limit exceeded
    when sqlState = '54000';
      // Error - SQL or product limit exceeded (generic)
      systemname = *blanks;
    when sqlState = '54001';
      // Error - Statement too long or complex
      systemname = *blanks;
    when sqlState = '54002';
      // Error - Literal string too long
      systemname = *blanks;
    when sqlState = '54004';
      // Error - Statement has too many host variables
      systemname = *blanks;
    when sqlState = '54006';
      // Error - Result too long
      systemname = *blanks;
    when sqlState = '54008';
      // Error - Maximum depth of nested queries exceeded
      systemname = *blanks;
    when sqlState = '54010';
      // Error - Limit on number of constraints exceeded
      systemname = *blanks;
    when sqlState = '54011';
      // Error - Too many columns specified
      systemname = *blanks;
    when sqlState = '54012';
      // Error - Limit on number of parameters or arguments exceeded
      systemname = *blanks;
    when sqlState = '54021';
      // Error - Too many concurrent LOB locators
      systemname = *blanks;
    when sqlState = '54023';
      // Error - Maximum depth of nested routines exceeded
      systemname = *blanks;
    when sqlState = '54028';
      // Error - Maximum number of partitions exceeded
      systemname = *blanks;
    when sqlState = '54044';
      // Error - Nesting level for routines too deep
      systemname = *blanks;
    when sqlState = '54053';
      // Error - Recursion not supported for application encoding scheme
      systemname = *blanks;
      
    // Class 55: Object not in prerequisite state
    when sqlState = '55000';
      // Error - Object not in prerequisite state (generic)
      systemname = *blanks;
    when sqlState = '55006';
      // Error - Object cannot be dropped
      systemname = *blanks;
    when sqlState = '55007';
      // Error - Object cannot be altered
      systemname = *blanks;
    when sqlState = '55019';
      // Error - Constraint cannot be dropped
      systemname = *blanks;
    when sqlState = '55029';
      // Error - Local program attempted to use remote object
      systemname = *blanks;
      
    // Class 56: Miscellaneous SQL or product error
    when sqlState = '56000';
      // Error - Miscellaneous SQL or product error (generic)
      systemname = *blanks;
    when sqlState = '56084';
      // Error - Unsupported SQLTYPE in SQLDA
      systemname = *blanks;
      
    // Class 57: Resource not available or operator intervention
    when sqlState = '57000';
      // Error - Resource not available or operator intervention (generic)
      systemname = *blanks;
    when sqlState = '57005';
      // Error - Object in use
      systemname = *blanks;
    when sqlState = '57006';
      // Error - Object cannot be created
      systemname = *blanks;
    when sqlState = '57007';
      // Error - Object cannot be used
      systemname = *blanks;
    when sqlState = '57011';
      // Error - Virtual storage or database resource not available
      systemname = *blanks;
    when sqlState = '57012';
      // Error - Non-database resource not available
      systemname = *blanks;
    when sqlState = '57013';
      // Error - Distributed protocol error
      systemname = *blanks;
    when sqlState = '57014';
      // Error - Processing cancelled as requested
      systemname = *blanks;
    when sqlState = '57017';
      // Error - Character conversion not defined
      systemname = *blanks;
    when sqlState = '57033';
      // Error - Deadlock or timeout occurred
      systemname = *blanks;
    when sqlState = '57042';
      // Error - Maximum number of concurrent LOB locators exceeded
      systemname = *blanks;
    when sqlState = '57050';
      // Error - Distributed transaction error
      systemname = *blanks;
      
    // Class 58: System error
    when sqlState = '58000';
      // Error - System error (generic)
      systemname = *blanks;
    when sqlState = '58004';
      // Error - Unexpected system failure
      systemname = *blanks;
    when sqlState = '58005';
      // Error - Data conversion or data mapping error
      systemname = *blanks;
    when sqlState = '58008';
      // Error - Execution failed due to distribution protocol error
      systemname = *blanks;
    when sqlState = '58009';
      // Error - Execution failed due to resource limit exceeded
      systemname = *blanks;
    when sqlState = '58010';
      // Error - Execution failed due to invalid use of data definition statement
      systemname = *blanks;
    when sqlState = '58011';
      // Error - Execution failed due to data descriptor error
      systemname = *blanks;
    when sqlState = '58012';
      // Error - Execution failed due to invalid use of statement
      systemname = *blanks;
    when sqlState = '58014';
      // Error - Execution failed due to invalid authorization specification
      systemname = *blanks;
    when sqlState = '58015';
      // Error - Execution failed due to object not found
      systemname = *blanks;
    when sqlState = '58016';
      // Error - Execution failed due to object already exists
      systemname = *blanks;
    when sqlState = '58017';
      // Error - Execution failed due to data exception
      systemname = *blanks;
      
    // Default case for any unhandled SQLSTATE
    other;
      // Unknown or unhandled SQLSTATE
      // Log the error for investigation
      systemname = *blanks;
  endsl;
  
  return systemname;

end-proc;



// ------------------------------------------------------------------------------
// check if job is running interactive or batch
// ------------------------------------------------------------------------------
Dcl-Proc ReturnJobEnvironment Export;
Dcl-PI *n Ind;
end-pi;

// retrieve job information (qusrjobi) api
Dcl-PR RetrieveJobInfo EXTPGM('QUSRJOBI');
  @Receive LIKE(JobStatus);
  @JobLength Int(10);
  @JobFormat Char(8);
  @JobName Char(26) CONST;
  @JobIndent Char(15) CONST;
  @ErrCode LIKE(APIERROR);
End-PR;

// ------------------------------------------------------------------------------
// Global API Error Data Structure
// Standard IBM i API error handling structure
// ------------------------------------------------------------------------------
Dcl-DS APIERROR Qualified;
  BytesProv Int(10) Inz(%Size(APIERROR));
  BytesAvail Int(10) Inz(0);
  ExceptionId Char(7);
  Reserved Char(1);
  ExceptionData Char(256);
End-DS;


// data definition section
// procedure work variables
Dcl-S Interactive Ind;
Dcl-S JobLength Int(10) INZ(%SIZE(JobStatus));
Dcl-S JobFormat Char(8) INZ('JOBI0100');

// job status data-structure
Dcl-DS JobStatus;
  JobBytesRtn Int(10) OVERLAY(JobStatus:*NEXT);
  JobBytesAvl Int(10) OVERLAY(JobStatus:*NEXT);
  JobName Char(10) OVERLAY(JobStatus:*NEXT);
  JobUser Char(10) OVERLAY(JobStatus:*NEXT);
  JobNumber Char(6) OVERLAY(JobStatus:*NEXT);
  JobIdentifier Char(16) OVERLAY(JobStatus:*NEXT);
  JobStatusCode Char(10) OVERLAY(JobStatus:*NEXT);
  JobType Char(1) OVERLAY(JobStatus:*NEXT);
  JobSubtype Char(1) OVERLAY(JobStatus:*NEXT);
  JobReserv1 Char(2) OVERLAY(JobStatus:*NEXT);
  JobRunPriority Int(10) OVERLAY(JobStatus:*NEXT);
  JobTimeSlice Int(10) OVERLAY(JobStatus:*NEXT);
  JobDefaultWait Int(10) OVERLAY(JobStatus:*NEXT);
  JobPurge Char(10) OVERLAY(JobStatus:*NEXT);
End-DS;

// Use API to retrieve job running status

RetrieveJobInfo (JobStatus:JobLength:JobFormat: '*':' ':apiError);

If JobType = 'I';
  Interactive = *ON;
Else;
  Interactive = *OFF;
EndIf;

Return Interactive;

End-Proc;














// -----------------------------------------------------------------------
// service program procedure called 'ExecuteCommand'
// Executes IBM i CL commands with comprehensive error handling
// -----------------------------------------------------------------------
dcl-proc ExecuteCommand export;
  dcl-pi ExecuteCommand ind; // Returns *ON if successful
    p_command char(512) const;
    p_errorMsg char(256) options(*nopass:*omit); // Optional error message output
  end-pi;
    
  // IBM i Command Execution API
  dcl-pr QCMDEXC extpgm('QCMDEXC');
    *n char(32000) const options(*varsize);
    *n packed(15:5) const;
  end-pr;

  dcl-s cmdLength packed(15:5);
  dcl-s success ind inz(*off);
  dcl-s errorMessage char(256);
  
  // Validate input command
  if %trim(p_command) = '';
    errorMessage = 'ERROR: Empty command string provided';
    if %parms >= 2 and %addr(p_errorMsg) <> *null;
      p_errorMsg = errorMessage;
    endif;
    return *off;
  endif;

  // Calculate actual command length for efficiency
  cmdLength = %len(%trim(p_command));
  
  // Execute the command with proper error handling
  monitor;
    QCMDEXC(p_command : cmdLength);
    success = *on;
    
  on-error;
    // Capture error details for diagnostics
    errorMessage = 'Command execution failed: ' + %trim(p_command);
    
    // Return error message if parameter provided
    if %parms >= 2 and %addr(p_errorMsg) <> *null;
      p_errorMsg = errorMessage;
    endif;
    
    success = *off;
  endmon;

  return success;

end-proc;









// -----------------------------------------------------------------------
// (DisplayWindow) display text in an IBM i 5250 pop-up window
// -----------------------------------------------------------------------
// Replacement (partial) for the DSPLY opcode:
//    1. Accepts text lenths much great than 52.
//    2. Does not accept input.
//
//  Uses the Display Long Text (QUILNGTX) API to display a pop-up
//  window containing the passed string.
//  API doesn't display bidirectional right to left text.
//
// Error Messages
// Message ID Error Message Text
// CPF3C90 E Literal value cannot be changed
// CPF6A4C E At least one parameter value is not correct. Reason code is &1
// CPF9871 E Error occurred while processing
dcl-proc DisplayWindow ;
  dcl-pi DisplayWindow;
    p_Text varchar(8192) const;
    p_MsgId char(7) Options(*nopass:*omit);
    p_MsgFile char(21) Options(*nopass:*omit);
  end-pi;

  dcl-ds myApiError ;
    APIEProv int(10) inz(%SIZE(APIEData)) pos(1);
    APIEAvail int(10) inz(0) pos(5);
    APIErrID char(7) pos(9);
    APIErrRsv char(1);
    APIEData char(256);
  end-ds;

  dcl-pr QUILNGTX extpgm('QUILNGTX');
    *n char(8192) const; // MsgText
    *n int(10) const; // MsgLength
    *n char(7) const; // MessageId
    *n char(21) const; // MessageFile
    *n options( *omit: *varsize ) like( myApierror ); // ErrorDS
  end-pr;

  dcl-s MsgId like(p_MsgId);
  dcl-s MsgFile like(p_MsgFile);

  If %Parms = 1;
    MsgId = 'CAE0103'; // 'Press Enter to continue.'
    MsgFile = 'QCPFMSG   *LIBL';
  Elseif %Parms = 2;
    MsgId = p_MsgId;
    MsgFile = 'QCPFMSG   *LIBL';
  Elseif %Parms = 3;
    MsgId = p_MsgId;
    MsgFile = p_MsgFile;
  Endif;
  APIEAvail = 0;  // Errors cause a crash.
  QUILNGTX ( p_Text
         : %Len(p_Text)
         : MsgId
         : MsgFile
         : myApiError
         );
  return;
end-proc;

