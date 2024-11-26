**free
//    _______  _______      ___       _____  ________  ____  ____  _    _     _
//   |_   __ \|_   __ \   .'   `.    |_   _||_   __  ||_  _||_  _|| |  | |   (_)
//     | |__) | | |__) | /  .-.  \     | |    | |_ \_|  \ \  / /  | |__| |_  __
//     |  ___/  |  __ /  | |   | | _   | |    |  _| _    > `' <   |____   _|[  |
//    _| |_    _| |  \ \_\  `-'  /| |__' |   _| |__/ | _/ /'`\ \_     _| |_  | |
//   |_____|  |____| |___|`.___.' `.____.'  |________||____||____|   |_____|[___]
//             -- The IBMi Developers Toolkit for Software Projex --
//                         https://www.projex4i.com
//
// CRUD for single file, with subfile using SQLRPGLE
//

/include projexsrc/@copybook,@hspec
ctl-opt copyright('| CRUD01RPG 2018.09.27');
ctl-opt main(proc_Main);

dcl-f CRUD01PNL workstn sfile(SFLTASK:TASKRRN)
  usropn infds(infds);

 /INCLUDE projexsrc/@copybook,@CORE

// Validation indicators
dcl-s pIndicators Pointer Inz(%Addr(*In));
dcl-ds DspInd Based(pIndicators);
  // Subfile indicators
  SflDsp          Ind Pos(99);
  SflDspCtl       Ind Pos(98);
  SflClr          Ind Pos(97);
  SflEnd          Ind Pos(96);
  // Validation Errors
  Taskidexisterror_31 Ind Pos(31);
  Startdateerror_32  Ind Pos(32);
  Enddateerror_33 Ind Pos(33);
  Dategreaterthanerror_34 Ind Pos(34);
  ProtectFields_35 Ind Pos(35);
  ProtectFields_36 Ind Pos(36);
  IndErrors char(20) Pos(31);
end-ds;

// Variable Pointer for SQL Errors
dcl-s pSqlstate Pointer Inz(%Addr(SQLState));

dcl-ds Ds_SqlState based(pSqlstate);
  xSqlstate char(2);
end-ds;

// Constant error on SQL
dcl-c Success_On_SQL '00';
dcl-c Warning_On_SQL '01';
dcl-c NoData_On_SQL  '02';

// Data structure based in the query neccesary for fill the subfile of
// the file CRUD01TBL
dcl-ds Ds_taskdata qualified;
  Taskid     zoned(10);
  Nametask    char(20);
  Start_date zoned(8);
  End_date   zoned(8);
  Taskstate  zoned(1);
end-ds;

// Data structure for general use in CRUD operations
dcl-ds Ds_datacrud extname('CRUD01TBL') qualified end-ds;

// Relative record number for SFLTASK subfile task
dcl-s taskrrn zoned(3:0);

// Variables for subfile scroll position
dcl-s Initialpos zoned(10:0) inz(0);
dcl-s Finalpos zoned(10:0) inz(10);

// Previous initial and finalpos for indicates final
dcl-s Previnitialpos zoned(10:0);
dcl-s PrevFinalpos zoned(10:0) ;

// Variable for apply filter to subfile query
dcl-s w_Wheresfl char(500) inz(*blanks);

// Quantity of records per page in subfile change the inz value depend
// of your subfile capacity
dcl-c Perpage 10;

// Variable for indicates that crud operations are finalized
dcl-s w_Crudfinalize Ind;

// Variable with current user
dcl-s CurrentUser char(10) inz(*user);


/title -------- MAINLINE ----------


dcl-proc proc_Main;

  dcl-s choice char(1) inz(*blanks);

  open CRUD01PNL;

  // The value 'S' is for Subfile Menu
  choice = 'S';

  proc_ShowScreen(choice);

  // Termination of program
  close CRUD01PNL;
  *Inlr = *On;
end-proc;



