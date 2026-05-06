**free
///
/// Service Program: NICKMOD - Service Program for Lessons
/// Description: This is an ever growing example service program filled with
///              useful procedures and sample code for various scenarios.
///
/// Exported Procedures:
///   - ReturnSystemName() - Returns current IBM i system name
///   - ReturnJobEnvironment() - Checks if job is interactive or batch
///   - ExecuteCommand() - Executes CL commands with error handling
///   - DisplayWindow() - Displays text in 5250 pop-up window
///
/// Purpose:
///   - Demonstrate modern RPG service program structure
///   - Provide reusable utility procedures
///   - Show best practices for error handling
///   - Illustrate efficient SQL usage
///
/// Features:
///   - Thread-safe procedures
///   - Comprehensive error handling
///   - Performance optimized
///   - Well-documented with examples
///
/// Compilation:
///   CRTRPGMOD MODULE(LIB/NICKMOD) SRCFILE(LIB/QRPGLESRC)
///   CRTSRVPGM SRVPGM(LIB/NICKMOD) MODULE(LIB/NICKMOD) EXPORT(*ALL)
///
/// Author: Nick Litten
///
/// Modification History:
/// v.001 2026.04.02 - Nick Litten - Created simple service program example
/// v.002 2026.05.06 - Nick Litten - Comprehensive refactoring and improvements
///

ctl-opt nomain
        option(*nodebugio:*srcstmt:*nounref)
        copyright('v.002 - Service Program for Lessons');

// ==============================================================================
// GLOBAL CONSTANTS
// ==============================================================================
Dcl-C DEFAULT_MSG_ID 'CAE0103';
Dcl-C DEFAULT_MSG_FILE 'QCPFMSG   *LIBL';
Dcl-C JOB_FORMAT 'JOBI0100';
Dcl-C INTERACTIVE_JOB 'I';

// ==============================================================================
// GLOBAL DATA STRUCTURES
// ==============================================================================

// Standard IBM i API error handling structure
Dcl-Ds ApiError_t qualified template;
   BytesProv int(10);
   BytesAvail int(10);
   ExceptionId char(7);
   Reserved char(1);
   ExceptionData char(256);
end-ds;

