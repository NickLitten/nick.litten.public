**FREE

// Code Snippet for https://www.nicklitten.com/course/what-does-an-rpg-subfile-look-like/
// This is FREE FORMAT RPGLE
// Assume the Table (file) is called "customer"
// The DSPF is "subfile" with two record formats: SFL001 (the subfile) and CTL001 (the control format)

ctl-opt dftactgrp(*no) actgrp(*caller);

dcl-f Customer disk(*ext) keyed usage(*input);
dcl-f Subfile workstn indds(Indicators);

Dcl-Ds Indicators;
   SflClr ind pos(50);
   SflDsp ind pos(50);
end-ds;

Dcl-S NumRecords int(5);
Dcl-S SubfileRecNo int(5);

// Main program logic
SubfileRecNo = 1;
LoadSubfile();
DisplaySubfile();
*inlr = *on;

// --------------------------------------------
// Load subfile with customer records
// --------------------------------------------
Dcl-Proc LoadSubfile;
   read Customer;
   dow (not %eof(Customer));
      SubfileRecNo += 1;
      write SFL001;
      read Customer;
   enddo;
end-proc;

// --------------------------------------------
// Display subfile to user
// --------------------------------------------
Dcl-Proc DisplaySubfile;
   SflClr = *off;  // SFLCLR Indicator
   write CTL001;
   SflDsp = *on;   // SFLDSP/SFLDSPCTL Indicator
   exfmt CTL001;
end-proc;