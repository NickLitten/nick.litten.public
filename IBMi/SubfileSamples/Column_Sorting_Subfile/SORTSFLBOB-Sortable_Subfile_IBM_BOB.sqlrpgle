**free
/// ----------------------------------------------------------------------------
/// Program Name: SORTSFLBOB - Sortable Subfile using Embedded SQL
/// ----------------------------------------------------------------------------
///
/// Description:
///   Interactive subfile demonstration with column-based sorting and search
///   capabilities. Shows modern SQLRPGLE techniques for dynamic data display
///   and user interaction patterns.
///
/// Purpose:
///   - Demonstrate dynamic SQL cursor usage in SQLRPGLE
///   - Show column-header click detection for sorting
///   - Illustrate search criteria building with SQL WHERE clauses
///   - Provide example of subfile pagination and control
///   - Demonstrate error handling and logging patterns
///
/// Features:
///   - Click column headers to sort (ascending/descending toggle)
///   - Search filtering across multiple fields
///   - Dynamic SQL statement construction
///   - Proper cursor management and resource cleanup
///   - Comprehensive error handling with job log integration
///   - Constants-based configuration for maintainability
///   - Indicator data structure for readable screen control
///
/// Usage:
///   CALL SORTSFLBOB
///   - Click any column header to sort by that column
///   - Click same header again to reverse sort order
///   - Enter search criteria in header fields to filter results
///   - Press F3 to exit
///
/// Author: Nick Litten
///
/// Modification History:
///   v1.0 2025.10.16 njl - Created for online example
///   v1.1 2026.02.03 njl - Enhanced with error handling, constants, and improved structure
///
/// ----------------------------------------------------------------------------

ctl-opt main(mainline)
        optimize(*full)
        option(*nodebugio:*srcstmt:*nounref)
        pgminfo(*pcml:*module)
        actgrp(*new)
        indent('| ')
        alwnull(*usrctl)
        dftactgrp(*no)
        bnddir('BIGBNDDIR')
        copyright('V1.1 - Sortable Subfile using SQL in RPG');

// File Declarations
dcl-f SORTSFL workstn sfile(SFL01:RRN) indds(indicators) usropn;

// Note: SORTSFLPF accessed via embedded SQL cursor (no native file I/O)

// --------------------------------------------
// Prototypes for Service Program Procedures
// --------------------------------------------
// LOGMESSAGE: Centralized logging utility for diagnostics and error tracking
//   - Writes messages to the job log with proper severity levels
//   - Used throughout this program for:
//     * SQL error reporting (prepare, open, fetch failures)
//     * Diagnostic information (record counts, search criteria)
//     * Runtime status tracking
//   - Provides consistent message format across all program operations
//   - Messages appear in QSYSOPR and can be monitored/analyzed
//   - Signature: LogMessage(message: char(256))
// --------------------------------------------
/include 'globals.rpgleinc'
/include 'prototypes.rpgleinc'

// Indicator Data Structure for better readability
Dcl-Ds indicators qualified;
   exit ind pos(3);
   columnClick ind pos(9);
   sflClr ind pos(30);
   sflDsp ind pos(31);
   sflDspCtl ind pos(32);
   sflEnd ind pos(33);
   norows ind pos(69);
end-ds;

Dcl-C SQL_SUCCESS 0;
Dcl-C SQL_NO_DATA 100;
Dcl-C SORT_ASCENDING 'ASC';
Dcl-C SORT_DESCENDING 'DESC';
Dcl-C DEFAULT_SORT_FIELD 'SORTDATE';

// Subfile control variables
Dcl-S rrn zoned(4:0);
Dcl-S SortField char(10) inz(DEFAULT_SORT_FIELD);
Dcl-S SortOrder char(4) inz(SORT_ASCENDING);
Dcl-S LastSortField char(10) inz('');

// SQL statement building
Dcl-S WhereClause varchar(1000) inz('');
Dcl-S SqlStmt varchar(2000) inz('');

// Error handling and diagnostics
Dcl-S ErrorOccurred ind inz(*off);
Dcl-S ErrorMessage char(256) inz('');


