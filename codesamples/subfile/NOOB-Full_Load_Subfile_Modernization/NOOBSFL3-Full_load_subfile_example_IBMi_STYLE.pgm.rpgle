**free

///
/// Program: NOOBSFL3 - IBM i Style Subfile Tutorial (Full Free-Format)
///
/// Description: Educational tutorial demonstrating modern IBM i full free-format
///              RPG subfile processing. This example shows complete conversion to
///              **free format with no fixed-format code remaining. Loads 9999
///              records with incrementing counter using modern RPG syntax.
///
/// Purpose: Educational tutorial demonstrating:
///   - Full free-format RPG (**free)
///   - Modern IBM i coding style
///   - Full-load subfile pattern
///   - Subroutine pattern in free format
///   - Modern built-in functions
///   - Cleaner, more readable syntax
///
/// Features:
///   - Loads exactly 9999 records into subfile
///   - Each record displays incrementing counter (1-9999)
///   - Uses full free-format syntax throughout
///   - Modern Dcl-F and Dcl-S declarations
///   - CLEAR opcode for variable initialization
///   - F3=Exit function key support
///   - Page up/down scrolling through records
///
/// Usage: CALL NOOBSFL3
///
/// Display File: NOOBDSPF
///   - SFL01: Subfile record format
///   - CTL01: Subfile control record
///   - CMD01: Command key record
///   - COUNT: Field displaying counter value
///
/// Indicators:
///   - KC (03): F3=Exit pressed
///   - 30: Clear subfile (SFLCLR)
///
/// Tutorial Notes:
///   This is the third in a series of 4 programs showing the evolution from
///   AS/400 fixed-format to modern IBM i free-format RPG:
///   - NOOBSFL1: AS/400 fixed-format
///   - NOOBSFL2: iSeries mixed format
///   - NOOBSFL3: IBM i full free-format (this program)
///   - NOOBSFL4: IBM i BOB style with procedures
///
/// Reference:
/// https://www.nicklitten.com/blog/rpgle-subfile-tutorial/
///
/// Modification History:
///   V.000 2020-01-15 | Nick Litten | Initial creation - IBM i tutorial
///   V.001 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

ctl-opt
  copyright('NOOBSFL3 | V.001 | IBM i style full free-format subfile tutorial')
  ;

// ------------------------------------------------------------------------------
// File Declarations
// ------------------------------------------------------------------------------
Dcl-F NOOBDSPF WORKSTN SFILE(SFL01:RRN01);

// ------------------------------------------------------------------------------
// Standalone Variables
// ------------------------------------------------------------------------------
Dcl-S RRN01 zoned(4:0);

// ------------------------------------------------------------------------------
// Main Program Logic
// ------------------------------------------------------------------------------

// Start of mainline code
// Execute subroutine to load the subfile
EXSR #LODSFL;

// Loop until user press the F3 key
DOU (*inkc = *on);
   // ExFmt the CONTROL FORMAT of the subfile.
   WRITE CMD01;
   EXFMT CTL01;
ENDDO;

// Free up resources and return
*inlr = *On;
Return;

// ------------------------------------------------------------------------------
// Subroutine: #LODSFL
// Description: Loads the subfile with 9999 records
// ------------------------------------------------------------------------------
BEGSR #LODSFL;
   // Clear the subfile. Clearing a subfile involves the following four
   // statements.
   // 1. Switch on the SFLCLR indicator
   // 2. Write to the control format
   // 3. Switch off the SFLCLR indicator
   // 4. Reset the RRN to zero (Or one).
   // The fourth statement actually is not related to subfile. However,
   // we generally reset this value while clearing the subfile itself.
   clear RRN01;
   *In(30) = *On;
   WRITE CTL01;
   *In(30) = *Off;
   
   // Set a looping condition. This condition may be based on anything.
   // But in any case, just ensure that RRN does not exceed 9999.
   DOW (RRN01 < 9999);
      // Increment the RRN to mark a new record of subfile. Remember that
      // the variable corresponding to RRN should not be less than one (1) a
      // nd it should never exceed 9999.
      RRN01 += 1;
      
      // Populate the fields defined in the subfile.
      // For this example simply show the RRN value as it accumulates
      COUNT = RRN01;
      
      // Perform actual write to the subfile. Notice that each write
      // actually adds a record to the subfile but is not displayed yet
      WRITE SFL01;
   ENDDO;
ENDSR;
