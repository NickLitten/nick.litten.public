///
/// Program: SIMPLESFL1 - AS/400 Style Full Load Subfile Example
///
/// Description: Educational example demonstrating traditional AS/400 fixed-format
///              RPG subfile processing. This program reads records from SIMPLEFILE
///              and displays them in a full-load subfile using classic RPG IV syntax.
///              Intentionally preserved in fixed format to show legacy coding style.
///
/// Purpose: Educational example demonstrating:
///   - Fixed-format RPG IV subfile processing
///   - Traditional AS/400 coding style
///   - Full-load subfile pattern (load all records at once)
///   - Classic indicator usage (30, 31, 32, 33, 99)
///   - Legacy file specifications and calculations
///
/// Features:
///   - Reads all records from SIMPLEFILE into subfile
///   - Displays up to 9999 records in subfile
///   - Uses traditional subfile control record (CTL01)
///   - Classic RPG cycle with indicators
///   - F3=Exit function key support
///   - SFLEND indicator when subfile is full
///
/// Usage: CALL SIMPLESFL1
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
///   - 99: EOF indicator
///
/// Note: This is an intentionally preserved legacy example showing AS/400 style
///       fixed-format RPG. For modern free-format examples, see SIMPLESFL2 and
///       SIMPLESFL3 programs.
///
/// Reference:
/// https://www.nicklitten.com/blog/rpgle-subfile-examples/
///
/// Modification History:
///   V.000 2020-01-15 | Nick Litten | Initial creation - AS/400 style example
///   V.001 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

     FSIMPLEDSPFCF   E             WORKSTN SFILE(SFL01:RRN01)
     FSIMPLEFILEIF   E           K DISK
      * Define the subfile row counter variable RRN01
     C                   Z-ADD     0             RRN01
     C                   EVAL      PGMNAME = 'SIMPLESFL1'
      * Clear the subfile
     C                   SETON                                        30
     C                   WRITE     CTL01
     C                   SETOFF                                       30
      *
      * Load subfile from the file SIMPLEFILE
      * Loop until the EOF indicator is ON, or until the SFL maxsize is reached
     C     *LOVAL        SETLL     SIMPLEFILE
     C     *IN99         DOUEQ     *ON
     C     RRN01         OREQ      9999
     C                   READ      SIMPLEFILE                             99
     C     *IN99         IFEQ      *OFF
     C                   ADD       1             RRN01
     C                   WRITE     SFL01
     C                   ENDIF
     C                   ENDDO
      * If we have read file data then show the SFL and the SFLEND indicator
     C     RRN01         IFGT      0
     C                   SETON                                        3133
     C                   ENDIF
      * Display subfile
     C                   SETON                                        32
     C                   WRITE     CMD01
     C     *IN03         DOUEQ     *ON
     C                   EXFMT     CTL01
     C                   ENDDO
      * Terminate program
     C                   SETON                                        LR