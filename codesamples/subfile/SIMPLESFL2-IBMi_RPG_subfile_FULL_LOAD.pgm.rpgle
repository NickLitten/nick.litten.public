**FREE
//
// Simple RPGLE program to demonstrate the use of subfile processing
// in RPGLE.  This program will read a file and display the records in a su
// The program will use a subfile control record and a subfile record forma
//
// MODIFICATION HISTORY:
// 1994.05.23 Nick Litten V1.0 Created
// 2007.10.03 njl converted to free format RPG
// 2018.05.25 njl played with as part of a Video RPG Upgrade Tour
//

Dcl-F SIMPLEDSPF WORKSTN SFILE(SFL01:RRN01);
Dcl-F SIMPLEFILE Usage(*Input) Keyed;

// define the subfile row counter variable RRN01
RRN01 = 0;
PGMNAME = 'SIMPLESFL2';

// clear the subfile
*In30 = *On;
WRITE CTL01;
*In30 = *Off;

// Load subfile from the file SIMPLEFILE
// Loop Until the EOF Indicator is ON, or until the SFL maxsize is reached
SETLL *LOVAL SIMPLEFILE;
DOU %EOF(SIMPLEFILE) OR RRN01 = 9999;
  READ SIMPLEFILE;
  If not %EOF(SIMPLEFILE);
    RRN01 += 1;
    WRITE SFL01;
  ENDIF;
ENDDO;

// if we have read file data then show the SFl and the SFLEND indicator
If RRN01 > 0;
  *In31 = *On;
  *In33 = *On;
ENDIF;

// display subfile
*In32 = *On;
WRITE CMD01;
Dou *IN03;
  EXFMT CTL01;
ENDDO;

// terminate program
*InLR = *On; 
Return;
