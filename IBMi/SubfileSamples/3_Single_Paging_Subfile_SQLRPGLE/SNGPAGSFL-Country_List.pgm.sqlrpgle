**free

///
/// Program: SNGPAGSFL - Single Page Subfile for Country Data
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
///   - Resource cleanup and error recovery
///
/// Features:
///   - Single page subfile with 18 records per page
///   - SQL cursor-based pagination for efficient data retrieval
///   - SCROLL cursor with RELATIVE positioning for page navigation
///   - Detail screen for viewing complete country information
///   - Comprehensive error handling and SQL state checking
///   - Page up/down navigation with end-of-file detection
///   - Record count and page number display
///   - Selection option (5=Display) for detail view
///   - Proper resource cleanup on exit
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
/// Usage: CALL SNGPAGSFL
///
/// Display File: SNGPAGSFL.DSPF
///   - SFLCTL: Subfile control record
///   - SFLREC: Subfile detail record (18 records per page)
///   - FOOTER: Footer with function keys
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
///   V.000 2021-01-17 | Nick Litten | Initial creation
///   V.001 2022-02-18 | Nick Litten | Added comprehensive triple-slash documentation
///   V.002 2025-03-08 | Nick Litten | Applied coding standards template
///   V.003 2026-05-17 | Nick Litten | Enhanced error handling, performance, and maintainability
///

ctl-opt
  main(mainline)
  optimize(*full)
  option(*nodebugio:*srcstmt:*nounref)
  pgminfo(*pcml:*module)
  actgrp(*new)
  indent('| ')
  alwnull(*usrctl)
  copyright('SNGPAGSFL | V.003 | Single page subfile for SAMPLEDB table')
  dftactgrp(*no)
  bnddir('QC2LE')
  ;

// --------------------------------------------------------------------------
// File Declarations
// --------------------------------------------------------------------------
dcl-f SNGPAGSFL workstn sfile(SFLREC:RRN) indds(Indicators) usropn;

// --------------------------------------------------------------------------
// Named Constants
// --------------------------------------------------------------------------
Dcl-C SQL_SUCCESS '00000';
Dcl-C SQL_NOT_FOUND '02000';
Dcl-C SQL_NO_DATA '02000';
Dcl-C SELECTION_DISPLAY '5';

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
Dcl-S PageSize packed(4:0) inz(18); // must match the value of SFLPAG in DSPF
Dcl-S PGMNAME char(10) inz('SNGPAGSFL');
Dcl-S USERNAME char(10);
Dcl-S CurrentPage packed(4:0) inz(1);
Dcl-S TotalRecords packed(4:0) inz(0);
Dcl-S TopRRN packed(4:0) inz(1);
Dcl-S DisplayFileOpen ind inz(*off);
Dcl-S ErrorMessage char(256);

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

   Dcl-S ProgramSuccess ind inz(*on);

   exec sql set option commit = *none, closqlcsr = *endmod;

   // Initialize program
   If (not InitializeProgram());
      Return;
   EndIf;

   // Main processing loop
   dow (not Indicators.Exit);

      // Initial load or refresh requested
      If (Indicators.Refresh or RRN = 0);
         CurrentPage = 1;
         TopRRN = 1;
         LoadSubfilePage(PageSize);
         Indicators.Refresh = *off;
      EndIf;

      write FOOTER;
      exfmt SFLCTL;

      Select;
         When (Indicators.Exit);
            leave;

         When (Indicators.Refresh);
            iter;

            // Handle page navigation
         When (Indicators.PageDown) or (Indicators.PageUp);
            HandlePageNavigation();

         Other;
            // Process user selections
            ProcessSelections();
      EndSl;

   enddo;

   // Cleanup and exit
   CleanupProgram();
   *inlr = *on;
   Return;

end-proc;

// --------------------------------------------------------------------------
// Procedure: InitializeProgram
// Description: Initialize program resources and display file
// Returns: *on if successful, *off if error
// --------------------------------------------------------------------------
Dcl-Proc InitializeProgram;

   Dcl-Pi *n ind end-pi;

   // Open display file
   monitor;
      open SNGPAGSFL;
      DisplayFileOpen = *on;
   on-error;
      // Display file open failed
      Return *off;
   endmon;

   SFLRCDNBR = 1;

   // Get current user
   exec sql select current user into :USERNAME from sysibm.sysdummy1;

   If (SQLSTATE <> SQL_SUCCESS);
      USERNAME = '*UNKNOWN';
   EndIf;

   // Get total record count for pagination
   GetTotalRecords();

   Return *on;

end-proc;

// --------------------------------------------------------------------------
// Procedure: CleanupProgram
// Description: Clean up resources before program exit
// --------------------------------------------------------------------------
Dcl-Proc CleanupProgram;

   // Close display file if open
   If (DisplayFileOpen);
      monitor;
         close SNGPAGSFL;
         DisplayFileOpen = *off;
      on-error;
         // Ignore close errors
      endmon;
   EndIf;

end-proc;

