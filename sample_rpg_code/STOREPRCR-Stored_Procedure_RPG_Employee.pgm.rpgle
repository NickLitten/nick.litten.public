**free
//
// program name: storeprcr-stored_procedure_rpg_employee.pgm.sqlrpgle
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
  copyright('STOREPRCR | V.000 | Stored Procedure using native IO RPG');


Dcl-Proc mainline;
  Dcl-Pi mainline;
       emp_id_in int(10) const;
       emp_name_out char(50);
       city_out char(30);
  end-pi;

  dcl-f EMPLO00001 usage(*input) extfile('NICKLITTEN/EMPLO00001') rename(EMPLO00001:EMPLREC) usropn;
  dcl-ds ds_employee_master likerec(EMPLREC:*INPUT) inz;
  dcl-s employeeFound ind;

  open EMPLO00001;

  read EMPLO00001 ds_employee_master;
  dow not %eof(EMPLO00001);
     if emp_id_in = ds_employee_master.emp_id;
          employeeFound = *on;
          leave;
     endif;
     read EMPLO00001 ds_employee_master;
  enddo;
  
  if employeeFound;
     emp_name_out = ds_employee_master.emp_name;
     city_out = ds_employee_master.city;
  else;
     emp_name_out = 'no employee found';
     city_out = 'n/a';
  endif;
  
  close EMPLO00001;

  return;
  
end-proc;