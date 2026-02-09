      * Simple RPGLE program to demonstrate the use of subfile processing
      * in RPGLE.  This program will read a file and display the records in a subfile.
      * The program will use a subfile control record and a subfile record format.
     FSIMPLEDSPFCF   E             WORKSTN SFILE(SFL01:RRN01)                  
     FSIMPLEFILEIF   E           K DISK           
      * define the subfile row counter variable RRN01                          
     C                   Z-ADD     0             RRN01      
     C                   EVAL      PGMNAME = 'SIMPLESFL1'
      * clear the subfile                                                    
     C                   SETON                                        30     
     C                   WRITE     CTL01                                     
     C                   SETOFF                                       30     
      *                                                                      
      * Load subfile from the file SIMPLEFILE  
      * Loop Until the EOF Indicator is ON, or until the SFL maxsize is reached                                                      
     C     *LOVAL        SETLL     SIMPLEFILE                                  
     C     *IN99         DOUEQ     *ON                                      
     C     RRN01         OREQ      9999                                      
     C                   READ      SIMPLEFILE                             99 
     C     *IN99         IFEQ      *OFF 
     C                   ADD       1             RRN01                         
     C                   WRITE     SFL01                                     
     C                   ENDIF
     C                   ENDDO                                               
      * if we have read file data then show the SFl and the SFLEND indicator
     C     RRN01         IFGT      0                                        
     C                   SETON                                        3133   
     C                   ENDIF                                               
      * display subfile                                                     
     C                   SETON                                        32   
     C                   WRITE     CMD01                                                                    
     C     *IN03         DOUEQ     *ON                                    
     C                   EXFMT     CTL01                                   
     C                   ENDDO                                             
      * terminate program                                                                    
     C                   SETON                                        LR   