     FTESTDSPF  CF   E             WORKSTN SFILE(SFL01:RRN)                  
     FTESTFILE  IF   E             DISK                                      
     C                   Z-ADD     0             RRN               5 0       
      * clear the subfile                                                    
     C                   SETON                                        30     
     C                   WRITE     CTL01                                     
      *                                                                      
     C     1             SETLL     TESTFILE                                  
     C                   READ      TESTFILE                               99 
      * Load subfile                                                         
     C     *IN99         DOWEQ     *OFF                                      
     C     RRN           ANDLT     9999                                      
     C                   ADD       1             RRN                         
     C                   WRITE     SFL01                                     
      * seton the indicators to let RPG know that we have some stuff to show 
     C                   SETON                                        3132   
     C                   READ      TESTFILE                               99 
     C                   ENDDO                                               
      * display the MORE value if more than one screen has been loaded       
     C     RRN           IFGT      15                                        
     C                   SETON                                        33     
     C                   ENDIF                                               
      * display subfile                                                     
     C                   EXFMT     CTL01                                   
     C     *IN03         DOWEQ     *OFF                                    
     C                   EXFMT     CTL01                                   
     C                   ENDDO                                             
     C*                                                                    
     C                   SETON                                        LR   