**free

///
/// Program: SIMPLESFL3 - Modern IBM i BOB Style Full Load Subfile
///
/// Description: Educational example demonstrating fully modernized RPGLE subfile
///              processing with best practices. This program reads records from
///              SIMPLEFILE and displays them in a full-load subfile using modern
///              RPG patterns including main() procedure, qualified data structures,
///              proper error handling, and modular design.
///
/// Purpose: Educational example demonstrating:
///   - Modern main() procedure pattern
///   - Qualified indicator data structure
///   - Modular procedure-based design
///   - Proper error handling with MONITOR/ON-ERROR
///   - Resource management (file opening/closing)
///   - Named constants instead of magic numbers
///   - Self-documenting code with descriptive names
///
/// Features:
///   - Main procedure eliminates RPG cycle overhead
///   - Qualified indicators for better readability
///   - Separate procedures for each logical function
///   - Comprehensive error handling
///   - Proper resource cleanup
///   - User-controlled file opening (UsrOpn)
///   - Maximum subfile size as named constant
///   - F3=Exit function key support
///
/// Usage: CALL SIMPLESFL3
///
/// Display File: SIMPLEDSPF
///   - SFL01: Subfile record format
///   - CTL01: Subfile control record
///   - CMD01: Command key record
///
/// Database File: SIMPLEFILE
///   - Input file containing records to display
///
/// Procedures:
///   - mainline: Main program entry point
///   - InitializeProgram: Opens files and initializes program state
///   - LoadSubfile: Loads records from database into subfile
///   - ClearSubfile: Clears all subfile records
///   - DisplaySubfile: Displays subfile and handles user interaction
///   - CleanupProgram: Closes files and releases resources
///
/// Reference:
/// https://www.nicklitten.com/blog/rpgle-subfile-examples/
///
/// Modification History:
///   V.000 1994-05-23 | Nick Litten | Initial creation
///   V.001 2007-10-03 | Nick Litten | Converted to free format RPG
///   V.002 2018-05-25 | Nick Litten | Updated as part of Video RPG Upgrade Tour
///   V.003 2026-02-03 | Bob AI | Enhanced with modern practices and error handling
///   V.004 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

ctl-opt
  main(mainline)
  dftactgrp(*no)
  actgrp(*caller)
  option(*srcstmt:*nodebugio)
  copyright('SIMPLESFL3 | V.004 | Modern IBM i BOB style full load subfile')
  ;

// ------------------------------------------------------------------------------
// File Declarations
// ------------------------------------------------------------------------------
Dcl-F SIMPLEDSPF WORKSTN SFILE(SFL01:RRN01) IndDs(Indicators) UsrOpn;
Dcl-F SIMPLEFILE Usage(*Input) Keyed UsrOpn;

// ------------------------------------------------------------------------------
// Named Constants
// ------------------------------------------------------------------------------
Dcl-C MAX_SUBFILE_SIZE 9999;

// ------------------------------------------------------------------------------
// Data Structures
// ------------------------------------------------------------------------------

// Indicator data structure for better readability
Dcl-Ds Indicators Qualified;
   Exit            Ind Pos(03);  // F3=Exit
   SflClr          Ind Pos(30);  // Clear subfile
   SflDsp          Ind Pos(31);  // Display subfile
   SflDspCtl       Ind Pos(32);  // Display subfile control
   SflEnd          Ind Pos(33);  // Subfile end (more records)
End-Ds;

// ------------------------------------------------------------------------------
// Standalone Variables
// ------------------------------------------------------------------------------
Dcl-S RRN01         Packed(4:0) Inz(0);
Dcl-S PGMNAME       Char(10)    Inz('SIMPLESFL3');
Dcl-S FileOpened    Ind         Inz(*Off);
Dcl-S ErrorOccurred Ind         Inz(*Off);

// ------------------------------------------------------------------------------
// Main Program Logic
// ------------------------------------------------------------------------------
Dcl-Proc mainline;

   // Initialize program
   If (InitializeProgram());
      // Load and display subfile
      LoadSubfile();
      DisplaySubfile();
    
      // Cleanup
      CleanupProgram();
   Else;
      // Error during initialization - exit gracefully
      ErrorOccurred = *On;
   EndIf;

   *InLR = *On;
   Return;

End-Proc;

// ------------------------------------------------------------------------------
// Procedure: InitializeProgram
// Description: Opens files and initializes program state
// Returns: *On if successful, *Off if error
// ------------------------------------------------------------------------------
Dcl-Proc InitializeProgram;
   Dcl-Pi *N Ind End-Pi;
  
   Dcl-S Success Ind Inz(*On);
  
   // Open display file
   Monitor;
      Open SIMPLEDSPF;
      FileOpened = *On;
   On-Error;
      Success = *Off;
   EndMon;
  
   // Open data file if display file opened successfully
   If (Success);
      Monitor;
         Open SIMPLEFILE;
      On-Error;
         Success = *Off;
         // Close display file if data file fails to open
         If (FileOpened);
            Close SIMPLEDSPF;
            FileOpened = *Off;
         EndIf;
      EndMon;
   EndIf;
  
   Return Success;
End-Proc;

// ------------------------------------------------------------------------------
// Procedure: LoadSubfile
// Description: Loads records from SIMPLEFILE into subfile
// ------------------------------------------------------------------------------
Dcl-Proc LoadSubfile;
  
   // Clear the subfile before loading
   ClearSubfile();
  
   // Position to beginning of file
   SetLL *LoVal SIMPLEFILE;
  
   // Read and load records until EOF or max size reached
   DoU (%Eof(SIMPLEFILE) Or RRN01 >= MAX_SUBFILE_SIZE);
      Read SIMPLEFILE;
    
      If (Not %Eof(SIMPLEFILE));
         RRN01 += 1;
         Write SFL01;
      EndIf;
   EndDo;
  
   // Set indicators based on records loaded
   If (RRN01 > 0);
      Indicators.SflDsp = *On;      // Display subfile
      Indicators.SflEnd = *On;      // Show end of subfile
   Else;
      Indicators.SflDsp = *Off;     // No records to display
      Indicators.SflEnd = *Off;
   EndIf;
  
End-Proc;

// ------------------------------------------------------------------------------
// Procedure: ClearSubfile
// Description: Clears all records from the subfile
// ------------------------------------------------------------------------------
Dcl-Proc ClearSubfile;
  
   Indicators.SflClr = *On;
   Write CTL01;
   Indicators.SflClr = *Off;
   RRN01 = 0;
  
End-Proc;

// ------------------------------------------------------------------------------
// Procedure: DisplaySubfile
// Description: Displays subfile and handles user interaction
// ------------------------------------------------------------------------------
Dcl-Proc DisplaySubfile;
  
   // Display subfile control and command key area
   Indicators.SflDspCtl = *On;
   Write CMD01;
  
   // Main display loop - continue until F3=Exit
   DoU (Indicators.Exit);
      ExFmt CTL01;
    
      // Process user selections here if needed
      // (e.g., option processing, refresh, etc.)
    
   EndDo;
  
End-Proc;

// ------------------------------------------------------------------------------
// Procedure: CleanupProgram
// Description: Closes files and releases resources
// ------------------------------------------------------------------------------
Dcl-Proc CleanupProgram;
  
   // Close files if they were opened
   Monitor;
      If (FileOpened);
         Close SIMPLEDSPF;
      EndIf;
      Close SIMPLEFILE;
   On-Error;
      // Ignore errors during cleanup
   EndMon;
  
End-Proc;