// This procedure receives a parameter that indicates what titles should
// written.
dcl-proc proc_WriteScreen;
  dcl-pi proc_WriteScreen;
    Par_Choice char(1);
  end-pi;

  // Secondary titles
  TITLE2 = proc_Center('Created by Some Bloke':%len(TITLE2));
  TITLE3 = proc_Center('Projex4i 2018':%len(TITLE3));

  // Principal title
  select;

  // CRUD Options
  when Par_Choice = 'I';
    TITLE1 = proc_Center('TASKS ADMINISTRATOR INSERT':%len(TITLE1));
  when Par_Choice = 'M';
    TITLE1 = proc_Center('TASKS ADMINISTRATOR MODIFY':%len(TITLE1));
  when Par_Choice = 'D';
    TITLE1 = proc_Center('TASKS ADMINISTRATOR DELETE':%len(TITLE1));
  when Par_Choice = 'V';
    TITLE1 = proc_Center('TASKS ADMINISTRATOR VIEW':%len(TITLE1));

  // Subfile
  when Par_Choice = 'S';
    TITLE1 = proc_Center('TASKS ADMINISTRATOR MAIN MENU':%len(TITLE1));
  endsl;

  if Par_Choice = 'S';
    FOOTTEXT = 'F3=Exit  F5=Refresh  F6=Create';
  elseif Par_Choice = 'I' or Par_Choice= 'M' or Par_Choice= 'D';
    FOOTTEXT = 'F3=Exit      F10=Confirm';
  elseif Par_Choice = 'V';
    FOOTTEXT = 'F3=Exit  ';
  endif;

  write HEADER;
  write FOOTER;
end-proc;



// This procedure executes and show the screen choiced by parameter
dcl-proc proc_ShowScreen;
  dcl-pi proc_ShowScreen ;
    Par_Choice char(1);
  end-pi;

  select;
  when Par_Choice = 'I';
    proc_InsertScreen(Par_Choice);
  when Par_Choice = 'S';
    proc_ShowSubfile(Par_Choice);
  when Par_Choice = 'M';
    proc_ModifyScreen(Par_Choice);
  when Par_Choice = 'D';
    proc_DeleteScreen(Par_Choice);
  when Par_Choice = 'V';
    proc_ViewScreen(Par_Choice);
  endsl;

end-proc;

// Show Window to user for confirm the current action
dcl-proc proc_ShowWdw;
  dcl-pi proc_ShowWdw;
    Par_Choice char(1);
  end-pi;

  // 'C' for confirm save record in database
  if Par_Choice = 'C';
    WDWTEXT1 = 'Are you sure to execute this action?';
    WDWTEXT2 = 'Please type Y/N ';
    write WDWCONFIRM;
    exfmt WDWCONFIRM;
  endif;

  // 'M' for message information
  if Par_Choice = 'M';
    WDWMSG1 = 'Your record has been saved';
    exfmt WDWMESSAGE;
  endif;

  if Par_Choice = 'D';
    WDWMSG1 = 'Your record has been deleted';
    exfmt WDWMESSAGE;
  endif;

  // 'E' for error message
  if Par_Choice = 'E';
    WDWMSG1 = 'Error executing this action ';
    exfmt WDWMESSAGE;
  endif;

end-proc;


// This procedure Center the titles of the screen
dcl-proc proc_Center;
  dcl-pi proc_Center char(80);
    Par_Text char(80) value;
    Par_Length zoned(2:0) value;
  end-pi;

  //Local variables
  dcl-s LenBlanks zoned(2:0);
  dcl-s InitPosition zoned(2:0);
  dcl-s Centeredtext char(80);

  Lenblanks= Par_Length - %Len(%Trim(Par_Text));
  InitPosition = Lenblanks /2;
  %Subst(Centeredtext:InitPosition)= %Trim(Par_Text);
  Return Centeredtext;

end-proc;