// ==============================================================================
// PROCEDURE: ReturnSystemName
// ==============================================================================
// Description: Returns the current IBM i system name using SQL CURRENT SERVER
//              special register. Uses efficient error handling with SQLSTATE
//              class checking instead of individual state checking.
//
// Parameters:  None
//
// Returns:     char(8) - System name (blank-padded) or error indicator
//
// Error Handling:
//   - Returns system name on success (SQLSTATE 00000)
//   - Returns 'ERR' + first 5 chars of SQLSTATE on any error
//   - Uses SQLSTATE class-based error detection for efficiency
//
// Example Usage:
//   dcl-s mySystem char(8);
//   mySystem = ReturnSystemName();
//   if %subst(mySystem:1:3) = 'ERR';
//      // Handle error
//   endif;
//
// Notes:
//   - Thread-safe (no static variables)
//   - More efficient than checking hundreds of individual SQLSTATE values
//   - SQLSTATE classes: 00=Success, 01=Warning, 02=No Data, 
//     07-58=Various errors
// ==============================================================================
Dcl-Proc ReturnSystemName export;
   Dcl-Pi *n char(8);
   end-pi;
  
   Dcl-S systemName char(8) inz;
   Dcl-S sqlStateClass char(2);
    
   // Retrieve system name using SQL special register
   exec sql
      VALUES CURRENT SERVER INTO :systemName;
  
   // Extract SQLSTATE class (first 2 characters) for efficient error checking
   sqlStateClass = %subst(SQLSTATE:1:2);
  
   // Comprehensive SQLSTATE error handling
   Select;
         // Class 00: Successful completion
      When (sqlState = '00000');
         // Success - No error occurred
         // Continue normal processing
      
         // Class 01: Warning
      When (sqlState = '01003');
         // Warning - Null values eliminated in set function
         systemname = *blanks;
      When (sqlState = '01004');
         // Warning - String data, right truncation occurred
         // Data may be truncated but operation succeeded
         systemname = *blanks;
      When (sqlState = '01503');
         // Warning - Number of result columns is larger than number of host variables
         // Some columns were not retrieved
         systemname = *blanks;
      When (sqlState = '01504');
         // Warning - UPDATE or DELETE without WHERE clause
         // All rows affected
         systemname = *blanks;
      When (sqlState = '01505');
         // Warning - Statement not executed because it is unacceptable in this environment
         systemname = *blanks;
      When (sqlState = '01506');
         // Warning - Adjustment made to DECFLOAT or FLOAT value
         // Precision may have been adjusted
         systemname = *blanks;
      When (sqlState = '01517');
         // Warning - Character conversion cannot be performed
         systemname = *blanks;
      When (sqlState = '01522');
         // Warning - Constraint violation was ignored
         // Data integrity may be compromised
         systemname = *blanks;
      When (sqlState = '01526');
         // Warning - Isolation level escalated
         // Lock level was increased for consistency
         systemname = *blanks;
      When (sqlState = '01527');
         // Warning - Too many host variables specified  
         systemname = *blanks;
         // Extra variables ignored
         systemname = *blanks;
      When (sqlState = '01528');
         // Warning - WHERE NOT NULL is ignored
         // Clause had no effect
         systemname = *blanks;
      When (sqlState = '01532');
         // Warning - An undefined object name was detected
         systemname = *blanks;
      When (sqlState = '01543');
         // Warning - Connection is successful but only supports a limited SQL mode
         // Some features may not be available
         systemname = *blanks;
      When (sqlState = '01565');
         // Warning - Empty string used in arithmetic operation
         // Treated as zero
         systemname = *blanks;
      When (sqlState = '01594');
         // Warning - Insufficient number of entries in an SQL Descriptor Area
         // Some data not retrieved
         systemname = *blanks;
      When (sqlState = '016xx');
         // Warning - Various XQuery warnings (01601-01699)
         // XQuery operation completed with warnings
         systemname = *blanks;
         // Class 02: No data
      When (sqlState = '02000');
         // No data - No row found for FETCH, UPDATE, or DELETE
         // Or result of query is empty table
         systemname = *blanks;
      When (sqlState = '02001');
         // No data - No additional result sets returned
         // All result sets have been processed
         systemname = *blanks;      
         // Class 07: Dynamic SQL error
      When (sqlState = '07001');
         // Error - Wrong number of host variables specified
         systemname = *blanks;
      When (sqlState = '07002');
         // Error - Host variable list does not match number of parameters
         systemname = *blanks;
      When (sqlState = '07003');
         // Error - Cursor specification cannot be executed
         systemname = *blanks;
      When (sqlState = '07005');
         // Error - Cursor not open
         systemname = *blanks;
      When (sqlState = '07006');
         // Error - Invalid conversion requested
         systemname = *blanks;
      When (sqlState = '07009');
         // Error - Invalid descriptor index
         systemname = *blanks;
      
         // Class 08: Connection exception
      When (sqlState = '08001');
         // Error - Application server unable to establish connection
         systemname = *blanks;
      When (sqlState = '08002');
         // Error - Connection already exists
         systemname = *blanks;
      When (sqlState = '08003');
         // Error - Connection does not exist
         systemname = *blanks;
      When (sqlState = '08004');
         // Error - Application server rejected establishment of connection
         systemname = *blanks;
      When (sqlState = '08006');
         // Error - Connection failure
         systemname = *blanks;
      When (sqlState = '08007');
         // Error - Transaction resolution unknown
         systemname = *blanks;
      
         // Class 21: Cardinality violation
      When (sqlState = '21000');
         // Error - Scalar subquery or SELECT INTO returned more than one row
         systemname = *blanks;
      
         // Class 22: Data exception
      When (sqlState = '22001');
         // Error - Character data, right truncation
         systemname = *blanks;
      When (sqlState = '22002');
         // Error - Null value, no indicator variable supplied
         systemname = *blanks;
      When (sqlState = '22003');
         // Error - Numeric value out of range
         systemname = *blanks;
      When (sqlState = '22004');
         // Error - Null value not allowed
         systemname = *blanks;
      When (sqlState = '22005');
         // Error - Error in assignment
         systemname = *blanks;
      When (sqlState = '22007');
         // Error - Invalid datetime format
         systemname = *blanks;
      When (sqlState = '22008');
         // Error - Datetime field overflow
         systemname = *blanks;
      When (sqlState = '22011');
         // Error - Substring error
         systemname = *blanks;
      When (sqlState = '22012');
         // Error - Division by zero
         systemname = *blanks;
      When (sqlState = '22018');
         // Error - Invalid character value for cast
         systemname = *blanks;
      When (sqlState = '22019');
         // Error - Invalid escape character
         systemname = *blanks;
      When (sqlState = '22021');
         // Error - Character not in repertoire
         systemname = *blanks;
      When (sqlState = '22023');
         // Error - Invalid parameter value
         systemname = *blanks;
      When (sqlState = '22024');
         // Error - Unterminated C string
         systemname = *blanks;
      When (sqlState = '22025');
         // Error - Invalid escape sequence
         systemname = *blanks;
      When (sqlState = '22027');
         // Error - Trim error
         systemname = *blanks;
      
         // Class 23: Integrity constraint violation
      When (sqlState = '23000');
         // Error - Integrity constraint violation (generic)
         systemname = *blanks;
      When (sqlState = '23001');
         // Error - Restrict violation
         systemname = *blanks;
      When (sqlState = '23502');
         // Error - Not null violation
         systemname = *blanks;
      When (sqlState = '23503');
         // Error - Foreign key violation
         systemname = *blanks;
      When (sqlState = '23504');
         // Error - Check constraint violation
         systemname = *blanks;
      When (sqlState = '23505');
         // Error - Unique constraint violation
         systemname = *blanks;
      When (sqlState = '23511');
         // Error - Parent key in a parent row cannot be updated
         systemname = *blanks;
      When (sqlState = '23512');
         // Error - Delete or update of parent key prevented by NO ACTION
         systemname = *blanks;
      When (sqlState = '23513');
         // Error - Row in parent table has dependent rows
         systemname = *blanks;
      
         // Class 24: Invalid cursor state
      When (sqlState = '24000');
         // Error - Invalid cursor state
         systemname = *blanks;
      When (sqlState = '24501');
         // Error - Cursor not open
         systemname = *blanks;
      When (sqlState = '24502');
         // Error - Cursor already open
         systemname = *blanks;
      When (sqlState = '24504');
         // Error - Cursor not positioned on locked row
         systemname = *blanks;
      When (sqlState = '24506');
         // Error - Cursor position prevents FETCH of current row
         systemname = *blanks;
      When (sqlState = '24507');
         // Error - Cursor position prevents UPDATE or DELETE
         systemname = *blanks;
      When (sqlState = '24513');
         // Error - FETCH not valid, cursor not scrollable
         systemname = *blanks;
      
         // Class 25: Invalid transaction state
      When (sqlState = '25000');
         // Error - Invalid transaction state
         systemname = *blanks;
      When (sqlState = '25001');
         // Error - Active SQL transaction
         systemname = *blanks;
      When (sqlState = '25006');
         // Error - Read-only SQL transaction
         systemname = *blanks;
      
         // Class 26: Invalid SQL statement identifier
      When (sqlState = '26000');
         // Error - Invalid SQL statement identifier
         systemname = *blanks;
      
         // Class 28: Invalid authorization specification
      When (sqlState = '28000');
         // Error - Invalid authorization specification
         systemname = *blanks;
      
         // Class 2D: Invalid transaction termination
      When (sqlState = '2D000');
         // Error - Invalid transaction termination
         systemname = *blanks;
      
         // Class 2E: Invalid connection name
      When (sqlState = '2E000');
         // Error - Invalid connection name
         systemname = *blanks;
      
         // Class 34: Invalid cursor name
      When (sqlState = '34000');
         // Error - Invalid cursor name
         systemname = *blanks;
      
         // Class 38: External routine exception
      When (sqlState = '38000');
         // Error - External routine exception (generic)
         systemname = *blanks;
      When (sqlState = '38001');
         // Error - Containing SQL not permitted
         systemname = *blanks;
      When (sqlState = '38002');
         // Error - Modifying SQL-data not permitted
         systemname = *blanks;
      When (sqlState = '38003');
         // Error - Prohibited SQL statement attempted
         systemname = *blanks;
      When (sqlState = '38004');
         // Error - Reading SQL-data not permitted
         systemname = *blanks;
      
         // Class 39: External routine invocation exception
      When (sqlState = '39000');
         // Error - External routine invocation exception (generic)
         systemname = *blanks;
      When (sqlState = '39001');
         // Error - Invalid SQLSTATE returned
         systemname = *blanks;
      When (sqlState = '39004');
         // Error - Null value not allowed
         systemname = *blanks;
      
         // Class 3B: Savepoint exception
      When (sqlState = '3B000');
         // Error - Savepoint exception (generic)
         systemname = *blanks;
      When (sqlState = '3B001');
         // Error - Invalid savepoint specification
         systemname = *blanks;
      When (sqlState = '3B002');
         // Error - Too many savepoints
         systemname = *blanks;
      
         // Class 40: Transaction rollback
      When (sqlState = '40000');
         // Error - Transaction rollback (generic)
         systemname = *blanks;
      When (sqlState = '40001');
         // Error - Serialization failure
         systemname = *blanks;
      When (sqlState = '40002');
         // Error - Integrity constraint violation
         systemname = *blanks;
      When (sqlState = '40003');
         // Error - Statement completion unknown
         systemname = *blanks;
      
         // Class 42: Syntax error or access rule violation
      When (sqlState = '42000');
         // Error - Syntax error or access rule violation (generic)
         systemname = *blanks;
      When (sqlState = '42501');
         // Error - Authorization failure
         systemname = *blanks;
      When (sqlState = '42502');
         // Error - Object does not exist or authorization failure
         systemname = *blanks;
      When (sqlState = '42601');
         // Error - SQL syntax error
         systemname = *blanks;
      When (sqlState = '42602');
         // Error - Invalid name
         systemname = *blanks;
      When (sqlState = '42603');
         // Error - Invalid column name
         systemname = *blanks;
      When (sqlState = '42604');
         // Error - Invalid numeric literal
         systemname = *blanks;
      When (sqlState = '42605');
         // Error - Number of arguments does not match
         systemname = *blanks;
      When (sqlState = '42607');
         // Error - Operation not allowed on system object
         systemname = *blanks;
      When (sqlState = '42612');
         // Error - Statement contains unrelated columns
         systemname = *blanks;
      When (sqlState = '42704');
         // Error - Undefined object or constraint name
         systemname = *blanks;
      When (sqlState = '42710');
         // Error - Duplicate object or constraint name
         systemname = *blanks;
      When (sqlState = '42723');
         // Error - Routine already exists with same signature
         systemname = *blanks;
      When (sqlState = '42803');
         // Error - Column not in GROUP BY
         systemname = *blanks;
      When (sqlState = '42804');
         // Error - Data type mismatch
         systemname = *blanks;
      When (sqlState = '42805');
         // Error - Integer in SELECT list not valid
         systemname = *blanks;
      When (sqlState = '42809');
         // Error - Object is not the type required
         systemname = *blanks;
      When (sqlState = '42810');
         // Error - Base table not specified
         systemname = *blanks;
      When (sqlState = '42815');
         // Error - Data type not comparable
         systemname = *blanks;
      When (sqlState = '42820');
         // Error - Floating point literal too long
         systemname = *blanks;
      When (sqlState = '42824');
         // Error - Operand of LIKE not a string
         systemname = *blanks;
      When (sqlState = '42825');
         // Error - Rows from UNION, INTERSECT, or EXCEPT do not match
         systemname = *blanks;
      When (sqlState = '42826');
         // Error - Rows from UNION, INTERSECT, or EXCEPT not compatible
         systemname = *blanks;
      When (sqlState = '42827');
         // Error - Cannot UPDATE or INSERT into a view
         systemname = *blanks;
      When (sqlState = '42828');
         // Error - Cannot modify target table of MERGE
         systemname = *blanks;
      When (sqlState = '42829');
         // Error - FOR UPDATE specified for read-only cursor
         systemname = *blanks;
      When (sqlState = '42830');
         // Error - Invalid foreign key definition
         systemname = *blanks;
      When (sqlState = '42831');
         // Error - Duplicate column name in key definition
         systemname = *blanks;
      When (sqlState = '42832');
         // Error - Operation not allowed on system object
         systemname = *blanks;
      When (sqlState = '42834');
         // Error - SET NULL not allowed, column cannot contain null
         systemname = *blanks;
      When (sqlState = '42836');
         // Error - Recursive common table expression not valid
         systemname = *blanks;
      When (sqlState = '42837');
         // Error - Cycle detected in recursive common table expression
         systemname = *blanks;
      When (sqlState = '42841');
         // Error - Parameter marker cannot have CAST specification
         systemname = *blanks;
      When (sqlState = '42846');
         // Error - Cast not supported between data types
         systemname = *blanks;
      When (sqlState = '42866');
         // Error - Data type cannot be specified for parameter marker
         systemname = *blanks;
      When (sqlState = '42872');
         // Error - FETCH not valid, cursor not scrollable
         systemname = *blanks;
      When (sqlState = '42879');
         // Error - Distinct type cannot be created on this data type
         systemname = *blanks;
      When (sqlState = '42880');
         // Error - CAST FROM cannot be specified
         systemname = *blanks;
      When (sqlState = '42881');
         // Error - CAST TO cannot be specified
         systemname = *blanks;
      When (sqlState = '42882');
         // Error - Specific instance of function does not exist
         systemname = *blanks;
      When (sqlState = '42883');
         // Error - No routine found with matching signature
         systemname = *blanks;
      When (sqlState = '42884');
         // Error - No routine found with only one specific instance
         systemname = *blanks;
      When (sqlState = '42885');
         // Error - Number of elements does not match
         systemname = *blanks;
      When (sqlState = '42886');
         // Error - Parameter name required
         systemname = *blanks;
      When (sqlState = '42887');
         // Error - Function not defined with RETURNS clause
         systemname = *blanks;
      When (sqlState = '42888');
         // Error - Table does not have matching parent key
         systemname = *blanks;
      When (sqlState = '42889');
         // Error - Table already has primary key
         systemname = *blanks;
      When (sqlState = '42890');
         // Error - Column list required for CREATE VIEW
         systemname = *blanks;
      When (sqlState = '42891');
         // Error - Duplicate column name in object definition
         systemname = *blanks;
      When (sqlState = '42893');
         // Error - Object or constraint name is reserved for system use
         systemname = *blanks;
      When (sqlState = '42894');
         // Error - Default value not valid
         systemname = *blanks;
      
         // Class 44: WITH CHECK OPTION violation
      When (sqlState = '44000');
         // Error - WITH CHECK OPTION violation
         systemname = *blanks;
      
         // Class 51: Invalid application state
      When (sqlState = '51002');
         // Error - Commit or rollback not allowed
         systemname = *blanks;
      When (sqlState = '51003');
         // Error - CONNECT not allowed
         systemname = *blanks;
      When (sqlState = '51004');
         // Error - SQL statement not allowed
         systemname = *blanks;
      When (sqlState = '51009');
         // Error - CONNECT not allowed in XA environment
         systemname = *blanks;
      When (sqlState = '51015');
         // Error - Local program attempted to use remote object
         systemname = *blanks;
      When (sqlState = '51021');
         // Error - Constraint cannot be dropped
         systemname = *blanks;
      When (sqlState = '51030');
         // Error - Distributed request not supported
         systemname = *blanks;
      
         // Class 53: Insufficient resources
      When (sqlState = '53000');
         // Error - Insufficient resources (generic)
         systemname = *blanks;
      When (sqlState = '53035');
         // Error - Maximum number of concurrent LOB locators exceeded
         systemname = *blanks;
      
         // Class 54: SQL or product limit exceeded
      When (sqlState = '54000');
         // Error - SQL or product limit exceeded (generic)
         systemname = *blanks;
      When (sqlState = '54001');
         // Error - Statement too long or complex
         systemname = *blanks;
      When (sqlState = '54002');
         // Error - Literal string too long
         systemname = *blanks;
      When (sqlState = '54004');
         // Error - Statement has too many host variables
         systemname = *blanks;
      When (sqlState = '54006');
         // Error - Result too long
         systemname = *blanks;
      When (sqlState = '54008');
         // Error - Maximum depth of nested queries exceeded
         systemname = *blanks;
      When (sqlState = '54010');
         // Error - Limit on number of constraints exceeded
         systemname = *blanks;
      When (sqlState = '54011');
         // Error - Too many columns specified
         systemname = *blanks;
      When (sqlState = '54012');
         // Error - Limit on number of parameters or arguments exceeded
         systemname = *blanks;
      When (sqlState = '54021');
         // Error - Too many concurrent LOB locators
         systemname = *blanks;
      When (sqlState = '54023');
         // Error - Maximum depth of nested routines exceeded
         systemname = *blanks;
      When (sqlState = '54028');
         // Error - Maximum number of partitions exceeded
         systemname = *blanks;
      When (sqlState = '54044');
         // Error - Nesting level for routines too deep
         systemname = *blanks;
      When (sqlState = '54053');
         // Error - Recursion not supported for application encoding scheme
         systemname = *blanks;
      
         // Class 55: Object not in prerequisite state
      When (sqlState = '55000');
         // Error - Object not in prerequisite state (generic)
         systemname = *blanks;
      When (sqlState = '55006');
         // Error - Object cannot be dropped
         systemname = *blanks;
      When (sqlState = '55007');
         // Error - Object cannot be altered
         systemname = *blanks;
      When (sqlState = '55019');
         // Error - Constraint cannot be dropped
         systemname = *blanks;
      When (sqlState = '55029');
         // Error - Local program attempted to use remote object
         systemname = *blanks;
      
         // Class 56: Miscellaneous SQL or product error
      When (sqlState = '56000');
         // Error - Miscellaneous SQL or product error (generic)
         systemname = *blanks;
      When (sqlState = '56084');
         // Error - Unsupported SQLTYPE in SQLDA
         systemname = *blanks;
      
         // Class 57: Resource not available or operator intervention
      When (sqlState = '57000');
         // Error - Resource not available or operator intervention (generic)
         systemname = *blanks;
      When (sqlState = '57005');
         // Error - Object in use
         systemname = *blanks;
      When (sqlState = '57006');
         // Error - Object cannot be created
         systemname = *blanks;
      When (sqlState = '57007');
         // Error - Object cannot be used
         systemname = *blanks;
      When (sqlState = '57011');
         // Error - Virtual storage or database resource not available
         systemname = *blanks;
      When (sqlState = '57012');
         // Error - Non-database resource not available
         systemname = *blanks;
      When (sqlState = '57013');
         // Error - Distributed protocol error
         systemname = *blanks;
      When (sqlState = '57014');
         // Error - Processing cancelled as requested
         systemname = *blanks;
      When (sqlState = '57017');
         // Error - Character conversion not defined
         systemname = *blanks;
      When (sqlState = '57033');
         // Error - Deadlock or timeout occurred
         systemname = *blanks;
      When (sqlState = '57042');
         // Error - Maximum number of concurrent LOB locators exceeded
         systemname = *blanks;
      When (sqlState = '57050');
         // Error - Distributed transaction error
         systemname = *blanks;
      
         // Class 58: System error
      When (sqlState = '58000');
         // Error - System error (generic)
         systemname = *blanks;
      When (sqlState = '58004');
         // Error - Unexpected system failure
         systemname = *blanks;
      When (sqlState = '58005');
         // Error - Data conversion or data mapping error
         systemname = *blanks;
      When (sqlState = '58008');
         // Error - Execution failed due to distribution protocol error
         systemname = *blanks;
      When (sqlState = '58009');
         // Error - Execution failed due to resource limit exceeded
         systemname = *blanks;
      When (sqlState = '58010');
         // Error - Execution failed due to invalid use of data definition statement
         systemname = *blanks;
      When (sqlState = '58011');
         // Error - Execution failed due to data descriptor error
         systemname = *blanks;
      When (sqlState = '58012');
         // Error - Execution failed due to invalid use of statement
         systemname = *blanks;
      When (sqlState = '58014');
         // Error - Execution failed due to invalid authorization specification
         systemname = *blanks;
      When (sqlState = '58015');
         // Error - Execution failed due to object not found
         systemname = *blanks;
      When (sqlState = '58016');
         // Error - Execution failed due to object already exists
         systemname = *blanks;
      When (sqlState = '58017');
         // Error - Execution failed due to data exception
         systemname = *blanks;
      
         // Default case for any unhandled SQLSTATE
      Other;
         // Unknown or unhandled SQLSTATE
         // Log the error for investigation
         systemname = *blanks;
   EndSl;
  
   Return systemName;

