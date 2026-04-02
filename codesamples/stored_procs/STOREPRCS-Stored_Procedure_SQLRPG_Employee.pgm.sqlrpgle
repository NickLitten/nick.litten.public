**free

/// Program: STOREPRCS - Stored Procedure SQLRPG Employee
///
/// Description: Simple SQLRPG stored procedure that retrieves employee details
///              based on employee ID using embedded SQL. Designed to be called
///              from SQL as a stored procedure, demonstrating modern SQL-based
///              database access within RPG with efficient single-row retrieval
///              and error handling.
///
/// Purpose: Educational example demonstrating:
///   - SQLRPG stored procedure implementation using MAIN procedure
///   - Embedded SQL for direct database access
///   - Single-row SELECT with INTO clause
///   - SQL error handling with SQLCODE checking
///   - Parameter passing (input employee ID, output name and city)
///   - Efficient set-based data retrieval
///
/// Features:
///   - Uses MAIN procedure for stored procedure entry point
///   - Accepts employee ID as input parameter
///   - Returns employee name and city as output parameters
///   - Executes SQL SELECT directly into host variables
///   - Checks SQLCODE for query success/failure
///   - Returns 'no employee found' if query fails
///   - No file opening/closing required (SQL handles resources)
///   - Uses PCML for external program interface
///
/// Usage: CALL STOREPRCS PARM(employee_id, employee_name, city)
///        Or via SQL: CALL library.STOREPRCS(123, ?, ?)
///
/// Parameters:
///   - emp_id_in: int(10) const - Employee ID to search for
///   - emp_name_out: char(50) - Employee name (output)
///   - city_out: char(30) - Employee city (output)
///
/// SQL Usage:
///   - SELECT with INTO clause for single-row retrieval
///   - WHERE clause filtering by employee ID
///   - SQLCODE checking for error detection
///   - Direct table access: nicklitten/employee_master
///
/// Dependencies:
///   - Table: nicklitten/employee_master
///   - Columns: emp_id, emp_name, city
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