// Show the subfile in the screen
dcl-proc proc_ShowSubfile;
  dcl-pi proc_Showsubfile;
    Par_Choice char(1);
  end-pi;

  dcl-s w_exist char(1);
  dcl-s choice char(1);

  dow not pfkey(03);
    proc_WriteScreen(Par_Choice);
    proc_ActivateSubfile();
    exfmt SFLTASKCTL;

    select ;
    when pfkey(03);
      pfkey(03) = *Off;
      reset Initialpos;
      reset Finalpos;
      leave;
    when infds.funcKey = Pageup;
      if Initialpos = 0 and Finalpos = 10;
        iter;
      elseif Initialpos > 1 and Finalpos > 10;
        Initialpos -= 11;
        Finalpos -= 10;
        proc_ShowScreen(Par_Choice);
        leave;
      endif;

    when infds.funcKey = PageDn;

      if Initialpos > 0 and Finalpos > 10;

        exec sql
          SELECT '1'
            INTO : w_exist
            FROM (SELECT A.*,
                         RowNumber()
                    Over()
                    as RNum
                    FROM CRUD01TBL AS A
                    Where 1 = 1)
            as Tbl
            Where RNum BetWeen : Initialpos AND
                  :Finalpos
            FETCH FIRST ROW ONLY;

        if w_exist <> '1';
          Initialpos -= 11;
          Finalpos -= 10;
        endif;

        proc_ShowScreen(Par_Choice);
        leave;

      else;
        proc_ShowScreen(Par_Choice);
        leave;
      endif;

    when pfkey(05);

      reset Initialpos;
      reset Finalpos;

      proc_ShowScreen(Par_Choice);
      leave;
    when pfkey(06);
      choice = 'I';
      proc_ShowScreen(choice);
      leave;
    other;
      reset w_Wheresfl;

      // if there are selected records in subfile then executes
      if taskrrn > *zeros;
        for taskrrn = 1 to Perpage;
          chain taskrrn SFLTASK;
          if %found();

            select;
            when OPCTASK = '2';

              clear Ds_datacrud;

              // Loads the data into data structure
              exec sql
                SELECT * INTO:Ds_datacrud
                  FROM CRUD01TBL
                  WHERE TASK_ID = : SFLTASKID;

              choice = 'M';
              proc_ShowScreen(choice);
              leave;
            when OPCTASK = '4';
              clear Ds_datacrud;

              // Loads the data into data structure
              exec sql
                SELECT * INTO:Ds_datacrud
                  FROM CRUD01TBL
                  WHERE TASK_ID = : SFLTASKID;

              choice = 'D';
              proc_ShowScreen(choice);
              leave;
            when OPCTASK = '5';
              clear Ds_datacrud;

              // Loads the data into data structure
              exec sql
                SELECT * INTO:Ds_datacrud
                  FROM CRUD01TBL
                  WHERE TASK_ID = : SFLTASKID;

              choice = 'V';
              proc_ShowScreen(choice);
              leave;
            endsl;
            // Clean the field
            OPCTASK = *Blanks;
            Update SFLTASK;
          else;
            leave;
          endif;
        endfor;
      endif;
    endsl;
    if w_CrudFinalize = *On;
      w_CrudFinalize = *Off;
      leave;
    endif;

  enddo;

end-proc ;



dcl-proc proc_ScreenValidation ;
  dcl-pi proc_ScreenValidation Ind;
    Par_Choice char(1);
  end-pi;

  dcl-s w_ValidisnotOK Ind;
  dcl-s w_Exists char(1);

  // Set zeros in general variable based in DspInd
  IndErrors = *zeros;

  if Par_Choice = 'I'; // Validations for Insert

    proc_TurnoffErrors();

    // Search Task id entered into database
    exec sql
      SELECT '1'
        INTO : w_Exists
        FROM CRUD01TBL
        WHERE TASK_ID = :CRUDTASKID;

    Taskidexisterror_31 = (w_Exists = '1');

    // Validation of dates
    test(De) *iso STARTDATE; //Validates if date is in YYYYMMDD

    Startdateerror_32 = %error;

    test(De) *iso ENDDATE;

    Enddateerror_33 = %error;

    if (STARTDATE <> *zeros and ENDDATE <> *zeros
        and Startdateerror_32 = *Off and Enddateerror_33 = *Off);
      if (STARTDATE > ENDDATE);
        Dategreaterthanerror_34 = *On;
      endif;
    endif;
  endif;

  w_ValidisnotOK = IndErrors <> *Zeros;

  return w_ValidisnotOK;
end-proc;


