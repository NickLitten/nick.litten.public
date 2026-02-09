**free

//
// CRUD01RPG - Task Administrator with Subfile
// This program demonstrates CRUD operations using modern RPGLE practices
//
// MODIFICATION HISTORY:
// 2019.06.25 Nick Litten V1.0 Created
// 2026.02.03 IBM Bob     V2.0 Modernized and improved
//

ctl-opt main(mainline) 
        copyright('| CRUD01RPG V2.0 - Improved') 
        option(*nodebugio:*srcstmt)
        dftactgrp(*no) 
        actgrp(*new);

dcl-f CRUD01PNL workstn sfile(SFLTASK:subfileRRN) usropn infds(infds);

/include 'information_data_structures.rpgleinc'

// ============================================================================
// NAMED CONSTANTS - Replace magic values for better readability
// ============================================================================

// Screen operation modes
Dcl-C MODE_INSERT    'I';
Dcl-C MODE_MODIFY    'M';
Dcl-C MODE_DELETE    'D';
Dcl-C MODE_VIEW      'V';
Dcl-C MODE_SUBFILE   'S';

// Window types
Dcl-C WDW_CONFIRM    'C';
Dcl-C WDW_MESSAGE    'M';
Dcl-C WDW_DELETE     'D';
Dcl-C WDW_ERROR      'E';

// Subfile options
Dcl-C OPT_MODIFY     '2';
Dcl-C OPT_DELETE     '4';
Dcl-C OPT_VIEW       '5';

// SQL State constants
Dcl-C SUCCESS_ON_SQL '00';
Dcl-C WARNING_ON_SQL '01';
Dcl-C NODATA_ON_SQL  '02';

// Subfile configuration
Dcl-C PERPAGE        10;
Dcl-C MAX_RRN        9999;

// ============================================================================
// DISPLAY FILE INDICATORS - Using based data structure for clarity
// ============================================================================

Dcl-S ptrDisplayIndicators Pointer Inz(%Addr(*In));
Dcl-Ds DisplayIndicators Based(ptrDisplayIndicators);
  // Subfile control indicators
  SflDsp          Ind Pos(99);
  SflDspCtl       Ind Pos(98);
  SflClr          Ind Pos(97);
  SflEnd          Ind Pos(96);
  
  // Validation error indicators
  TaskIdExistsError    Ind Pos(31);
  StartDateError       Ind Pos(32);
  EndDateError         Ind Pos(33);
  DateRangeError       Ind Pos(34);
  ProtectFields_35     Ind Pos(35);
  ProtectFields_36     Ind Pos(36);
  
  // Error indicator overlay for bulk operations
  IndErrors char(20) Pos(31);
end-ds;

// ============================================================================
// SQL ERROR HANDLING - Improved access to SQLSTATE
// ============================================================================

Dcl-S pSqlstate Pointer Inz(%Addr(SQLState));
Dcl-Ds Ds_SqlState based(pSqlstate);
  xSqlstate char(2);
end-ds;

// ============================================================================
// DATA STRUCTURES
// ============================================================================

// Task data for subfile population
Dcl-Ds t_taskData qualified template;
  taskId     int(10);
  name       char(20);
  startDate  date;
  endDate    date;
  state      int(3);
end-ds;



// Main task record - externally described
Dcl-Ds taskRecord extname('CRUD01TBL') qualified end-ds;

// ============================================================================
// GLOBAL VARIABLES
// ============================================================================

// Subfile management
Dcl-S subfileRRN      int(5);
Dcl-S initialPos      int(10) inz(0);
Dcl-S finalPos        int(10) inz(10);
Dcl-S prevInitialPos  int(10);
Dcl-S prevFinalPos    int(10);

// Task data for cursor operations
Dcl-Ds taskData likeds(t_taskData);

// Query filtering
Dcl-S whereClause     varchar(500) inz('');

// Operation control
Dcl-S crudFinalized   ind;
Dcl-S currentUser     char(10) inz(*user);

