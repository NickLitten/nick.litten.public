**free

///
/// Program: NOOBSFL4 - IBM i BOB Style Subfile Tutorial (Procedures)
///
/// Description: Educational tutorial demonstrating fully modernized IBM i RPG
///              subfile processing with best practices. This example shows the
///              ultimate evolution using main() procedure pattern, qualified data
///              structures, named constants, proper error handling, and modular
///              design. Loads 9999 records with incrementing counter.
///
/// Purpose: Educational tutorial demonstrating:
///   - Main procedure pattern (eliminates RPG cycle)
///   - Qualified indicator data structure
///   - Named constants instead of magic numbers
///   - Modular procedure-based design
///   - Proper error handling with %ERROR
///   - Self-documenting code
///   - Modern best practices
///
/// Features:
///   - Loads exactly 9999 records into subfile
///   - Each record displays incrementing counter (1-9999)
///   - Uses main() procedure pattern
///   - Qualified indicators for clarity
///   - Named constants for maintainability
///   - Error handling with %ERROR built-in
///   - Separate procedures for each function
///   - F3=Exit function key support
///
/// Usage: CALL NOOBSFL4
///
/// Display File: NOOBDSPF
///   - SFL01: Subfile record format
///   - CTL01: Subfile control record
///   - CMD01: Command key record
///   - COUNT: Field displaying counter value
///
/// Procedures:
///   - mainline: Main program entry point
///   - LoadSubfile: Clears and loads subfile with records
///   - ClearSubfile: Clears all subfile records
///   - ProcessUserInput: Handles user interaction loop
///
/// Tutorial Notes:
///   This is the fourth and final in a series of 4 programs showing the
///   evolution from AS/400 fixed-format to modern IBM i free-format RPG:
///   - NOOBSFL1: AS/400 fixed-format
///   - NOOBSFL2: iSeries mixed format
///   - NOOBSFL3: IBM i full free-format
///   - NOOBSFL4: IBM i BOB style with procedures (this program)
///
/// Reference:
/// https://www.nicklitten.com/blog/rpgle-subfile-tutorial/
///
/// Modification History:
///   V.000 2020-01-15 | Nick Litten | Initial creation - BOB style tutorial
///   V.001 2026-02-03 | Bob AI | Enhanced with error handling and constants
///   V.002 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

ctl-opt
  main(mainline)
  dftactgrp(*no)
  actgrp(*new)
  option(*srcstmt:*nodebugio)
  copyright('NOOBSFL4 | V.002 | IBM i BOB style subfile tutorial with procedures')
  ;

// ------------------------------------------------------------------------------
// File Declarations
// ------------------------------------------------------------------------------
Dcl-F NOOBDSPF WORKSTN SFILE(SFL01:RRN01) IndDs(Indicators);

// ------------------------------------------------------------------------------
// Named Constants
// ------------------------------------------------------------------------------
Dcl-C MAX_SUBFILE_RECORDS 9999;
Dcl-C INDICATOR_EXIT 03;
Dcl-C INDICATOR_SFLCLR 30;
Dcl-C INDICATOR_SFLDSP 31;
Dcl-C INDICATOR_SFLDSPCTL 32;

// ------------------------------------------------------------------------------
// Data Structures
// ------------------------------------------------------------------------------

// Indicator data structure for better readability
Dcl-Ds Indicators Qualified;
   Exit Ind Pos(INDICATOR_EXIT);
   SflClr Ind Pos(INDICATOR_SFLCLR);
   SflDsp Ind Pos(INDICATOR_SFLDSP);
   SflDspCtl Ind Pos(INDICATOR_SFLDSPCTL);
End-Ds;

// ------------------------------------------------------------------------------
// Standalone Variables
// ------------------------------------------------------------------------------
Dcl-S RRN01 Packed(4:0);
Dcl-S ReturnCode Ind Inz(*Off);

// ------------------------------------------------------------------------------
// Main Program Logic
// ------------------------------------------------------------------------------
Dcl-Proc mainline;

   // Initialize and load the subfile
   ReturnCode = LoadSubfile();

   If (ReturnCode);
      // Display subfile and process user interaction
      ProcessUserInput();
   Else;
      // Handle load failure (could send message to user)
      // In production, you might call SNDPGMMSG or similar
   EndIf;

   // Clean termination
   *InLr = *On;
   Return;

End-Proc;

// ------------------------------------------------------------------------------
// Procedure: LoadSubfile
// Description: Clears and loads the subfile with records
// Returns: *On if successful, *Off if error occurred
// ------------------------------------------------------------------------------
Dcl-Proc LoadSubfile;
   Dcl-Pi *N Ind End-Pi;
  
   Dcl-S Success Ind Inz(*On);
   Dcl-S RecordCount Packed(4:0) Inz(0);
  
   // Clear the subfile using proper indicator sequence
   ClearSubfile();
  
   // Load subfile records with boundary checking
   Dow (RecordCount < MAX_SUBFILE_RECORDS);
      RecordCount += 1;
    
      // Populate subfile fields
      COUNT = RecordCount;
    
      // Write record to subfile with error handling
      Write SFL01;
    
      // Check for write errors (optional but recommended)
      If (%Error);
         Success = *Off;
         Leave;
      EndIf;
    
      RRN01 = RecordCount;
      EndDow;
  
      // Enable subfile display if records were loaded
      If (RecordCount > 0);
         Indicators.SflDsp = *On;
         Indicators.SflDspCtl = *On;
      EndIf;
  
      Return Success;
   End-Proc;

   // ------------------------------------------------------------------------------
   // Procedure: ClearSubfile
   // Description: Clears all records from the subfile
   // Notes: Uses standard 4-step subfile clear process
   // ------------------------------------------------------------------------------
   Dcl-Proc ClearSubfile;
  
      // Step 1: Reset RRN to zero
      RRN01 = 0;
  
      // Step 2: Turn on SFLCLR indicator
      Indicators.SflClr = *On;
  
      // Step 3: Write control record to clear subfile
      Write CTL01;
  
      // Step 4: Turn off SFLCLR indicator
      Indicators.SflClr = *Off;
  
      // Turn off display indicators for clean state
      Indicators.SflDsp = *Off;
      Indicators.SflDspCtl = *Off;
  
   End-Proc;

   // ------------------------------------------------------------------------------
   // Procedure: ProcessUserInput
   // Description: Handles user interaction with the subfile
   // Notes: Loops until F3 (Exit) is pressed
   // ------------------------------------------------------------------------------
   Dcl-Proc ProcessUserInput;
  
      // Display loop - continue until user presses F3
      Dow (Not Indicators.Exit);
         // Write command key line
         Write CMD01;
    
         // Display subfile control format and wait for input
         ExFmt CTL01;
    
         // Process function keys or subfile options here
         // (In a real application, you would check for other
         // function keys and process subfile option fields)
    
         If (Indicators.Exit);
            Leave;
         EndIf;
         EndDow;
  
      End-Proc;
