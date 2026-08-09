**FREE

/// -------------------------------------------------------------------
/// ACTGRPTST - Program With Caller Called From Actgrp
/// -------------------------------------------------------------------
/// Version: 1.0
/// Author:  Nick Litten
///
/// Purpose:
///   Demonstration program that runs in the *CALLER activation group.
///   Shows that when called from ACTGRPTST1 (actgrp ONE) or
///   ACTGRPTST2 (actgrp TWO), this program joins the caller's actgrp
///   rather than creating its own.
///
///   The static call counter increments within a single actgrp lifetime,
///   proving the program shares the caller's storage context.
///
/// Parameters:
///   Message  char(10)  - Name of the calling activation group
///
/// Modification History:
///   2025-05-30  NL  Initial version - added **FREE, doc header, fixes
/// -------------------------------------------------------------------

/include 'header.rpgleinc'
ctl-opt copyright('ACTGRPTST | 1.0 - Program With Caller Called From Actgrp');

// -------------------------------------------------------------------
// Prototype: this program (for recursive / external call reference)
// -------------------------------------------------------------------
dcl-pr ACTGRPTST extpgm('ACTGRPTST');
  *n char(10);
end-pr;

dcl-pi ACTGRPTST;
  Message char(10);
end-pi;

// -------------------------------------------------------------------
// Prototype: PASE job-log writer
// -------------------------------------------------------------------
/include 'QPROTO-Qp0zLprintf_Prototype.rpgleinc'

// -------------------------------------------------------------------
// Variables
// -------------------------------------------------------------------
dcl-s callCount   int(10)   inz(0) static;  // persists within actgrp lifetime
dcl-s logTitle    char(50);
dcl-s logBody     char(100);

// -------------------------------------------------------------------
// Mainline
// -------------------------------------------------------------------
callCount += 1;
logTitle = 'Called ' + %char(callCount) + ' time(s)';
logBody  = 'ACTGRP is (' + %trim(Message) + ')';

Qp0zLprintf( '>>: %s %s' + X'25'
           : %trim(logTitle)
           : %trim(logBody));

return;
