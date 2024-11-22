**free
// --------------------------------------------------------------------- 
// Alternate Helloworld with Environment codes
// --------------------------------------------------------------------- 
//
// This program is a simple 'Hello World' style RPG program which has
// been fleshed out to match my preferred standard RPG style.
//
// The control options define runtime setup for this program including
// some notable options:
// * main(mainline) - tell RPG not to add all the usual RPG Cycle info
//                    but to execure the procedure called MAINLINE by
//                    default.
// * pgminfo(*pcml:*module) - this embeds the parameter information in
//                    the compiled object so that processes like the 
//                    integrated webserver can see the expected parms
// * copyright - store version information against the program to make
//                    version information available using DSPPGM
// * Defined(*CRTBNDRPG) - add activation group defaults if this is 
//                    created as a bound program versus a module and ILE
//   
// The program expects three incoming parameters:
// * Environment Code - 3 character enviroment code (DEV, TST, UAT, PRD)
// * A success indicator which will return *ON/*OFF
// * A status message which will contain error code or info message
//                                     
// To call use: CALL PGM(HELLOADV) PARM(('DEV') (' ') (' '))               
//
// --------------------------------------------------------------------- 
// Modification History:                                                 
// V.000 2024.03.14 NJL Created                                                
// --------------------------------------------------------------------- 
ctl-opt
  main(mainline)
  optimize(*full)
  option(*nodebugio:*srcstmt:*nounref)
  pgminfo(*pcml:*module)
  indent('| ')
  copyright('HelloAdvanced  | V.000 | Sample Stylised RPG Program')
  ;

// --------------------------------------------------------------------- 
// the mainline (default) runtime procedure
// --------------------------------------------------------------------- 
dcl-proc mainline;
  dcl-pi mainline;
    p_env char(3) const;
    p_success ind;
    p_msg char(50);
  end-pi;

  dcl-s myResponse char(1);

  if valid_environment(p_env);

    p_msg = 'Environment is:' + p_env;
    dsply p_msg;

    p_msg = 'Press Y to continue';
    Dou %upper(myResponse) = 'Y';
      dsply p_msg '' myResponse;
    enddo;

    p_success = *on;

  else;

    p_success = *off;
    p_msg = 'Invalid Environment code received:' + p_env;

  endif;

  return;

end-proc;




// --------------------------------------------------------------------- 
// validate the environment code parameter
// --------------------------------------------------------------------- 
dcl-proc valid_environment;
  dcl-pi valid_environment ind;
    p_env char(3) const;
  end-pi;

  if p_env = 'DEV' or p_env = 'TST' or p_env = 'UAT' or p_env = 'PRD';
    return *on;
  else;
    return *off;
  endif;

end-proc;