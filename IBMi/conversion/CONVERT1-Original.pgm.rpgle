///
/// Program: CONVERT1 - EBCDIC to ASCII Conversion (Original Fixed-Format)
///
/// Description: Legacy fixed-format RPG program that converts EBCDIC data to
///              ASCII using the QDCXLATE API. This is intentionally preserved
///              in its original fixed-format style to demonstrate the evolution
///              from legacy RPG to modern free-format code. Compare with
///              CONVERT2, CONVERT3, and CONVERT4 to see modernization progression.
///
/// Purpose: Educational example demonstrating:
///   - Legacy fixed-format RPG syntax (columns 6-80)
///   - Traditional file specifications (F-specs)
///   - Fixed-format data definitions (D-specs)
///   - Input specifications (I-specs) for record layout
///   - Calculation specifications (C-specs) with indicators
///   - Output specifications (O-specs) for EXCEPT operation
///   - GOTO-based control flow (legacy pattern)
///   - Subroutine usage (BEGSR/ENDSR)
///
/// Features:
///   - Fixed-format RPG III/IV syntax
///   - Uses QDCXLATE API with QTCPASC translation table
///   - Processes 80-byte fixed-length records
///   - Indicator-based logic (*IN97, *INLR)
///   - TAG and GOTO for program flow
///   - EXCEPT for output record writing
///
/// Usage: CALL CONVERT1
///        (Reads from FILEIN, writes to FILEOUT)
///
/// Parameters:
///   None
///
/// Dependencies:
///   - Input file: FILEIN (80-byte EBCDIC records)
///   - Output file: FILEOUT (80-byte ASCII records)
///   - QDCXLATE API (system program)
///
/// Note: This program is intentionally kept in fixed-format to serve as a
///       "before" example. See CONVERT2, CONVERT3, and CONVERT4 for modern
///       implementations of the same functionality.
///
/// Reference:
///   https://www.ibm.com/docs/en/i/7.5?topic=ssw_ibm_i_75/apis/qdcxlate.html
///   https://www.nicklitten.com/rpg-modernization-journey/
///
/// Modification History:
///   1.0 2020-01-01 | Nick Litten | Original legacy version
///   1.1 2026-05-23 | Nick Litten | Added comprehensive documentation
///

     Ffilein    if   f   80        disk
     Ffileout   o    f   80        disk

     D data            s             80a
     D out             s             80a

     D Translate       PR                  ExtPgm('QDCXLATE')
     D   Length                       5P 0 const
     D   Data                     32766A   options(*varsize)
     D   Table                       10A   const

     Ifilein    ns  98
     I                                  1   80  record

     C                   eval      *in97 = *off
     C     read          tag
     C                   read      filein                                 97
     C                   if        *in97 = *on
     C                   goto      end
     C                   endif
     C                   exsr      convrt
     C                   if        *in97 = *off
     C                   goto      read
     C                   endif
     C     end           tag
     C                   eval      *inlr = *on
     C     convrt        begsr
     C                   eval      data = *blanks
     C                   eval      out = *blanks
     C                   eval      data = record
     C                   callp     Translate(80: Data: 'QTCPASC')
     C                   eval      out = data
     C                   except    recout
     C                   endsr
     Ofileout   e            recout
     O                       out                 80