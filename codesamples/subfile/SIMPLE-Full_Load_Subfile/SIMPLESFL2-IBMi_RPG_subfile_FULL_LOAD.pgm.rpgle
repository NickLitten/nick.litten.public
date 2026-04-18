**free

///
/// Program: SIMPLESFL2 - IBM i Style Full Load Subfile Example
///
/// Description: Educational example demonstrating modern free-format RPG subfile
///              processing. This program reads records from SIMPLEFILE and displays
///              them in a full-load subfile using free-format RPG syntax. Shows the
///              evolution from fixed-format (SIMPLESFL1) to free-format coding.
///
/// Purpose: Educational example demonstrating:
///   - Free-format RPG subfile processing
///   - Modern IBM i coding style
///   - Full-load subfile pattern (load all records at once)
///   - Built-in functions (%EOF) instead of indicators
///   - Cleaner, more readable code structure
///
/// Features:
///   - Reads all records from SIMPLEFILE into subfile
///   - Displays up to 9999 records in subfile
///   - Uses modern free-format syntax
///   - %EOF() built-in function for end-of-file detection
///   - F3=Exit function key support
///   - SFLEND indicator when subfile is full
///
/// Usage: CALL SIMPLESFL2
///
/// Display File: SIMPLEDSPF
///   - SFL01: Subfile record format
///   - CTL01: Subfile control record
///   - CMD01: Command key record
///
/// Database File: SIMPLEFILE
///   - Input file containing records to display
///
/// Indicators:
///   - 03: F3=Exit pressed
///   - 30: Clear subfile
///   - 31: Display subfile
///   - 32: Subfile display control
///   - 33: SFLEND (subfile full)
///
/// Note: This is a transitional example showing free-format RPG. For fully
///       modernized code with main() procedure pattern, see SIMPLESFL3.
///
/// Reference:
/// https://www.nicklitten.com/blog/rpgle-subfile-examples/
///
/// Modification History:
///   V.000 1994-05-23 | Nick Litten | Initial creation
///   V.001 2007-10-03 | Nick Litten | Converted to free format RPG
///   V.002 2018-05-25 | Nick Litten | Updated as part of Video RPG Upgrade Tour
///   V.003 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

ctl-opt
  copyright('SIMPLESFL2 | V.003 | IBM i style full load subfile example')
  ;

// ------------------------------------------------------------------------------
// File Declarations
// ------------------------------------------------------------------------------
Dcl-F SIMPLEDSPF WORKSTN SFILE(SFL01:RRN01);
Dcl-F SIMPLEFILE Usage(*Input) Keyed;

// ------------------------------------------------------------------------------
// Standalone Variables
// ------------------------------------------------------------------------------
Dcl-S RRN01 Packed(4:0);
Dcl-S PGMNAME Char(10);

// ------------------------------------------------------------------------------
// Main Program Logic
// ------------------------------------------------------------------------------

// Initialize variables
RRN01 = 0;
PGMNAME = 'SIMPLESFL2';

// Clear the subfile
*In30 = *On;
WRITE CTL01;
*In30 = *Off;

// Load subfile from the file SIMPLEFILE
// Loop until the EOF indicator is ON, or until the SFL maxsize is reached
SETLL *LOVAL SIMPLEFILE;
DOU (%EOF(SIMPLEFILE) OR RRN01 = 9999);
   READ SIMPLEFILE;
   If (not %EOF(SIMPLEFILE));
      RRN01 += 1;
      WRITE SFL01;
   EndIf;
ENDDO;

// If we have read file data then show the SFL and the SFLEND indicator
If (RRN01 > 0);
   *In31 = *On;
   *In33 = *On;
EndIf;

// Display subfile
*In32 = *On;
WRITE CMD01;
Dou (*IN03);
   EXFMT CTL01;
ENDDO;

// Terminate program
*InLR = *On;
Return;
