**free

/// Program: STOREPRCRS - Stored Procedure with Result Set
///
/// Description: SQLRPG stored procedure that returns multiple rows using
///              SQL result sets. Demonstrates how to return a dynamic result
///              set to the calling application, allowing retrieval of multiple
///              employee records based on search criteria.
///
/// Purpose: Educational example demonstrating:
/// - SQL stored procedure with result set return
/// - Dynamic result set using DECLARE CURSOR
/// - OPEN cursor with RETURN TO CALLER
/// - Multiple row retrieval capability
/// - Parameter-based filtering
/// - Modern stored procedure patterns
///
/// Features:
/// - Returns multiple rows via result set
/// - Accepts department code as input parameter
/// - Uses cursor to define result set
/// - OPEN cursor leaves it open for caller
/// - Caller can fetch all matching rows
/// - No row count limitation
/// - Efficient set-based processing
/// - Uses PCML for external program interface
///
/// Usage:
///   Via SQL:
///     CALL library.STOREPRCRS('SALES')
///     -- Then fetch from result set
///
///   Via JDBC/ODBC:
///     CallableStatement cs = conn.prepareCall("CALL library.STOREPRCRS(?)");
///     cs.setString(1, "SALES");
///     ResultSet rs = cs.executeQuery();
///     while (rs.next()) {
///       // Process each row
///     }
///
/// Parameters:
/// - dept_code_in: char(10) const - Department code to filter by
///
/// Result Set Columns:
/// - emp_id: int(10) - Employee ID
/// - emp_name: char(50) - Employee name
/// - city: char(30) - Employee city
/// - salary: dec(11,2) - Employee salary
///
/// SQL Usage:
/// - DECLARE CURSOR for result set definition
/// - OPEN cursor with RETURN TO CALLER
/// - Cursor remains open for caller to fetch
/// - WHERE clause filtering by department
///
/// Dependencies:
/// - Table: nicklitten/employee_master
/// - Columns: emp_id, emp_name, city, salary, dept_code
///
/// Control Options:
/// - main(mainline): Specifies main procedure entry point
/// - optimize(*full): Full optimization for performance
/// - option(*nodebugio): Disables debug I/O
/// - option(*srcstmt): Includes source statements in debug
/// - pgminfo(*pcml:*module): Generates PCML for external calls
/// - actgrp(*new): Creates new activation group per call
/// - alwnull(*usrctl): Allows null-capable fields
///
/// Reference:
///   https://www.ibm.com/docs/en/i/7.5?topic=procedures-returning-result-sets
///
/// Modification History:
/// 2023-11-03 V1.0 Initial creation - Nick Litten
/// ---

ctl-opt
     main(mainline)
     optimize(*full)
     option(*nodebugio:*srcstmt:*nounref)
     pgminfo(*pcml:*module)
     actgrp(*new)
     indent('| ')
     alwnull(*usrctl)
     copyright('V1.0 - Stored Procedure with Result Set');

Dcl-Proc mainline;
   Dcl-Pi *n;
      dept_code_in char(10) const;
   end-pi;

   // Declare cursor for result set
   // This cursor will be returned to the caller
   exec sql
        declare c1 cursor for
        select emp_id,
               emp_name,
               city,
               salary
        from nicklitten/employee_master
        where dept_code = :dept_code_in
        order by emp_name;

   // Open cursor and return to caller
   // The cursor remains open for the caller to fetch rows
   exec sql
        open c1;

   // Set result sets - tells SQL this procedure returns result sets
   exec sql
        set result sets cursor c1;

   Return;
end-proc;