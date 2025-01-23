**free
//
// CRUD for single file, with subfile using SQLRPGLE
//

ctl-opt copyright('| CRUD01RPG 2018.09.27');
ctl-opt main(proc_Main);

dcl-f CRUD01PNL workstn sfile(SFLTASK:taskrrn) usropn infds(infds);
      

// Validation indicators
Dcl-S pIndicators Pointer Inz(%Addr(*In));
Dcl-Ds DspInd Based(pIndicators);
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
Dcl-S pSqlstate Pointer Inz(%Addr(SQLState));

Dcl-Ds Ds_SqlState based(pSqlstate);
   xSqlstate char(2);
end-ds;

// Constant error on SQL
Dcl-C SUCCESS_ON_SQL '00';
Dcl-C WARNING_ON_SQL '01';
Dcl-C NODATA_ON_SQL  '02';

// Data structure based in the query neccesary for fill the subfile of
// the file CRUD01TBL
Dcl-Ds Ds_taskdata qualified;
   Taskid     zoned(10);
   Nametask    char(20);
   Start_date zoned(8);
   End_date   zoned(8);
   Taskstate  zoned(1);
end-ds;

// Data structure for general use in CRUD operations
Dcl-Ds Ds_datacrud extname('CRUD01TBL') qualified end-ds;

// Relative record number for SFLTASK subfile task
Dcl-S taskrrn zoned(3:0);

// Variables for subfile scroll position
Dcl-S Initialpos zoned(10:0) inz(0);
Dcl-S Finalpos zoned(10:0) inz(10);

// Previous initial and finalpos for indicates final
Dcl-S Previnitialpos zoned(10:0);
Dcl-S PrevFinalpos zoned(10:0) ;

// Variable for apply filter to subfile query
Dcl-S w_Wheresfl char(500) inz(*blanks);

// Quantity of records per page in subfile change the inz value depend
// of your subfile capacity
Dcl-C PERPAGE 10;

// Variable for indicates that crud operations are finalized
Dcl-S w_Crudfinalize Ind;

// Variable with current user
Dcl-S CurrentUser char(10) inz(*user);


/title [---- proc_Main ----] 
Dcl-Proc proc_Main;

   Dcl-S choice char(1) inz(*blanks);

   open CRUD01PNL;

   // The value 'S' is for Subfile Menu
   choice = 'S';

   proc_ShowScreen(choice);

   // Termination of program
   close CRUD01PNL;
   *Inlr = *On;
end-proc;


/title [---- proc_WriteScreen ----] 
// This procedure receives a parameter that indicates what titles should
// written.
Dcl-Proc proc_WriteScreen;
   Dcl-Pi proc_WriteScreen;
      p_choice char(1);
   end-pi;

   // Secondary titles
   TITLE2 = proc_Center('Created by Some Bloke':%len(TITLE2));
   TITLE3 = proc_Center('Projex4i 2018':%len(TITLE3));

   // Principal title
   Select;

         // CRUD Options
      When (p_choice = 'I');
         TITLE1 = proc_Center('TASKS ADMINISTRATOR INSERT':%len(TITLE1));
      When (p_choice = 'M');
         TITLE1 = proc_Center('TASKS ADMINISTRATOR MODIFY':%len(TITLE1));
      When (p_choice = 'D');
         TITLE1 = proc_Center('TASKS ADMINISTRATOR DELETE':%len(TITLE1));
      When (p_choice = 'V');
         TITLE1 = proc_Center('TASKS ADMINISTRATOR VIEW':%len(TITLE1));

         // Subfile
      When (p_choice = 'S');
         TITLE1 = proc_Center('TASKS ADMINISTRATOR MAIN MENU':%len(TITLE1));
   EndSl;

   // Use an IF/ELSEIF as a different way of doing SELECT groups
   // here is an example:
   If (p_choice = 'S');
      FOOTTEXT = 'F3=Exit  F5=Refresh  F6=Create';
   elseif (p_choice = 'I' or p_choice= 'M' or p_choice= 'D');
      FOOTTEXT = 'F3=Exit      F10=Confirm';
   elseif (p_choice = 'V');
      FOOTTEXT = 'F3=Exit  ';
   EndIf;

   write HEADER;
   write FOOTER;
end-proc;


