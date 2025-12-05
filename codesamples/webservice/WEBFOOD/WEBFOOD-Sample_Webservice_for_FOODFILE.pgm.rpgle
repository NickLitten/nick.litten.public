**free
//
// program name: WEBFOOD-Sample_Webservice_for_FOODFILE.pgm.sqlrpgle
// description: Sample RPGLE program to provide webservice access to FOODFILE
//
// modification history:                                                 
// v.000 2025.10.19 njl created for online example     
//

ctl-opt
main(mainline)
    optimize(*full)
    option(*nodebugio:*srcstmt:*nounref)
    pgminfo(*pcml:*module)
    actgrp(*new)
    indent('| ')
    alwnull(*usrctl)
    copyright('WEBFOOD | V.000 | Sample CGI Webservice');

    dcl-f FOODFILE usage(*INPUT:*OUTPUT:*UPDATE:*DELETE) keyed usropn rename(FOODFILE:RECFOOD);

    dcl-proc mainline;
        dcl-pi *n;
            function char(3);
            rtntext char(100);
            data likeds(FoodRec);
        end-pi;

        // fields come from FOODFILE record format
        dcl-ds FoodRec extname('FOODFILE':*input) qualified inz; // EXTNAME binds the file layout
        end-ds;

        monitor;

            if function <> 'GET' and function <> 'ADD' and function <> 'UPD' and function <> 'DLT';
                rtntext = '(INVALID) Function must be READ/ADD/UPDATE/DELETE: ' + %trim(function);
            else;

                open foodfile;

                select;
                    when function = 'GET';
                        chain (data.INGID) FOODFILE;
                        if %found(FOODFILE);
                            data.INGNAME = INGNAME;
                            data.CATEGORY = CATEGORY;
                            data.MEASURE = MEASURE;
                            data.QUANTITY = QUANTITY;
                            data.EXPDATE = EXPDATE;
                            data.ORGANIC = ORGANIC;
                            rtntext = 'Row ' + %char(data.INGID) + ' Successfully Read';
                        else;
                            rtntext = '(READ FAIL) Ingredient ID does not exist: ' + %char(data.INGID);
                        endif;

                    when function = 'ADD';
                        chain (data.INGID) FOODFILE;
                        if not %found(FOODFILE);
                            INGNAME = %trimr(data.INGNAME);
                            CATEGORY = %trimr(data.CATEGORY);
                            MEASURE = %trimr(data.MEASURE);
                            QUANTITY = data.QUANTITY;
                            EXPDATE = data.EXPDATE;
                            ORGANIC = data.ORGANIC;
                            write RECFOOD;
                            rtntext = 'Row ' + %char(data.INGID) + ' Successfully Added';
                        else;
                            rtntext = '(ADD FAIL) Ingredient ID already exists: ' + %char(data.INGID);
                        endif;

                    when function = 'UPD';
                        chain (data.INGID) FOODFILE;
                        if %found(FOODFILE);
                            INGNAME = %trimr(data.INGNAME);
                            CATEGORY = %trimr(data.CATEGORY);
                            MEASURE = %trimr(data.MEASURE);
                            QUANTITY = data.QUANTITY;
                            EXPDATE = data.EXPDATE;
                            ORGANIC = data.ORGANIC;
                            update RECFOOD;
                            rtntext = 'Data Successfully Updated';
                        else;
                            rtntext = '(UPDATE FAIL) Ingredient ID does not exist for UPDATE: ' + %char(data.INGID);
                        endif;

                    when function = 'DLT';
                        chain (data.INGID) FOODFILE;
                        if %found(FOODFILE);
                            delete RECFOOD;
                            rtntext = 'Row ' + %char(data.INGID) + ' Successfully Deleted';
                        else;
                            rtntext = '(DELETE FAIL) Ingredient ID does not exist for DELETE: ' + %char(data.INGID);
                        endif;

                endsl;

                close foodfile;

            endif;

            return;

        on-error;
            rtntext = '(ERROR) Main Program Error: ' + %char(%status);
        endmon;

end-proc;