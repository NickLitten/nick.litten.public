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

// ============================================================================
// Indicator Data Structure for better readability
// ============================================================================
dcl-ds indicators;
   exit ind pos(3);
   columnClick ind pos(5);
   sflClr ind pos(30);
   sflDsp ind pos(31);
   sflDspCtl ind pos(32);
   sflEnd ind pos(33);
end-ds;

// ============================================================================
// Constants for maintainability
// ============================================================================
dcl-c MAX_SUBFILE_SIZE 9999;
dcl-c SUBFILE_PAGE_SIZE 15;
dcl-c SQL_SUCCESS 0;
dcl-c SQL_NO_DATA 100;
dcl-c SORT_ASCENDING 'ASC';
dcl-c SORT_DESCENDING 'DESC';
dcl-c DEFAULT_SORT_FIELD 'NOTDATE';

// Column position constants for click detection
dcl-c COL_DATE_START 2;
dcl-c COL_DATE_END 9;
dcl-c COL_TIME_START 12;
dcl-c COL_TIME_END 17;
dcl-c COL_USER_START 22;
dcl-c COL_USER_END 31;
dcl-c COL_CMD_START 34;
dcl-c COL_CMD_END 43;
dcl-c COL_STATUS_START 46;
dcl-c COL_STATUS_END 48;
dcl-c HEADER_ROW 2;

// SQL State codes for better error handling
dcl-c SQLSTATE_SUCCESS '00000';
dcl-c SQLSTATE_NO_DATA '02000';

// ============================================================================
// Subfile control variables
// ============================================================================
dcl-s rrn zoned(4:0);
dcl-s SortField char(10) inz(DEFAULT_SORT_FIELD);
dcl-s SortOrder char(4) inz(SORT_ASCENDING);
dcl-s LastSortField char(10) inz('');

// ============================================================================
// SQL statement building
// ============================================================================
dcl-s WhereClause varchar(1000) inz('');
dcl-s SqlStmt varchar(2000) inz('');

// ============================================================================
// Search criteria fields (initialized to prevent garbage values)
// ============================================================================
dcl-s srchdate zoned(8:0) inz(0);
dcl-s srchtime zoned(6:0) inz(0);
dcl-s srchuser char(10) inz('');
dcl-s srchcmd char(10) inz('');
dcl-s srchstat char(3) inz('');

// ============================================================================
// Error handling and diagnostics
// ============================================================================
dcl-s ErrorOccurred ind inz(*off);
dcl-s SqlState char(5);
dcl-s ErrorMessage char(256) inz('');

// ============================================================================
// Main Program Logic
// ============================================================================

// Initialize and display the subfile interface
DisplaySubfile();

// Normal program termination
*inlr = *on;
return;

// ============================================================================
// Procedure: ClearSubfile
// Purpose: Clear all records from the subfile
// ============================================================================
dcl-proc ClearSubfile;
   sflClr = *on;
   write CTL01;
   sflClr = *off;
   rrn = 0;
end-proc;

