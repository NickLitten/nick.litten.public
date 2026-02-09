**FREE

// Program: SIMPLESFL3
// Description: Demonstrates full-load subfile processing in modern RPGLE
//              Reads SIMPLEFILE and displays records in a subfile with
//              proper error handling and best practices
//
// MODIFICATION HISTORY:
// Date       Author      Description
// 1994.05.23 Nick Litten V1.0 Created
// 2007.10.03 njl         Converted to free format RPG
// 2018.05.25 njl         Updated as part of Video RPG Upgrade Tour
// 2026.02.03 IBM Bob     Enhanced with modern practices and error handling


// Control Options
Ctl-Opt DftActGrp(*No) ActGrp(*Caller) Option(*SrcStmt:*NoDebugIO);

// File Declarations

Dcl-F SIMPLEDSPF WORKSTN SFILE(SFL01:RRN01) IndDs(Indicators) UsrOpn;
Dcl-F SIMPLEFILE Usage(*Input) Keyed UsrOpn;

// Data Structures


// Indicator Data Structure for better readability
Dcl-Ds Indicators;
  Exit            Ind Pos(03);  // F3=Exit
  SflClr          Ind Pos(30);  // Clear subfile
  SflDsp          Ind Pos(31);  // Display subfile
  SflDspCtl       Ind Pos(32);  // Display subfile control
  SflEnd          Ind Pos(33);  // Subfile end (more records)
End-Ds;

// Standalone Variables

Dcl-S RRN01         Packed(4:0) Inz(0);     // Subfile relative record number
Dcl-S PGMNAME       Char(10)    Inz('SIMPLESFL3');
Dcl-S MaxSflSize    Packed(4:0) Inz(9999);  // Maximum subfile size
Dcl-S FileOpened    Ind         Inz(*Off);  // Track if files are opened
Dcl-S ErrorOccurred Ind         Inz(*Off);  // Error flag

// Main Processing


// Initialize program
If InitializeProgram();
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

// Procedures


// InitializeProgram: Open files and initialize program state
// Returns: *On if successful, *Off if error

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
  If Success;
    Monitor;
      Open SIMPLEFILE;
    On-Error;
      Success = *Off;
      // Close display file if data file fails to open
      If FileOpened;
        Close SIMPLEDSPF;
        FileOpened = *Off;
      EndIf;
    EndMon;
  EndIf;
  
  Return Success;
End-Proc;

// LoadSubfile: Load records from SIMPLEFILE into subfile

Dcl-Proc LoadSubfile;
  
  // Clear the subfile before loading
  ClearSubfile();
  
  // Position to beginning of file
  SetLL *LoVal SIMPLEFILE;
  
  // Read and load records until EOF or max size reached
  DoU %Eof(SIMPLEFILE) Or RRN01 >= MaxSflSize;
    Read SIMPLEFILE;
    
    If Not %Eof(SIMPLEFILE);
      RRN01 += 1;
      Write SFL01;
    EndIf;
  EndDo;
  
  // Set indicators based on records loaded
  If RRN01 > 0;
    SflDsp = *On;      // Display subfile
    SflEnd = *On;      // Show end of subfile
  Else;
    SflDsp = *Off;     // No records to display
    SflEnd = *Off;
  EndIf;
  
End-Proc;

// ClearSubfile: Clear all records from the subfile

Dcl-Proc ClearSubfile;
  
  SflClr = *On;
  Write CTL01;
  SflClr = *Off;
  RRN01 = 0;
  
End-Proc;

// DisplaySubfile: Display subfile and handle user interaction

Dcl-Proc DisplaySubfile;
  
  // Display subfile control and command key area
  SflDspCtl = *On;
  Write CMD01;
  
  // Main display loop - continue until F3=Exit
  DoU Exit;
    ExFmt CTL01;
    
    // Process user selections here if needed
    // (e.g., option processing, refresh, etc.)
    
  EndDo;
  
End-Proc;

// CleanupProgram: Close files and cleanup resources

Dcl-Proc CleanupProgram;
  
  // Close files if they were opened
  Monitor;
    If FileOpened;
      Close SIMPLEDSPF;
    EndIf;
    Close SIMPLEFILE;
  On-Error;
    // Ignore errors during cleanup
  EndMon;
  
End-Proc;
