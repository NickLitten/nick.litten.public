**free

/// Program: RECIPCRUD - Recipe CRUD Example (WORK IN PROGRESS)
///
/// Description: Simple CRUD (Create, Read, Update, Delete) program for recipe
///              management demonstrating page-at-a-time subfile implementation
///              with proper PageUp/PageDown support. Loads and displays 10
///              recipes per page with efficient database access and user-
///              friendly navigation controls.
///
/// Purpose: Educational example demonstrating:
///   - Page-at-a-time subfile loading technique
///   - Efficient database pagination with SQL
///   - PageUp/PageDown navigation handling
///   - Record count tracking for paging logic
///   - Subfile indicator management
///   - Function key processing (F3, F5, F6, F12)
///   - Option-based record selection
///
/// Features:
///   - Displays 10 recipes per page in subfile
///   - PageDown to view next page of recipes
///   - PageUp to view previous page of recipes
///   - F5=Refresh to reload current page
///   - F6=Add New to create new recipe
///   - Option 2=Change, 4=Delete, 5=Display
///   - Tracks total record count for navigation
///   - Maintains current page position
///   - Automatic subfile clearing and reloading
///
/// Usage: CALL RECIPCRUD
///        (Interactive - displays recipe management subfile)
///
/// Parameters: None
///
/// SQL Usage:
///   - SELECT COUNT(*) for total record count
///   - SELECT with OFFSET/FETCH for page-at-a-time loading
///   - INSERT for new recipe creation
///   - UPDATE for recipe modifications
///   - DELETE for recipe removal
///
/// Dependencies:
///   - Display file: SIMPCRUD (subfile display)
///   - Table: RECIPIES (recipe data storage)
///   - Record format: SFLREC (subfile record)
///
/// Control Options:
///   - dftactgrp(*no): Required for modern RPG features
///   - actgrp(*new): Creates new activation group per call
///   - option(*nodebugio): Disables debug I/O
///   - option(*srcstmt): Includes source statements in debug
///
/// Note: This program is currently under development. Some features may be
///       incomplete or subject to change.
///
/// Modification History:
/// 1.0 20xx-xx-xx | Nick Litten | Initial creation
/// 1.1 2026-04-02 | Nick Litten | Added comprehensive triple-slash documentation

ctl-opt dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt);

// FILE DECLARATIONS

dcl-f SIMPCRUD workstn sfile(SFLREC:RRN) indds(Indicators);

// PROGRAM STATUS DATA STRUCTURE (PSDS)

Dcl-Ds PSDS psds qualified;
   ProgramName char(10) pos(1);      // Program name
   ProcedureName *PROC;              // Current procedure
   StatusCode *STATUS;               // Program status
   User char(10) pos(254);           // Current user
   JobName char(10) pos(244);        // Job name
   JobNumber char(6) pos(264);       // Job number
end-ds;

// INDICATOR DATA STRUCTURE

Dcl-Ds Indicators;
   Exit           ind pos(03);  // F3=Exit
   Refresh        ind pos(05);  // F5=Refresh
   AddNew         ind pos(06);  // F6=Add New
   Cancel         ind pos(12);  // F12=Cancel
   PageDown       ind pos(25);  // PageDown pressed
   PageUp         ind pos(26);  // PageUp pressed
   SflDsp         ind pos(31);  // Display subfile
   SflDspCtl      ind pos(32);  // Display subfile control
   SflClr         ind pos(33);  // Clear subfile
   SflEnd         ind pos(34);  // More records indicator
   ProtectField   ind pos(41);  // Protect option field
end-ds;

// GLOBAL VARIABLES

Dcl-S RRN          int(5);      // Relative Record Number for subfile
Dcl-S Mode         char(10);    // Current operation mode
Dcl-S SaveRECID int(10);     // Save RECIPIE ID for updates
Dcl-S PageSize     int(5) inz(10); // Records per page
Dcl-S TopRRN       int(5) inz(1);  // Top record on current page
Dcl-S BotRRN       int(5);         // Bottom record on current page
Dcl-S TotalRecs    int(5);         // Total records in database

// MAIN PROGRAM LOGIC - Page-at-a-time processing

exec sql set option commit=*none, closqlcsr=*endmod;
PGMNAME = PSDS.ProgramName;
USERNAME = PSDS.User;

