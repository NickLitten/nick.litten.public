      * **********************************************************************************
      * Simple RPGLE program to demonstrate the use of subfile processing
      * in RPGLE.  This program will read a file and display the records in a subfile.
      * The program will use a subfile control record and a subfile record format.
      * **********************************************************************************
     FSIMPLEDSPFCF   E             WORKSTN SFILE(SFL01:RRN01)                  
     FSIMPLEFILEIF   E             DISK           
      * **********************************************************************************
      * define the subfile row counter variable RRN01                          
     C                   Z-ADD     0             RRN01           5 0       
      * clear the subfile                                                    
     C                   SETON                                        30     
     C                   WRITE     CTL01                                     
     C                   SETOFF                                       30     
      *                                                                      
     C     1             SETLL     SIMPLEFILE                                  
     C                   READ      SIMPLEFILE                             99 
      * Load subfile                                                         
     C     *IN99         DOWEQ     *OFF                                      
     C     RRN01         ANDLT     9999                                      
     C                   ADD       1             RRN01                         
     C                   WRITE     SFL01                                     
      * seton the indicators to let RPG know that we have some stuff to show 
     C                   SETON                                        31
     C                   READ      SIMPLEFILE                             99 
     C                   ENDDO                                               
      * display the MORE value if more than one screen has been loaded       
     C     RRN01         IFGT      15                                        
     C                   SETON                                        33     
     C                   ENDIF                                               
      * display subfile                                                     
     C                   SETON                                        32   
     C                   WRITE     CMD01                                   
     C                   EXFMT     CTL01                                   
     C     *IN03         DOWEQ     *OFF                                    
     C                   EXFMT     CTL01                                   
     C                   ENDDO                                             
      * terminate program                                                                    
     C                   SETON                                        LR   