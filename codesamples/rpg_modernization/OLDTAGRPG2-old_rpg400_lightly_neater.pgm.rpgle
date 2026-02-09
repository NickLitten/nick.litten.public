      // AUTHOR: NICK LITTEN                                       
      // SOME OLD SAMPLE CODE WRITTEN IN THE 1990S FOR RPG400 STYLE
      // WITH GOTO STATEMENTS AND SUBROUTINES. THIS CODE HAS BEEN
      // CONVERTED TO FREE FORMAT RPG AS PART OF A VIDEO RPG UPGRADE.                             
      // WRITTEN  : DURING A 1990'S RAVE                                          
      // MODIFICATION HISTORY:
      // 2025.10.06 NJL PLAYED WITH AS PART OF A VIDEO RPG UPGRADE
      // https://www.nicklitten.com/course/old-rpg-with-goto-tag-and-subroutines-to-modern-rpgle-with-sub_procedures                                     
     FQTXTSRC   IF   E           K DISK    RENAME(QTXTSRC:RECTXT)   
                                                            
     DDATA             DS                                    
     DRECORD                         92A   INZ               
     DFLAG                            8A   OVERLAY(RECORD:1) 
     DPARTN                          20A   OVERLAY(RECORD:10)
  
     C     *ENTRY        PLIST                                      
     C                   PARM                    RTN              10

     C                   MOVEL     'NOT FOUND'   RTN

      // outside DO loop
     C                   READ      QTXTSRC                                50
     C                   DOW       *IN50 = '0'
     C                   EXSR      LOGIC
     C                   IF        RTN = 'EXISTS'
     C                   LEAVE
     C                   ENDIF
     C                   READ      QTXTSRC                                50
     C                   ENDDO

      // inside do loop (alternate logic for reference)
      //C                   DOU       1 <> 1
      //C                   READ      QTXTSRC                                50
      //C                   IF        *IN50 = '1'
      //C                   LEAVE
      //C                   ENDIF
      //C                   EXSR      LOGIC
      //C                   ENDDO

      // PROGRAM EXIT POINT
     C                   EVAL      *INLR = *ON
      // THIS IS A SUBROUTINE TO DEMONSTRATE THE OLD STYLE OF RPG400
      // SUBROUTINES. 
     C     LOGIC         BEGSR
     C                   MOVEL     SRCDTA        RECORD
     C                   IF        FLAG = 'THISONE' 
     C                   IF        PARTN <> *BLANKS
     C                   MOVEL     'EXISTS'      RTN
     C                   LEAVESR
     C                   ENDIF
     C                   ENDIF
      // here might be other processing
     C                   ENDSR