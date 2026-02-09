**FREE
// ================================================================
// Program: PERSONSFL
// Description: Expanding page subfile example for Person table
// Author: IBM Bob
// Date: 2026-02-03
// ================================================================
// This program demonstrates an expanding page subfile that loads
// records as the user pages down through the data.
// ================================================================

ctl-opt dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt);

// ================================================================
// File Declarations
// ================================================================
dcl-f PERSONSFL workstn sfile(SFLREC:RRN) indds(Indicators) usropn;

// ================================================================
// Data Structures
// ================================================================
dcl-ds Indicators;
  Exit ind pos(3);
  Refresh ind pos(5);
  Cancel ind pos(12);
  SflDsp ind pos(91);
  SflDspCtl ind pos(92);
  SflClr ind pos(93);
  SflEnd ind pos(94);
end-ds;

// ================================================================
// Standalone Variables
// ================================================================
dcl-s RRN packed(4:0);
dcl-s PageSize packed(4:0) inz(10);
dcl-s LastRRN packed(4:0) inz(0);
dcl-s MoreRecords ind inz(*on);
dcl-s FirstTime ind inz(*on);

// ================================================================
// SQL Cursor Declaration
// ================================================================
dcl-s FetchName varchar(50);
dcl-s FetchDOB date;
dcl-s FetchAddress varchar(100);
dcl-s PGMNAME char(10);
dcl-s USERNAME char(10);

// ================================================================
// Main Program Logic
// ================================================================
exec sql set option commit = *none, closqlcsr = *endmod;

open PERSONSFL;

PGMNAME = 'PERSONSFL';
USERNAME = 'SOMEBLOKE';
SFLRCDNBR = 1;

dow not Exit;
  
  if FirstTime or Refresh;
    LoadSubfile();
    FirstTime = *off;
    Refresh = *off;
  endif;

  write SFLCTL;
  exfmt SFLCTL;

  if Exit;
    leave;
  endif;

  if Refresh;
    iter;
  endif;

  // Process subfile selections
  ProcessSelections();

enddo;

close PERSONSFL;
*inlr = *on;
return;

// ================================================================
// LoadSubfile - Load initial page of subfile records
// ================================================================
dcl-proc LoadSubfile;
  
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
    select PNAME, PDOB, PADDRESS
    from PERSONTBL
    order by PNAME;
  
  exec sql open C1;
  
  // Load first page
  dow RRN < PageSize and MoreRecords;
    exec sql fetch next from C1 
      into :FetchName, :FetchDOB, :FetchAddress;
    
    if SQLSTATE = '00000';
      RRN += 1;
      LastRRN = RRN;
      SFLSEL = ' ';
      PNAME = FetchName;
      PDOB = FetchDOB;
      PADDRESS = FetchAddress;
      write SFLREC;
    else;
      MoreRecords = *off;
      SflEnd = *on;
    endif;
  enddo;
  
  // Check if more records exist
  if MoreRecords;
    exec sql fetch next from C1 
      into :FetchName, :FetchDOB, :FetchAddress;
    
    if SQLSTATE <> '00000';
      MoreRecords = *off;
      SflEnd = *on;
    else;
      // Put the record back by closing and reopening cursor
      exec sql close C1;
      SflEnd = *off;
    endif;
  endif;
  
  exec sql close C1;
  
  // Display subfile if records exist
  if RRN > 0;
    SflDsp = *on;
    SflDspCtl = *on;
  else;
    SflDsp = *off;
    SflDspCtl = *on;
  endif;
  
end-proc;

// ================================================================
// ProcessSelections - Handle user selections from subfile
// ================================================================
dcl-proc ProcessSelections;
  
  dcl-s CurrentRRN packed(4:0);
  
  CurrentRRN = 1;
  
  dow CurrentRRN <= LastRRN;
    chain CurrentRRN SFLREC;
    
    if %found(PERSONSFL);
      select;
        when SFLSEL = '1';  // Display details
          DisplayDetails();
          SFLSEL = ' ';
          update SFLREC;
      endsl;
    endif;
    
    CurrentRRN += 1;
  enddo;
  
end-proc;

// ================================================================
// DisplayDetails - Show detail screen for selected record
// ================================================================
dcl-proc DisplayDetails;
  
  DNAME = PNAME;
  DDOB = PDOB;
  DADDRESS = PADDRESS;
  
  Cancel = *off;
  
  dow not Cancel;
    write FOOTREC;
    exfmt DETAILREC;
    
    if Cancel;
      leave;
    endif;
  enddo;
  
  Cancel = *off;
  
end-proc;

// ================================================================
// Note: Expanding page logic
// ================================================================
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
// ================================================================