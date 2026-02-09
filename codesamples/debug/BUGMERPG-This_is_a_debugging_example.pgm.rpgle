**free
// BUGMERPG debug code example based on Helloworld 
//
// This will recieve a parameter and change the value before returning
//
// Modification History:                                                 
// V.000 2025.03.27 NJL Created                                                
/include 'header.rpgleinc'

ctl-opt
  copyright('Bug Me RPG | V.000 | Sample RPG Program for Debug')
  ;
// Procedure: mainline
// Description: Main entry point for the program.
Dcl-Proc mainline;
   Dcl-Pi mainline;
      incomingDebugMsg char(100);
   end-pi;

   incomingDebugMsg = %trim(incomingDebugMsg) + ' - (updated from BUGMERPG!)';

   Return;

end-proc;