// Get total record count
GetRecordCount();

// Initial load
TopRRN = 1;
LoadPage();

dow (not Exit);
   DisplaySubfile();
  
   If (not Exit);
      Select;
         When (PageDown);
            PageDownProc();
         When (PageUp);
            PageUpProc();
         When (Refresh);
            GetRecordCount();
            LoadPage();
         Other;
            ProcessSelections();
      EndSl;
   EndIf;
enddo;

*inlr = *on;
Return;

// GETRECORDCOUNT - Get total number of records

Dcl-Proc GetRecordCount;
  
   exec sql select count(*) into :TotalRecs from RECIPIES;
  
   If (sqlcode <> 0);
      TotalRecs = 0;
   EndIf;
  
end-proc;

// LOADPAGE - Load one page of records into subfile

Dcl-Proc LoadPage;
   Dcl-S RecCount int(5);
   Dcl-S SkipRecs int(5);
  
   // Clear the subfile
   SflClr = *on;
   SflDsp = *off;
   SflDspCtl = *on;
   write SFLCTL;
   SflClr = *off;
  
   // Calculate records to skip
   SkipRecs = TopRRN - 1;
  
   // Declare cursor with offset for paging
   exec sql declare C1 scroll cursor for
    select RECID, RECNAME, CATEGORY, PREPTIME
    from RECIPIES
    order by RECNAME;
  
   exec sql open C1;
  
   // Position cursor to starting record
   If (SkipRecs > 0);
      exec sql fetch relative :SkipRecs from C1
      into :RECID, :RECNAME, :CATEGORY, :PREPTIME;
   EndIf;
  
   // Load one page of records
   RRN = 0;
   RecCount = 0;
  
   exec sql fetch next from C1
    into :RECID, :RECNAME, :CATEGORY, :PREPTIME;
  
   dow (sqlcode = 0 and RecCount < PageSize);
      RRN += 1;
      RecCount += 1;
      OPT = ' ';
    
      write SFLREC;
    
      exec sql fetch next from C1
      into :RECID, :RECNAME, :CATEGORY, :PREPTIME;
   enddo;
  
   exec sql close C1;
  
   // Calculate bottom RRN
   BotRRN = TopRRN + RRN - 1;
  
   // Set display indicators
   If (RRN > 0);
      SflDsp = *on;
   EndIf;
  
   // Set SFLEND indicator if more records exist
   If (BotRRN < TotalRecs);
      SflEnd = *off;
   Else;
      SflEnd = *on;
   EndIf;
  
end-proc;

// PAGEDOWNPROC - Handle PageDown key

Dcl-Proc PageDownProc;
  
   // Check if more records exist
   If (BotRRN < TotalRecs);
      TopRRN = BotRRN + 1;
      LoadPage();
   EndIf;
  
end-proc;

// PAGEUPPROC - Handle PageUp key

Dcl-Proc PageUpProc;
  
   // Check if not at beginning
   If (TopRRN > 1);
      TopRRN -= PageSize;
      If (TopRRN < 1);
         TopRRN = 1;
      EndIf;
      LoadPage();
   EndIf;
  
end-proc;

// DISPLAYSUBFILE - Show the subfile screen to user

Dcl-Proc DisplaySubfile;
   Dcl-S CurrentPage int(5);
   Dcl-S TotalPages int(5);
  
   // Calculate page information
   If (TotalRecs > 0);
      CurrentPage = ((TopRRN - 1) / PageSize) + 1;
      TotalPages = ((TotalRecs - 1) / PageSize) + 1;
   Else;
      CurrentPage = 0;
      TotalPages = 0;
   EndIf;
  
   // Set display fields
   RECCOUNT = TotalRecs;
   PAGENUM = CurrentPage;
   TOTPAGES = TotalPages;
  
   // Display the control record and footer
   SflDspCtl = *on;
   If (RRN > 0);
      SflDsp = *on;
   EndIf;
  
   exfmt SFLCTL;
   write FOOTER;
  
   // Handle position to
   If (POSTOID > 0);
      PositionToRecord();
   EndIf;
  
end-proc;

// POSITIONTORECORD - Position subfile to specific record ID

