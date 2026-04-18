**free

///
/// Program: SAMPLESFL - Single Page Subfile for Country Data
///
/// Description: Displays European country information in a single-page subfile
///              format with the ability to view detailed information for each
///              country. Uses SQL cursor-based pagination for efficient data
///              retrieval from the SAMPLEDB table.
///
/// Purpose: Educational example demonstrating:
///   - Single-page subfile implementation with SQL
///   - SQL cursor operations with SCROLL and RELATIVE positioning
///   - Efficient pagination without loading entire dataset
///   - Detail screen navigation pattern
///   - Proper SQL state checking and error handling
///   - Modern RPG subfile best practices
///
/// Features:
///   - Single page subfile with 20 records per page
///   - SQL cursor-based pagination for efficient data retrieval
///   - SCROLL cursor with RELATIVE positioning for page navigation
///   - Detail screen for viewing complete country information
///   - Proper error handling and SQL state checking
///   - Page up/down navigation with end-of-file detection
///   - Record count and page number display
///   - Selection option (5=Display) for detail view
///
/// Control Options:
///   - main(mainline): Eliminates RPG cycle overhead
///   - optimize(*full): Maximum optimization
///   - option(*nodebugio:*srcstmt:*nounref): Debug and compile options
///   - pgminfo(*pcml:*module): Embeds parameter metadata
///   - actgrp(*new): New activation group for clean execution
///   - indent('| '): Code indentation character
///   - alwnull(*usrctl): Allow null-capable fields
///
/// SQL Options:
///   - commit(*none): No commitment control
///   - closqlcsr(*endmod): Close cursors at module end
///
/// Usage: CALL SAMPLESFL
///
/// Display File: SAMPLESFL.DSPF
///   - SFLCTL: Subfile control record
///   - SFLREC: Subfile detail record (20 records per page)
///   - FOOTREC: Footer with function keys
///   - DETAILREC: Detail display record
///
/// Database: SAMPLEDB table
///   - Contains European country information
///   - Fields: Country code, name, region, EU membership, currency, etc.
///
/// Function Keys:
///   - F3: Exit program
///   - F5: Refresh display
///   - F12: Cancel/Return from detail
///   - PageUp: Previous page
///   - PageDown: Next page
///
/// Reference:
/// https://www.nicklitten.com/ibm-i-rpg-subfile-single-page-sql-example
///
/// Modification History:
///   V.000 2026-04-17 | Nick Litten | Initial creation
///   V.001 2026-04-18 | Bob AI | Added comprehensive triple-slash documentation
///   V.002 2026-04-18 | Bob AI | Applied coding standards template
///

ctl-opt
  main(mainline)
  optimize(*full)
  option(*nodebugio:*srcstmt:*nounref)
  pgminfo(*pcml:*module)
  actgrp(*new)
  indent('| ')
  alwnull(*usrctl)
  copyright('SAMPLESFL | V.002 | Single page subfile for SAMPLEDB table')
  ;

// --------------------------------------------------------------------------
// File Declarations
// --------------------------------------------------------------------------
dcl-f SAMPLESFL workstn sfile(SFLREC:RRN) indds(Indicators) usropn;

// --------------------------------------------------------------------------
// Named Constants
// --------------------------------------------------------------------------
Dcl-C PAGE_SIZE 20;
Dcl-C SQL_SUCCESS '00000';
Dcl-C SQL_NOT_FOUND '02000';
Dcl-C SELECTION_DISPLAY '5';
Dcl-C BLANK ' ';

// --------------------------------------------------------------------------
// Data Structures
// --------------------------------------------------------------------------
Dcl-Ds Indicators qualified;
   Exit ind pos(3);
   Refresh ind pos(5);
   Cancel ind pos(12);
   PageDown ind pos(25);
   PageUp ind pos(26);
   NoData ind pos(70);
   SflDsp ind pos(91);
   SflDspCtl ind pos(92);
   SflClr ind pos(93);
   SflEnd ind pos(94);
end-ds;

// --------------------------------------------------------------------------
// Standalone Variables - Display Control
// --------------------------------------------------------------------------
Dcl-S RRN packed(4:0);
Dcl-S PGMNAME char(10);
Dcl-S USERNAME char(10);
Dcl-S CurrentPage packed(4:0) inz(1);
Dcl-S TotalRecords packed(4:0) inz(0);
Dcl-S TopRRN packed(4:0) inz(1);

