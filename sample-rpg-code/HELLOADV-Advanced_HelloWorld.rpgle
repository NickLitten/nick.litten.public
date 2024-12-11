**free
// --------------------------------------------------------------------- 
// Advanced Helloworld with some different code concepts
// --------------------------------------------------------------------- 
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
// --------------------------------------------------------------------- 
// Modification History:                                                 
// V.000 2020.03.14 NJL Created                                                
// --------------------------------------------------------------------- 
/include header.rpgleinc

ctl-opt
  copyright('HelloAdvanced | V.000 | Sample Stylised RPG Program')
  ;

dcl-proc mainline;
  dcl-pi mainline;
  end-pi;

  dcl-s msg char(50);
  dcl-s reply char(1);

  msg = 'Hello World!';
  dsply msg;

  msg = 'Press Y to continue';
  Dou %upper(reply) = 'Y';
    dsply msg '' reply;
  enddo;

  return;

end-proc;