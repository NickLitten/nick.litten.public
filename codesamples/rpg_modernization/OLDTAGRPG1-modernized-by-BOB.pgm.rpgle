**FREE
// AUTHOR: NICK LITTEN                                       
// MODERNIZED VERSION OF OLD RPG400 CODE FROM THE 1990S
// ORIGINAL HAD GOTO STATEMENTS AND SUBROUTINES
// THIS VERSION USES MODERN FREE-FORMAT RPGLE WITH SUBPROCEDURES                             
// WRITTEN  : DURING A 1990'S RAVE                                          
// MODIFICATION HISTORY:
// 2025.10.06 NJL PLAYED WITH AS PART OF A VIDEO RPG UPGRADE
// 2026.01.23 NJL FULLY MODERNIZED TO FREE-FORMAT RPGLE
// https://www.nicklitten.com/course/old-rpg-with-goto-tag-and-subroutines-to-modern-rpgle-with-sub_procedures                                      
// MODERNIZATION #1: Added CTL-OPT for modern compiler settings
// - DFTACTGRP(*NO): Don't use default activation group (required for subprocedures)
// - ACTGRP('NICKLITTEN'): Use named activation group for better resource management
// - OPTION(*SRCSTMT): Include source statement numbers in joblog for debugging
// - OPTION(*NODEBUGIO): Disable debug I/O for better performance
CTL-OPT DFTACTGRP(*NO) ACTGRP('NICKLITTEN') OPTION(*SRCSTMT:*NODEBUGIO);

// MODERNIZATION #2: Converted F-spec to DCL-F with modern syntax
// Old: FQTXTSRC   IF   E           K DISK    RENAME(QTXTSRC:RECTXT)
// New: DCL-F with USAGE, KEYED, and RENAME keywords in free format
DCL-F QTXTSRC DISK USAGE(*INPUT) KEYED RENAME(QTXTSRC:RECTXT);

// MODERNIZATION #3: Converted *ENTRY PLIST to DCL-PI procedure interface
// Old: C     *ENTRY        PLIST
//      C                   PARM                    RTN              10
// New: Modern procedure interface with proper parameter definition
DCL-PI *N;
  rtn CHAR(10);
END-PI;

// MODERNIZATION #4: Converted D-spec data structure to DCL-DS with qualified fields
// Old: DDATA             DS
//      DRECORD                         92A   INZ
//      DFLAG                            8A   OVERLAY(RECORD:1)
//      DPARTN                          20A   OVERLAY(RECORD:10)
// New: Qualified DS with POS() instead of OVERLAY() for better clarity
DCL-DS data QUALIFIED INZ;
  record CHAR(92);
  flag CHAR(8) POS(1);
  partnumber CHAR(20) POS(10);
END-DS;

// MODERNIZATION #5: Initialize return value at start (replaces MOVEL in GOTO logic)
// Old: C                   MOVEL     'NOT FOUND'   RTN
// New: Direct assignment using modern syntax
rtn = 'NOT FOUND';

// MODERNIZATION #6: Replaced GOTO/TAG infinite loop with structured DOW loop
// Old logic flow:
//   C     START         TAG
//   C                   READ      QTXTSRC                                50
//   C                   IF        *IN50 = '1'
//   C                   MOVEL     'NOT FOUND'   RTN
//   C                   GOTO      ENDPGM
//   C                   ENDIF
//   C                   EXSR      LOGIC
//   C                   GOTO      START
//
// New: Structured loop with %EOF() built-in function and early exit logic
READ RECTXT;
DOW NOT %EOF(QTXTSRC) AND processRecord();
  READ RECTXT;
ENDDO;

// MODERNIZATION #7: Removed ENDPGM TAG - no longer needed with structured code
// Old: C     ENDPGM        TAG
//      C                   EVAL      *INLR = *ON
// New: Direct assignment at end of main logic
*INLR = *ON;
// MODERNIZATION #8: Converted BEGSR subroutine to DCL-PROC subprocedure
// Old: C     LOGIC         BEGSR
//      C                   MOVEL     SRCDTA        RECORD
//      C                   IF        FLAG = 'THISONE'
//      C                   IF        PARTN <> *BLANKS
//      C                   MOVEL     'EXISTS'      RTN
//      C                   GOTO      ENDPGM
//      C                   ENDIF
//      C                   ENDIF
//      C                   ENDSR
//
// New: Proper subprocedure with return value for loop control
// Returns *ON to continue processing, *OFF to exit loop
DCL-PROC processRecord;
  DCL-PI *N IND;
  END-PI;
  
  DCL-S continueProcessing IND INZ(*ON);
  
  // MODERNIZATION #9: Replaced MOVEL with direct assignment to qualified field
  // Old: C                   MOVEL     SRCDTA        RECORD
  // New: Direct assignment using qualified data structure notation
  data.record = SRCDTA;
  
  // MODERNIZATION #10: Simplified nested IF logic with AND operator
  // Old: C                   IF        FLAG = 'THISONE'
  //      C                   IF        PARTN <> *BLANKS
  // New: Combined conditions in single IF statement for better readability
  IF data.flag = 'THISONE' AND data.partnumber <> *BLANKS;
    rtn = 'EXISTS';
    continueProcessing = *OFF;  // Signal to exit the loop
  ENDIF;
  
  RETURN continueProcessing;
END-PROC;