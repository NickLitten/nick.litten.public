**free

/// Program: SQLREAD - Sample SQL RPG Dynamic File Read
///
/// Description: Demonstrates the use of dynamic SQL in RPG to query database
///              tables with parameterized queries. Shows how to prepare SQL
///              statements at runtime, use cursors for result set processing,
///              and handle parameter substitution with placeholders. This
///              example retrieves country names based on country code.
///
/// Purpose: Educational example demonstrating:
///   - Dynamic SQL statement preparation using PREPARE
///   - Parameterized queries with placeholder (?) substitution
///   - Cursor declaration and management for result sets
///   - Runtime parameter binding with USING clause
///   - Row-by-row data retrieval with FETCH
///   - Proper cursor resource cleanup
///   - Comprehensive SQLSTATE error checking
///   - Multiple row processing with loop
///
/// Features:
///   - Prepares SQL statement from character variable
///   - Uses parameterized query for flexible filtering
///   - Declares and manages cursor for result processing
///   - Binds runtime parameters to SQL placeholders
///   - Fetches query results into RPG variables
///   - Processes multiple rows with proper loop control
///   - Comprehensive error handling with SQLSTATE checking
///   - Proper resource cleanup in all scenarios
///   - Fully qualified table names for production use
///
/// Usage: CALL SQLREAD
///        (No parameters - uses hardcoded country code 'GB')
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
///   - SQLSTATE checking after each SQL operation
///
/// Dependencies:
///   - Table: SAMPLEDB (Country Names)
///   - Fields: COUNTRY_CODE (ISO alpha-2 code), COUNTRY_NAME (country name)
///   - Include: header.rpgleinc
///
/// Control Options:
///   - copyright: Program identification and version
///   - option(*sqlcursorstay): Keep cursor open across commit boundaries
///
/// Reference:
///   https://www.ibm.com/docs/en/i/7.5?topic=statements-prepare
///   https://www.ibm.com/docs/en/i/7.5?topic=codes-sqlstate-values-common-error
///
/// Modification History:
///   1.0 2025-09-05 | Nick Litten | Created from example by Aldo Succi
///   1.1 2026-04-02 | Nick Litten | Added comprehensive triple-slash documentation
///   1.2 2026-05-17 | Nick Litten | Enhanced with error handling, loop processing, and best practices
///   1.3 2026-05-17 | Nick Litten | Refactored to use subprocedures with on-error handling
///

/include 'header.rpgleinc'

ctl-opt
  copyright('SQLREAD | 1.3 - Dynamic SQL with subprocedures and on-error handling')
  option(*sqlcursorstay);

Dcl-C SQL_SUCCESS     '00000';
Dcl-C SQL_NOT_FOUND   '02000';
Dcl-C MAX_ROWS        100;

// ---
// Main Processing
// ---

Dcl-S success Ind;

success = executeQuery('GB');

If (success);
   Dsply 'Query executed successfully';
Else;
   Dsply 'Query execution failed';
EndIf;

*inlr = *On;
Return;

// ---
// Subprocedures
// ---

// Execute dynamic SQL query with error handling
Dcl-Proc executeQuery;
   Dcl-Pi *N Ind;
      searchCode Char(3) Const;
   End-Pi;
  
   Dcl-S sqlString Varchar(500);
   Dcl-S rowCount Int(10);
  
   // Build dynamic SQL with parameterized query
   sqlString = 'SELECT COUNTRY_NAME '
            + 'FROM NICKLITTEN.SAMPLEDB '
            + 'WHERE COUNTRY_CODE = ? '
            + 'ORDER BY COUNTRY_NAME';
  
   // Prepare the SQL statement
   Exec SQL PREPARE Sql1 FROM :sqlString;
  
   If (SQLSTATE <> SQL_SUCCESS);
      Dsply ('SQL PREPARE failed: ' + SQLSTATE);
      Return *Off;
   EndIf;
  
   // Declare cursor for the prepared statement
   Exec SQL DECLARE Cursor1 CURSOR FOR Sql1;
  
   // Open cursor with parameter binding
   Exec SQL OPEN Cursor1 USING :searchCode;
  
   If (SQLSTATE <> SQL_SUCCESS);
      Dsply ('SQL OPEN failed: ' + SQLSTATE);
      Return *Off;
   EndIf;
  
   // Process all rows
   rowCount = processResults();
  
   // Display summary
   displaySummary(rowCount: searchCode);
  
   // Close cursor to release resources
   Exec SQL CLOSE Cursor1;
  
   If (SQLSTATE <> SQL_SUCCESS And SQLSTATE <> SQL_NOT_FOUND);
      Dsply ('SQL CLOSE warning: ' + SQLSTATE);
   EndIf;
  
   Return *On;
  
On-Error;
   Dsply 'Unexpected error in executeQuery';
   Return *Off;
End-Proc;

// Process result set rows
Dcl-Proc processResults;
   Dcl-Pi *N Int(10);
   End-Pi;
  
   Dcl-S countryName Varchar(100);
   Dcl-S rowCount Int(10) Inz(0);
  
   // Fetch and process all rows
   DoU (SQLSTATE = SQL_NOT_FOUND Or rowCount >= MAX_ROWS);
    
      Exec SQL FETCH Cursor1 INTO :countryName;
    
      If (SQLSTATE = SQL_SUCCESS);
         rowCount += 1;
         Dsply ('Row ' + %Char(rowCount) + ': ' + %Trim(countryName));
      ElseIf (SQLSTATE <> SQL_NOT_FOUND);
         Dsply ('SQL FETCH failed: ' + SQLSTATE);
         Leave;
      EndIf;
    
   EndDo;
  
   Return rowCount;
  
On-Error;
   Dsply 'Unexpected error in processResults';
   Return -1;
End-Proc;

// Display query summary
Dcl-Proc displaySummary;
   Dcl-Pi *N;
      rows Int(10) Const;
      code Char(3) Const;
   End-Pi;
  
   If (rows = 0);
      Dsply ('No rows found for country code: ' + code);
   ElseIf (rows < 0);
      Dsply 'Error occurred during processing';
   Else;
      Dsply ('Total rows retrieved: ' + %Char(rows));
   EndIf;
  
On-Error;
   Dsply 'Unexpected error in displaySummary';
End-Proc;
