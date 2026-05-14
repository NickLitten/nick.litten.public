**free

/// Program: STOREPRCR - Stored Procedure RPG Employee
///
/// Description: Simple RPG stored procedure that retrieves employee details
///              based on employee ID using native record-level I/O. Designed
///              to be called from SQL as a stored procedure, demonstrating
///              traditional RPG file processing techniques within a modern
///              stored procedure framework.
///
/// Purpose: Educational example demonstrating:
///   - RPG stored procedure implementation using MAIN procedure
///   - Native record-level I/O for database access
///   - Sequential file reading with %EOF checking
///   - Parameter passing (input employee ID, output name and city)
///   - File opening and closing within procedure scope
///   - Conditional logic for record matching
///
/// Features:
///   - Uses MAIN procedure for stored procedure entry point
///   - Accepts employee ID as input parameter
///   - Returns employee name and city as output parameters
///   - Reads EMPLO00001 file sequentially
///   - Searches for matching employee ID
///   - Returns 'no employee found' if ID not found
///   - Properly opens and closes file resources
///   - Uses PCML for external program interface
///
/// Usage: CALL STOREPRCR PARM(employee_id, employee_name, city)
///        Or via SQL: CALL library.STOREPRCR(123, ?, ?)
///
/// Parameters:
///   - emp_id_in: int(10) const - Employee ID to search for
///   - emp_name_out: char(50) - Employee name (output)
///   - city_out: char(30) - Employee city (output)
///
/// Dependencies:
///   - File: NICKLITTEN/EMPLO00001 (employee master file)
///   - Record format: EMPLREC
///   - Fields: emp_id, emp_name, city
///
/// Control Options:
///   - main(mainline): Specifies main procedure entry point
///   - optimize(*full): Full optimization for performance
///   - option(*nodebugio): Disables debug I/O
///   - option(*srcstmt): Includes source statements in debug
///   - option(*nounref): Flags unreferenced variables
///   - pgminfo(*pcml:*module): Generates PCML for external calls
///   - actgrp(*new): Creates new activation group per call
///   - alwnull(*usrctl): Allows null-capable fields with user control
///
/// Modification History:
/// 1.0 2025-10-14 | Nick Litten | Created for online example
/// 1.1 2026-04-02 | Bob AI | Added comprehensive triple-slash documentation

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