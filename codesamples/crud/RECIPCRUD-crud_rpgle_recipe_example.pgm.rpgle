**FREE

// !!!!!!!!!!!!!!!!!!!!!!!!
// !!! WORK IN PROGRESS !!!
// !!!!!!!!!!!!!!!!!!!!!!!!


// SIMPCRUD - Simple CRUD Program for RECIPIE Management
// Page-at-a-time subfile implementation with PageUp/PageDown support
// Demonstrates proper subfile paging with 10 rows per page

ctl-opt dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt);

// FILE DECLARATIONS

dcl-f SIMPCRUD workstn sfile(SFLREC:RRN) indds(Indicators);

// PROGRAM STATUS DATA STRUCTURE (PSDS)

dcl-ds PSDS psds qualified;
  ProgramName char(10) pos(1);      // Program name
  ProcedureName *PROC;              // Current procedure
  StatusCode *STATUS;               // Program status
  User char(10) pos(254);           // Current user
  JobName char(10) pos(244);        // Job name
  JobNumber char(6) pos(264);       // Job number
end-ds;

// INDICATOR DATA STRUCTURE

dcl-ds Indicators;
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

dcl-s RRN          int(5);      // Relative Record Number for subfile
dcl-s Mode         char(10);    // Current operation mode
dcl-s SaveRECID int(10);     // Save RECIPIE ID for updates
dcl-s PageSize     int(5) inz(10); // Records per page
dcl-s TopRRN       int(5) inz(1);  // Top record on current page
dcl-s BotRRN       int(5);         // Bottom record on current page
dcl-s TotalRecs    int(5);         // Total records in database

// MAIN PROGRAM LOGIC - Page-at-a-time processing

exec sql set option commit=*none, closqlcsr=*endmod;
PGMNAME = PSDS.ProgramName;
USERNAME = PSDS.User;

// Get total record count
GetRecordCount();

// Initial load
TopRRN = 1;
LoadPage();

dow not Exit;
  DisplaySubfile();
  
  if not Exit;
    select;
      when PageDown;
        PageDownProc();
      when PageUp;
        PageUpProc();
      when Refresh;
        GetRecordCount();
        LoadPage();
      other;
        ProcessSelections();
    endsl;
  endif;
enddo;

*inlr = *on;
return;

// GETRECORDCOUNT - Get total number of records

dcl-proc GetRecordCount;
  
  exec sql select count(*) into :TotalRecs from RECIPIES;
  
  if sqlcode <> 0;
    TotalRecs = 0;
  endif;
  
end-proc;

// LOADPAGE - Load one page of records into subfile

dcl-proc LoadPage;
  dcl-s RecCount int(5);
  dcl-s SkipRecs int(5);
  
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
  if SkipRecs > 0;
    exec sql fetch relative :SkipRecs from C1
      into :RECID, :RECNAME, :CATEGORY, :PREPTIME;
  endif;
  
  // Load one page of records
  RRN = 0;
  RecCount = 0;
  
  exec sql fetch next from C1
    into :RECID, :RECNAME, :CATEGORY, :PREPTIME;
  
  dow sqlcode = 0 and RecCount < PageSize;
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
  if RRN > 0;
    SflDsp = *on;
  endif;
  
  // Set SFLEND indicator if more records exist
  if BotRRN < TotalRecs;
    SflEnd = *off;
  else;
    SflEnd = *on;
  endif;
  
end-proc;

// PAGEDOWNPROC - Handle PageDown key

dcl-proc PageDownProc;
  
  // Check if more records exist
  if BotRRN < TotalRecs;
    TopRRN = BotRRN + 1;
    LoadPage();
  endif;
  
end-proc;

// PAGEUPPROC - Handle PageUp key

dcl-proc PageUpProc;
  
  // Check if not at beginning
  if TopRRN > 1;
    TopRRN -= PageSize;
    if TopRRN < 1;
      TopRRN = 1;
    endif;
    LoadPage();
  endif;
  
end-proc;

// DISPLAYSUBFILE - Show the subfile screen to user