// ============================================================================
// MAIN PROCEDURE
// ============================================================================

Dcl-Proc mainline;
  Dcl-S screenMode char(1);
  
  monitor;
    open CRUD01PNL;
    
    screenMode = MODE_SUBFILE;
    ShowScreen(screenMode);
    
    close CRUD01PNL;
    *Inlr = *On;
    
  on-error;
    // Handle any unexpected errors
    If %open(CRUD01PNL);
      close CRUD01PNL;
    EndIf;
    *Inlr = *On;
  endmon;
end-proc;

// ============================================================================
// SCREEN MANAGEMENT PROCEDURES
// ============================================================================
// WriteScreen - Set screen titles and footer based on mode
Dcl-Proc WriteScreen;
  Dcl-Pi *N;
    mode char(1) const;
  end-pi;
  
  // Set secondary titles
  TITLE2 = centerText('Task Management System' : %len(TITLE2));
  TITLE3 = centerText('Version 2.0' : %len(TITLE3));
  
  // Set primary title based on mode
  Select;
    When mode = MODE_INSERT;
      TITLE1 = centerText('TASKS ADMINISTRATOR - INSERT' : %len(TITLE1));
      FOOTTEXT = 'F3=Exit  F10=Confirm';
      
    When mode = MODE_MODIFY;
      TITLE1 = centerText('TASKS ADMINISTRATOR - MODIFY' : %len(TITLE1));
      FOOTTEXT = 'F3=Exit  F10=Confirm';
      
    When mode = MODE_DELETE;
      TITLE1 = centerText('TASKS ADMINISTRATOR - DELETE' : %len(TITLE1));
      FOOTTEXT = 'F3=Exit  F10=Confirm';
      
    When mode = MODE_VIEW;
      TITLE1 = centerText('TASKS ADMINISTRATOR - VIEW' : %len(TITLE1));
      FOOTTEXT = 'F3=Exit';
      
    When mode = MODE_SUBFILE;
      TITLE1 = centerText('TASKS ADMINISTRATOR - MAIN MENU' : %len(TITLE1));
      FOOTTEXT = 'F3=Exit  F5=Refresh  F6=Create';
  EndSl;
  
  write HEADER;
  write FOOTER;
end-proc;





// ShowScreen - Route to appropriate screen based on mode
Dcl-Proc ShowScreen;
  Dcl-Pi *N;
    mode char(1) const;
  end-pi;
  
  Select;
    When mode = MODE_INSERT;
      InsertScreen(mode);
    When mode = MODE_SUBFILE;
      ShowSubfile(mode);
    When mode = MODE_MODIFY;
      ModifyScreen(mode);
    When mode = MODE_DELETE;
      DeleteScreen(mode);
    When mode = MODE_VIEW;
      ViewScreen(mode);
  EndSl;
end-proc;





// ShowWindow - Display confirmation or message windows
Dcl-Proc ShowWindow;
  Dcl-Pi *N;
    windowType char(1) const;
  end-pi;
  
  Select;
    When windowType = WDW_CONFIRM;
      WDWTEXT1 = 'Are you sure you want to proceed?';
      WDWTEXT2 = 'Please type Y/N';
      write WDWCONFIRM;
      exfmt WDWCONFIRM;
      
    When windowType = WDW_MESSAGE;
      WDWMSG1 = 'Record saved successfully';
      exfmt WDWMESSAGE;
      
    When windowType = WDW_DELETE;
      WDWMSG1 = 'Record deleted successfully';
      exfmt WDWMESSAGE;
      
    When windowType = WDW_ERROR;
      WDWMSG1 = 'Error executing operation';
      exfmt WDWMESSAGE;
  EndSl;
end-proc;

