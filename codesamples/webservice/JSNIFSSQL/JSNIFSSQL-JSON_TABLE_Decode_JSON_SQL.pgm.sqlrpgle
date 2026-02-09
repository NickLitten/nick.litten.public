**FREE

/TITLE JSON_TABLE Decode JSON using SQL - Proof of Concept

// PROGRAM CREATION OVERRIDES:
// Create as a Module and bind into ILE program
//
// JSNIFSSQL.sqlrpgle (fully /free)
//
// This demonstrates reading JSON data from an IFS file and then
// parsing that JSON using SQL JSON_TABLE functions.
//
// The JSON data is loaded into a data structure suitable
// for display from a program debugger.
//
// MODIFICATION HISTORY:
// 07/17/2017 nick litten V1.0 Created
// 06/20/2021 nick litten V1.1 Removed unused variables for clarity

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