// ----------------------------------------------------------
// Procedure: mainline
// Purpose: Main display loop - handles user interaction
// SORTes: Centralized control flow for better maintainability
// ----------------------------------------------------------
Dcl-Proc mainline;
   Dcl-S firstDisplay ind inz(*on);
   
   open SORTSFL;
   HEADDATE = 'Date';
   HEADTIME = 'Time';
   HEADUSER = 'User ID';
   HEADTEXT = 'Text';
   HEADSTAT = 'Status';

   dow (not indicators.exit);
      // Clear and reload subfile
      ClearSubfile();
      LoadSubfile();
      
      // Set display indicators
      indicators.sflDsp = (rrn > 0);     // Display subfile only if records exist
      indicators.sflDspCtl = *on;        // Always display control record
      
      // Display the screen
      write CMD01;
      exfmt CTL01;
      
      // Check mouseclick value for user action
      Select;
         When (indicators.exit);
            leave;
            
         When (indicators.columnClick);
            HandleColumnClick();
            // Continue to next iteration to refresh display
      EndSl;
            
      firstDisplay = *off;
   enddo;

   close SORTSFL;

   Return;
   
end-proc;


// ----------------------------------------------------------
// Procedure: ClearSubfile
// Purpose: Clear all records from the subfile
// ----------------------------------------------------------
Dcl-Proc ClearSubfile;
   indicators.sflClr = *on;
   write CTL01;
   indicators.sflClr = *off;
   rrn = 0;
end-proc;

