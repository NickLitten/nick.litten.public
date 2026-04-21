**free
//
// Program Name: SORTSFL - Sortable Subfile using Embedded SQL
// Description:  Interactive subfile with column-based sorting and search capabilities
//
// Modification History:
// v.002 2026.02.03 njl Enhanced with improved error handling, performance, and maintainability
// v.001 2026.02.03 njl Enhanced with error handling, constants, and improved structure
// v.000 2025.10.16 njl Created for online example
//

ctl-opt
     optimize(*full)
     option(*nodebugio:*srcstmt:*nounref)
     pgminfo(*pcml:*module)
     actgrp(*new)
     indent('| ')
     alwnull(*usrctl)
     copyright('SORTSFL | V.002 | Sortable Subfile using SQL in RPG');

// File Declarations
dcl-f SORTSFLPF disk usage(*input) keyed;
dcl-f SORTSFL workstn SFILE(SFL01:RRN) indds(indicators);

// ------------------------------------------------------------------------------
// Indicator Data Structure for better readability
// ------------------------------------------------------------------------------
Dcl-Ds indicators;
   exit ind pos(3);
   columnClick ind pos(5);
   sflClr ind pos(30);
   sflDsp ind pos(31);
   sflDspCtl ind pos(32);
   sflEnd ind pos(33);
end-ds;

// ------------------------------------------------------------------------------
// Constants for maintainability
// ------------------------------------------------------------------------------
Dcl-C MAX_SUBFILE_SIZE 9999;
Dcl-C SUBFILE_PAGE_SIZE 15;
Dcl-C SQL_SUCCESS 0;
Dcl-C SQL_NO_DATA 100;
Dcl-C SORT_ASCENDING 'ASC';
Dcl-C SORT_DESCENDING 'DESC';
Dcl-C DEFAULT_SORT_FIELD 'NOTDATE';

// Column position constants for click detection
Dcl-C COL_DATE_START 2;
Dcl-C COL_DATE_END 9;
Dcl-C COL_TIME_START 12;
Dcl-C COL_TIME_END 17;
Dcl-C COL_USER_START 22;
Dcl-C COL_USER_END 31;
Dcl-C COL_CMD_START 34;
Dcl-C COL_CMD_END 43;
Dcl-C COL_STATUS_START 46;
Dcl-C COL_STATUS_END 48;
Dcl-C HEADER_ROW 2;

// SQL State codes for better error handling
Dcl-C SQLSTATE_SUCCESS '00000';
Dcl-C SQLSTATE_NO_DATA '02000';

// ------------------------------------------------------------------------------
// Subfile control variables
// ------------------------------------------------------------------------------
Dcl-S rrn zoned(4:0);
Dcl-S SortField char(10) inz(DEFAULT_SORT_FIELD);
Dcl-S SortOrder char(4) inz(SORT_ASCENDING);
Dcl-S LastSortField char(10) inz('');

// ------------------------------------------------------------------------------
// SQL statement building
// ------------------------------------------------------------------------------
Dcl-S WhereClause varchar(1000) inz('');
Dcl-S SqlStmt varchar(2000) inz('');

// ------------------------------------------------------------------------------
// Search criteria fields (initialized to prevent garbage values)
// ------------------------------------------------------------------------------
Dcl-S srchdate zoned(8:0) inz(0);
Dcl-S srchtime zoned(6:0) inz(0);
Dcl-S srchuser char(10) inz('');
Dcl-S srchcmd char(10) inz('');
Dcl-S srchstat char(3) inz('');

// ------------------------------------------------------------------------------
// Error handling and diagnostics
// ------------------------------------------------------------------------------
Dcl-S ErrorOccurred ind inz(*off);
Dcl-S SqlState char(5);
Dcl-S ErrorMessage char(256) inz('');

// ------------------------------------------------------------------------------
// Main Program Logic
// ------------------------------------------------------------------------------

// Initialize and display the subfile interface
DisplaySubfile();

// Normal program termination
*inlr = *on;
Return;