// --------------------------------------------------------------------------
// SQL Variables for Cursor Operations
// --------------------------------------------------------------------------
Dcl-S FetchCode char(2);
Dcl-S FetchName varchar(100);
Dcl-S FetchRegion varchar(50);
Dcl-S FetchEUMember char(1);
Dcl-S FetchCurrency char(3);
Dcl-S FetchPopulation packed(12:0);
Dcl-S FetchNameLocal varchar(100);
Dcl-S FetchCapital varchar(100);
Dcl-S FetchArea packed(12:2);
Dcl-S FetchEUJoinDate date;
Dcl-S FetchCurrencyName varchar(50);

// --------------------------------------------------------------------------
// Main Program Logic
// --------------------------------------------------------------------------
Dcl-Proc mainline;
   
   exec sql set option commit = *none, closqlcsr = *endmod;
   
   open SAMPLESFL;
   
   PGMNAME = 'SAMPLESFL';
   SFLRCDNBR = 1;
   
   // Get current user
   exec sql select current user into :USERNAME from sysibm.sysdummy1;
   
   // Get total record count for pagination
   GetTotalRecords();
   
   dow (not Indicators.Exit);
      
      // Initial load or refresh requested
      If (Indicators.Refresh or RRN = 0);
         CurrentPage = 1;
         TopRRN = 1;
         LoadSubfilePage();
         Indicators.Refresh = *off;
      EndIf;
      
      write FOOTREC;
      exfmt SFLCTL;
      
      If (Indicators.Exit);
         leave;
      EndIf;
      
      If (Indicators.Refresh);
         iter;
      EndIf;
      
      // Handle page navigation
      If (Indicators.PageDown);
         If (RRN >= PAGE_SIZE and not Indicators.SflEnd);
            CurrentPage += 1;
            TopRRN += PAGE_SIZE;
            LoadSubfilePage();
         EndIf;
         Indicators.PageDown = *off;
      EndIf;
      
      If (Indicators.PageUp);
         If (CurrentPage > 1);
            CurrentPage -= 1;
            TopRRN -= PAGE_SIZE;
            LoadSubfilePage();
         EndIf;
         Indicators.PageUp = *off;
      EndIf;
      
      // Process user selections
      ProcessSelections();
      
   enddo;
   
   close SAMPLESFL;
   *inlr = *on;
   Return;
   
end-proc;

// --------------------------------------------------------------------------
// Procedure: GetTotalRecords
// Description: Get total count of records for pagination
// --------------------------------------------------------------------------
Dcl-Proc GetTotalRecords;
   
   exec sql 
      select count(*) 
      into :TotalRecords
      from SAMPLEDB;
   
   // Handle SQL errors
   If (SQLSTATE <> SQL_SUCCESS);
      TotalRecords = 0;
   EndIf;
   
end-proc;

// --------------------------------------------------------------------------
// Procedure: LoadSubfilePage
// Description: Load one page of country records into subfile
// Parameters: None (uses global variables)
// --------------------------------------------------------------------------
Dcl-Proc LoadSubfilePage;
   
   Dcl-S RecordsToSkip packed(4:0);
   Dcl-S RecordsLoaded packed(4:0);
   Dcl-S SQLState_Local char(5);
   
   // Clear the subfile
   Indicators.SflDsp = *off;
   Indicators.SflDspCtl = *on;
   Indicators.SflClr = *on;
   write SFLCTL;
   Indicators.SflClr = *off;
   
   RRN = 0;
   RecordsLoaded = 0;
   RecordsToSkip = (CurrentPage - 1) * PAGE_SIZE;
   
   // Declare scrollable cursor with optimized column selection
   exec sql 
      declare C1 scroll cursor for
      select 
         COUNTRY_CODE,
         COUNTRY_NAME,
         REGION,
         EU_MEMBER,
         CURRENCY_CODE,
         CURRENCY_NAME
      from SAMPLEDB
      order by COUNTRY_NAME;
   
   exec sql open C1;
   
   // Check for cursor open errors
   If (SQLSTATE <> SQL_SUCCESS);
      Indicators.NoData = *on;
      Return;
   EndIf;
   
   // Skip to the correct page position using RELATIVE positioning
   If (RecordsToSkip > 0);
      exec sql 
         fetch relative :RecordsToSkip from C1
         into :FetchCode,
              :FetchName,
              :FetchRegion,
              :FetchEUMember,
              :FetchCurrency,
              :FetchCurrencyName;
   EndIf;
   
   // Load one page of records
   dow (RecordsLoaded < PAGE_SIZE);
      
      exec sql 
         fetch next from C1
         into :FetchCode,
              :FetchName,
              :FetchRegion,
              :FetchEUMember,
              :FetchCurrency,
              :FetchCurrencyName;
      
      SQLState_Local = SQLSTATE;
      
      If (SQLState_Local = SQL_SUCCESS);
         RRN += 1;
         RecordsLoaded += 1;
         SFLSEL = BLANK;
         CCODE = FetchCode;
         CNAME = %subst(FetchName : 1 : %len(FetchName));
         CREGION = %subst(FetchRegion : 1 : %len(FetchRegion));
         CEUMEM = FetchEUMember;
         CCURR = FetchCurrency;
         CCURNAME = %subst(FetchCurrencyName : 1 : %len(FetchCurrencyName));
         write SFLREC;
      elseif (SQLState_Local = SQL_NOT_FOUND);
         leave;
      Else;
         // Handle other SQL errors
         leave;
      EndIf;
      
   enddo;
   
   exec sql close C1;
   
   // Display subfile if records exist
   If (RRN > 0);
      Indicators.SflDsp = *on;
      Indicators.SflDspCtl = *on;
      Indicators.NoData = *off;
      
      // Set end of file indicator if we're on the last page
      If ((CurrentPage * PAGE_SIZE) >= TotalRecords);
         Indicators.SflEnd = *on;
      Else;
         Indicators.SflEnd = *off;
      EndIf;
      
      RECCOUNT = TotalRecords;
      SFLPGM = CurrentPage;
   Else;
      Indicators.SflDsp = *off;
      Indicators.SflDspCtl = *on;
      Indicators.NoData = *on;
      RECCOUNT = 0;
   EndIf;
   
