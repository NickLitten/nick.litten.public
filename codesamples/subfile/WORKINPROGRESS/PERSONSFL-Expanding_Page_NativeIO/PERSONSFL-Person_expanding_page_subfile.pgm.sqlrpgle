**free
// ------------------------------------------------------------------------------
// Program: PERSONSFL
// Description: Expanding page subfile example for Person table
// Author: Nick Litten
// Date: 2026-02-03
// ------------------------------------------------------------------------------
// This program demonstrates an expanding page subfile that loads
// records as the user pages down through the data.
// ------------------------------------------------------------------------------

ctl-opt dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt);

// ------------------------------------------------------------------------------
// File Declarations
// ------------------------------------------------------------------------------
dcl-f PERSONSFL workstn sfile(SFLREC:RRN) indds(Indicators) usropn;

// ------------------------------------------------------------------------------
// Data Structures
// ------------------------------------------------------------------------------
Dcl-Ds Indicators;
   Exit ind pos(3);
   Refresh ind pos(5);
   Cancel ind pos(12);
   SflDsp ind pos(91);
   SflDspCtl ind pos(92);
   SflClr ind pos(93);
   SflEnd ind pos(94);
end-ds;

// ------------------------------------------------------------------------------
// Standalone Variables
// ------------------------------------------------------------------------------
Dcl-S RRN packed(4:0);
Dcl-S PageSize packed(4:0) inz(10);
Dcl-S LastRRN packed(4:0) inz(0);
Dcl-S MoreRecords ind inz(*on);
Dcl-S FirstTime ind inz(*on);

// ------------------------------------------------------------------------------
// SQL Cursor Declaration
// ------------------------------------------------------------------------------
Dcl-S FetchName varchar(50);
Dcl-S FetchDOB date;
Dcl-S FetchAddress varchar(100);
Dcl-S PGMNAME char(10);
Dcl-S USERNAME char(10);

// ------------------------------------------------------------------------------
// Main Program Logic
// ------------------------------------------------------------------------------
exec sql set option commit = *none, closqlcsr = *endmod;

open PERSONSFL;

PGMNAME = 'PERSONSFL';
USERNAME = 'SOMEBLOKE';
SFLRCDNBR = 1;

dow (not Exit);
   
   If (FirstTime or Refresh);
      LoadSubfile();
      FirstTime = *off;
      Refresh = *off;
   EndIf;

   write SFLCTL;
   exfmt SFLCTL;

   If (Exit);
      leave;
   EndIf;

   If (Refresh);
      iter;
   EndIf;

   // Process subfile selections
   ProcessSelections();

enddo;

close PERSONSFL;
*inlr = *on;
Return;

// ------------------------------------------------------------------------------
// LoadSubfile - Load initial page of subfile records
// ------------------------------------------------------------------------------
Dcl-Proc LoadSubfile;
   
   // Clear the subfile
   SflDsp = *off;
   SflDspCtl = *on;
   SflClr = *on;
   write SFLCTL;
   SflClr = *off;
   
   RRN = 0;
   LastRRN = 0;
   MoreRecords = *on;
   
   // Declare cursor for initial load
   exec sql declare C1 cursor for
      select :PNAME, PDOB, PADDRESS
      from PERSONTBL
      order by :PNAME;
   
   exec sql open C1;
   
   // Load first page
   dow (RRN < PageSize and MoreRecords);
      exec sql fetch next from C1
         into :FetchName, :FetchDOB, :FetchAddress;
      
      If (SQLSTATE = '00000');
         RRN += 1;
         LastRRN = RRN;
         SFLSEL = ' ';
         PNAME = FetchName;
         PDOB = FetchDOB;
         PADDRESS = FetchAddress;
         write SFLREC;
      Else;
         MoreRecords = *off;
         SflEnd = *on;
      EndIf;
   enddo;
   
   // Check if more records exist
   If (MoreRecords);
      exec sql fetch next from C1
         into :FetchName, :FetchDOB, :FetchAddress;
      
      If (SQLSTATE <> '00000');
         MoreRecords = *off;
         SflEnd = *on;
      Else;
         // Put the record back by closing and reopening cursor
         exec sql close C1;
         SflEnd = *off;
      EndIf;
   EndIf;
   
   exec sql close C1;
   
   // Display subfile if records exist
   If (RRN > 0);
      SflDsp = *on;
      SflDspCtl = *on;
   Else;
      SflDsp = *off;
      SflDspCtl = *on;
   EndIf;
   
end-proc;

// ------------------------------------------------------------------------------
// ProcessSelections - Handle user selections from subfile
// ------------------------------------------------------------------------------
Dcl-Proc ProcessSelections;
   
   Dcl-S CurrentRRN packed(4:0);
   
   CurrentRRN = 1;
   
   dow (CurrentRRN <= LastRRN);
      chain CurrentRRN SFLREC;
      
      If (%found(PERSONSFL));
         Select;
            When (SFLSEL = '1');  // Display details
               DisplayDetails();
               SFLSEL = ' ';
               update SFLREC;
         EndSl;
      EndIf;
      
      CurrentRRN += 1;
   enddo;
   
end-proc;

// ------------------------------------------------------------------------------
// DisplayDetails - Show detail screen for selected record
// ------------------------------------------------------------------------------
Dcl-Proc DisplayDetails;
   
   DNAME = PNAME;
   DDOB = PDOB;
   DADDRESS = PADDRESS;
   
   Cancel = *off;
   
   dow (not Cancel);
      write FOOTREC;
      exfmt DETAILREC;
      
      If (Cancel);
         leave;
      EndIf;
   enddo;
   
   Cancel = *off;
   
end-proc;

// ------------------------------------------------------------------------------
// Note: Expanding page logic
// ------------------------------------------------------------------------------
// The expanding page subfile automatically loads more records
// when the user pages down past the current set of records.
// This is controlled by:
// - SFLSIZ(0020): Total subfile size
// - SFLPAG(0010): Page size (records per page)
// - SFLEND(*MORE): Shows "More..." indicator
// 
// When SFLRCDNBR exceeds LastRRN, the program should detect
// this and load the next page of records. This can be enhanced
// by checking SFLRCDNBR after the EXFMT operation.
// ------------------------------------------------------------------------------
