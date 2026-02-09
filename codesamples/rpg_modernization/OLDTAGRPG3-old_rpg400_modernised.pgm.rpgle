**free
// author: nick litten               
// some old sample code written in the 1990s for rpg400 style
// with goto statements and subroutines. this code has been
// converted to free format rpg as part of a video rpg upgrade.             
// written  : during a 1990's rave              
// modification history:
// 2025.10.06 njl played with as part of a video rpg upgrade
// https://www.nicklitten.com/course/old-rpg-with-goto-tag-and-subroutines-to-modern-rpgle-with-sub_procedures               
ctl-opt dftactgrp(*no) actgrp('NICKLITTEN') option(*srcstmt:*nodebugio);

dcl-f qtxtsrc disk usage(*input) rename(qtxtsrc:rectxt);

dcl-pi *n;
  rtn char(10);
end-pi;  

dcl-ds srcdta qualified inz;
  flag char(8) pos(1);
  partnumber char(20) pos(11);
end-ds;

rtn = 'NOT FOUND';

// read every row in QTXTSRC and update 'RTN' if match found
read qtxtsrc;
dow not %eof(qtxtsrc) and no_match_found(srcdta.flag:srcdta.partnumber);
  read qtxtsrc;
enddo;

dsply %char('Rtn=' + rtn);

*inlr = *on;
// this is a subprocedure that replaces a goto tag subroutine
dcl-proc no_match_found;
  dcl-pi *n ind;
    myFlag like(srcdta.flag);
    myPartnumber like(srcdta.partnumber);
  end-pi;
  dcl-s myStatus ind inz(*on);

  if myFlag = 'THISONE' and myPartnumber <> *BLANKS;
    rtn = 'EXISTS';
    myStatus = *off;
  endif;

  return myStatus;
end-proc;
