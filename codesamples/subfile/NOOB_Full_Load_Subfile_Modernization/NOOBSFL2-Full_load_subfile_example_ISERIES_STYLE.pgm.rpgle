///
/// Program: NOOBSFL2 - iSeries Style Subfile Tutorial (Mixed Format)
///
/// Description: Educational tutorial demonstrating iSeries-era mixed-format RPG
///              subfile processing. This example shows the transition period when
///              /FREE and /END-FREE blocks were introduced, allowing free-format
///              code within fixed-format programs. Loads 9999 records with counter.
///
/// Purpose: Educational tutorial demonstrating:
///   - Mixed-format RPG (fixed + /FREE blocks)
///   - iSeries transitional coding style
///   - Full-load subfile pattern
///   - Migration from fixed to free format
///   - /FREE and /END-FREE block usage
///   - Subroutine pattern in mixed format
///
/// Features:
///   - Loads exactly 9999 records into subfile
///   - Each record displays incrementing counter (1-9999)
///   - Uses /FREE blocks for mainline code
///   - Mixes fixed and free format syntax
///   - F3=Exit function key support
///   - Page up/down scrolling through records
///
/// Usage: CALL NOOBSFL2
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
///   This is the second in a series of 4 programs showing the evolution from
///   AS/400 fixed-format to modern IBM i free-format RPG:
///   - NOOBSFL1: AS/400 fixed-format
///   - NOOBSFL2: iSeries mixed format (this program)
///   - NOOBSFL3: IBM i full free-format
///   - NOOBSFL4: IBM i BOB style with procedures
///
/// Reference:
/// https://www.nicklitten.com/blog/rpgle-subfile-tutorial/
///
/// Modification History:
///   V.000 2020-01-15 | Nick Litten | Initial creation - iSeries tutorial
///   V.001 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

     * Declare the display file which contains the subfile
     FNOOBDSPF  CF   E             WORKSTN SFILE(SFL01:RRN01)

     /FREE

     * Start of mainline code

     * Execute subroutine to load the subfile
      EXSR #LODSFL;

     * Loop until user press the F3 key
      DOU (*inkc = *on);
     * ExFmt the CONTROL FORMAT of the subfile.
        WRITE CMD01;
        EXFMT CTL01;
      ENDDO;

     * Free up resources and return
      *inlr = *On;
      Return;
     * Subroutine : #LODSFL
     * This subroutine is used to load the subfile with 9999 records.
     * The subroutine is called from the mainline code. The subroutine
     * clears the subfile, increments the RRN, and writes the record
     * to the subfile. The subroutine is called from the mainline code.
      BEGSR #LODSFL;
     * Clear the subfile. Clearing a subfile involves the following four
     * statements.
     * 1. Switch on the SFLCLR indicator
     * 2. Write to the control format
     * 3. Switch off the SFLCLR indicator
     * 4. Reset the RRN to zero (Or one).
     * The fourth statement actually is not related to subfile. However,
     * we generally reset this value while clearing the subfile itself.

     /end-free
     C                   Z-Add     0             RRN01             4 0
     /free

      *In(30) = *On;
      WRITE CTL01;
      *In(30) = *Off;

     * Set a looping condition. This condition may be based on anything.
     * But in any case, just ensure that RRN does not exceed 9999.

      DOW (RRN01 < 9999);
     * Increment the RRN to mark a new record of subfile. Remember that
     * the variable corresponding to RRN should not be less than one (1)
     * and it should never exceed 9999.
       RRN01 += 1;
     * Populate the fields defined in the subfile.
     * For this example simply show the RRN value as it accumulates
       COUNT = RRN01;
     * Perform actual write to the subfile. Notice that each write
     * actually adds a record to the subfile but is not displayed yet
       WRITE SFL01;
      ENDDO;
      ENDSR;