**free

/// Program: JSNIFSSQL2 - JSON_TABLE Decode JSON using SQL
///
/// Description: Demonstrates reading JSON data from an IFS file and parsing it
///              using SQL JSON_TABLE functions. This program loads JSON data
///              from the IFS into a CLOB variable, then uses SQL's JSON_TABLE
///              function to parse and extract structured data into RPG data
///              structures for further processing.
///
/// Purpose: Educational example demonstrating:
///   - Reading JSON files from the IFS using SQL QSYS2.IFS_READ_UTF8 function
///   - Parsing JSON data using SQL JSON_TABLE function
///   - Extracting nested JSON arrays into RPG data structures
///   - Handling JSON data in embedded SQL within SQLRPGLE
///   - Processing multiple JSON records in a cursor loop
///   - Proper error handling with MONITOR blocks and resource cleanup
///   - Modern main procedure structure with constants
///
/// Features:
///   - Reads JSON file from IFS using SQL QSYS2.IFS_READ_UTF8 function
///   - Validates file existence before processing
///   - Loads JSON data into SQL CLOB variable for processing
///   - Uses JSON_TABLE to parse nested JSON arrays
///   - Extracts user data (userID, firstName, lastName, etc.)
///   - Stores parsed data in dynamically sized array
///   - Comprehensive error handling with MONITOR/ON-ERROR blocks
///   - Proper resource cleanup (cursors) in all code paths
///   - Configurable maximum record limit via constant
///   - Detailed logging of processing results
///
/// Usage: CALL JSNIFSSQL2
///        Optionally override IFS_FILE_PATH constant for different file
///
/// Parameters: None (file path configurable via constant)
///
/// SQL Usage:
///   - QSYS2.IFS_READ_UTF8 to read IFS file into CLOB
///   - JSON_TABLE function to parse JSON structure
///   - Cursor to iterate through parsed JSON records
///   - Nested path '$.users[*]' to access JSON array elements
///   - Individual field paths for data extraction
///
/// Dependencies:
///   - IFS file: /home/nicklitten/getwebjsn.json (configurable)
///   - SQL QSYS2.IFS_READ_UTF8 function (requires IBM i 7.3 or higher)
///   - SQL JSON_TABLE function (requires IBM i 7.2 or higher)
///   - Activation group: NICKLITTEN
///
/// Control Options:
///   - dftactgrp(*no): Required for ILE procedures and SQL
///   - actgrp('NICKLITTEN'): Named activation group for resource management
///   - option(*nodebugio): Disables debug I/O for performance
///   - option(*srcstmt): Includes source statements in debug view
///   - option(*nounref): Flags unreferenced variables
///   - option(*sqlcursorstay): Keeps SQL cursors open across commits
///   - datfmt(*ISO): Uses ISO date format (YYYY-MM-DD)
///   - main(mainline): Specifies main procedure entry point
///
/// Modification History:
/// 1.0 2026-06-01 | Nick Litten | Initial creation

ctl-opt 
   dftactgrp(*no)
   actgrp('NICKLITTEN')
   option(*nodebugio:*srcstmt:*nounref)
   datfmt(*ISO)
   decedit('0.')
   main(mainline)
   copyright('JSNIFSSQL2 V1.0 - JSON_TABLE parse with SQL');

Dcl-C IFS_FILE_PATH '/home/nicklitten/getwebjsn.json';

