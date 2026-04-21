///
/// Program: NOOBSFL1 - AS/400 Style Subfile Tutorial (9999 Records)
///
/// Description: Educational tutorial demonstrating traditional AS/400 fixed-format
///              RPG subfile processing. This beginner-friendly example loads a
///              subfile with 9999 records, each displaying an incrementing counter
///              value. Intentionally preserved in fixed format to show legacy style.
///
/// Purpose: Educational tutorial demonstrating:
///   - Fixed-format RPG IV subfile basics
///   - Traditional AS/400 coding style
///   - Full-load subfile pattern (all records at once)
///   - Classic subroutine usage (BEGSR/ENDSR)
///   - Four-step subfile clearing process
///   - Indicator-based control (*IN30, *INKC)
///
/// Features:
///   - Loads exactly 9999 records into subfile
///   - Each record displays incrementing counter (1-9999)
///   - Uses traditional subroutine pattern
///   - Classic four-step subfile clear process
///   - F3=Exit function key support
///   - Page up/down scrolling through records
///
/// Usage: CALL NOOBSFL1
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
///   This is the first in a series of 4 programs showing the evolution from
///   AS/400 fixed-format to modern IBM i free-format RPG:
///   - NOOBSFL1: AS/400 fixed-format (this program)
///   - NOOBSFL2: iSeries mixed format (/FREE blocks)
///   - NOOBSFL3: IBM i full free-format
///   - NOOBSFL4: IBM i BOB style with procedures
///
/// Reference:
/// https://www.nicklitten.com/blog/rpgle-subfile-tutorial/
///
/// Modification History:
///   V.000 2020-01-15 | Nick Litten | Initial creation - AS/400 tutorial
///   V.001 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

     * Declare the display file which contains the subfile
     FNOOBDSPF  CF   E             WORKSTN SFILE(SFL01:RRN01)
     * Start of mainline code
     * Execute subroutine to load the subfile
     C                   ExSr      #LodSfl
     * Loop until user press the F3 key
     C                   DoU       *inkc = *on
     * ExFmt the CONTROL FORMAT of the subfile.
     C                   Write     CMD01
     C                   ExFmt     CTL01
     C                   EndDo
     * Free up resources and return
     C                   Eval      *inlr = *On
     C                   Return
     * Subroutine : #LODSFL
     * This subroutine is used to load the subfile with 9999 records.
     * The subroutine is called from the mainline code. The subroutine
     * clears the subfile, increments the RRN, and writes the record
     * to the subfile. The subroutine is called from the mainline code.
     C     #LODSFL       BegSr
     * Clear the subfile. Clearing a subfile involves the following four
     * statements.
     * 1. Switch on the SFLCLR indicator
     * 2. Write to the control format
     * 3. Switch off the SFLCLR indicator
     * 4. Reset the RRN to zero (Or one).
     * The fourth statement actually is not related to subfile. However,
     * we generally reset this value while clearing the subfile itself.
     C                   Z-Add     0             RRN01             4 0
     C                   Eval      *In(30) = *On
     C                   Write     CTL01
     C                   Eval      *In(30) = *Off
     * Set a looping condition. This condition may be based on anything.
     * But in any case, just ensure that RRN does not exceed 9999.
     C                   DoW       RRN01 < 9999
     * Increment the RRN to mark a new record of subfile. Remember that
     * the variable corresponding to RRN should not be less than one (1) a
     * nd it should never exceed 9999.
     C                   Eval      RRN01 += 1
     * Populate the fields defined in the subfile.
     * For this example simply show the RRN value as it accumulates
     C                   Eval      COUNT = RRN01
     * Perform actual write to the subfile. Notice that each write
     * actually adds a record to the subfile but is not displayed yet
     C                   Write     SFL01
     C                   EndDo
     C                   EndSr