/title [---- proc_WriteScreen ----] 
// This procedure executes and show the screen choiced by parameter
Dcl-Proc proc_ShowScreen;
   Dcl-Pi proc_ShowScreen ;
      p_choice char(1);
   end-pi;

   Select;
      When (p_choice = 'I');
         proc_InsertScreen(p_choice);
      When (p_choice = 'S');
         proc_ShowSubfile(p_choice);
      When (p_choice = 'M');
         proc_ModifyScreen(p_choice);
      When (p_choice = 'D');
         proc_DeleteScreen(p_choice);
      When (p_choice = 'V');
         proc_ViewScreen(p_choice);
   EndSl;

end-proc;


/title [---- proc_WriteScreen ----] 
// Show Window to user for confirm the current action
Dcl-Proc proc_ShowWdw;
   Dcl-Pi proc_ShowWdw;
      p_choice char(1);
   end-pi;

   // 'C' for confirm save record in database
   If (p_choice = 'C');
      WDWTEXT1 = 'Are you sure to execute this action?';
      WDWTEXT2 = 'Please type Y/N ';
      write WDWCONFIRM;
      exfmt WDWCONFIRM;
   EndIf;

   // 'M' for message information
   If (p_choice = 'M');
      WDWMSG1 = 'Your record has been saved';
      exfmt WDWMESSAGE;
   EndIf;

   If (p_choice = 'D');
      WDWMSG1 = 'Your record has been deleted';
      exfmt WDWMESSAGE;
   EndIf;

   // 'E' for error message
   If (p_choice = 'E');
      WDWMSG1 = 'Error executing this action ';
      exfmt WDWMESSAGE;
   EndIf;

end-proc;


/title [---- proc_WriteScreen ----] 
// This procedure Center the titles of the screen
Dcl-Proc proc_Center;
   Dcl-Pi proc_Center char(80);
      Par_Text char(80) value;
      Par_Length zoned(2:0) value;
   end-pi;

   // Local variables
   Dcl-S LenBlanks zoned(2:0);
   Dcl-S InitPosition zoned(2:0);
   Dcl-S Centeredtext char(80);

   LenBlanks= Par_Length - %Len(%Trim(Par_Text));
   InitPosition = LenBlanks /2;
   %Subst(Centeredtext:InitPosition)= %Trim(Par_Text);
   Return Centeredtext;

end-proc;



/title [---- proc_WriteScreen ----] 
// Show the subfile in the screen
Dcl-Proc proc_ShowSubfile;
   Dcl-Pi proc_ShowSubfile;
      p_choice char(1);
   end-pi;

   Dcl-S w_exist char(1);
   Dcl-S choice char(1);

   dow (not pfkey(03));
      proc_WriteScreen(p_choice);
      proc_ActivateSubfile();
      exfmt SFLTASKCTL;

      Select ;
         When (pfkey(03));
            pfkey(03) = *Off;
            reset Initialpos;
            reset Finalpos;
            leave;
         When (infds.funcKey = Pageup);
            If (Initialpos = 0 and Finalpos = 10);
               iter;
            elseif (Initialpos > 1 and Finalpos > 10);
               Initialpos -= 11;
               Finalpos -= 10;
               proc_ShowScreen(p_choice);
               leave;
            EndIf;

         When (infds.funcKey = PageDn);

            If (Initialpos > 0 and Finalpos > 10);

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

               If (w_exist <> '1');
                  Initialpos -= 11;
                  Finalpos -= 10;
               EndIf;

               proc_ShowScreen(p_choice);
               leave;

            Else;
               proc_ShowScreen(p_choice);
               leave;
            EndIf;

         When (pfkey(05));

            reset Initialpos;
            reset Finalpos;

            proc_ShowScreen(p_choice);
            leave;
         When (pfkey(06));
            choice = 'I';
            proc_ShowScreen(choice);
            leave;
         Other;
            reset w_Wheresfl;

            // if there are selected records in subfile then executes
            If (taskrrn > *zeros);
               for taskrrn = 1 to PERPAGE;
                  chain taskrrn SFLTASK;
                  If (%found());

                     Select;
                        When (OPCTASK = '2');

                           clear Ds_datacrud;

                           // Loads the data into data structure
                           exec sql
                SELECT * INTO:Ds_datacrud
                  FROM CRUD01TBL
                  WHERE TASK_ID = : SFLTASKID;

                           choice = 'M';
                           proc_ShowScreen(choice);
                           leave;
                        When (OPCTASK = '4');
                           clear Ds_datacrud;

                           // Loads the data into data structure
                           exec sql
                SELECT * INTO:Ds_datacrud
                  FROM CRUD01TBL
                  WHERE TASK_ID = : SFLTASKID;

                           choice = 'D';
                           proc_ShowScreen(choice);
                           leave;
                        When (OPCTASK = '5');
                           clear Ds_datacrud;

                           // Loads the data into data structure
                           exec sql
                SELECT * INTO:Ds_datacrud
                  FROM CRUD01TBL
                  WHERE TASK_ID = : SFLTASKID;

                           choice = 'V';
                           proc_ShowScreen(choice);
                           leave;
                     EndSl;
                     // Clean the field
                     OPCTASK = *Blanks;
                     Update SFLTASK;
                  Else;
                     leave;
                  EndIf;
               endfor;
            EndIf;
      EndSl;
      If (w_CrudFinalize = *On);
         w_Crudfinalize = *Off;
         leave;
      EndIf;

   enddo;