// ============================================================================
// UTILITY PROCEDURES
// ============================================================================
// centerText - Center text within specified length
Dcl-Proc centerText;
  Dcl-Pi *N char(80);
    text char(80) const;
    length int(5) const;
  end-pi;
  
  Dcl-S blanksNeeded int(5);
  Dcl-S startPos int(5);
  Dcl-S centered char(80) inz(*blanks);
  Dcl-S textLen int(5);
  
  textLen = %len(%trim(text));
  
  // Ensure we don't exceed the target length
  If textLen >= length;
    Return %subst(text : 1 : length);
  EndIf;
  
  blanksNeeded = length - textLen;
  startPos = (blanksNeeded / 2) + 1;
  
  If startPos > 0;
    %subst(centered : startPos) = %trim(text);
  Else;
    centered = text;
  EndIf;
  
  Return centered;
end-proc;





// resetErrors - Clear all validation error indicators
Dcl-Proc resetErrors;
  TaskIdExistsError = *off;
  StartDateError = *off;
  EndDateError = *off;
  DateRangeError = *off;
end-proc;





// handleSqlError - Centralized SQL error handling
Dcl-Proc handleSqlError;
  Dcl-Pi *N ind;
    operation varchar(50) const;
  end-pi;
  
  If xSqlstate <> SUCCESS_ON_SQL;
    WDWMSG1 = 'SQL Error: ' + %trim(operation);
    WDWMSG2 = 'SQLSTATE: ' + SQLSTATE + ' Code: ' + %char(SQLCODE);
    exfmt WDWMESSAGE;
    Return *on;
  EndIf;
  
  Return *off;
end-proc;

// ============================================================================
// SUBFILE MANAGEMENT PROCEDURES
// ============================================================================
// ShowSubfile - Main subfile display loop
Dcl-Proc ShowSubfile;
  Dcl-Pi *N;
    mode char(1) const;
  end-pi;
  
  Dcl-S nextMode char(1);
  
  dow not pfkey(03);
    WriteScreen(mode);
    ActivateSubfile();
    exfmt SFLTASKCTL;
    
    Select;
      When pfkey(03);
        pfkey(03) = *off;
        initialPos = 0;
        finalPos = PERPAGE;
        leave;
        
      When infds.funcKey = PAGEUP;
        handlePageUp(mode);
        
      When infds.funcKey = PAGEDOWN;
        handlePageDown(mode);
        
      When pfkey(05);
        initialPos = 0;
        finalPos = PERPAGE;
        iter;
        
      When pfkey(06);
        nextMode = MODE_INSERT;
        ShowScreen(nextMode);
        leave;
        
      Other;
        processSubfileOptions(nextMode);
        If nextMode <> *blanks;
          ShowScreen(nextMode);
          leave;
        EndIf;
    EndSl;
    
    If crudFinalized;
      crudFinalized = *off;
      leave;
    EndIf;
  enddo;
end-proc;





// handlePageUp - Process page up request
Dcl-Proc handlePageUp;
  Dcl-Pi *N;
    mode char(1) const;
  end-pi;
  
  If initialPos = 0 and finalPos = PERPAGE;
    // Already at first page
    Return;
  EndIf;
  
  If initialPos > 1;
    initialPos -= (PERPAGE + 1);
    finalPos -= PERPAGE;
    ShowScreen(mode);
  EndIf;
end-proc;





// handlePageDown - Process page down request
Dcl-Proc handlePageDown;
  Dcl-Pi *N;
    mode char(1) const;
  end-pi;
  
  Dcl-S recordExists ind;
  
  If initialPos > 0 and finalPos > PERPAGE;
    recordExists = checkRecordsExist(initialPos : finalPos);
    
    If not recordExists;
      initialPos -= (PERPAGE + 1);
      finalPos -= PERPAGE;
    EndIf;
    
    ShowScreen(mode);
  Else;
    ShowScreen(mode);
  EndIf;
end-proc;





// checkRecordsExist - Verify records exist in range
Dcl-Proc checkRecordsExist;
  Dcl-Pi *N ind;
    startPos int(10) const;
    endPos int(10) const;
  end-pi;
  
  Dcl-S recordCount int(10);
  
  exec sql
    SELECT COUNT(*) INTO :recordCount
    FROM CRUD01TBL;
  
  // Check if the requested range is within available records
  Return (recordCount >= startPos);
