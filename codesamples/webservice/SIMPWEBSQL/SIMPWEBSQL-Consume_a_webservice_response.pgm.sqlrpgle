**free
/title Simply consume a webservice response from nicklitten dot com
//
// Service - SIMPWEBSQL
//
// COMPILE NOTES:
// Change the source location to match yours:
//
// CRTSQLRPGI OBJ(WEBSERVICE/SIMPWEBSQL)
// SRCSTMF('/home/nicklitten/source-webservices/SIMPWEBSQL.sqlrpgle')
// COMMIT(*NONE) OBJTYPE(*PGM) DBGVIEW(*SOURCE) CVTCCSID(*JOB)
//
// Modification History:
// 2022-06-11 V1.0 Created by Nick Litten
ctl-opt
  main(SIMPWEBSQL)
  pgminfo(*PCML:*MODULE:*DCLCASE)
  option(*srcstmt:*nodebugio:*noshowcpy)
  /if Defined(*CRTSQLRPGI)
   dftactgrp(*no) actgrp('NICKLITTEN')
  /endIf
  copyright('SIMPWEBSQL: Version 1.0 June 2022');

dcl-ds psds PSDS qualified;
  program char(10) pos(1);
end-ds;


//-- SIMPWEBSQL - Consume an external internet webservice from
//-- my IBMi System. Get the JSON result and let SQL decompose
//-- that from JSON into fields that I can use.
dcl-proc SIMPWEBSQL;
dcl-pi SIMPWEBSQL end-pi;

// Output values
dcl-s g_firstname varchar(50);
dcl-s g_surname varchar(50);
dcl-s g_website varchar(50);

// result string humans who like to know what happened
dcl-s g_result char(50);

monitor;

    // consume external webservice
    exec sql
    select firstname, surname, website
    into :g_firstname, :g_surname, :g_website
    from JSON_TABLE( SYSTOOLS.HTTPGETCLOB (
    'http://nicklitten.com/sample.json', null), '$'
    COLUMNS(
    firstname VARCHAR(50) path '$.firstName',
    surname VARCHAR(50) path '$.surName',
    website VARCHAR(50) path '$.webSite'
    ) error on error
    ) as x;

    Select;
    when sqlcode = 0;
    g_result = 'Completed normally';
    when sqlcode = 100;
    g_result = 'No data found';
    when sqlcode > 0;
    g_result = 'Completed with warning';
    when sqlcode < 0;
    g_result = 'Did not complete normally';
    endsl;

    // Display values returned
    DSPLY sqlcode;
    DSPLY g_firstname;
    DSPLY g_surname;
    DSPLY g_website;

    return;

on-error ;
    dump(a);
    dsply ('*** Webservice(' + %trim(psds.program) + ') has failed!');
endmon ;

end-proc;