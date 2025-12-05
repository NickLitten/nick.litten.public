**free
//
// program name: storeprcs-stored_procedure_sqlrpg_employee.pgm.sqlrpgle
// description:  simple example of an rpg stored procedure to retrieve
//               employee details based on employee id. 
//
// modification history:                                                 
// v.000 2025.10.14 njl created for online example     
//

ctl-opt
     main(mainline)
     optimize(*full)
     option(*nodebugio:*srcstmt:*nounref)
     pgminfo(*pcml:*module)
     actgrp(*new)
     indent('| ')
     alwnull(*usrctl)
     copyright('STOREPRCS | V.000 | Stored Procedure using SQL in RPG');

dcl-proc mainline;
     dcl-pi *n;
          emp_id_in int(10) const;
          emp_name_out char(50);
          city_out char(30);
     end-pi;

     exec sql
          select emp_name, city
               into :emp_name_out, :city_out
               from nicklitten/employee_master
               where emp_id = :emp_id_in;

     if sqlcode <> 0;
          emp_name_out = 'no employee found';
          city_out = 'n/a';
     endif;

     return;
end-proc;