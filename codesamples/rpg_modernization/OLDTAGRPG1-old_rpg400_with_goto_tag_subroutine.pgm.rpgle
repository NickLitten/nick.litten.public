      // AUTHOR: NICK LITTEN                                       
      // SOME OLD SAMPLE CODE WRITTEN IN THE 1990S FOR RPG400 STYLE
      // WITH GOTO STATEMENTS AND SUBROUTINES. THIS CODE HAS BEEN
      // CONVERTED TO FREE FORMAT RPG AS PART OF A VIDEO RPG UPGRADE.                             
      // WRITTEN  : DURING A 1990'S RAVE                                          
      // MODIFICATION HISTORY:
      // 2025.10.06 NJL PLAYED WITH AS PART OF A VIDEO RPG UPGRADE
      // https://www.nicklitten.com/course/old-rpg-with-goto-tag-and-subroutines-to-modern-rpgle-with-sub_procedures                                      
     FQTXTSRC   IF   E           K DISK    RENAME(QTXTSRC:RECTXT)    
      // THIS PROGRAM READS A RECORD FROM A FILE AND PROCESSES IT. 
      // IT USES OLD STYLE RPG WITH GOTO STATEMENTS AND SUBROUTINES.
     DDATA             DS                                    
     DRECORD                         92A   INZ                  
     DFLAG                            8A   OVERLAY(RECORD:1) 
     DPARTN                          20A   OVERLAY(RECORD:10)
  
     C     *ENTRY        PLIST                                      
     C                   PARM                    RTN              10

     C     START         TAG

     C                   READ      QTXTSRC                                50
     C                   IF        *IN50 = '1'
     C                   MOVEL     'NOT FOUND'   RTN
     C                   GOTO      ENDPGM
     C                   ENDIF

     C                   EXSR      LOGIC

     C                   GOTO      START 

      // PROGRAM EXIT POINT
     C     ENDPGM        TAG
     C                   EVAL      *INLR = *ON
      // THIS IS A SUBROUTINE TO DEMONSTRATE THE OLD STYLE OF RPG400
      // SUBROUTINES. 
     C     LOGIC         BEGSR
     C                   MOVEL     SRCDTA        RECORD
     C                   IF        FLAG = 'THISONE' 
     C                   IF        PARTN <> *BLANKS
     C                   MOVEL     'EXISTS'      RTN
     C                   GOTO      ENDPGM
     C                   ENDIF
     C                   ENDIF
     C                   ENDSR