end-proc;

// --------------------------------------------------------------------------
// Procedure: ProcessSelections
// Description: Handle user selections from subfile
// Parameters: None (uses global variables)
// --------------------------------------------------------------------------
Dcl-Proc ProcessSelections;
   
   Dcl-S CurrentRRN packed(4:0);
   
   CurrentRRN = 1;
   
   dow (CurrentRRN <= RRN);
      
      chain CurrentRRN SFLREC;
      
      If (%found(SAMPLESFL));
         Select;
            When (SFLSEL = SELECTION_DISPLAY);
               DisplayDetails(CCODE);
               SFLSEL = BLANK;
               update SFLREC;
         EndSl;
      EndIf;
      
      CurrentRRN += 1;
      
   enddo;
   
end-proc;

// --------------------------------------------------------------------------
// Procedure: DisplayDetails
// Description: Show detail screen for selected country
// Parameters:
//   - pCountryCode: Country code to display details for
// --------------------------------------------------------------------------
Dcl-Proc DisplayDetails;
   
   Dcl-Pi *n;
      pCountryCode char(2) const;
   end-pi;
   
   Dcl-S SQLState_Local char(5);
   
   // Fetch complete country details
   exec sql 
      select 
         COUNTRY_CODE,
         COUNTRY_NAME,
         COUNTRY_NAME_LOCAL,
         CAPITAL_CITY,
         REGION,
         POPULATION,
         AREA_KM2,
         EU_MEMBER,
         EU_JOIN_DATE,
         CURRENCY_CODE,
         CURRENCY_NAME
      into 
         :FetchCode,
         :FetchName,
         :FetchNameLocal,
         :FetchCapital,
         :FetchRegion,
         :FetchPopulation,
         :FetchArea,
         :FetchEUMember,
         :FetchEUJoinDate,
         :FetchCurrency,
         :FetchCurrencyName
      from SAMPLEDB
      where COUNTRY_CODE = :pCountryCode;
   
   SQLState_Local = SQLSTATE;
   
   If (SQLState_Local = SQL_SUCCESS);
      
      // Populate detail screen fields
      DCODE = FetchCode;
      DNAME = FetchName;
      DLOCAL = FetchNameLocal;
      DCAPITAL = FetchCapital;
      DREGION = FetchRegion;
      DPOP = FetchPopulation;
      DAREA = FetchArea;
      DEUMEM = FetchEUMember;
      JOINDATE = %char(FetchEUJoinDate);
      
      DCURCODE = FetchCurrency;
      DCURNAME = FetchCurrencyName;
      
      Indicators.Cancel = *off;
      
      dow (not Indicators.Cancel);
         exfmt DETAILREC;
         
         If (Indicators.Cancel);
            leave;
         EndIf;
      enddo;
      
   Else;
      // Handle record not found or SQL error
      // Could add error message display here
   EndIf;
   
end-proc;