end-proc ;


/title [---- proc_WriteScreen ----] 
Dcl-Proc proc_ScreenValidation ;
   Dcl-Pi proc_ScreenValidation Ind;
      p_choice char(1);
   end-pi;

   Dcl-S w_ValidisnotOK Ind;
   Dcl-S w_Exists char(1);

   // Set zeros in general variable based in DspInd
   IndErrors = *zeros;

   If (p_choice = 'I'); // Validations for Insert

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

      If (STARTDATE <> *zeros and ENDDATE <> *zeros
        and Startdateerror_32 = *Off and Enddateerror_33 = *Off);
         If (STARTDATE > ENDDATE);
            Dategreaterthanerror_34 = *On;
         EndIf;
      EndIf;
   EndIf;

   w_ValidisnotOK = IndErrors <> *Zeros;

   Return w_ValidisnotOK;
end-proc;



/title [---- proc_WriteScreen ----] 
Dcl-Proc proc_TurnoffErrors;
   Taskidexisterror_31 = *Off;
   Startdateerror_32 = *Off;
   Enddateerror_33 = *Off;
   Dategreaterthanerror_34 = *Off;
end-proc ;


/title [---- proc_WriteScreen ----] 
// This procedure set the sql variable to the procedure to
// populate the subfile with data based in the customized
// sql variable
Dcl-Proc proc_SubfileStart;
   Dcl-Pi proc_SubfileStart;
   end-pi;

   // Variable for store the sql query required
   Dcl-S sqlcustomized char(500);

   sqlcustomized = 'SELECT TASK_ID , NAME , STARTDATE , ENDDATE , STATE '+
                  'FROM (SELECT A.*, RowNumber() Over() as RNum FROM '+
                  'CRUD01TBL AS A Where 1=1) as Tbl Where RNum '+
                  'BetWeen '+%char(Initialpos)+' and '+%char(Finalpos) +
                  ' '+%trim(w_Wheresfl);

   proc_FillSfl(sqlcustomized);

end-proc;


/title [---- proc_WriteScreen ----] 
// Initialize and prepare the subfile
Dcl-Proc proc_Sflinitial;
   SflEnd = *off;
   SflClr = *on;
   write SFLTASKCTL;
   SflClr = *off;
   taskrrn = *zeros;
   SflDsp = *off;
   SflDspCtl = *off;
end-proc;


/title [---- proc_WriteScreen ----] 
// Activate the subfile for being visualizated in Screen
Dcl-Proc proc_ActivateSubfile;
   proc_Sflinitial();
   proc_SubfileStart();

   SflEnd = proc_Gettotalrecords() < 10;

   If (taskrrn > 0);
      SflDsp = *On;
   Else;
      write EMPTY;
   EndIf;

   SflDspCtl = *On;
end-proc;


/title [---- proc_WriteScreen ----] 
// Fill the subfile with a Cursor
Dcl-Proc proc_FillSfl;
   Dcl-Pi proc_FillSfl;
      Par_sqlcustomized char(500);
   end-pi;

   Dcl-S Count zoned(2:0);

   Dcl-S LastRRN zoned(10:0);

   // Set previous values for indicates final of subfile is it is
   // necessary
   clear Previnitialpos;
   clear PrevFinalpos;

   Previnitialpos = Initialpos;
   PrevFinalpos = Finalpos;

   clear Ds_taskdata;

   exec sql
    PREPARE YOURQUERY FROM : Par_sqlcustomized;

   exec sql
    DECLARE TASK_CURSOR INSENSITIVE SCROLL CURSOR FOR YOURQUERY;

   exec sql
    OPEN TASK_CURSOR;

   exec sql
    FETCH NEXT FROM TASK_CURSOR INTO : Ds_taskdata;

   dow (xSQLState <> NoData_On_SQL) and (Count < PERPAGE);
      Count = Count+1;
      LastRRN = LastRRN+1;

      If (xSQLState = Success_On_Sql);
         proc_DatatoSfl();
      EndIf;

      exec sql
      FETCH NEXT FROM TASK_CURSOR INTO : Ds_taskdata;
      If (xSQLState <> Success_On_Sql);
         If (taskrrn = 10);
            Initialpos += Count+1;
            Finalpos += LastRRN;
         EndIf;
      EndIf;
   enddo;

   exec sql
    CLOSE TASK_CURSOR;
