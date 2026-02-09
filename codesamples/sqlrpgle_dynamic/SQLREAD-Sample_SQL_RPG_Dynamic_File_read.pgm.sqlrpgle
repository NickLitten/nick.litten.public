**FREE
// Program Name: SQLREAD-Sample_SQL_RPG_Dynamic_File_read.pgm.sqlrpgle
// Description:  Simple example of using dynamic SQL in RPG 
// Modification History:                                                 
// V.000 2025.09.05 NJL Created from example by ALDO SUCCI      
/include 'header.rpgleinc'

ctl-opt
  copyright('SQLREAD | V.000 | Simple example of using dynamic SQL in RPG');
 
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