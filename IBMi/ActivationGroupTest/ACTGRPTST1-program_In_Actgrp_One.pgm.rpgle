**FREE

/// -------------------------------------------------------------------
/// ACTGRPTST1 - Program In Actgrp One
/// -------------------------------------------------------------------
/// Version: 1.0
/// Author:  Nick Litten
///
/// Purpose:
///   Runs in named activation group 'ONE'. Calls ACTGRPTST (*CALLER)
///   to demonstrate that the called program joins this actgrp.
///
/// Modification History:
///   2025-05-30  NL  Initial version - added **FREE, doc header, fixes
/// -------------------------------------------------------------------

/include 'header.rpgleinc'
ctl-opt copyright('ACTGRPTST | 1.0 - Program In Actgrp One');

// -------------------------------------------------------------------
// Prototype: *CALLER target program
// -------------------------------------------------------------------
dcl-pr CallWithStarCaller extpgm('ACTGRPTST1');
  *n char(10);
end-pr;

// -------------------------------------------------------------------
// Prototype: PASE job-log writer
// -------------------------------------------------------------------
/include 'QPROTO-Qp0zLprintf_Prototype.rpgleinc'

// -------------------------------------------------------------------
// Variables
// -------------------------------------------------------------------
dcl-s actgrpName  char(10);
dcl-s logTitle    char(50);
dcl-s logBody     char(100);

// -------------------------------------------------------------------
// Mainline
// -------------------------------------------------------------------
actgrpName = 'ONE';
logTitle   = 'ACTGRPTST1 called';
logBody    = ' ';

Qp0zLprintf( '>>: %s %s' + X'25'
           : %trim(logTitle)
           : %trim(logBody));

CallWithStarCaller(actgrpName);

return;
