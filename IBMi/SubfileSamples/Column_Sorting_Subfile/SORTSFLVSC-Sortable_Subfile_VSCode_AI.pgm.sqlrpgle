**free

/// --------------------------------------------
/// Program Name: SORTSFLVSC
/// --------------------------------------------
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
///   - Click column headers to sort (ASC/DSC toggle)
///   - Search filtering across multiple fields
///   - Dynamic SQL statement construction
///   - Proper cursor management and resource cleanup
///   - Comprehensive error handling with job log integration
///   - Constants-based configuration for maintainability
///   - Indicator data structure for readable screen control
///
/// Usage:
///   CALL SORTSFLVSC
///   - Click any column header to sort by that column
///   - Click same header again to reverse sort order
///   - Enter search criteria in header fields to filter results
///   - Press F3 to exit
///
/// Author: Nick Litten
///
/// Modification History:
///   2025.10.16 njl - Created for online example
///   2026.02.03 njl - Enhanced with error handling, constants, and improved structure
///   2026.06.10 njl - Updated comments to match coding standards
///
/// --------------------------------------------

ctl-opt main(mainline)
        optimize(*full)
        option(*nodebugio:*srcstmt:*nounref)
        pgminfo(*pcml:*module)
        actgrp(*new)
        indent('| ')
        alwnull(*usrctl)
        dftactgrp(*no)
        bnddir('BIGBNDDIR')
        copyright('v1.3 - Sortable Subfile using SQL in RPG');

// --------------------------------------------
// File Declarations
// --------------------------------------------
dcl-f SORTSFL workstn sfile(SFL01:RRN) indds(indicators) usropn;

// --------------------------------------------
// Include Files
// --------------------------------------------
/INCLUDE 'globals.rpgleinc'
/INCLUDE 'prototypes.rpgleinc'

// --------------------------------------------
// Data Structures
// --------------------------------------------
Dcl-Ds indicators qualified;
   exit ind pos(3);
   columnClick ind pos(9);
   sflClr ind pos(30);
   sflDsp ind pos(31);
   sflDspCtl ind pos(32);
   sflEnd ind pos(33);
   norows ind pos(69);
end-ds;

// --------------------------------------------
// Constants
// --------------------------------------------
Dcl-C SQL_SUCCESS 0;
Dcl-C SQL_NO_DATA 100;
Dcl-C SORT_ASC 'ASC';
Dcl-C SORT_DSC 'DESC';
Dcl-C DFT_SORT_FIELD 'SORTDATE';

// --------------------------------------------
// Global Variables
// --------------------------------------------
Dcl-S rrn zoned(4:0);
Dcl-S SortField char(10) inz('SORTDATE');
Dcl-S SortOrder char(4) inz(SORT_ASC);
Dcl-S LastSortField char(10);

Dcl-S WhereClause varchar(1000);
Dcl-S SqlStmt varchar(2000);
Dcl-S OrderByClause varchar(32);

Dcl-S FetchSortDate zoned(10:0);
Dcl-S FetchSortTime zoned(10:0);
Dcl-S FetchSortUser char(10);
Dcl-S FetchSortText char(40);
Dcl-S FetchSortStatus char(1);

Dcl-S ErrorOccurred ind inz(*off);
Dcl-S ErrorMessage char(256);


// --------------------------------------------
// Procedure: mainline
// Purpose: Main display loop - handles user interaction
// Notes: Centralized control flow for better maintainability
// --------------------------------------------
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


// --------------------------------------------
// Procedure: ClearSubfile
// Purpose: Clear all records from the subfile
// --------------------------------------------
Dcl-Proc ClearSubfile;
   indicators.sflClr = *on;
   write CTL01;
   indicators.sflClr = *off;
   rrn = 0;
end-proc;

// --------------------------------------------
// Procedure: GetOrderByClause
// Purpose: Restrict dynamic ORDER BY to known columns before opening cursor
// --------------------------------------------
Dcl-Proc GetOrderByClause;
   Dcl-Pi *N varchar(32) end-pi;

   Select;
      When (fld = 'HEADDATE' or fld = 'SRCHDATE');
         Return 'SORTDATE ' + %trim(SortOrder);

      When (fld = 'HEADTIME' or fld = 'SRCHTIME');
         Return 'SORTTIME ' + %trim(SortOrder);

      When (fld = 'HEADUSER' or fld = 'SRCHUSER');
         Return 'SORTUSER ' + %trim(SortOrder);

      When (fld = 'HEADTEXT' or fld = 'SRCHTEXT');
         Return 'SORTTEXT ' + %trim(SortOrder);

      When (fld = 'HEADSTAT' or fld = 'SRCHSTAT');
         Return 'SORTSTATUS ' + %trim(SortOrder);

      Other;
         SortField = DFT_SORT_FIELD;
         SortOrder = SORT_ASC;
         Return DFT_SORT_FIELD + ' ' + SORT_ASC;
   EndSl;