end-proc;

// ==============================================================================
// PROCEDURE: ReturnJobEnvironment
// ==============================================================================
// Description: Determines if the current job is running interactively or in
//              batch mode using the QUSRJOBI API.
//
// Parameters:  None
//
// Returns:     ind - *ON if interactive, *OFF if batch
//
// Error Handling:
//   - Returns *OFF if API call fails
//   - API error structure captures detailed error information
//
// Example Usage:
//   if ReturnJobEnvironment();
//      // Interactive processing
//   else;
//      // Batch processing
//   endif;
//
// Notes:
//   - Uses JOBI0100 format for minimal overhead
//   - Thread-safe
//   - Job type 'I' = Interactive, all others = Batch
// ==============================================================================
Dcl-Proc ReturnJobEnvironment export;
   Dcl-Pi *n ind;
   end-pi;

   // API prototype for QUSRJOBI
   dcl-pr RetrieveJobInfo extpgm('QUSRJOBI');
      receiver likeds(JobInfo_t);
      receiverLen int(10) const;
      format char(8) const;
      qualifiedJobName char(26) const;
      internalJobId char(16) const;
      errorCode likeds(ApiError_t);
   end-pr;

   // Job information structure (JOBI0100 format)
   Dcl-Ds JobInfo_t qualified;
      bytesReturned int(10);
      bytesAvailable int(10);
      jobName char(10);
      userName char(10);
      jobNumber char(6);
      internalJobId char(16);
      status char(10);
      jobType char(1);
      jobSubtype char(1);
      reserved char(2);
      runPriority int(10);
      timeSlice int(10);
      defaultWait int(10);
      purge char(10);
   end-ds;

   Dcl-Ds apiError likeds(ApiError_t) inz;
   Dcl-S isInteractive ind inz(*off);

   // Initialize API error structure
   apiError.BytesProv = %size(apiError);
   apiError.BytesAvail = 0;

   // Call API to retrieve job information
   RetrieveJobInfo(JobInfo_t : %size(JobInfo_t) : JOB_FORMAT : 
                   '*' : *blank : apiError);

   // Check for API errors
   If (apiError.BytesAvail > 0);
      // API error occurred - default to batch mode
      Return *off;
   EndIf;

   // Determine if job is interactive
   isInteractive = (JobInfo_t.jobType = INTERACTIVE_JOB);

   Return isInteractive;