end-proc;





// processSubfileOptions - Handle user selections in subfile
Dcl-Proc processSubfileOptions;
  Dcl-Pi *N;
    nextMode char(1);
  end-pi;
  
  Dcl-S rrn int(5);
  
  nextMode = *blanks;
  
  If subfileRRN = 0;
    Return;
  EndIf;
  
  For rrn = 1 to PERPAGE;
    chain rrn SFLTASK;
    
    If not %found();
      leave;
    EndIf;
    
    If OPCTASK = *blanks;
      iter;
    EndIf;
    
    // Load task data
    If not loadTaskById(SFLTASKID);
      OPCTASK = *blanks;
      update SFLTASK;
      iter;
    EndIf;
    
    // Determine next screen based on option
    Select;
      When OPCTASK = OPT_MODIFY;
        nextMode = MODE_MODIFY;
      When OPCTASK = OPT_DELETE;
        nextMode = MODE_DELETE;
      When OPCTASK = OPT_VIEW;
        nextMode = MODE_VIEW;
    EndSl;
    
    OPCTASK = *blanks;
    update SFLTASK;
    leave;
  EndFor;
end-proc;





// loadTaskById - Load task record by ID
Dcl-Proc loadTaskById;
  Dcl-Pi *N ind;
    taskId int(10) const;
  end-pi;
  
  clear taskRecord;
  
  exec sql
    SELECT * INTO :taskRecord
    FROM CRUD01TBL
    WHERE TASK_ID = :taskId;
  
  Return (xSqlstate = SUCCESS_ON_SQL);
end-proc;





// SflInitial - Initialize subfile for loading
Dcl-Proc SflInitial;
  SflEnd = *off;
  SflClr = *on;
  write SFLTASKCTL;
  SflClr = *off;
  subfileRRN = 0;
  SflDsp = *off;
  SflDspCtl = *off;
end-proc;





// ActivateSubfile - Prepare and display subfile
Dcl-Proc ActivateSubfile;
  Dcl-S totalRecords int(10);
  
  SflInitial();
  FillSubfile();
  
  totalRecords = getTotalRecords();
  // Set end indicator based on whether we've loaded all records
  SflEnd = (initialPos + subfileRRN >= totalRecords);
  
  If subfileRRN > 0;
    SflDsp = *on;
  Else;
    write EMPTY;
  EndIf;
  
  SflDspCtl = *on;
end-proc;





// FillSubfile - Load subfile with data using cursor
Dcl-Proc FillSubfile;
  Dcl-S count int(5) inz(0);
  
  prevInitialPos = initialPos;
  prevFinalPos = finalPos;
  
  clear taskData;
  
  exec sql
    DECLARE TASK_CURSOR CURSOR FOR
    SELECT TASK_ID, NAME, STARTDATE, ENDDATE, STATE
    FROM CRUD01TBL
    ORDER BY TASK_ID
    OFFSET :initialPos ROWS
    FETCH FIRST :PERPAGE ROWS ONLY;
  
  exec sql OPEN TASK_CURSOR;
  
  If xSqlstate <> SUCCESS_ON_SQL;
    Return;
  EndIf;
  
  exec sql FETCH TASK_CURSOR INTO :taskData.taskId, :taskData.name,
                                   :taskData.startDate, :taskData.endDate,
                                   :taskData.state;
  
  dow (xSqlstate = SUCCESS_ON_SQL) and (count < PERPAGE);
    count += 1;
    addToSubfile();
    exec sql FETCH TASK_CURSOR INTO :taskData.taskId, :taskData.name,
                                     :taskData.startDate, :taskData.endDate,
                                     :taskData.state;
  enddo;
  
  exec sql CLOSE TASK_CURSOR;
  
  // Update position for next page
  If count = PERPAGE;
    initialPos += count + 1;
    finalPos += count;
  EndIf;