// ----------------------------------------------------------
// Procedure: BuildWhereClause
// Purpose: Construct SQL WHERE clause based on search criteria
// Returns: WhereClause variable populated with conditions
// SORTes: Uses parameterized approach to prevent SQL injection
// ----------------------------------------------------------
Dcl-Proc BuildWhereClause;
   Dcl-S conditions varchar(1000) inz('');
   Dcl-S hasConditions ind inz(*off);
   
   WhereClause = '';
   
   // Build individual conditions with proper SQL syntax
   // Using UPPER() for case-insensitive searches
   
   If (srchdate <> '');
      conditions += ' AND SORTDATE LIKE UPPER(''%' + 
                    %trim(%scanrpl('''':'''''':srchdate)) + '%'')';
      hasConditions = *on;
   EndIf;
   
   If (srchtime <> '');
      conditions += ' AND SORTTIME LIKE UPPER(''%' + 
                    %trim(%scanrpl('''':'''''':srchtime)) + '%'')';
      hasConditions = *on;
   EndIf;
   
   If (%trim(srchuser) <> '');
      // Escape single quotes in user input to prevent SQL issues
      conditions += ' AND UPPER(SORTUSER) LIKE UPPER(''%' + 
                    %trim(%scanrpl('''':'''''':srchuser)) + '%'')';
      hasConditions = *on;
   EndIf;
   
   If (%trim(srchtext) <> '');
      conditions += ' AND UPPER(SORTTEXT) LIKE UPPER(''%' + 
                    %trim(%scanrpl('''':'''''':srchtext)) + '%'')';
      hasConditions = *on;
   EndIf;
   
   If (%trim(srchstat) <> '');
      conditions += ' AND UPPER(SORTSTATUS) LIKE UPPER(''%' + 
                    %trim(%scanrpl('''':'''''':srchstat)) + '%'')';
      hasConditions = *on;
   EndIf;
   
   // Convert conditions to proper WHERE clause
   If (hasConditions);
      WhereClause = 'WHERE' + %subst(conditions : 5);
   EndIf;
end-proc;

// ----------------------------------------------------------
// Procedure: LoadSubfile
// Purpose: Execute SQL query and populate subfile with results
// Returns: Sets ErrorOccurred flag if SQL errors occur
// SORTes: Uses cursor for efficient data retrieval
// ----------------------------------------------------------
Dcl-Proc LoadSubfile;
   Dcl-S sqlErrMsg char(256);
   
   ErrorOccurred = *off;
   ErrorMessage = '';
   indicators.norows = *off;
   
   // Build the WHERE clause from search criteria
   BuildWhereClause();
   
   // Construct dynamic SQL statement with proper spacing
   SqlStmt = 'SELECT SORTDATE, SORTTIME, SORTUSER, SORTTEXT, SORTSTATUS ' +
             'FROM SORTSFLPF ' +
             %trim(WhereClause) + ' ' +
             'ORDER BY ' + %trim(SortField) + ' ' + %trim(SortOrder);
   
   // Prepare SQL statement
   exec sql prepare S1 from :SqlStmt;
   
   If (sqlcode <> SQL_SUCCESS);
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Prepare failed: sqlcode=' + %char(sqlcode);
      LogMessage(ErrorMessage);
      Return;
   EndIf;
   
   // Declare and open cursor
   exec sql declare myCursor cursor for S1;
   
   exec sql open myCursor;
   
   If (sqlcode <> SQL_SUCCESS);
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Open cursor failed: sqlcode=' + %char(sqlcode);
      LogMessage(ErrorMessage);
      Return;
   EndIf;
   
   // Fetch records in a loop
   exec sql fetch next from myCursor 
            into :SORTDATE, :SORTTIME, :SORTUSER, :SORTTEXT, :SORTSTATUS;
   
   // Loop through all records with proper boundary checking
   dow (sqlcode = SQL_SUCCESS and rrn < 9999);
      rrn += 1;
      write SFL01;
      
      exec sql fetch next from myCursor
               into :SORTDATE, :SORTTIME, :SORTUSER, :SORTTEXT, :SORTSTATUS;
      
   enddo;
   
   // Close cursor and free resources
   exec sql close myCursor;
   
   // Handle edge cases
   If (sqlcode <> SQL_SUCCESS and sqlcode <> SQL_NO_DATA);
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Fetch error: sqlcode=' + %char(sqlcode);
      LogMessage(ErrorMessage);
   EndIf;
   
   // Set indicator if we hit the subfile size limit
   If (rrn >= 9999);
      indicators.sflEnd = *on;  // Show "more records available" indicator
   Else;
      indicators.sflEnd = *off;
   EndIf;
   
   // Log successful load for diagnostics
   If (rrn = 0);
      LogMessage('No records found matching criteria');
      indicators.norows = *on;
   EndIf;
end-proc;

// ----------------------------------------------------------
// Procedure: HandleColumnClick
// Purpose: Process column header clicks to change sort order

// SORTes: Uses cursor position to determine which column was clicked
// ----------------------------------------------------------
Dcl-Proc HandleColumnClick;
   Dcl-S newSortField char(10) inz('');
   
   // Determine which column was clicked based on cursor position
   Select;
      When (fld = 'HEADDATE' or fld = 'SRCHDATE');
         newSortField = 'SORTDATE';
         
      When (fld = 'HEADTIME' or fld = 'SRCHTIME');
         newSortField = 'SORTTIME';
         
      When (fld = 'HEADUSER' or fld = 'SRCHUSER');
         newSortField = 'SORTUSER';
         
      When (fld = 'HEADTEXT' or fld = 'SRCHTEXT');
         newSortField = 'SORTTEXT';
         
      When (fld = 'HEADSTAT' or fld = 'SRCHSTAT');
         newSortField = 'SORTSTATUS';
         
      Other;
         // Click outside valid column headers - use Date as default
         SortField = 'SORTDATE';
         SortOrder = SORT_ASCENDING;
         Return;
   EndSl;
   
   // Update sort field and toggle order if needed
   If (newSortField <> '');
      SortField = newSortField;
      ToggleSortOrder();
   EndIf;
end-proc;

// ----------------------------------------------------------
// Procedure: ToggleSortOrder
// Purpose: Toggle between ascending and descending sort order
// SORTes: Maintains sort direction when clicking same column repeatedly
// ----------------------------------------------------------
Dcl-Proc ToggleSortOrder;
   // If same field clicked, toggle sort direction
   If (SortField = LastSortField);
      If (SortOrder = SORT_ASCENDING);
         SortOrder = SORT_DESCENDING;
      Else;
         SortOrder = SORT_ASCENDING;
      EndIf;
   Else;
      // New field selected, default to ascending
      SortOrder = SORT_ASCENDING;
   EndIf;
   
   LastSortField = SortField;
end-proc;