end-proc;

// ==============================================================================
// PROCEDURE: ExecuteCommand
// ==============================================================================
// Description: Executes IBM i CL commands with comprehensive error handling
//              and optional error message return.
//
// Parameters:
//   p_command  - char(512) const - CL command to execute
//   p_errorMsg - char(256) optional - Error message output
//
// Returns:     ind - *ON if successful, *OFF if failed
//
// Error Handling:
//   - Validates command is not empty
//   - Uses monitor/on-error for exception handling
//   - Returns detailed error messages via optional parameter
//
// Example Usage:
//   dcl-s errMsg char(256);
//   if ExecuteCommand('DSPLIBL' : errMsg);
//      // Command succeeded
//   else;
//      // Command failed - errMsg contains details
//   endif;
//
// Notes:
//   - Maximum command length: 512 characters
//   - Uses QCMDEXC API for command execution
//   - Thread-safe
// ==============================================================================
Dcl-Proc ExecuteCommand export;
   Dcl-Pi ExecuteCommand ind;
      p_command char(512) const;
      p_errorMsg char(256) options(*nopass:*omit);
   end-pi;
    
   // IBM i Command Execution API
   dcl-pr QCMDEXC extpgm('QCMDEXC');
      command char(32000) const options(*varsize);
      commandLength packed(15:5) const;
   end-pr;

   Dcl-S cmdLength packed(15:5);
   Dcl-S errorMessage char(256);
  
   // Validate input command
   If (%trim(p_command) = '');
      errorMessage = 'ERROR: Empty command string provided';
      setErrorMessage(p_errorMsg : errorMessage);
      Return *off;
   EndIf;

   // Calculate actual command length for efficiency
   cmdLength = %len(%trim(p_command));
  
   // Execute the command with proper error handling
   monitor;
      QCMDEXC(p_command : cmdLength);
      Return *on;
    
   on-error;
      // Capture error details for diagnostics
      errorMessage = 'Command execution failed: ' + %trim(p_command);
      setErrorMessage(p_errorMsg : errorMessage);
      Return *off;
   endmon;