dcl-proc DisplaySubfile;
  dcl-s CurrentPage int(5);
  dcl-s TotalPages int(5);
  
  // Calculate page information
  if TotalRecs > 0;
    CurrentPage = ((TopRRN - 1) / PageSize) + 1;
    TotalPages = ((TotalRecs - 1) / PageSize) + 1;
  else;
    CurrentPage = 0;
    TotalPages = 0;
  endif;
  
  // Set display fields
  RECCOUNT = TotalRecs;
  PAGENUM = CurrentPage;
  TOTPAGES = TotalPages;
  
  // Display the control record and footer
  SflDspCtl = *on;
  if RRN > 0;
    SflDsp = *on;
  endif;
  
  exfmt SFLCTL;
  write FOOTER;
  
  // Handle position to
  if POSTOID > 0;
    PositionToRecord();
  endif;
  
end-proc;

// POSITIONTORECORD - Position subfile to specific record ID

dcl-proc PositionToRecord;
  dcl-s FoundRRN int(5);
  
  // Find record position in database
  exec sql select count(*) into :FoundRRN
    from RECIPIES
    where RECNAME < (select RECNAME from RECIPIES
                        where RECID = :POSTOID)
    order by RECNAME;
  
  if sqlcode = 0 and FoundRRN >= 0;
    // Calculate which page contains this record
    TopRRN = ((FoundRRN / PageSize) * PageSize) + 1;
    LoadPage();
  endif;
  
  POSTOID = 0;
  
end-proc;

// PROCESSSELECTIONS - Handle user's option selections

dcl-proc ProcessSelections;
  dcl-s CurrentRRN int(5);
  dcl-s NeedReload ind inz(*off);
  
  // Check if user pressed F6 to add new record
  if AddNew;
    AddRecord();
    GetRecordCount();
    LoadPage();
    return;
  endif;
  
  // Process each subfile record for option selections
  CurrentRRN = 0;
  
  dow CurrentRRN < RRN;
    CurrentRRN += 1;
    
    // Read subfile record
    chain CurrentRRN SFLREC;
    
    if %found(SIMPCRUD);
      // Process based on option entered
      select;
        when OPT = '2';  // Change
          ChangeRecord();
          NeedReload = *on;
        when OPT = '4';  // Delete
          DeleteRecord();
          NeedReload = *on;
        when OPT = '5';  // Display
          DisplayRecord();
      endsl;
      
      // Clear the option after processing
      OPT = ' ';
      update SFLREC;
    endif;
  enddo;
  
  // Reload page if changes were made
  if NeedReload;
    GetRecordCount();
    LoadPage();
  endif;
  
end-proc;

// ADDRECORD - Add a new RECIPIE to the database

dcl-proc AddRecord;
  dcl-s Valid ind;
  
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
  
  dow not Exit and not Cancel;
    
    // Display detail screen
    exfmt DETAIL;
    
    if not Exit and not Cancel;
      // Validate input
      Valid = ValidateInput();
      
      if Valid;
        // Insert new record into database
        exec sql insert into RECIPIES 
          (RECNAME, CATEGORY, PREPTIME, SERVINGS, DIFFICULTY)
          values (:DRECNAME, :DCATEGORY, :DPREPTIME, 
                  :DSERVINGS, :DDIFFICULTY);
        
        if sqlcode = 0;
          ERRMSG = 'Record added successfully';
          exfmt DETAIL;
          leave;
        else;
          ERRMSG = 'Error adding record - SQL code: ' + %char(sqlcode);
        endif;
      endif;
    endif;
  enddo;
  
  // Reset indicators
  Exit = *off;
  Cancel = *off;
  
end-proc;

// CHANGERECORD - Update an existing RECIPIE