end-proc;





// addToSubfile - Add current record to subfile
Dcl-Proc addToSubfile;
  subfileRRN += 1;
  SFLTASKID = taskData.taskId;
  SFLTASKNAM = taskData.name;
  SFLSTRDATE = %dec(taskData.startDate);
  SFLENDDATE = %dec(taskData.endDate);
  SFLSTATE = taskData.state;
  write SFLTASK;
  clear SFLTASK;
end-proc;





// getTotalRecords - Get count of all records
Dcl-Proc getTotalRecords;
  Dcl-Pi *N int(10);
  end-pi;
  
  Dcl-S total int(10);
  
  exec sql
    SELECT COUNT(*) INTO :total
    FROM CRUD01TBL;
  
  If xSqlstate <> SUCCESS_ON_SQL;
    total = 0;
  EndIf;
  
  Return total;
end-proc;

// ============================================================================
// VALIDATION PROCEDURES
// ============================================================================
// validateScreen - Validate input based on mode
Dcl-Proc validateScreen;
  Dcl-Pi *N ind;
    mode char(1) const;
  end-pi;
  
  Dcl-S hasErrors ind inz(*off);
  
  IndErrors = *zeros;
  resetErrors();
  
  Select;
    When mode = MODE_INSERT;
      hasErrors = validateInsert();
    When mode = MODE_MODIFY;
      hasErrors = validateModify();
    Other;
      // No validation needed for DELETE or VIEW modes
      hasErrors = *off;
  EndSl;
  
  Return hasErrors;
end-proc;





// validateInsert - Validation specific to insert operation
Dcl-Proc validateInsert;
  Dcl-Pi *N ind;
  end-pi;
  
  Dcl-S exists char(1);
  Dcl-S hasErrors ind inz(*off);
  
  // Check if task ID already exists
  clear exists;
  exec sql
    SELECT '1' INTO :exists
    FROM CRUD01TBL
    WHERE TASK_ID = :CRUDTASKID
    FETCH FIRST ROW ONLY;
  
  If xSqlstate = SUCCESS_ON_SQL and exists = '1';
    TaskIdExistsError = *on;
    hasErrors = *on;
  EndIf;
  
  // Validate start date
  test(de) *iso STARTDATE;
  If %error;
    StartDateError = *on;
    hasErrors = *on;
  EndIf;
  
  // Validate end date
  test(de) *iso ENDDATE;
  If %error;
    EndDateError = *on;
    hasErrors = *on;
  EndIf;
  
  // Validate date range
  If STARTDATE <> 0 and ENDDATE <> 0 
     and not StartDateError and not EndDateError;
    If STARTDATE > ENDDATE;
      DateRangeError = *on;
      hasErrors = *on;
    EndIf;
  EndIf;
  
  Return hasErrors;
end-proc;





// validateModify - Validation specific to modify operation
Dcl-Proc validateModify;
  Dcl-Pi *N ind;
  end-pi;
  
  Dcl-S hasErrors ind inz(*off);
  
  // Validate start date
  test(de) *iso STARTDATE;
  If %error;
    StartDateError = *on;
    hasErrors = *on;
  EndIf;
  
  // Validate end date
  test(de) *iso ENDDATE;
  If %error;
    EndDateError = *on;
    hasErrors = *on;
  EndIf;
  
  // Validate date range
  If STARTDATE <> 0 and ENDDATE <> 0
     and not StartDateError and not EndDateError;
    If STARTDATE > ENDDATE;
      DateRangeError = *on;
      hasErrors = *on;
    EndIf;
  EndIf;
  
  Return hasErrors;
end-proc;

