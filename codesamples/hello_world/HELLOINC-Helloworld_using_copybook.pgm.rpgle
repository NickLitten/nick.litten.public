**free
// Alternate Helloworld with copybook
//
// This program is a simple 'Hello World' style RPG program which has
// been fleshed out to match my preferred standard RPG style.
//
// The control options define runtime setup for this program including
// some notable options:
// * main(mainline) - tell RPG not to add all the usual RPG Cycle info
//                    but to execute the procedure called MAINLINE by
//                    default.
// * pgminfo(*pcml:*module) - this embeds the parameter information in
//                    the compiled object so that processes like the 
//                    integrated webserver can see the expected parms
// * copyright - store version information against the program to make
//                    version information available using DSPPGM
//
// Modification History:                                                 
// V.000 2024.11.22 NJL Created      
// V.001 2024.12.11 NJL Christmas Update                                          
/include 'header.rpgleinc'

ctl-opt
  copyright('HelloAlternate | V.001 | Sample Stylised RPG Program');

/include 'variables.rpgleinc'

Dcl-Proc mainline;
   Dcl-Pi mainline;
   end-pi;

   Dcl-S msg char(50);
   Dcl-S reply char(1);

   msg = 'Hello World!';
   dsply msg;

   msg = 'Press Y to continue';
   Dou (%upper(reply) = 'Y');
      dsply msg '' reply;
   enddo;

   Return;

   on-exit success;

      If not success;
         // Handle abnormal end
      Else;
         // do *normal* program closure items - close files, etc
      EndIf;

end-proc;