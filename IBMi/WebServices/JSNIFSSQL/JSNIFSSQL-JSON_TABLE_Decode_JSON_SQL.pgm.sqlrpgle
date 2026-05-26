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
///   - Reading JSON files from the IFS using C API functions
///   - Parsing JSON data using SQL JSON_TABLE function
///   - Extracting nested JSON arrays into RPG data structures
///   - Handling JSON data in embedded SQL within SQLRPGLE
///   - Processing multiple JSON records in a cursor loop
///   - Proper error handling and resource cleanup
///
/// Features:
///   - Reads JSON file from IFS using open/read/close C APIs
///   - Loads JSON data into SQL CLOB variable for processing
///   - Uses JSON_TABLE to parse nested JSON arrays
///   - Extracts user data (userID, firstName, lastName, etc.)
///   - Stores parsed data in array of data structures
///   - Comprehensive error handling with detailed messages
///   - Proper resource cleanup (file handles, cursors)
///   - Supports up to 9999 JSON records
///   - Validates file handle and read operations
///
/// Usage: CALL JSNIFSSQL
///        (No parameters required - reads from hardcoded IFS path)
///
/// Parameters: None
///
/// SQL Usage:
///   - JSON_TABLE function to parse JSON structure
///   - Cursor C1 to iterate through parsed JSON records
///   - Nested path '$.users[*]' to access JSON array elements
///   - Individual field paths for data extraction
///
/// Dependencies:
///   - IFS file: /home/nicklitten/getwebjsn.json
///   - C API functions: open(), read(), close()
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
///
/// Modification History:
/// 1.0 2017-07-17 | Nick Litten | Initial creation
/// 1.1 2021-06-20 | Nick Litten | Removed unused variables for clarity
/// 1.2 2026-04-02 | Nick Litten | Added comprehensive triple-slash documentation
/// 2.0 2026-05-17 | Nick Litten | Major refactoring: improved error handling,
///                                 resource cleanup, performance optimization,
///                                 added validation and edge case handling

ctl-opt dftactgrp(*no) actgrp('NICKLITTEN')
 option(*nodebugio:*srcstmt:*nounref:*sqlcursorstay)
 datfmt(*ISO) decedit('0.')
 copyright('JSNIFSSQL V2.0 - Use JSON_TABLE to read IFS and parse JSON');


// IFS file with JSON code that we will be reading and decoding
Dcl-C IFSFILENAME const('/home/nicklitten/getwebjsn.json');

// File open flags
Dcl-C O_RDONLY const(1);
Dcl-C O_TEXTDATA const(16777216);

// Maximum array size for JSON records
Dcl-C MAX_RECORDS const(9999);

// Maximum file size (16MB)
Dcl-C MAX_FILE_SIZE const(16000000);


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
   jsonArray likeds(jsonFields) dim(MAX_RECORDS);
End-Ds;


// Open IFS file
Dcl-Pr open int(10) extproc('open');
   *n pointer value options(*string); // filename
   *n int(10) value; // openflags
   *n uns(10) value options(*nopass); // mode
   *n uns(10) value options(*nopass); // codepage
End-Pr;

// Read from IFS file
Dcl-Pr read int(10) extproc('read');
   *n int(10) value; // filehandle
   *n pointer value; // datareceived
   *n uns(10) value; // nbytes
End-Pr;

// Close IFS file
Dcl-Pr close int(10) extproc('close');
   *n int(10) value; // filehandle
End-Pr;


Dcl-S fileHandle int(10) inz(-1);
Dcl-S json sqltype(clob:MAX_FILE_SIZE);
Dcl-S ifsData char(MAX_FILE_SIZE);
Dcl-S bytesRead int(10);
Dcl-S totalBytesRead int(10) inz(0);
Dcl-S cursorOpen ind inz(*off);

// ---
// Main Processing
// ---

// Open the IFS file
fileHandle = open(%trim(IFSFILENAME): O_RDONLY + O_TEXTDATA);

// Validate file handle
If (fileHandle < 0);
   result.success = *off;
   result.errmsg = 'Failed to open IFS file: ' + %trim(IFSFILENAME);
   *inlr = *on;
   Return;
EndIf;

// Read the entire file into memory
// Note: For very large files, consider reading in chunks
bytesRead = read(fileHandle: %addr(ifsData): %size(ifsData));

If (bytesRead < 0);
   result.success = *off;
   result.errmsg = 'Error reading from IFS file';
   close(fileHandle);
   *inlr = *on;
   Return;
ElseIf (bytesRead = 0);
   result.success = *off;
   result.errmsg = 'IFS file is empty';
   close(fileHandle);
   *inlr = *on;
   Return;
EndIf;

totalBytesRead = bytesRead;

// Close the file handle immediately after reading
close(fileHandle);
fileHandle = -1;

// Validate that we have data
If (totalBytesRead = 0 or %trim(ifsData) = '');
   result.success = *off;
   result.errmsg = 'No data read from IFS file';
   *inlr = *on;
   Return;
EndIf;

// Set SQL options for optimal performance and behavior
Exec SQL
   set option naming = *sys,
              commit = *none,
              usrprf = *user,
              dynusrprf = *user,
              datfmt = *iso,
              closqlcsr = *endmod;

// Load the IFS data into the CLOB variable for SQL processing
json_data = %subst(ifsData: 1: totalBytesRead);
json_len = totalBytesRead;

// Declare cursor to process JSON data using JSON_TABLE
// Column sizes match data structure for 27x132 screen display
Exec SQL
   declare C1 cursor for
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
Exec SQL :open C1;

// Check for SQL errors on cursor open
If (SQLSTATE <> '00000');
   result.success = *off;
   result.errmsg = 'Failed to open cursor. SQLSTATE: ' + SQLSTATE;
   *inlr = *on;
   Return;
EndIf;

cursorOpen = *on;

// Fetch first record
Exec SQL fetch next from C1 into :jsonFields;

// Process all records from the cursor
Dow (SQLSTATE = '00000' or %subst(SQLSTATE: 1: 2) = '01');

   // Increment record counter
   result.recordCount += 1;

   // Check if we've exceeded maximum array size
   If (result.recordCount > MAX_RECORDS);
      result.errmsg = 'Warning: Maximum record limit reached (' +
                      %char(MAX_RECORDS) + ')';
      leave;
   EndIf;

   // Store data structure values in next element of return array
   result.jsonArray(result.recordCount) = jsonFields;

   // Fetch next record
   Exec SQL fetch next from C1 into :jsonFields;

EndDo;

// Close the cursor
Exec SQL :close C1;
cursorOpen = *off;

// Check if we processed any records
If (result.recordCount = 0);
   result.success = *off;
   result.errmsg = 'No records found in JSON data';
Else;
   result.success = *on;
   // Add success message if there was a warning
   If (result.errmsg = '');
      result.errmsg = 'Successfully processed ' +
                      %char(result.recordCount) + ' records';
   EndIf;
EndIf;

*inlr = *on;