// ============================================================================
// CRUD OPERATION PROCEDURES
// ============================================================================
// InsertScreen - Handle insert operation
Dcl-Proc InsertScreen;
  Dcl-Pi *N;
    mode char(1) const;
  end-pi;
  
  Dcl-S nextMode char(1);
  
  WriteScreen(mode);
  
  dow not pfkey(03);
    ProtectFields_35 = *off;
    ProtectFields_36 = *off;
    exfmt CRUDTASK;
    
    Select;
      When pfkey(03);
        cleanupAndReturn(nextMode);
        ShowScreen(nextMode);
        leave;
        
      When pfkey(10);
        If not validateScreen(mode);
          If confirmAction();
            If performInsert();
              ShowWindow(WDW_MESSAGE);
              cleanupAndReturn(nextMode);
              ShowScreen(nextMode);
              leave;
            Else;
              ShowWindow(WDW_ERROR);
            EndIf;
          Else;
            clear CRUDTASK;
          EndIf;
        EndIf;
        
      Other;
        If validateScreen(mode);
          iter;
        EndIf;
    EndSl;
  enddo;
end-proc;





// performInsert - Execute insert with transaction control
Dcl-Proc performInsert;
  Dcl-Pi *N ind;
  end-pi;
  
  loadDataToRecord();
  
  monitor;
    exec sql
      INSERT INTO CRUD01TBL (
        TASK_ID, NAME, DESCR, ENDDES,
        STARTDATE, ENDDATE, STATE, OWNER
      ) VALUES (
        :taskRecord.Task_id,
        :taskRecord.Name,
        :taskRecord.Descr,
        :taskRecord.Enddes,
        :taskRecord.Startdate,
        :taskRecord.Enddate,
        :taskRecord.State,
        :taskRecord.Owner
      );
    
    If xSqlstate = SUCCESS_ON_SQL;
      exec sql COMMIT;
      Return *on;
    Else;
      exec sql ROLLBACK;
      Return *off;
    EndIf;
    
  on-error;
    exec sql ROLLBACK;
    Return *off;
  endmon;
end-proc;





// ModifyScreen - Handle modify operation
Dcl-Proc ModifyScreen;
  Dcl-Pi *N;
    mode char(1) const;
  end-pi;
  
  Dcl-S nextMode char(1);
  
  loadDataToScreen();
  WriteScreen(mode);
  
  dow not pfkey(03);
    ProtectFields_35 = *on;
    exfmt CRUDTASK;
    
    Select;
      When pfkey(03);
        ProtectFields_35 = *off;
        cleanupAndReturn(nextMode);
        crudFinalized = *on;
        ShowScreen(nextMode);
        leave;
        
      When pfkey(10);
        If not validateScreen(mode);
          If confirmAction();
            If performUpdate();
              ShowWindow(WDW_MESSAGE);
              cleanupAndReturn(nextMode);
              crudFinalized = *on;
              ShowScreen(nextMode);
              leave;
            Else;
              ShowWindow(WDW_ERROR);
            EndIf;
          Else;
            clear CRUDTASK;
          EndIf;
        EndIf;
        
      Other;
        If validateScreen(mode);
          iter;
        EndIf;
    EndSl;
  enddo;
end-proc;





// performUpdate - Execute update operation
Dcl-Proc performUpdate;
  Dcl-Pi *N ind;
  end-pi;
  
  monitor;
    exec sql
      UPDATE CRUD01TBL
      SET NAME = :NAMETASK,
          DESCR = :DESCRP,
          ENDDES = :SOLUTION,
          STARTDATE = :STARTDATE,
          ENDDATE = :ENDDATE,
          STATE = :STATETASK,
          OWNER = :currentUser
      WHERE TASK_ID = :CRUDTASKID;
    
    If xSqlstate = SUCCESS_ON_SQL;
      exec sql COMMIT;
      Return *on;
    Else;
      exec sql ROLLBACK;
      Return *off;
    EndIf;
    
  on-error;
    exec sql ROLLBACK;
    Return *off;
  endmon;
end-proc;





