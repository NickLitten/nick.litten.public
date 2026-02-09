**FREE

// Program: NOOBSFL4 - Full Load Subfile Example (IBM i BOB Style)
// Purpose: Demonstrates modern RPG subfile handling with full load
//          of up to 9999 records using best practices
// Author:  IBM Bob
// Date:    2026-02-03
//
// Maintenance Log:
// Date       Developer    Description
// 2026-02-03 IBM Bob      Enhanced with error handling and constants

Ctl-Opt DftActGrp(*No) ActGrp(*New) Option(*SrcStmt:*NoDebugIo);

// Display file declaration with subfile definition
Dcl-F NOOBDSPF WORKSTN SFILE(SFL01:RRN01) IndDs(Indicators);

// Named constants for better maintainability
Dcl-C MAX_SUBFILE_RECORDS 9999;
Dcl-C INDICATOR_EXIT 03;
Dcl-C INDICATOR_SFLCLR 30;
Dcl-C INDICATOR_SFLDSP 31;
Dcl-C INDICATOR_SFLDSPCTL 32;

// Data structure for indicator management
Dcl-Ds Indicators;
  Exit Ind Pos(INDICATOR_EXIT);
  SflClr Ind Pos(INDICATOR_SFLCLR);
  SflDsp Ind Pos(INDICATOR_SFLDSP);
  SflDspCtl Ind Pos(INDICATOR_SFLDSPCTL);
End-Ds;

// Subfile relative record number
Dcl-S RRN01 Packed(4:0);

// Return code for error handling
Dcl-S ReturnCode Ind Inz(*Off);
// Main Processing Logic
// Initialize and load the subfile
ReturnCode = LoadSubfile();

If ReturnCode;
  // Display subfile and process user interaction
  ProcessUserInput();
Else;
  // Handle load failure (could send message to user)
  // In production, you might call SNDPGMMSG or similar
EndIf;

// Clean termination
*InLr = *On;
Return;
// Procedure: LoadSubfile
// Purpose:   Clears and loads the subfile with records
// Returns:   *On if successful, *Off if error occurred
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
    If %Error;
      Success = *Off;
      Leave;
    EndIf;
    
    RRN01 = RecordCount;
  EndDow;
  
  // Enable subfile display if records were loaded
  If RecordCount > 0;
    SflDsp = *On;
    SflDspCtl = *On;
  EndIf;
  
  Return Success;
End-Proc;
// Procedure: ClearSubfile
// Purpose:   Clears all records from the subfile
// Notes:     Uses standard 4-step subfile clear process
Dcl-Proc ClearSubfile;
  // Step 1: Reset RRN to zero
  RRN01 = 0;
  
  // Step 2: Turn on SFLCLR indicator
  SflClr = *On;
  
  // Step 3: Write control record to clear subfile
  Write CTL01;
  
  // Step 4: Turn off SFLCLR indicator
  SflClr = *Off;
  
  // Turn off display indicators for clean state
  SflDsp = *Off;
  SflDspCtl = *Off;
End-Proc;
// Procedure: ProcessUserInput
// Purpose:   Handles user interaction with the subfile
// Notes:     Loops until F3 (Exit) is pressed
Dcl-Proc ProcessUserInput;
  // Display loop - continue until user presses F3
  Dow Not Exit;
    // Write command key line
    Write CMD01;
    
    // Display subfile control format and wait for input
    ExFmt CTL01;
    
    // Process function keys or subfile options here
    // (In a real application, you would check for other
    // function keys and process subfile option fields)
    
    If Exit;
      Leave;
    EndIf;
  EndDow;
End-Proc;