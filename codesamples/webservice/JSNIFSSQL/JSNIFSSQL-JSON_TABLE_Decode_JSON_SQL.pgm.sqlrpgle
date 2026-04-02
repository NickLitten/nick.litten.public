**free

/// Program: JSNIFSSQL - JSON_TABLE Decode JSON using SQL
///
/// Description: Demonstrates reading JSON data from an IFS file and parsing it
///              using SQL JSON_TABLE functions. This program loads JSON data
///              from the IFS into a CLOB variable, then uses SQL's JSON_TABLE
///              function to parse and extract structured data into RPG data
///              structures for further processing.
///
/// Purpose: Educational example demonstrating:
///   - Reading JSON files from the IFS using C API functions
///   - Parsing JSON data using SQL JSON_TABLE function
///   - Extracting nested JSON arrays into RPG data structures
///   - Handling JSON data in embedded SQL within SQLRPGLE
///   - Processing multiple JSON records in a cursor loop
///
/// Features:
///   - Reads JSON file from IFS using open/read/close C APIs
///   - Loads JSON data into SQL CLOB variable for processing
///   - Uses JSON_TABLE to parse nested JSON arrays
///   - Extracts user data (userID, firstName, lastName, etc.)
///   - Stores parsed data in array of data structures
///   - Provides success/error result handling
///   - Supports up to 9999 JSON records
///
/// Usage: CALL JSNIFSSQL
///        (No parameters required - reads from hardcoded IFS path)
///
/// Parameters: None
///
/// SQL Usage:
///   - JSON_TABLE function to parse JSON structure
///   - Cursor C1 to iterate through parsed JSON records
///   - Nested path '$.users[*]' to access JSON array elements
///   - Individual field paths for data extraction
///
/// Dependencies:
///   - IFS file: /home/nicklitten/getwebjsn.json
///   - C API functions: open(), read(), close()
///   - SQL JSON_TABLE function (requires IBM i 7.2 or higher)
///   - Activation group: NICKLITTEN
///
/// Control Options:
///   - dftactgrp(*no): Required for ILE procedures and SQL
///   - actgrp('NICKLITTEN'): Named activation group for resource management
///   - option(*nodebugio): Disables debug I/O for performance
///   - option(*srcstmt): Includes source statements in debug view
///   - option(*nounref): Flags unreferenced variables
///   - datfmt(*ISO): Uses ISO date format (YYYY-MM-DD)
///
/// Modification History:
/// 1.0 2017-07-17 | Nick Litten | Initial creation
/// 1.1 2021-06-20 | Nick Litten | Removed unused variables for clarity
/// 1.2 2026-04-02 | Bob AI | Added comprehensive triple-slash documentation

ctl-opt dftactgrp(*no) actgrp('NICKLITTEN')
 option(*nodebugio:*srcstmt:*nounref)
 datfmt(*ISO) decedit('0.')
 copyright('| JSNIFSSQL V1.1 Use JSONTABLE to read IFS and parse JSON');

// IFS file with JSON code that we will be reading and decoding
dcl-c ifsFilename const('/home/nicklitten/getwebjsn.json');

dcl-ds jsonFields qualified;
    USERID varchar(100);
    FIRSTNAME varchar(100);
    LASTNAME varchar(100);
    INITIALS varchar(100);
    COMPANY int(10);
    DIVISION int(10);
    DEPARTMENT int(10);
end-ds;

dcl-ds result qualified;
    success ind;
    errmsg varchar(500);
    jsonArray likeds(jsonFields) dim(9999);
end-ds;

// procedures and variables for IBM i *APIS to loads IFS into variable
dcl-pr open int(10) extproc('open');
    *n pointer value options(*string); // filename
    *n int(10) value; // openflags
    *n uns(10) value options(*nopass); // mode
    *n uns(10) value options(*nopass); // codepage
end-pr;

dcl-pr read int(10) extproc('read');
    *n int(10) value; // filehandle
    *n pointer value; // datareceived
    *n uns(10) value; // nbytes
end-pr;

dcl-pr close int(10) extproc('close');
    *n int(10) value; // filehandle
end-pr;

dcl-s Count int(10);
dcl-s Handle int(10);
dcl-s json sqltype(clob:16000000);
dcl-s ifsData char(16000000);
dcl-s ifsDataLen int(10);
dcl-s rc int(10);
dcl-s O_RDONLY int(10) inz(1);
dcl-s O_TEXTDATA int(10) inz(16777216);
dcl-s lastElem int(10);

dcl-ds ErrorCode;
    BytesProv int(10) inz(0);
    BytesAvail int(10) inz(0);
end-ds;


// Open the stream file
Handle = open(%trim(ifsFilename):O_RDONLY + O_TEXTDATA);

// Loop to read the stream file into variable "ifsData"
dou ifsDataLen<1;
    Count += 1;
    ifsDataLen = read(Handle:%addr(ifsData):%size(ifsData));
enddo;

// Close the stream file
rc = close(Handle);

if ifsData <> *blanks;

    // we have the IFS data loaded into variable(ifsData) so lets load
    // that variable into the SQL(clob) and process it using the JSON_TABLE
    // to break the JSON out into fields for processing. NOTE: we are not
    // doing anything with those fields in this program because this is just
    // a proof of concept
    exec sql
    set option naming = *sys,
                      commit = *none,
                      usrprf = *user,
                      dynusrprf = *user,
                      datfmt = *iso,
                      closqlcsr = *endmod;

    // read the JSON data from a string variable using JSON_TABLE
    exec sql
    declare C1 cursor for
    select *
        from json_table(
            :JSON,
            '$'
            columns(
            nested '$.users[*]' columns(
                USERID varchar(100) path '$.userID',
                FIRSTNAME varchar(100) path '$.firstName',
                LASTNAME varchar(100) path '$.lastName',
                INITIALS varchar(100) path '$.initials',
                COMPANY int path '$.company',
                DIVISION int path '$.division',
                DEPARTMENT int path '$.department'
            )
            )
        ) as X;

    exec sql open c1;

    exec sql fetch next from c1 into :jsonfields;

    dow sqlstt='00000' or %subst(sqlstt:1:2)='01';

        lastelem += 1;  

        // Store Datastructure values in next element of 'return array'
        result.jsonArray(lastelem) = jsonFields;

        // here we could do something with each row of data ie: write to file
        // or some other business logic.
        exec sql fetch next from c1 into :jsonfields;

    enddo;

    exec sql
    close c1;

    result.success = *on;
 
else;

    // If unable to load JSON data from the IFS then tell the world
    result.success = *off;
    result.errmsg = 'Ouch! I couldnt read the IFS file';

endif;

*inlr = *on;