dcl-proc proc_TurnoffErrors;
  Taskidexisterror_31 = *Off;
  Startdateerror_32 = *Off;
  Enddateerror_33 = *Off;
  Dategreaterthanerror_34 = *Off;
end-proc ;



// This procedure set the sql variable to the procedure for
// poblate the subfile with data based in the customized
// sql variable
dcl-proc proc_SubfileStart;
  dcl-pi proc_SubfileStart;
  end-pi;

  // Variable for store the sql query required
  dcl-s sqlcustomized char(500);

  sqlcustomized = 'SELECT TASK_ID , NAME , STARTDATE , ENDDATE , STATE '+
                  'FROM (SELECT A.*, RowNumber() Over() as RNum FROM '+
                  'CRUD01TBL AS A Where 1=1) as Tbl Where RNum '+
                  'BetWeen '+%char(Initialpos)+' and '+%char(Finalpos) +
                  ' '+%trim(w_WhereSfl);

  proc_FillSfl(sqlcustomized);

end-proc;



// Initialize and prepare the subfile
dcl-proc proc_Sflinitial;
  SflEnd = *off;
  SflClr = *on;
  write SFLTASKCTL;
  SflClr = *off;
  taskrrn = *zeros;
  SflDsp = *off;
  SflDspCtl = *off;
end-proc;

// Activate the subfile for being visualizated in Screen
dcl-proc proc_ActivateSubfile;
  proc_Sflinitial();
  proc_SubfileStart();

  SflEnd = proc_Gettotalrecords() < 10;

  if taskrrn > 0;
    SflDsp = *On;
  else;
    write EMPTY;
  endif;

  SflDspCtl = *On;
end-proc;



// Fill the subfile with a Cursor
dcl-proc proc_FillSfl;
  dcl-pi proc_FillSfl;
    Par_sqlcustomized char(500);
  end-pi;

  dcl-s Count zoned(2:0);

  dcl-s LastRRN zoned(10:0);

  // Set previous values for indicates final of subfile is it is
  // necessary
  clear Previnitialpos;
  clear Prevfinalpos;

  Previnitialpos = Initialpos;
  Prevfinalpos = Finalpos;

  clear Ds_taskdata;

  exec sql
    PREPARE YOURQUERY FROM : Par_sqlcustomized;

  exec sql
    DECLARE TASK_CURSOR INSENSITIVE SCROLL CURSOR FOR YOURQUERY;

  exec sql
    OPEN TASK_CURSOR;

  exec sql
    FETCH NEXT FROM TASK_CURSOR INTO : Ds_taskdata;

  dow (xSQLState <> NoData_On_SQL) and (Count < Perpage);
    Count = Count+1;
    LastRRN = LastRRN+1;

    if xSQLState = Success_On_Sql;
      proc_DatatoSfl();
    endif;

    exec sql
      FETCH NEXT FROM TASK_CURSOR INTO : Ds_taskdata;
    if xSQLState <> Success_On_Sql;
      if taskrrn = 10;
        Initialpos += Count+1;
        Finalpos += LastRRN;
      endif;
    endif;
  enddo;

  exec sql
    CLOSE TASK_CURSOR;
end-proc;



// This procedure assign the data fetched from cursor to subfile
dcl-proc proc_DatatoSfl;
  taskrrn +=1;
  SFLTASKID = Ds_taskdata.Taskid;
  SFLTASKNAM = Ds_taskdata.Nametask;
  SFLSTRDATE = Ds_taskdata.Start_date;
  SFLENDDATE = Ds_taskdata.End_date;
  SFLSTATE = Ds_taskdata.Taskstate;
  write SFLTASK;
  clear SFLTASK;
end-proc;

dcl-proc proc_Gettotalrecords;
  dcl-pi proc_Gettotalrecords zoned(10);
  end-pi;

  dcl-s w_Total zoned(10:0);

  dcl-s sqlcustomized char(500);

  sqlcustomized = 'SELECT COUNT(*) '+
         'FROM (SELECT A.*, RowNumber() Over() as RNum FROM '+
         'CRUD01TBL AS A Where 1=1) as Tbl Where RNum '+
         'BetWeen '+%char(PrevInitialpos)+' and '+%char(Prevfinalpos) +
         ' '+%trim(w_WhereSfl);

  exec sql
    PREPARE QRY FROM: sqlcustomized;

  exec sql
    DECLARE QRYC CURSOR FOR QRY;

  exec sql
    OPEN QRYC;

  exec sql
    FETCH QRYC INTO:w_Total;

  exec sql
    CLOSE QRYC;

  return w_Total;