// DeleteScreen - Handle delete operation
Dcl-Proc DeleteScreen;
  Dcl-Pi *N;
    mode char(1) const;
  end-pi;
  
  Dcl-S nextMode char(1);
  
  loadDataToScreen();
  WriteScreen(mode);
  
  dow not pfkey(03);
    ProtectFields_35 = *on;
    ProtectFields_36 = *on;
    exfmt CRUDTASK;
    
    Select;
      When pfkey(03);
        ProtectFields_35 = *off;
        ProtectFields_36 = *off;
        cleanupAndReturn(nextMode);
        crudFinalized = *on;
        ShowScreen(nextMode);
        leave;
        
      When pfkey(10);
        If confirmAction();
          If performDelete();
            ShowWindow(WDW_DELETE);
            cleanupAndReturn(nextMode);
            crudFinalized = *on;
            ShowScreen(nextMode);
            leave;
          Else;
            ShowWindow(WDW_ERROR);
          EndIf;
        Else;
          clear CRUDTASK;
        EndIf;
        
      Other;
        iter;
    EndSl;
  enddo;
end-proc;





// performDelete - Execute delete operation
Dcl-Proc performDelete;
  Dcl-Pi *N ind;
  end-pi;
  
  monitor;
    exec sql
      DELETE FROM CRUD01TBL
      WHERE TASK_ID = :CRUDTASKID;
    
    If xSqlstate = SUCCESS_ON_SQL;
      exec sql COMMIT;
      Return *on;
    Else;
      exec sql ROLLBACK;
      Return *off;
    EndIf;
    
  on-error;
    exec sql ROLLBACK;
    Return *off;
  endmon;
end-proc;





// ViewScreen - Display record in read-only mode
Dcl-Proc ViewScreen;
  Dcl-Pi *N;
    mode char(1) const;
  end-pi;
  
  Dcl-S nextMode char(1);
  
  loadDataToScreen();
  WriteScreen(mode);
  
  dow not pfkey(03);
    ProtectFields_35 = *on;
    ProtectFields_36 = *on;
    exfmt CRUDTASK;
    
    If pfkey(03);
      ProtectFields_35 = *off;
      ProtectFields_36 = *off;
      cleanupAndReturn(nextMode);
      crudFinalized = *on;
      ShowScreen(nextMode);
      leave;
    EndIf;
  enddo;
end-proc;

// ============================================================================
// DATA TRANSFER PROCEDURES
// ============================================================================
// loadDataToScreen - Transfer data from record to screen
Dcl-Proc loadDataToScreen;
  clear CRUDTASK;
  CRUDTASKID = taskRecord.Task_id;
  NAMETASK = taskRecord.Name;
  DESCRP = taskRecord.Descr;
  SOLUTION = taskRecord.Enddes;
  STARTDATE = taskRecord.Startdate;
  ENDDATE = taskRecord.Enddate;
  STATETASK = taskRecord.State;
end-proc;





// loadDataToRecord - Transfer data from screen to record
Dcl-Proc loadDataToRecord;
  clear taskRecord;
  taskRecord.Task_id = CRUDTASKID;
  taskRecord.Name = %trim(NAMETASK);
  taskRecord.Descr = %trim(DESCRP);
  taskRecord.Enddes = %trim(SOLUTION);
  taskRecord.Startdate = STARTDATE;
  taskRecord.Enddate = ENDDATE;
  taskRecord.State = STATETASK;
  taskRecord.Owner = currentUser;
end-proc;





// confirmAction - Get user confirmation
Dcl-Proc confirmAction;
  Dcl-Pi *N ind;
  end-pi;
  
  ShowWindow(WDW_CONFIRM);
  Return (WDWCHOICE = 'Y');
end-proc;





// cleanupAndReturn - Clean up and prepare to return to subfile
Dcl-Proc cleanupAndReturn;
  Dcl-Pi *N;
    nextMode char(1);
  end-pi;
  
  clear CRUDTASK;
  clear OPCTASK;
  pfkey(03) = *off;
  initialPos = 0;
  finalPos = PERPAGE;
  nextMode = MODE_SUBFILE;
end-proc;