end-proc;


/title [---- proc_WriteScreen ----] 
// This procedure assign the data fetched from cursor to subfile
Dcl-Proc proc_DatatoSfl;
   taskrrn +=1;
   SFLTASKID = Ds_taskdata.Taskid;
   SFLTASKNAM = Ds_taskdata.Nametask;
   SFLSTRDATE = Ds_taskdata.Start_date;
   SFLENDDATE = Ds_taskdata.End_date;
   SFLSTATE = Ds_taskdata.Taskstate;
   write SFLTASK;
   clear SFLTASK;
end-proc;



/title [---- proc_WriteScreen ----] 
Dcl-Proc proc_Gettotalrecords;
   Dcl-Pi proc_Gettotalrecords zoned(10);
   end-pi;

   Dcl-S w_Total zoned(10:0);

   Dcl-S sqlcustomized char(500);

   sqlcustomized = 'SELECT COUNT(*) '+
         'FROM (SELECT A.*, RowNumber() Over() as RNum FROM '+
         'CRUD01TBL AS A Where 1=1) as Tbl Where RNum '+
         'BetWeen '+%char(Previnitialpos)+' and '+%char(PrevFinalpos) +
         ' '+%trim(w_Wheresfl);

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

   Return w_Total;
end-proc;



/title [---- proc_WriteScreen ----] 
Dcl-Proc proc_ExecuteCrudScreen;
   Dcl-Pi proc_ExecuteCrudScreen;
      p_choice char(1);
   end-pi;

   If (p_choice = 'I'); // Insert Screen
      proc_InsertScreen(p_choice);
   EndIf;

   If (p_choice = 'M'); // Modify Screen
      proc_ModifyScreen(p_choice);
   EndIf;

   If (p_choice = 'D'); // Delete Screen
      proc_DeleteScreen(p_choice);
   EndIf;

   If (p_choice = 'V'); // View Screen
      proc_ViewScreen(p_choice);
   EndIf;
end-proc;


/title [---- proc_WriteScreen ----] 
Dcl-Proc proc_InsertScreen;
   Dcl-Pi proc_InsertScreen;
      p_choice char(1);
   end-pi;

   Dcl-S choice char(1);
   Dcl-S nameowner char(10);

   nameowner = 'RAJCARDON';

   proc_WriteScreen(p_choice);

   dow (not pfkey(03));
      ProtectFields_35 = *Off;
      ProtectFields_36 = *Off;
      exfmt CRUDTASK;
      Select;
         When (pfkey(03));
            clear CRUDTASK;
            reset Initialpos;
            reset Finalpos;
            pfkey(03) = *Off;
            choice = 'S';
            proc_ShowScreen(choice);
            leave;
         When (pfkey(10));
            If (proc_ScreenValidation(p_choice) = *Off);

               // Executes window confirmation
               choice = 'C';
               proc_ShowWdw(choice);
               If (WDWCHOICE = 'Y');
                  proc_LoaddatatoDs();

                  exec sql
            INSERT INTO CRUD01TBL
              VALUES (:Ds_datacrud);

                  If (xSQLState = Success_On_Sql);
                     choice = 'M'; // Message of successful
                     proc_ShowWdw(choice);
                     clear CRUDTASK;
                     reset Initialpos;
                     reset Finalpos;
                     choice = 'S';
                     proc_ShowScreen(choice);
                     leave;
                  Else;
                     choice = 'E'; // Error Message
                     proc_ShowWdw(choice);
                  EndIf;
               Else ;
                  clear CRUDTASK;
               EndIf;
            EndIf;

         Other;
            If (proc_ScreenValidation(p_choice) = *On);
               iter;
            EndIf ;
      EndSl;
   enddo;
end-proc;