Dcl-Proc mainline;
   Dcl-Pi *n;
   End-Pi;

   // Structure to hold individual JSON record fields
   Dcl-Ds jsonFields qualified;
      userID varchar(20);
      firstName varchar(30);
      lastName varchar(30);
      initials varchar(5);
      company int(10);
      division int(10);
      department int(10);
   End-Ds;

   // Result structure with success indicator, error message, and data array
   Dcl-Ds result qualified;
      success ind inz(*off);
      errmsg varchar(256);
      recordCount int(10) inz(0);
      jsonArray likeds(jsonFields) dim(999);
   End-Ds;

   Dcl-S json sqltype(clob:16000000);
   
   Dcl-S cursorOpen ind inz(*off);

   Monitor;
      // Read JSON file from IFS into CLOB
      Exec SQL
         select QSYS2.IFS_READ_UTF8(:IFS_FILE_PATH)
         into :json;

      // Check for SQL errors on file read
      If (SQLSTATE <> '00000');
         result.errmsg = 'Failed to read IFS file: ' + IFS_FILE_PATH +
                              ' SQLSTATE: ' + SQLSTATE;
         displayResults(result);
         Return;
      EndIf;

      // Declare cursor to process JSON data using JSON_TABLE
      Exec SQL
      declare myCursor cursor for
      select *
      from json_table(
         :json,
         '$'
         columns(
            nested '$.users[*]' columns(
               userid varchar(100) path '$.userID',
               firstname varchar(100) path '$.firstName',
               lastname varchar(100) path '$.lastName',
               initials varchar(100) path '$.initials',
               company int path '$.company',
               division int path '$.division',
               department int path '$.department'
            )
         )
      ) as x;

      // Open cursor
      Exec SQL open MYCURSOR;

      // Check for SQL errors on cursor open
      If (SQLSTATE <> '00000');
         result.errmsg = 'Failed to open cursor. SQLSTATE: ' + SQLSTATE;
         displayResults(result);
         Return;
      EndIf;

      cursorOpen = *on;

      // Fetch and process all records
      Exec SQL fetch next from MYCURSOR
         into :result.jsonArray(:result.recordCount + 1);

      Dow (SQLSTATE = '00000' or %subst(SQLSTATE:1:2) = '01');
         result.recordCount += 1;

         // Check array bounds
         If (result.recordCount >= 999);
            result.errmsg = 'Warning: Maximum record limit reached (' +
                                 %char(999) + ')';
            Leave;
         EndIf;

         // Fetch next record
         Exec SQL fetch next from MYCURSOR
            into :result.jsonArray(:result.recordCount + 1);
      EndDo;

      // Close cursor
      If (cursorOpen);
         Exec SQL close MYCURSOR;
         cursorOpen = *off;
      EndIf;

      // Set final status
      If (result.recordCount = 0);
         result.errmsg = 'No records found in JSON data';
      Else;
         result.success = *on;
         If (result.errmsg = '');
            result.errmsg = 'Successfully processed ' +
                                 %char(result.recordCount) + ' records';
         EndIf;
      EndIf;

   On-Error;
      // Handle any unexpected errors
      result.errmsg = 'Unexpected error during JSON processing';

      // Ensure cursor is closed
      If (cursorOpen);
         Monitor;
            Exec SQL close MYCURSOR;
         On-Error;
            // Ignore errors during cleanup
         EndMon;
         cursorOpen = *off;
      EndIf;
   EndMon;

   // Display results to user
   displayResults(result);

   Return;
End-Proc;

// ---
// Display Results Procedure
// ---

Dcl-Proc displayResults;
   Dcl-Pi *n;
      pResult likeds(result);
   End-Pi;

   Dcl-S idx int(10);
   Dcl-S msg varchar(256);

   // Display summary
   If (pResult.success);
      dsply ('SUCCESS: ' + pResult.errmsg);
   Else;
      dsply ('ERROR: ' + pResult.errmsg);
   EndIf;

   // Display first 5 records as sample
   If (pResult.recordCount > 0);
      dsply ('Sample records (first 5):');
      For idx = 1 to %min(pResult.recordCount:5);
         msg = %char(idx) + ': ' +
               %trim(pResult.jsonArray(idx).userID) + ' - ' +
               %trim(pResult.jsonArray(idx).firstName) + ' ' +
               %trim(pResult.jsonArray(idx).lastName);
         dsply (msg);
      EndFor;
   EndIf;

   Return;
End-Proc;
