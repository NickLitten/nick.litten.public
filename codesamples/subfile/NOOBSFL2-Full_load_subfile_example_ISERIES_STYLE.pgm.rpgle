      * - Simple RPG Subfile Example using a full load of 9999 records
      * - This program is a simple example of how to load a subfile with
      *   9999 records. The subfile is loaded with a counter value that
      *   increments by one for each record. The subfile is cleared
      *   before loading the records.
      * - The subfile is defined in the display file. The subfile is
      *   defined with a relative record number (RRN) field. The RRN
      *   field is used to identify the record number of the subfile.
      * - The subfile is loaded by a subroutine. The subroutine clears
      *   the subfile, increments the RRN, and writes the record to the
      *   subfile. The subroutine is called from the mainline code.
      * - The mainline code is a simple loop that calls the subroutine
      *   to load the subfile. The loop continues until the user presses
      *   the exit key.
      * - The program is compiled and run. The subfile is displayed with
      *   9999 records. The user can scroll through the records using the
      *   page up and page down keys. The user can exit the program by
      *   pressing the exit key.
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