/title [---- proc_WriteScreen ----] 
Dcl-Proc proc_ModifyScreen;
   Dcl-Pi proc_ModifyScreen;
      p_choice char(1);
   end-pi;

   Dcl-S choice char(1);

   proc_LoaddatatoScreen();
   proc_WriteScreen(p_choice);

   dow (not pfkey(03));
      ProtectFields_35 = *On;
      exfmt CRUDTASK;
      Select;
         When (pfkey(03));
            ProtectFields_35 = *Off;
            clear CRUDTASK;
            clear OPCTASK;
            pfkey(03) = *Off;
            w_Crudfinalize = *On ;
            reset Initialpos;
            reset Finalpos;
            choice = 'S';
            proc_ShowScreen(choice);
            leave;
         When (pfkey(10));
            If (proc_ScreenValidation(p_choice) = *Off);

               // Executes window confirmation
               choice = 'C';
               proc_ShowWdw(choice);
               If (WDWCHOICE = 'Y');

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

                  If (xSQLState = Success_On_Sql);
                     choice = 'M'; // Message of successful
                     proc_ShowWdw(choice);
                     clear CRUDTASK;
                     clear OPCTASK;
                     reset Initialpos;
                     reset Finalpos;
                     choice = 'S';
                     proc_ShowScreen(choice);
                     w_Crudfinalize = *On ;
                     leave;
                  Else;
                     choice = 'E'; // Error Message
                     proc_ShowWdw(choice);
                  EndIf;
               Else ;
                  clear CRUDTASK;
               EndIf;
            EndIf;

         Other;
            If (proc_ScreenValidation(p_choice) = *On);
               iter;
            EndIf ;
      EndSl;
   enddo;
end-proc;



/title [---- proc_WriteScreen ----] 
Dcl-Proc proc_DeleteScreen;
   Dcl-Pi proc_DeleteScreen;
      p_choice char(1);
   end-pi;

   Dcl-S choice char(1);

   proc_LoaddatatoScreen();
   proc_WriteScreen(p_choice);

   dow (not pfkey(03));
      ProtectFields_35 = *On;
      ProtectFields_36 = *On;
      exfmt CRUDTASK;
      Select;
         When (pfkey(03));
            ProtectFields_35 = *Off;
            ProtectFields_36 = *Off;
            clear CRUDTASK;
            clear OPCTASK;
            pfkey(03) = *Off;
            w_Crudfinalize = *On ;
            reset Initialpos;
            reset Finalpos;
            choice = 'S';
            proc_ShowScreen(choice);
            leave;
         When (pfkey(10));
            If (proc_ScreenValidation(p_choice) = *Off);

               // Executes window confirmation
               choice = 'C';
               proc_ShowWdw(choice);
               If (WDWCHOICE = 'Y');

                  exec sql
            DELETE FROM CRUD01TBL WHERE TASK_ID = : CRUDTASKID;

                  If (xSQLState = Success_On_Sql);
                     proc_ShowWdw(p_choice);
                     clear CRUDTASK;
                     clear OPCTASK;
                     reset Initialpos;
                     reset Finalpos;
                     choice = 'S';
                     proc_ShowScreen(choice);
                     w_Crudfinalize = *On ;
                     leave;
                  Else;
                     choice = 'E'; // Error Message
                     proc_ShowWdw(choice);
                  EndIf;
               Else ;
                  clear CRUDTASK;
               EndIf;
            EndIf;

         Other;
            If (proc_ScreenValidation(p_choice) = *On);
               iter;
            EndIf ;
      EndSl;
   enddo;
end-proc;


/title [---- proc_WriteScreen ----] 
Dcl-Proc proc_ViewScreen;
   Dcl-Pi proc_ViewScreen;
      p_choice char(1);
   end-pi;

   Dcl-S choice char(1);

   proc_LoaddatatoScreen();
   proc_WriteScreen(p_choice);

   dow (not pfkey(03));
      ProtectFields_35 = *On;
      ProtectFields_36 = *On;
      exfmt CRUDTASK;
      If (pfkey(03));
         ProtectFields_35 = *Off;
         ProtectFields_36 = *Off;
         clear CRUDTASK;
         clear OPCTASK;
         pfkey(03) = *Off;
         w_Crudfinalize = *On ;
         reset Initialpos;
         reset Finalpos;
         choice = 'S';
         proc_ShowScreen(choice);
         leave;
      EndIf;
   enddo;
end-proc;



/title [---- proc_WriteScreen ----] 
Dcl-Proc proc_LoaddatatoScreen;
   clear CRUDTASK;
   CRUDTASKID = Ds_datacrud.Task_id;
   NAMETASK = Ds_datacrud.Name;
   DESCRP = Ds_datacrud.Descr;
   SOLUTION = Ds_datacrud.Enddes;
   STARTDATE = Ds_datacrud.Startdate;
   ENDDATE = Ds_datacrud.Enddate;
   STATETASK = Ds_datacrud.State;
end-proc ;


/title [---- proc_WriteScreen ----] 
Dcl-Proc proc_LoaddatatoDs;
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