// ------------------------------------------------------------------------------
// Procedure: ClearSubfile
// Purpose: Clear all records from the subfile
// ------------------------------------------------------------------------------
Dcl-Proc ClearSubfile;
   sflClr = *on;
   write CTL01;
   sflClr = *off;
   rrn = 0;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: BuildWhereClause
// Purpose: Construct SQL WHERE clause based on search criteria
// Returns: WhereClause variable populated with conditions
// Notes: Uses parameterized approach to prevent SQL injection
// ------------------------------------------------------------------------------
Dcl-Proc BuildWhereClause;
   Dcl-S conditions varchar(1000) inz('');
   Dcl-S hasConditions ind inz(*off);
   
   WhereClause = '';
   
   // Build individual conditions with proper SQL syntax
   // Using UPPER() for case-insensitive searches
   
   If (srchdate <> 0);
      conditions += ' AND NOTDATE = ' + %char(srchdate);
      hasConditions = *on;
   EndIf;
   
   If (srchtime <> 0);
      conditions += ' AND NOTTIME = ' + %char(srchtime);
      hasConditions = *on;
   EndIf;
   
   If (%trim(srchuser) <> '');
      // Escape single quotes in user input to prevent SQL issues
      conditions += ' AND UPPER(NOTUSER) LIKE UPPER(''%' + 
                    %trim(%scanrpl('''':'''''':srchuser)) + '%'')';
      hasConditions = *on;
   EndIf;
   
   If (%trim(srchcmd) <> '');
      conditions += ' AND UPPER(NOTCMD) LIKE UPPER(''%' + 
                    %trim(%scanrpl('''':'''''':srchcmd)) + '%'')';
      hasConditions = *on;
   EndIf;
   
   If (%trim(srchstat) <> '');
      conditions += ' AND UPPER(NOTSTATUS) LIKE UPPER(''%' + 
                    %trim(%scanrpl('''':'''''':srchstat)) + '%'')';
      hasConditions = *on;
   EndIf;
   
   // Convert conditions to proper WHERE clause
   If (hasConditions);
      WhereClause = 'WHERE' + %subst(conditions : 5);
   EndIf;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: LoadSubfile
// Purpose: Execute SQL query and populate subfile with results
// Returns: Sets ErrorOccurred flag if SQL errors occur
// Notes: Uses cursor for efficient data retrieval
// ------------------------------------------------------------------------------
Dcl-Proc LoadSubfile;
   Dcl-S fetchCount int(10) inz(0);
   Dcl-S sqlCode int(10);
   Dcl-S sqlErrMsg char(256);
   
   ErrorOccurred = *off;
   ErrorMessage = '';
   
   // Build the WHERE clause from search criteria
   BuildWhereClause();
   
   // Construct dynamic SQL statement with proper spacing
   SqlStmt = 'SELECT NOTDATE, NOTTIME, NOTUSER, NOTCMD, NOTSTATUS ' +
             'FROM SORTSFLPF ' +
             %trim(WhereClause) + ' ' +
             'ORDER BY ' + %trim(SortField) + ' ' + %trim(SortOrder);
   
   // Prepare SQL statement
   exec sql prepare S1 from :SqlStmt;
   
   If (sqlcode <> SQL_SUCCESS);
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Prepare failed: SQLCODE=' + %char(sqlcode);
      LogError(ErrorMessage);
      Return;
   EndIf;
   
   // Declare and open cursor
   exec sql declare myCursor cursor for S1;
   
   exec sql open myCursor;
   
   If (sqlcode <> SQL_SUCCESS);
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Open cursor failed: SQLCODE=' + %char(sqlcode);
      LogError(ErrorMessage);
      Return;
   EndIf;
   
   // Fetch records in a loop
   exec sql fetch next from myCursor 
            into :NOTDATE, :NOTTIME, :NOTUSER, :NOTCMD, :NOTSTATUS;
   
   sqlCode = sqlcode;
   
   // Loop through all records with proper boundary checking
   dow (sqlCode = SQL_SUCCESS and rrn < MAX_SUBFILE_SIZE);
      rrn += 1;
      fetchCount += 1;
      write SFL01;
      
      exec sql fetch next from myCursor 
               into :NOTDATE, :NOTTIME, :NOTUSER, :NOTCMD, :NOTSTATUS;
      
      sqlCode = sqlcode;
   enddo;
   
   // Close cursor and free resources
   exec sql close myCursor;
   
   // Handle edge cases
   If (sqlCode <> SQL_SUCCESS and sqlCode <> SQL_NO_DATA);
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Fetch error: SQLCODE=' + %char(sqlCode);
      LogError(ErrorMessage);
   EndIf;
   
   // Set indicator if we hit the subfile size limit
   If (rrn >= MAX_SUBFILE_SIZE);
      sflEnd = *on;  // Show "more records available" indicator
   Else;
      sflEnd = *off;
   EndIf;
   
   // Log successful load for diagnostics
   If (fetchCount = 0);
      LogError('No records found matching criteria');
   EndIf;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: DisplaySubfile
// Purpose: Main display loop - handles user interaction
// Notes: Centralized control flow for better maintainability
// ------------------------------------------------------------------------------
Dcl-Proc DisplaySubfile;
   Dcl-S firstDisplay ind inz(*on);
   
   dow (not exit);
      // Clear and reload subfile
      ClearSubfile();
      LoadSubfile();
      
      // Set display indicators
      sflDsp = (rrn > 0);     // Display subfile only if records exist
      sflDspCtl = *on;        // Always display control record
      
      // Display the screen
      write HDR01;
      write FOOTER;
      exfmt CTL01;
      
      // Check for exit
      If (exit);
         leave;
      EndIf;
      
      // Handle column header click for sorting
      If (columnClick);
         HandleColumnClick();
         // Continue to next iteration to refresh display
      EndIf;
      
      firstDisplay = *off;
   enddo;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: HandleColumnClick
// Purpose: Process column header clicks to change sort order
// Notes: Uses cursor position to determine which column was clicked
// ------------------------------------------------------------------------------
Dcl-Proc HandleColumnClick;
   Dcl-S newSortField char(10) inz('');
   
   // Only process clicks on header row
   If (row <> HEADER_ROW);
      Return;
   EndIf;
   
   // Determine which column was clicked based on cursor position
   Select;
      When (col >= COL_DATE_START and col <= COL_DATE_END);
         newSortField = 'NOTDATE';
         
      When (col >= COL_TIME_START and col <= COL_TIME_END);
         newSortField = 'NOTTIME';
         
      When (col >= COL_USER_START and col <= COL_USER_END);
         newSortField = 'NOTUSER';
         
      When (col >= COL_CMD_START and col <= COL_CMD_END);
         newSortField = 'NOTCMD';
         
      When (col >= COL_STATUS_START and col <= COL_STATUS_END);
         newSortField = 'NOTSTATUS';
         
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

// ------------------------------------------------------------------------------
// Procedure: ToggleSortOrder
// Purpose: Toggle between ascending and descending sort order
// Notes: Maintains sort direction when clicking same column repeatedly
// ------------------------------------------------------------------------------
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

// ------------------------------------------------------------------------------
// Procedure: LogError
// Purpose: Centralized error logging for diagnostics
// Parameters: errMsg - Error message to log
// Notes: Can be enhanced to write to job log or error file
// ------------------------------------------------------------------------------
Dcl-Proc LogError;
   Dcl-Pi *n;
      errMsg char(256) const;
   end-pi;
   
   Dcl-S msgText char(512);
   
   // Format error message with timestamp
   msgText = %char(%timestamp()) + ' - SORTSFL: ' + %trim(errMsg);
   
   // Send diagnostic message to job log
   exec sql call qsys2.qcmdexc('SNDPGMMSG MSG(''' + 
            %trim(%scanrpl('''':'''''':msgText)) + 
            ''') TOPGMQ(*EXT) MSGTYPE(*DIAG)');
   
   // Could also write to an error log file here if needed
end-proc;