dcl-proc ChangeRecord;
  dcl-s Valid ind;
  
  Mode = 'CHANGE';
  SaveRECID = RECID;
  
  // Read full record from database
  exec sql select RECID, RECNAME, CATEGORY, PREPTIME, 
                  SERVINGS, DIFFICULTY
    into :DRECID, :DRECNAME, :DCATEGORY, :DPREPTIME,
         :DSERVINGS, :DDIFFICULTY
    from RECIPIES
    where RECID = :SaveRECID;
  
  if sqlcode <> 0;
    return;
  endif;
  
  ERRMSG = '';
  
  // Set field attributes to normal
  NAMEATTR = ' ';
  CATATTR = ' ';
  TIMEATTR = ' ';
  SERVATTR = ' ';
  DIFFATTR = ' ';
  
  dow not Exit and not Cancel;
    
    exfmt DETAIL;
    
    if not Exit and not Cancel;
      Valid = ValidateInput();
      
      if Valid;
        // Update database record
        exec sql update RECIPIES set
          RECNAME = :DRECNAME,
          CATEGORY = :DCATEGORY,
          PREPTIME = :DPREPTIME,
          SERVINGS = :DSERVINGS,
          DIFFICULTY = :DDIFFICULTY
          where RECID = :SaveRECID;
        
        if sqlcode = 0;
          ERRMSG = 'Record updated successfully';
          exfmt DETAIL;
          leave;
        else;
          ERRMSG = 'Error updating record - SQL code: ' + %char(sqlcode);
        endif;
      endif;
    endif;
  enddo;
  
  Exit = *off;
  Cancel = *off;
  
end-proc;

// DELETERECORD - Delete a RECIPIE from the database

dcl-proc DeleteRecord;
  
  SaveRECID = RECID;
  
  // Read record to display before deleting
  exec sql select RECID, RECNAME, CATEGORY, PREPTIME,
                  SERVINGS, DIFFICULTY
    into :DRECID, :DRECNAME, :DCATEGORY, :DPREPTIME,
         :DSERVINGS, :DDIFFICULTY
    from RECIPIES
    where RECID = :SaveRECID;
  
  if sqlcode <> 0;
    return;
  endif;
  
  // Protect all fields (display only)
  NAMEATTR = 'PR';
  CATATTR = 'PR';
  TIMEATTR = 'PR';
  SERVATTR = 'PR';
  DIFFATTR = 'PR';
  
  ERRMSG = 'Press Enter to confirm delete, F12 to cancel';
  
  exfmt DETAIL;
  
  if not Cancel and not Exit;
    // Delete the record
    exec sql delete from RECIPIES where RECID = :SaveRECID;
    
    if sqlcode = 0;
      ERRMSG = 'Record deleted successfully';
    else;
      ERRMSG = 'Error deleting record - SQL code: ' + %char(sqlcode);
    endif;
    
    exfmt DETAIL;
  endif;
  
  Exit = *off;
  Cancel = *off;
  
end-proc;

// DISPLAYRECORD - Display RECIPIE details (read-only)

dcl-proc DisplayRecord;
  
  SaveRECID = RECID;
  
  // Read full record
  exec sql select RECID, RECNAME, CATEGORY, PREPTIME,
                  SERVINGS, DIFFICULTY
    into :DRECID, :DRECNAME, :DCATEGORY, :DPREPTIME,
         :DSERVINGS, :DDIFFICULTY
    from RECIPIES
    where RECID = :SaveRECID;
  
  if sqlcode <> 0;
    return;
  endif;
  
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

dcl-proc ValidateInput;
  dcl-s IsValid ind inz(*on);
  
  ERRMSG = '';
  
  // Reset all field attributes
  NAMEATTR = ' ';
  CATATTR = ' ';
  TIMEATTR = ' ';
  SERVATTR = ' ';
  DIFFATTR = ' ';
  
  // Validate RECIPIE name
  if DRECNAME = '';
    ERRMSG = 'RECIPIE name is required';
    NAMEATTR = 'RI';  // Reverse image
    IsValid = *off;
  endif;
  
  // Validate category
  if DCATEGORY = '';
    ERRMSG = 'Category is required';
    CATATTR = 'RI';
    IsValid = *off;
  endif;
  
  // Validate prep time
  if DPREPTIME <= 0;
    ERRMSG = 'Prep time must be greater than 0';
    TIMEATTR = 'RI';
    IsValid = *off;
  endif;
  
  // Validate servings
  if DSERVINGS <= 0;
    ERRMSG = 'Servings must be greater than 0';
    SERVATTR = 'RI';
    IsValid = *off;
  endif;
  
  // Validate difficulty
  if DDIFFICULTY = '';
    ERRMSG = 'Difficulty is required';
    DIFFATTR = 'RI';
    IsValid = *off;
  endif;
  
  return IsValid;
  
end-proc;