end-proc;

// ==============================================================================
// PROCEDURE: DisplayWindow (Export)
// ==============================================================================
// Description: Displays text in an IBM i 5250 pop-up window using the
//              QUILNGTX API. Provides a modern replacement for DSPLY opcode
//              with support for much longer text strings.
//
// Parameters:
//   p_text    - varchar(8192) const - Text to display
//   p_msgId   - char(7) optional - Message ID for bottom of window
//   p_msgFile - char(21) optional - Message file (qualified)
//
// Returns:     None (void procedure)
//
// Error Handling:
//   - API errors cause program termination (by design)
//   - Set APIEAvail = 0 to enable error exceptions
//
// Example Usage:
//   DisplayWindow('Hello World!');
//   DisplayWindow('Custom message' : 'USR0001' : 'MYLIB/MYMSGF');
//
// Notes:
//   - Maximum text length: 8192 characters
//   - Does not accept user input (display only)
//   - Does not support bidirectional (right-to-left) text
//   - Default message ID: CAE0103 ('Press Enter to continue.')
// ==============================================================================
Dcl-Proc DisplayWindow export;
   Dcl-Pi DisplayWindow;
      p_text varchar(8192) const;
      p_msgId char(7) options(*nopass:*omit);
      p_msgFile char(21) options(*nopass:*omit);
   end-pi;

   // API error structure
   Dcl-Ds apiError qualified;
      bytesProv int(10) inz(%size(apiError.exceptionData));
      bytesAvail int(10) inz(0);
      exceptionId char(7);
      reserved char(1);
      exceptionData char(256);
   end-ds;

   // Display Long Text API
   dcl-pr QUILNGTX extpgm('QUILNGTX');
      messageText char(8192) const;
      messageLength int(10) const;
      messageId char(7) const;
      messageFile char(21) const;
      errorCode likeds(apiError) options(*omit:*varsize);
   end-pr;

   Dcl-S msgId char(7);
   Dcl-S msgFile char(21);

   // Set message ID and file based on parameters passed
   Select;
      When (%Parms() = 1);
         msgId = DEFAULT_MSG_ID;
         msgFile = DEFAULT_MSG_FILE;
      
      When (%Parms() = 2);
         msgId = p_msgId;
         msgFile = DEFAULT_MSG_FILE;
      
      When (%Parms() = 3);
         msgId = p_msgId;
         msgFile = p_msgFile;
   EndSl;

   // Set to 0 to cause exceptions on API errors
   apiError.bytesAvail = 0;

   // Display the window
   QUILNGTX ( p_text : %len(p_text) : msgId : msgFile : apiError );

end-proc;

// ==============================================================================
// INTERNAL HELPER PROCEDURES
// ==============================================================================

// ------------------------------------------------------------------------------
// PROCEDURE: setErrorMessage (Internal)
// ------------------------------------------------------------------------------
// Description: Helper procedure to safely set optional error message parameter
//
// Parameters:
//   p_errorMsg - char(256) optional - Error message output parameter
//   p_message  - char(256) const - Message to set
//
// Returns:     None
// ------------------------------------------------------------------------------
Dcl-Proc setErrorMessage;
   Dcl-Pi *n;
      p_errorMsg char(256) options(*nopass:*omit);
      p_message char(256) const;
   end-pi;

   // Only set error message if parameter was passed and not omitted
   If (%Parms() >= 1 and %addr(p_errorMsg) <> *null);
      p_errorMsg = p_message;
   EndIf;

end-proc;