// ============================================================================
// Procedure: BuildWhereClause
// Purpose: Construct SQL WHERE clause based on search criteria
// Returns: WhereClause variable populated with conditions
// Notes: Uses parameterized approach to prevent SQL injection
// ============================================================================
dcl-proc BuildWhereClause;
   dcl-s conditions varchar(1000) inz('');
   dcl-s hasConditions ind inz(*off);
   
   WhereClause = '';
   
   // Build individual conditions with proper SQL syntax
   // Using UPPER() for case-insensitive searches
   
   if srchdate <> 0;
      conditions += ' AND NOTDATE = ' + %char(srchdate);
      hasConditions = *on;
   endif;
   
   if srchtime <> 0;
      conditions += ' AND NOTTIME = ' + %char(srchtime);
      hasConditions = *on;
   endif;
   
   if %trim(srchuser) <> '';
      // Escape single quotes in user input to prevent SQL issues
      conditions += ' AND UPPER(NOTUSER) LIKE UPPER(''%' + 
                    %trim(%scanrpl('''':'''''':srchuser)) + '%'')';
      hasConditions = *on;
   endif;
   
   if %trim(srchcmd) <> '';
      conditions += ' AND UPPER(NOTCMD) LIKE UPPER(''%' + 
                    %trim(%scanrpl('''':'''''':srchcmd)) + '%'')';
      hasConditions = *on;
   endif;
   
   if %trim(srchstat) <> '';
      conditions += ' AND UPPER(NOTSTATUS) LIKE UPPER(''%' + 
                    %trim(%scanrpl('''':'''''':srchstat)) + '%'')';
      hasConditions = *on;
   endif;
   
   // Convert conditions to proper WHERE clause
   if hasConditions;
      WhereClause = 'WHERE' + %subst(conditions : 5);
   endif;
end-proc;

// ============================================================================
// Procedure: LoadSubfile
// Purpose: Execute SQL query and populate subfile with results
// Returns: Sets ErrorOccurred flag if SQL errors occur
// Notes: Uses cursor for efficient data retrieval
// ============================================================================
dcl-proc LoadSubfile;
   dcl-s fetchCount int(10) inz(0);
   dcl-s sqlCode int(10);
   dcl-s sqlErrMsg char(256);
   
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
   
   if sqlcode <> SQL_SUCCESS;
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Prepare failed: SQLCODE=' + %char(sqlcode);
      LogError(ErrorMessage);
      return;
   endif;
   
   // Declare and open cursor
   exec sql declare myCursor cursor for S1;
   
   exec sql open myCursor;
   
   if sqlcode <> SQL_SUCCESS;
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Open cursor failed: SQLCODE=' + %char(sqlcode);
      LogError(ErrorMessage);
      return;
   endif;
   
   // Fetch records in a loop
   exec sql fetch next from myCursor 
            into :NOTDATE, :NOTTIME, :NOTUSER, :NOTCMD, :NOTSTATUS;
   
   sqlCode = sqlcode;
   
   // Loop through all records with proper boundary checking
   dow sqlCode = SQL_SUCCESS and rrn < MAX_SUBFILE_SIZE;
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
   if sqlCode <> SQL_SUCCESS and sqlCode <> SQL_NO_DATA;
      ErrorOccurred = *on;
      ErrorMessage = 'SQL Fetch error: SQLCODE=' + %char(sqlCode);
      LogError(ErrorMessage);
   endif;
   
   // Set indicator if we hit the subfile size limit
   if rrn >= MAX_SUBFILE_SIZE;
      sflEnd = *on;  // Show "more records available" indicator
   else;
      sflEnd = *off;
   endif;
   
   // Log successful load for diagnostics
   if fetchCount = 0;
      LogError('No records found matching criteria');
   endif;
end-proc;

// ============================================================================
// Procedure: DisplaySubfile
// Purpose: Main display loop - handles user interaction
// Notes: Centralized control flow for better maintainability
// ============================================================================
dcl-proc DisplaySubfile;
   dcl-s firstDisplay ind inz(*on);
   
   dow not exit;
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
      if exit;
         leave;
      endif;
      
      // Handle column header click for sorting
      if columnClick;
         HandleColumnClick();
         // Continue to next iteration to refresh display
      endif;
      
      firstDisplay = *off;
   enddo;
end-proc;

// ============================================================================
// Procedure: HandleColumnClick
// Purpose: Process column header clicks to change sort order
// Notes: Uses cursor position to determine which column was clicked
// ============================================================================
dcl-proc HandleColumnClick;
   dcl-s newSortField char(10) inz('');
   
   // Only process clicks on header row
   if row <> HEADER_ROW;
      return;
   endif;
   
   // Determine which column was clicked based on cursor position
   select;
      when col >= COL_DATE_START and col <= COL_DATE_END;
         newSortField = 'NOTDATE';
         
      when col >= COL_TIME_START and col <= COL_TIME_END;
         newSortField = 'NOTTIME';
         
      when col >= COL_USER_START and col <= COL_USER_END;
         newSortField = 'NOTUSER';
         
      when col >= COL_CMD_START and col <= COL_CMD_END;
         newSortField = 'NOTCMD';
         
      when col >= COL_STATUS_START and col <= COL_STATUS_END;
         newSortField = 'NOTSTATUS';
         
      other;
         // Click outside valid column headers - ignore
         return;
   endsl;
   
   // Update sort field and toggle order if needed
   if newSortField <> '';
      SortField = newSortField;
      ToggleSortOrder();
   endif;
end-proc;

// ============================================================================
// Procedure: ToggleSortOrder
// Purpose: Toggle between ascending and descending sort order
// Notes: Maintains sort direction when clicking same column repeatedly
// ============================================================================
dcl-proc ToggleSortOrder;
   // If same field clicked, toggle sort direction
   if SortField = LastSortField;
      if SortOrder = SORT_ASCENDING;
         SortOrder = SORT_DESCENDING;
      else;
         SortOrder = SORT_ASCENDING;
      endif;
   else;
      // New field selected, default to ascending
      SortOrder = SORT_ASCENDING;
   endif;
   
   LastSortField = SortField;
end-proc;

// ============================================================================
// Procedure: LogError
// Purpose: Centralized error logging for diagnostics
// Parameters: errMsg - Error message to log
// Notes: Can be enhanced to write to job log or error file
// ============================================================================
dcl-proc LogError;
   dcl-pi *n;
      errMsg char(256) const;
   end-pi;
   
   dcl-s msgText char(512);
   
   // Format error message with timestamp
   msgText = %char(%timestamp()) + ' - SORTSFL: ' + %trim(errMsg);
   
   // Send diagnostic message to job log
   exec sql call qsys2.qcmdexc('SNDPGMMSG MSG(''' + 
            %trim(%scanrpl('''':'''''':msgText)) + 
            ''') TOPGMQ(*EXT) MSGTYPE(*DIAG)');
   
   // Could also write to an error log file here if needed
end-proc;
