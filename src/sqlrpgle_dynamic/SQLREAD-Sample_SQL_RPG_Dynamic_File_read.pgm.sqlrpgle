**free

/// Program: SQLREAD - Sample SQL RPG Dynamic File Read
///
/// Description: Demonstrates the use of dynamic SQL in RPG to query database
///              tables with parameterized queries. Shows how to prepare SQL
///              statements at runtime, use cursors for result set processing,
///              and handle parameter substitution with placeholders. This
///              example retrieves customer names based on customer type.
///
/// Purpose: Educational example demonstrating:
///   - Dynamic SQL statement preparation using PREPARE
///   - Parameterized queries with placeholder (?) substitution
///   - Cursor declaration and management for result sets
///   - Runtime parameter binding with USING clause
///   - Row-by-row data retrieval with FETCH
///   - Proper cursor resource cleanup
///
/// Features:
///   - Prepares SQL statement from character variable
///   - Uses parameterized query for flexible filtering
///   - Declares and manages cursor for result processing
///   - Binds runtime parameters to SQL placeholders
///   - Fetches query results into RPG variables
///   - Displays retrieved data for verification
///   - Closes cursor to release database resources
///
/// Usage: CALL SQLREAD
///        (No parameters - uses hardcoded customer type 'BBB')
///
/// Parameters: None
///
/// SQL Usage:
///   - SELECT statement with WHERE clause parameter
///   - PREPARE to compile SQL from string variable
///   - DECLARE CURSOR to create result set iterator
///   - OPEN with USING to bind parameter values
///   - FETCH to retrieve row data into host variables
///   - CLOSE to release cursor resources
///
/// Dependencies:
///   - Table: CLANA00F (customer analysis file)
///   - Fields: CLCIB0 (customer type), CLNOM0 (customer name)
///   - Include: header.rpgleinc
///
/// Control Options:
///   - copyright: Program identification and version
///
/// Modification History:
/// 1.0 2025-09-05 | Nick Litten | Created from example by Aldo Succi
/// 1.1 2026-04-02 | Bob AI | Added comprehensive triple-slash documentation

ctl-opt
  copyright('SQLREAD | V.000 | Simple example of using dynamic SQL in RPG');

/include 'header.rpgleinc'
 
// Declare variable to hold the customer type (3 characters)
dcl-s wCLCIB0 CHAR(3);
 
// Declare variable to hold the customer name retrieved from the database
dcl-s wCLNOM0 CHAR(50);
 
// Declare a character variable to hold the SQL statement.
// INZ(...) initializes the variable with a parameterized SQL query.
// The "?" acts as a placeholder for values supplied at runtime.
dcl-s SqlString CHAR(500) INZ('SELECT CLNOM0 FROM CLANA00F WHERE CLCIB0 = ?');
//* Prepare the SQL statement stored in SqlString.                *
//* PREPARE converts the text in SqlString into an executable SQL *
//* statement identified here as 'Sql1'.                          *
Exec SQL PREPARE Sql1 FROM :SqlString;
 
// Associate the prepared SQL statement with a cursor.
// A cursor allows row-by-row retrieval of query results.
Exec SQL DECLARE Cursor1 CURSOR FOR Sql1;
//* Assign the customer type to be used as input    *
//* for the parameterized query.                    *
wCLCIB0 = 'BBB';
 
// Open the cursor, supplying the parameter value (wCLCIB0).
// The value replaces the "?" placeholder in the SQL statement.
Exec SQL OPEN Cursor1 USING :wCLCIB0;
 
// Retrieve the first (and in this case, only) row from the result set.
// The value of CLNOM0 from the query is stored into wCLNOM0.
Exec SQL FETCH Cursor1 INTO :wCLNOM0;
 
// For demonstration purposes, simply display the retrieved value.
// In a real-world program, this could be written to a display file,
// printed, or processed further.
Dsply wCLNOM0;   
//* Close the cursor to release resources. *
Exec SQL CLOSE Cursor1;
//* End of program *
*inlr = *on; // Set the last record indicator to ON, ending the program.
return;      // Return control to the caller or operating system.