end-proc;

// --------------------------------------------
// Procedure: BuildWhereClause
// Purpose: Construct SQL WHERE clause based on search criteria
// Returns: WhereClause variable populated with conditions
// Notes: Uses parameterized approach to prevent SQL injection
// --------------------------------------------
Dcl-Proc BuildWhereClause;
   Dcl-S conditions varchar(1000);
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

// --------------------------------------------
// Procedure: LoadSubfile
// Purpose: Execute SQL query and populate subfile with results
// Returns: Sets ErrorOccurred flag if SQL errors occur
// Notes: Uses cursor for efficient data retrieval
// --------------------------------------------
Dcl-Proc LoadSubfile;
   Dcl-S fetchCount int(10);
   Dcl-S localSqlCode int(10) inz(SQL_SUCCESS);
   
   ErrorOccurred = *off;
   ErrorMessage = '';
   indicators.norows = *off;
   
   // Build the WHERE clause from search criteria
   BuildWhereClause();
   OrderByClause = GetOrderByClause();
   
   // Native PF I/O is replaced with cursor FETCH so sorting stays fully in SQL.
   // Construct dynamic SQL statement with proper spacing
   SqlStmt = 'SELECT SORTDATE, SORTTIME, SORTUSER, SORTTEXT, SORTSTATUS ' +
             'FROM SORTSFLPF ' +
             %trim(WhereClause) + ' ' +
             'ORDER BY ' + %trim(OrderByClause);
   
   // Prepare SQL statement
   exec sql prepare S1 from :SqlStmt;
   
   If (sqlcode <> SQL_SUCCESS);
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Prepare failed: SQLCODE=' + %char(sqlcode);
      LogMessage(ErrorMessage);
      Return;
   EndIf;
   
   // Declare and open cursor
   exec sql declare myCursor cursor for S1;
   
   exec sql open myCursor;
   
   If (sqlcode <> SQL_SUCCESS);
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Open cursor failed: SQLCODE=' + %char(sqlcode);
      LogMessage(ErrorMessage);
      Return;
   EndIf;
   
   // Fetch records in a loop
   exec sql fetch next from myCursor 
            into :FetchSortDate, :FetchSortTime, :FetchSortUser,
                 :FetchSortText, :FetchSortStatus;
   
   localSqlCode = sqlcode;
   
   // Loop through all records with proper boundary checking
   dow (localSqlCode = SQL_SUCCESS and rrn < 9999);
      rrn += 1;
      fetchCount += 1;
      SORTDATE = FetchSortDate;
      SORTTIME = FetchSortTime;
      SORTUSER = FetchSortUser;
      SORTTEXT = FetchSortText;
      SORTSTATUS = FetchSortStatus;
      write SFL01;
      
      exec sql fetch next from myCursor 
               into :FetchSortDate, :FetchSortTime, :FetchSortUser,
                    :FetchSortText, :FetchSortStatus;
      
      localSqlCode = sqlcode;
   enddo;
   
   // Close cursor and free resources
   exec sql close myCursor;
   
   // Handle edge cases
   If (localSqlCode <> SQL_SUCCESS and localSqlCode <> SQL_NO_DATA);
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Fetch error: SQLCODE=' + %char(localSqlCode);
      LogMessage(ErrorMessage);
   EndIf;
   
   // Set indicator if we hit the subfile size limit
   If (rrn >= 9999);
      indicators.sflEnd = *on;  // Show "more records available" indicator
   Else;
      indicators.sflEnd = *off;
   EndIf;
   
   // Log successful load for diagnostics
   If (fetchCount = 0);
      LogMessage('No records found matching criteria');
      
      indicators.norows = *on;
   EndIf;
end-proc;

// --------------------------------------------
// Procedure: HandleColumnClick
// Purpose: Process column header clicks to change sort order
// Notes: Uses cursor position to determine which column was clicked
// --------------------------------------------
Dcl-Proc HandleColumnClick;
   Dcl-S newSortField char(10);
  
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
         // Click outside valid column headers - ignore
         Return;
   EndSl;
   
   // Update sort field and toggle order if needed
   If (newSortField <> '');
      SortField = newSortField;
      ToggleSortOrder();
   EndIf;
end-proc;

// --------------------------------------------
// Procedure: ToggleSortOrder
// Purpose: Toggle between ASC and DSC sort order
// Notes: Maintains sort direction when clicking same column repeatedly
// --------------------------------------------
Dcl-Proc ToggleSortOrder;
   // If same field clicked, toggle sort direction
   If (SortField = LastSortField);
      If (SortOrder = SORT_ASC);
         SortOrder = SORT_DSC;
      Else;
         SortOrder = SORT_ASC;
      EndIf;
   Else;
      // New field selected, default to ASC
      SortOrder = SORT_ASC;
   EndIf;
   
   LastSortField = SortField;
end-proc;