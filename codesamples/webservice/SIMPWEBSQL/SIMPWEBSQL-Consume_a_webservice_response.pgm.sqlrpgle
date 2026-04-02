**free

/// Program: SIMPWEBSQL - Consume a Webservice Response
///
/// Description: Demonstrates consuming an external REST API webservice from
///              IBM i using SQL's HTTPGETCLOB and JSON_TABLE functions. Fetches
///              JSON data from a web endpoint and parses it into RPG variables
///              using embedded SQL, showing a simple and efficient approach to
///              web service integration without external tools.
///
/// Purpose: Educational example demonstrating:
///   - Consuming external REST APIs from IBM i
///   - Using SYSTOOLS.HTTPGETCLOB for HTTP GET requests
///   - Parsing JSON responses with JSON_TABLE function
///   - Extracting JSON fields into RPG host variables
///   - SQL-based web service consumption
///   - Error handling for web service calls
///
/// Features:
///   - Fetches JSON data from external URL
///   - Parses JSON using SQL JSON_TABLE function
///   - Extracts firstName, surName, and webSite fields
///   - Handles SQL return codes (success, no data, warnings, errors)
///   - Displays retrieved values for verification
///   - Comprehensive error handling with MONITOR/ON-ERROR
///   - Dumps program state on error for debugging
///
/// Usage: CALL SIMPWEBSQL
///        (Fetches and displays data from nicklitten.com/sample.json)
///
/// Parameters: None
///
/// SQL Usage:
///   - SYSTOOLS.HTTPGETCLOB() to fetch JSON from URL
///   - JSON_TABLE() to parse JSON structure
///   - JSON path expressions ($.firstName, $.surName, $.webSite)
///   - SELECT INTO to extract values into host variables
///   - SQLCODE checking for result status
///
/// Dependencies:
///   - External URL: http://nicklitten.com/sample.json
///   - SYSTOOLS.HTTPGETCLOB function (IBM i 7.2+)
///   - JSON_TABLE function (IBM i 7.2+)
///   - Internet connectivity from IBM i
///
/// Compile Command:
/// CRTSQLRPGI OBJ(WEBSERVICE/SIMPWEBSQL)
///            SRCSTMF('/home/nicklitten/source-webservices/SIMPWEBSQL.sqlrpgle')
///            COMMIT(*NONE) OBJTYPE(*PGM) DBGVIEW(*SOURCE) CVTCCSID(*JOB)
///
/// Control Options:
///   - main(SIMPWEBSQL): Uses main procedure pattern
///   - pgminfo(*PCML:*MODULE:*DCLCASE): Generates PCML metadata
///   - option(*srcstmt): Includes source statements
///   - option(*nodebugio): Disables debug I/O
///   - dftactgrp(*no): Required for ILE and SQL
///   - actgrp('NICKLITTEN'): Named activation group
///
/// Modification History:
/// 1.0 2022-06-11 | Nick Litten | Initial creation
/// 1.1 2026-04-02 | Bob AI | Added comprehensive triple-slash documentation

/title Simply consume a webservice response from nicklitten dot com
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