Dcl-Proc PositionToRecord;
   Dcl-S FoundRRN int(5);
  
   // Find record position in database
   exec sql select count(*) into :FoundRRN
    from RECIPIES
    where RECNAME < (select RECNAME from RECIPIES
                        where RECID = :POSTOID)
    order by RECNAME;
  
   If (sqlcode = 0 and FoundRRN >= 0);
      // Calculate which page contains this record
      TopRRN = ((FoundRRN / PageSize) * PageSize) + 1;
      LoadPage();
   EndIf;
  
   POSTOID = 0;
  
end-proc;

// PROCESSSELECTIONS - Handle user's option selections

Dcl-Proc ProcessSelections;
   Dcl-S CurrentRRN int(5);
   Dcl-S NeedReload ind inz(*off);
  
   // Check if user pressed F6 to add new record
   If (AddNew);
      AddRecord();
      GetRecordCount();
      LoadPage();
      Return;
   EndIf;
  
   // Process each subfile record for option selections
   CurrentRRN = 0;
  
   dow (CurrentRRN < RRN);
      CurrentRRN += 1;
    
      // Read subfile record
      chain CurrentRRN SFLREC;
    
      If (%found(SIMPCRUD));
         // Process based on option entered
         Select;
            When (OPT = '2');  // Change
               ChangeRecord();
               NeedReload = *on;
            When (OPT = '4');  // Delete
               DeleteRecord();
               NeedReload = *on;
            When (OPT = '5');  // Display
               DisplayRecord();
         EndSl;
      
         // Clear the option after processing
         OPT = ' ';
         update SFLREC;
      EndIf;
   enddo;
  
   // Reload page if changes were made
   If (NeedReload);
      GetRecordCount();
      LoadPage();
   EndIf;
  
end-proc;

// ADDRECORD - Add a new RECIPIE to the database

Dcl-Proc AddRecord;
   Dcl-S Valid ind;
  
   Mode = 'ADD';
  
   // Clear detail screen fields
   DRECID = 0;
   DRECNAME = '';
   DCATEGORY = '';
   DPREPTIME = 0;
   DSERVINGS = 0;
   DDIFFICULTY = '';
   ERRMSG = '';
  
   // Set field attributes to normal (not protected)
   NAMEATTR = ' ';
   CATATTR = ' ';
   TIMEATTR = ' ';
   SERVATTR = ' ';
   DIFFATTR = ' ';
  
   dow (not Exit and not Cancel);
    
      // Display detail screen
      exfmt DETAIL;
    
      If (not Exit and not Cancel);
         // Validate input
         Valid = ValidateInput();
      
         If (Valid);
            // Insert new record into database
            exec sql insert into RECIPIES 
          (RECNAME, CATEGORY, PREPTIME, SERVINGS, DIFFICULTY)
          values (:DRECNAME, :DCATEGORY, :DPREPTIME, 
                  :DSERVINGS, :DDIFFICULTY);
        
            If (sqlcode = 0);
               ERRMSG = 'Record added successfully';
               exfmt DETAIL;
               leave;
            Else;
               ERRMSG = 'Error adding record - SQL code: ' + %char(sqlcode);
            EndIf;
         EndIf;
      EndIf;
   enddo;
  
   // Reset indicators
   Exit = *off;
   Cancel = *off;
  
end-proc;

// CHANGERECORD - Update an existing RECIPIE

Dcl-Proc ChangeRecord;
   Dcl-S Valid ind;
  
   Mode = 'CHANGE';
   SaveRECID = RECID;
  
   // Read full record from database
   exec sql select RECID, RECNAME, CATEGORY, PREPTIME, 
                  SERVINGS, DIFFICULTY
    into :DRECID, :DRECNAME, :DCATEGORY, :DPREPTIME,
         :DSERVINGS, :DDIFFICULTY
    from RECIPIES
    where RECID = :SaveRECID;
  
   If (sqlcode <> 0);
      Return;
   EndIf;
  
   ERRMSG = '';
  
   // Set field attributes to normal
   NAMEATTR = ' ';
   CATATTR = ' ';
   TIMEATTR = ' ';
   SERVATTR = ' ';
   DIFFATTR = ' ';
  
   dow (not Exit and not Cancel);
    
      exfmt DETAIL;
    
      If (not Exit and not Cancel);
         Valid = ValidateInput();
      
         If (Valid);
            // Update database record
            exec sql update RECIPIES set
          RECNAME = :DRECNAME,
          CATEGORY = :DCATEGORY,
          PREPTIME = :DPREPTIME,
          SERVINGS = :DSERVINGS,
          DIFFICULTY = :DDIFFICULTY
          where RECID = :SaveRECID;
        
            If (sqlcode = 0);
               ERRMSG = 'Record updated successfully';
               exfmt DETAIL;
               leave;
            Else;
               ERRMSG = 'Error updating record - SQL code: ' + %char(sqlcode);
            EndIf;
         EndIf;
      EndIf;
   enddo;
  
   Exit = *off;
   Cancel = *off;
  