end-proc;



dcl-proc proc_ExecuteCrudScreen;
  dcl-pi proc_ExecuteCrudScreen;
    Par_Choice char(1);
  end-pi;

  if Par_Choice = 'I'; // Insert Screen
    proc_InsertScreen(Par_Choice);
  endif;

  if Par_Choice = 'M'; // Modify Screen
    proc_ModifyScreen(Par_Choice);
  endif;

  if Par_Choice = 'D'; // Delete Screen
    proc_DeleteScreen(Par_Choice);
  endif;

  if Par_Choice = 'V'; // View Screen
    proc_ViewScreen(Par_Choice);
  endif;
end-proc;



dcl-proc proc_InsertScreen;
  dcl-pi proc_InsertScreen;
    Par_Choice char(1);
  end-pi;

  dcl-s choice char(1);
  dcl-s nameowner char(10);

  nameowner = 'RAJCARDON';

  proc_WriteScreen(Par_Choice);

  dow not pfkey(03);
    ProtectFields_35 = *Off;
    ProtectFields_36 = *Off;
    exfmt CRUDTASK;
    select;
    when pfkey(03);
      clear CRUDTASK;
      reset Initialpos;
      reset Finalpos;
      pfkey(03) = *Off;
      choice = 'S';
      proc_ShowScreen(choice);
      leave;
    when pfkey(10);
      if proc_ScreenValidation(Par_Choice) = *Off;

        // Executes window confirmation
        choice = 'C';
        proc_ShowWdw(choice);
        if WDWCHOICE = 'Y';
          proc_LoaddatatoDs();

          exec sql
            INSERT INTO CRUD01TBL
              VALUES (:Ds_datacrud);

          if xSQLState = Success_On_Sql;
            choice = 'M'; // Message of successful
            proc_ShowWdw(choice);
            clear CRUDTASK;
            reset Initialpos;
            reset Finalpos;
            choice = 'S';
            proc_ShowScreen(choice);
            leave;
          else;
            choice = 'E'; // Error Message
            proc_ShowWdw(choice);
          endif;
        else ;
          clear CRUDTASK;
        endif;
      endif;

    other;
      if proc_ScreenValidation(Par_Choice) = *On;
        iter;
      endif ;
    endsl;
  enddo;
end-proc;



dcl-proc proc_ModifyScreen;
  dcl-pi proc_ModifyScreen;
    Par_Choice char(1);
  end-pi;

  dcl-s choice char(1);

  proc_LoaddatatoScreen();
  proc_WriteScreen(Par_Choice);

  dow not pfkey(03);
    ProtectFields_35 = *On;
    exfmt CRUDTASK;
    select;
    when pfkey(03);
      ProtectFields_35 = *Off;
      clear CRUDTASK;
      clear OPCTASK;
      pfkey(03) = *Off;
      w_CrudFinalize = *On ;
      reset Initialpos;
      reset Finalpos;
      choice = 'S';
      proc_ShowScreen(choice);
      leave;
    when pfkey(10);
      if proc_ScreenValidation(Par_Choice) = *Off;

        // Executes window confirmation
        choice = 'C';
        proc_ShowWdw(choice);
        if WDWCHOICE = 'Y';

          exec sql
            UPDATE CRUD01TBL
              SET NAME = :NAMETASK,
                  DESCR = :DESCRP,
                  ENDDES = :SOLUTION,
                  STARTDATE = :STARTDATE,
                  ENDDATE = :ENDDATE,
                  STATE = :STATETASK,
                  OWNER = :CurrentUser
              WHERE TASK_ID = : CRUDTASKID;

          if xSQLState = Success_On_Sql;
            choice = 'M'; // Message of successful
            proc_ShowWdw(choice);
            clear CRUDTASK;
            clear OPCTASK;
            reset Initialpos;
            reset Finalpos;
            choice = 'S';
            proc_ShowScreen(choice);
            w_CrudFinalize = *On ;
            leave;
          else;
            choice = 'E'; // Error Message
            proc_ShowWdw(choice);
          endif;
        else ;
          clear CRUDTASK;
        endif;
      endif;

    other;
      if proc_ScreenValidation(Par_Choice) = *On;
        iter;
      endif ;
    endsl;
  enddo;
