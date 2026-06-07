**free

/// Program: JSNIFSSQL - JSON_TABLE Decode JSON using SQL
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
///   - Proper error handling and resource cleanup
///   - Modern main procedure structure
///
/// Features:
///   - Reads JSON file from IFS using SQL QSYS2.IFS_READ_UTF8 function
///   - Loads JSON data into SQL CLOB variable for processing
///   - Uses JSON_TABLE to parse nested JSON arrays
///   - Extracts user data (userID, firstName, lastName, etc.)
///   - Stores parsed data in array of data structures
///   - Comprehensive error handling with detailed messages
///   - Proper resource cleanup (cursors)
///   - Supports up to 9999 JSON records
///   - Validates file existence and read operations
///   - Uses main procedure instead of cycle main
///
/// Usage: CALL JSNIFSSQL
///        (No parameters required - reads from hardcoded IFS path)
///
/// Parameters: None
///
/// SQL Usage:
///   - QSYS2.IFS_READ_UTF8 to read IFS file into CLOB
///   - JSON_TABLE function to parse JSON structure
///   - Cursor MYCURSOR to iterate through parsed JSON records
///   - Nested path '$.users[*]' to access JSON array elements
///   - Individual field paths for data extraction
///
/// Dependencies:
///   - IFS file: /home/nicklitten/getwebjsn.json
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
///   - main(main): Specifies main procedure entry point
///
/// Modification History:
/// 1.0 2017-07-17 | Nick Litten | Initial creation
/// 1.1 2021-06-20 | Nick Litten | Removed unused variables for clarity
/// 1.2 2026-04-02 | Nick Litten | Added comprehensive triple-slash documentation
/// 2.0 2026-05-17 | Nick Litten | Major refactoring: improved error handling,
///                                 resource cleanup, performance optimization,
///                                 added validation and edge case handling
/// 3.0 2026-06-07 | Nick Litten | Refactored IFS access from C APIs to SQL
///                                 using QSYS2.IFS_READ_UTF8 for modern approach
/// 4.0 2026-06-07 | Nick Litten | Converted to main procedure structure
/// 4.2 2026-06-07 | Nick Litten | Fixed to use positional parameters with
///                                 QSYS2.IFS_READ_UTF8 (correct syntax)

ctl-opt dftactgrp(*no) actgrp('NICKLITTEN')
 option(*nodebugio:*srcstmt:*nounref:*sqlcursorstay)
 datfmt(*ISO) decedit('0.')
 main(main)
 copyright('JSNIFSSQL V4.2 - Use JSON_TABLE to read IFS and parse JSON');


// --------------------------------------------
// Main Procedure
// --------------------------------------------

Dcl-Proc main;
   Dcl-Pi *n;
   end-pi;

   // Structure to hold individual JSON record fields
   // Field sizes optimized for 27x132 screen display
   Dcl-Ds jsonFields qualified;
      userID varchar(20);      // User ID - max 20 chars
      firstName varchar(30);   // First name - max 30 chars
      lastName varchar(30);    // Last name - max 30 chars
      initials varchar(5);     // Initials - max 5 chars
      company int(10);         // Company number
      division int(10);        // Division number
      department int(10);      // Department number
   End-Ds;

   // Result structure with success indicator, error message, and data array
   Dcl-Ds result qualified;
      success ind inz(*off);
      errmsg varchar(132);     // Error message - fits one screen line
      recordCount int(10) inz(0);
      jsonArray likeds(jsonFields) dim(9999);
   End-Ds;


   Dcl-S json sqltype(clob:16000000);

   Dcl-S cursorOpen ind inz(*off);

   Exec SQL
      select QSYS2.IFS_READ_UTF8('/home/nicklitten/getwebjsn.json')
      into :json
      from sysibm.sysdummy1;

   // Check for SQL errors on file read
   If (SQLSTATE <> '00000');
      result.success = *off;
      result.errmsg = 'Failed to read IFS file with SQLSTATE: ' + SQLSTATE;
      Return;
   EndIf;

   // Validate that we have data
   // Check CLOB length - json_len is the length indicator for the CLOB
   If (json_len = 0 or json_len = *null);
      result.success = *off;
      result.errmsg = 'IFS file is empty or contains no data';
      Return;
   EndIf;

   // Declare cursor to process JSON data using JSON_TABLE
   // Column sizes match data structure for 27x132 screen display
   Exec SQL
      declare MYCURSOR cursor for
      select *
      from json_table(
         :json,
         '$'
         columns(
            nested '$.users[*]' columns(
               userID varchar(20) path '$.userID',
               firstName varchar(30) path '$.firstName',
               lastName varchar(30) path '$.lastName',
               initials varchar(5) path '$.initials',
               company int path '$.company',
               division int path '$.division',
               department int path '$.department'
            )
         )
      ) as X;

   // Open the cursor
   Exec SQL open MYCURSOR;

   // Check for SQL errors on cursor open
   If (SQLSTATE <> '00000');
      result.success = *off;
      result.errmsg = 'Failed to open cursor. SQLSTATE: ' + SQLSTATE;
      Return;
   EndIf;

   cursorOpen = *on;

   // Fetch first record
   Exec SQL fetch next from MYCURSOR into :jsonFields;

   // Process all records from the cursor
   Dow (SQLSTATE = '00000' or %subst(SQLSTATE: 1: 2) = '01');

      // Increment record counter
      result.recordCount += 1;

      // Check if we've exceeded maximum array size
      If (result.recordCount > 9999);
         result.errmsg = 'Warning: Maximum record limit reached (' +
                         %char(9999) + ')';
         leave;
      EndIf;

      // Store data structure values in next element of return array
      result.jsonArray(result.recordCount) = jsonFields;

      // Fetch next record
      Exec SQL fetch next from MYCURSOR into :jsonFields;

   EndDo;

   // Close cursor if still open
   If (cursorOpen = *on);
      Exec SQL close MYCURSOR;
      cursorOpen = *off;
   EndIf;

   // Check if we processed any records
   If (result.recordCount = 0);
      result.success = *off;
      result.errmsg = 'No records found in JSON data';
   Else;
      result.success = *on;
      // Add success message if there was a warning
      If (result.errmsg = '');
