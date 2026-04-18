**free
// ------------------------------------------------------------------------------
// Program: OLDTAGRPG3 - Old RPG400 Modernized Example
// Author: Nick Litten
//
// Description:
//   Sample code originally written in the 1990s using RPG400 style with GOTO
//   statements and subroutines. This version has been modernized to free-format
//   RPG with subprocedures, demonstrating the evolution from legacy to modern
//   RPG programming practices.
//
// Written: During a 1990's rave
//
// Modification History:
//   2025.10.06 NJL - Initial modernization as part of video RPG upgrade
//   2026.04.18 NJL - Updated source comments and documentation
//
// Reference:
//   https://www.nicklitten.com/course/old-rpg-with-goto-tag-and-subroutines-to-modern-rpgle-with-sub_procedures
// ------------------------------------------------------------------------------

ctl-opt dftactgrp(*no) actgrp('NICKLITTEN') option(*srcstmt:*nodebugio);

dcl-f qtxtsrc disk usage(*input) rename(qtxtsrc:rectxt);

Dcl-Pi *n;
   rtn char(10);
end-pi;  

Dcl-Ds srcdta qualified inz;
   flag char(8) pos(1);
   partnumber char(20) pos(11);
end-ds;

rtn = 'NOT FOUND';

// read every row in QTXTSRC and update 'RTN' if match found
read qtxtsrc;
dow (not %eof(qtxtsrc) and no_match_found(srcdta.flag:srcdta.partnumber));
   read qtxtsrc;
enddo;

dsply %char('Rtn=' + rtn);

*inlr = *on;

// Subprocedure: no_match_found
// Purpose: Replaces legacy GOTO/TAG subroutine logic with modern subprocedure
// Returns: *ON if no match found, *OFF if match exists
Dcl-Proc no_match_found;
   Dcl-Pi *n ind;
      myFlag like(srcdta.flag);
      myPartnumber like(srcdta.partnumber);
   end-pi;
   Dcl-S myStatus ind inz(*on);

   If (myFlag = 'THISONE' and myPartnumber <> *BLANKS);
      rtn = 'EXISTS';
      myStatus = *off;
   EndIf;

   Return myStatus;
end-proc;