end-proc;

// DELETERECORD - Delete a RECIPIE from the database

Dcl-Proc DeleteRecord;
  
   SaveRECID = RECID;
  
   // Read record to display before deleting
   exec sql select RECID, RECNAME, CATEGORY, PREPTIME,
                  SERVINGS, DIFFICULTY
    into :DRECID, :DRECNAME, :DCATEGORY, :DPREPTIME,
         :DSERVINGS, :DDIFFICULTY
    from RECIPIES
    where RECID = :SaveRECID;
  
   If (sqlcode <> 0);
      Return;
   EndIf;
  
   // Protect all fields (display only)
   NAMEATTR = 'PR';
   CATATTR = 'PR';
   TIMEATTR = 'PR';
   SERVATTR = 'PR';
   DIFFATTR = 'PR';
  
   ERRMSG = 'Press Enter to confirm delete, F12 to cancel';
  
   exfmt DETAIL;
  
   If (not Cancel and not Exit);
      // Delete the record
      exec sql delete from RECIPIES where RECID = :SaveRECID;
    
      If (sqlcode = 0);
         ERRMSG = 'Record deleted successfully';
      Else;
         ERRMSG = 'Error deleting record - SQL code: ' + %char(sqlcode);
      EndIf;
    
      exfmt DETAIL;
   EndIf;
  
   Exit = *off;
   Cancel = *off;
  
end-proc;

// DISPLAYRECORD - Display RECIPIE details (read-only)

Dcl-Proc DisplayRecord;
  
   SaveRECID = RECID;
  
   // Read full record
   exec sql select RECID, RECNAME, CATEGORY, PREPTIME,
                  SERVINGS, DIFFICULTY
    into :DRECID, :DRECNAME, :DCATEGORY, :DPREPTIME,
         :DSERVINGS, :DDIFFICULTY
    from RECIPIES
    where RECID = :SaveRECID;
  
   If (sqlcode <> 0);
      Return;
   EndIf;
  
   // Protect all fields (display only)
   NAMEATTR = 'PR';
   CATATTR = 'PR';
   TIMEATTR = 'PR';
   SERVATTR = 'PR';
   DIFFATTR = 'PR';
  
   ERRMSG = 'Display only - Press Enter or F12 to return';
  
   exfmt DETAIL;
  
   Exit = *off;
   Cancel = *off;
  
end-proc;

// VALIDATEINPUT - Validate user input on detail screen

Dcl-Proc ValidateInput;
   Dcl-S IsValid ind inz(*on);
  
   ERRMSG = '';
  
   // Reset all field attributes
   NAMEATTR = ' ';
   CATATTR = ' ';
   TIMEATTR = ' ';
   SERVATTR = ' ';
   DIFFATTR = ' ';
  
   // Validate RECIPIE name
   If (DRECNAME = '');
      ERRMSG = 'RECIPIE name is required';
      NAMEATTR = 'RI';  // Reverse image
      IsValid = *off;
   EndIf;
  
   // Validate category
   If (DCATEGORY = '');
      ERRMSG = 'Category is required';
      CATATTR = 'RI';
      IsValid = *off;
   EndIf;
  
   // Validate prep time
   If (DPREPTIME <= 0);
      ERRMSG = 'Prep time must be greater than 0';
      TIMEATTR = 'RI';
      IsValid = *off;
   EndIf;
  
   // Validate servings
   If (DSERVINGS <= 0);
      ERRMSG = 'Servings must be greater than 0';
      SERVATTR = 'RI';
      IsValid = *off;
   EndIf;
  
   // Validate difficulty
   If (DDIFFICULTY = '');
      ERRMSG = 'Difficulty is required';
      DIFFATTR = 'RI';
      IsValid = *off;
   EndIf;
  
   Return IsValid;
  
end-proc;