// --------------------------------------------------------------------------
// Procedure: HandlePageNavigation
// Description: Process page up/down navigation
// --------------------------------------------------------------------------
Dcl-Proc HandlePageNavigation;

   // Handle page down
   If (Indicators.PageDown);
      If (RRN >= PageSize and not Indicators.SflEnd);
         CurrentPage += 1;
         TopRRN += PageSize;
         LoadSubfilePage(PageSize);
      EndIf;
      Indicators.PageDown = *off;
   EndIf;

   // Handle page up
   If (Indicators.PageUp);
      If (CurrentPage > 1);
         CurrentPage -= 1;
         TopRRN -= PageSize;
         LoadSubfilePage(PageSize);
      EndIf;
      Indicators.PageUp = *off;
   EndIf;

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
// Parameters: p_pagesize - Number of records to load per page
// --------------------------------------------------------------------------
Dcl-Proc LoadSubfilePage;
   Dcl-Pi *n;
      p_pagesize like(PageSize) const;
   end-pi;

   Dcl-S RecordsToSkip packed(4:0);
   Dcl-S RecordsLoaded packed(4:0);
   Dcl-S SQLState_Local char(5);
   Dcl-S CursorOpen ind inz(*off);

   // Clear the subfile
   ClearSubfile();

   RRN = 0;
   RecordsLoaded = 0;
   RecordsToSkip = (CurrentPage - 1) * p_pagesize;

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

   CursorOpen = *on;

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
   dow (RecordsLoaded < p_pagesize);

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
         PopulateSubfileRecord();
         write SFLREC;
      elseif (SQLState_Local = SQL_NOT_FOUND);
         leave;
      Else;
         // Handle other SQL errors
         leave;
      EndIf;

   enddo;

   // Close cursor
   If (CursorOpen);
      exec sql close C1;
   EndIf;

   // Display subfile if records exist
   DisplaySubfile(p_pagesize);

end-proc;

// --------------------------------------------------------------------------
// Procedure: ClearSubfile
// Description: Clear the subfile for new data
// --------------------------------------------------------------------------
Dcl-Proc ClearSubfile;

   Indicators.SflDsp = *off;
   Indicators.SflDspCtl = *on;
   Indicators.SflClr = *on;
   write SFLCTL;
   Indicators.SflClr = *off;

end-proc;

// --------------------------------------------------------------------------
// Procedure: PopulateSubfileRecord
// Description: Populate subfile record fields from fetched data
// --------------------------------------------------------------------------
Dcl-Proc PopulateSubfileRecord;

   clear SFLSEL;
   CCODE = FetchCode;
   CNAME = %trim(FetchName);
   CREGION = %trim(FetchRegion);
   CEUMEM = FetchEUMember;
   CCURR = FetchCurrency;
   CCURNAME = %trim(FetchCurrencyName);

end-proc;

// --------------------------------------------------------------------------
// Procedure: DisplaySubfile
// Description: Set indicators and display the subfile
// Parameters: p_pagesize - Page size for end-of-file calculation
// --------------------------------------------------------------------------
Dcl-Proc DisplaySubfile;
   Dcl-Pi *n;
      p_pagesize like(PageSize) const;
   end-pi;

   If (RRN > 0);
      Indicators.SflDsp = *on;
      Indicators.SflDspCtl = *on;
      Indicators.NoData = *off;

      // Set end of file indicator if we're on the last page
      If ((CurrentPage * p_pagesize) >= TotalRecords);
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
// --------------------------------------------------------------------------
Dcl-Proc ProcessSelections;

   Dcl-S CurrentRRN packed(4:0);

   CurrentRRN = 1;

   dow (CurrentRRN <= RRN);

      chain CurrentRRN SFLREC;

      If (%found(SNGPAGSFL));
         Select;
            When (SFLSEL = SELECTION_DISPLAY);
               DisplayDetails(CCODE);
               clear SFLSEL;
               update SFLREC;
         EndSl;
      EndIf;

      CurrentRRN += 1;

   enddo;

end-proc;

// --------------------------------------------------------------------------
// Procedure: DisplayDetails
// Description: Show detail screen for selected country
// Parameters: pCountryCode - Country code to display details for
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
      PopulateDetailScreen();

      // Display detail screen loop
      Indicators.Cancel = *off;

      dow (not Indicators.Cancel);
         exfmt DETAILREC;

         If (Indicators.Cancel);
            leave;
         EndIf;
      enddo;

   Else;
      // Handle record not found or SQL error
      // In production, would display error message to user
   EndIf;

end-proc;

// --------------------------------------------------------------------------
// Procedure: PopulateDetailScreen
// Description: Populate detail screen fields from fetched data
// --------------------------------------------------------------------------
Dcl-Proc PopulateDetailScreen;

   DCODE = FetchCode;
   DNAME = %trim(FetchName);
   DLOCAL = %trim(FetchNameLocal);
   DCAPITAL = %trim(FetchCapital);
   DREGION = %trim(FetchRegion);
   DPOP = FetchPopulation;
   DAREA = FetchArea;
   DEUMEM = FetchEUMember;

   // Format date for display
   If (FetchEUJoinDate <> *loval);
      JOINDATE = %char(FetchEUJoinDate);
   Else;
      clear JOINDATE;
   EndIf;

   DCURCODE = FetchCurrency;
   DCURNAME = %trim(FetchCurrencyName);

end-proc;