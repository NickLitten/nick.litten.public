**free
//
// program name: SORTSFL-Sortable_Subfile.pgm.rpgle
// description:  example of a sortable subfile using embedded sql
//
// modification history:                                                 
// v.000 2025.10.16 njl created for online example     
//

ctl-opt
     optimize(*full)
     option(*nodebugio:*srcstmt:*nounref)
     pgminfo(*pcml:*module)
     actgrp(*new)
     indent('| ')
     alwnull(*usrctl)
     copyright('SORTSFL | V.000 | Sortable Subfile using SQL in RPG');

dcl-f SORTSFLPF disk usage(*input) keyed;
dcl-f SORTSFL workstn SFILE(SFL01:RRN);

dcl-s rrn zoned(4:0);
dcl-s SortField char(10);
dcl-s SortOrder char(4) inz('ASC');
dcl-s LastSortField char(10);
dcl-s WhereClause varchar(1000);
dcl-s SqlStmt varchar(1000);
dcl-s srchdate zoned(8:0);
dcl-s srchtime zoned(6:0);
dcl-s srchuser char(10);
dcl-s srchcmd char(10);
dcl-s srchstat char(3);


SortField = 'NOTDATE';
SortOrder = 'ASC';
exsr DisplaySubfile;

return;



begsr ClearSubfile;
   *In30 = *On;
   WRITE CTL01;
   *In30 = *Off;
    rrn = 0;
endsr;



begsr BuildWhere;
    WhereClause = '';
    if srchdate <> 0;
        WhereClause = %trim(WhereClause) + ' AND NOTDATE = ' + %char(srchdate);
    endif;
    if srchtime <> 0;
        WhereClause = %trim(WhereClause) + ' AND NOTTIME = ' + %char(srchtime);
    endif;
    if srchuser <> '';
        WhereClause = %trim(WhereClause) + ' AND NOTUSER LIKE ''%' + %trim(srchuser) + '%''';
    endif;
    if srchcmd <> '';
        WhereClause = %trim(WhereClause) + ' AND NOTCMD LIKE ''%' + %trim(srchcmd) + '%''';
    endif;
    if srchstat <> '';
        WhereClause = %trim(WhereClause) + ' AND NOTSTATUS LIKE ''%' + %trim(srchstat) + '%''';
    endif;
    if WhereClause <> '';
        WhereClause = 'WHERE' + %subst(WhereClause : 5);
    endif;
endsr;



begsr LoadSubfile;

    exsr BuildWhere;

    eval SqlStmt = 'SELECT NOTDATE, NOTTIME, ' +
        'NOTUSER, NOTCMD, NOTSTATUS ' +
              'FROM SORTSFLPF ' +
        %trim(WhereClause) + 
              ' ORDER BY ' +
        %trim(SortField) + ' ' +
              SortOrder;

    exec sql declare myCursor cursor for S1;

    exec sql prepare S1 from :SqlStmt;

    exec sql open myCursor;

    exec sql fetch next from myCursor into :NOTDATE, :NOTTIME, :NOTUSER, :NOTCMD, :NOTSTATUS;

    dow sqlcode = 0;
        rrn += 1;
        write SFL01;
        exec sql fetch next from myCursor into :NOTDATE, :NOTTIME, :NOTUSER, :NOTCMD, :NOTSTATUS;
    enddo;

    exec sql close myCursor;

endsr;

begsr DisplaySubfile;
    dow *IN03 = *off;
        exsr ClearSubfile;
        exsr LoadSubfile;
        *in31 = (rrn > 0);
        write CTL01;
        exfmt CTL01;
        if *IN03 = *on;
            leave;
        endif;
        if *IN05 = *on;
            if row = 2;
                select;
                    when col >= 2 and col <= 9;
                        SortField = 'NOTDATE';
                        exsr ToggleSort;
                    when col >= 12 and col <= 17;
                        SortField = 'NOTTIME';
                        exsr ToggleSort;
                    when col >= 22 and col <= 31;
                        SortField = 'NOTUSER';
                        exsr ToggleSort;
                    when col >= 34 and col <= 43;
                        SortField = 'NOTCMD';
                        exsr ToggleSort;
                    when col >= 46 and col <= 48;
                        SortField = 'NOTSTATUS';
                        exsr ToggleSort;
                endsl;
            endif;
            iter;
        endif;
    enddo;
endsr;

begsr ToggleSort;
    if SortField = LastSortField;
        if SortOrder = 'ASC';
            SortOrder = 'DESC';
        else;
            SortOrder = 'ASC';
        endif;
    else;
        SortOrder = 'ASC';
    endif;
    LastSortField = SortField;
endsr;