end-proc;



dcl-proc proc_DeleteScreen;
  dcl-pi proc_DeleteScreen;
    Par_Choice char(1);
  end-pi;

  dcl-s choice char(1);

  proc_LoaddatatoScreen();
  proc_WriteScreen(Par_Choice);

  dow not pfkey(03);
    ProtectFields_35 = *On;
    ProtectFields_36 = *On;
    exfmt CRUDTASK;
    select;
    when pfkey(03);
      ProtectFields_35 = *Off;
      ProtectFields_36 = *Off;
      clear CRUDTASK;
      clear OPCTASK;
      pfkey(03) = *Off;
      w_CrudFinalize = *On ;
      reset Initialpos;
      reset Finalpos;
      choice = 'S';
      proc_ShowScreen(choice);
      leave;
    when pfkey(10);
      if proc_ScreenValidation(Par_Choice) = *Off;

        // Executes window confirmation
        choice = 'C';
        proc_ShowWdw(choice);
        if WDWCHOICE = 'Y';

          exec sql
            DELETE FROM CRUD01TBL WHERE TASK_ID = : CRUDTASKID;

          if xSQLState = Success_On_Sql;
            proc_ShowWdw(Par_Choice);
            clear CRUDTASK;
            clear OPCTASK;
            reset Initialpos;
            reset Finalpos;
            choice = 'S';
            proc_ShowScreen(choice);
            w_CrudFinalize = *On ;
            leave;
          else;
            choice = 'E'; // Error Message
            proc_ShowWdw(choice);
          endif;
        else ;
          clear CRUDTASK;
        endif;
      endif;

    other;
      if proc_ScreenValidation(Par_Choice) = *On;
        iter;
      endif ;
    endsl;
  enddo;
end-proc;



dcl-proc proc_ViewScreen;
  dcl-pi proc_ViewScreen;
    Par_Choice char(1);
  end-pi;

  dcl-s choice char(1);

  proc_LoaddatatoScreen();
  proc_WriteScreen(Par_Choice);

  dow not pfkey(03);
    ProtectFields_35 = *On;
    ProtectFields_36 = *On;
    exfmt CRUDTASK;
    if pfkey(03);
      ProtectFields_35 = *Off;
      ProtectFields_36 = *Off;
      clear CRUDTASK;
      clear OPCTASK;
      pfkey(03) = *Off;
      w_CrudFinalize = *On ;
      reset Initialpos;
      reset Finalpos;
      choice = 'S';
      proc_ShowScreen(choice);
      leave;
    endif;
  enddo;
end-proc;



dcl-proc proc_LoaddatatoScreen;
  clear CRUDTASK;
  CRUDTASKID = Ds_datacrud.Task_id;
  NAMETASK = Ds_datacrud.Name;
  DESCRP = Ds_datacrud.Descr;
  SOLUTION = Ds_datacrud.Enddes;
  STARTDATE = Ds_datacrud.Startdate;
  ENDDATE = Ds_datacrud.Enddate;
  STATETASK = Ds_datacrud.State;
end-proc ;



dcl-proc proc_LoaddatatoDs;
  clear Ds_datacrud;
  Ds_datacrud.Task_id = CRUDTASKID;
  Ds_datacrud.Name = %trim(NAMETASK);
  Ds_datacrud.Descr = %trim(DESCRP);
  Ds_datacrud.Enddes = %trim(SOLUTION);
  Ds_datacrud.Startdate = STARTDATE;
  Ds_datacrud.Enddate = ENDDATE;
  Ds_datacrud.State = STATETASK;
  Ds_datacrud.Owner = CurrentUser;
end-proc;
