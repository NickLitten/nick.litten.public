**free

///
/// Program: {PROGRAM_NAME}
///
/// Description: {DESCRIPTION}
///
/// Purpose: {PURPOSE}
///   - {PURPOSE_ITEM_1}
///   - {PURPOSE_ITEM_2}
///   - {PURPOSE_ITEM_3}
///
/// Features:
///   - {FEATURE_1}
///   - {FEATURE_2}
///   - {FEATURE_3}
///
/// Usage: {USAGE_EXAMPLE}
///
/// Parameters:
///   - {PARAM_1}: {PARAM_1_DESC}
///   - {PARAM_2}: {PARAM_2_DESC}
///
/// Dependencies:
///   - {DEPENDENCY_1}
///   - {DEPENDENCY_2}
///
/// Reference:
///   {REFERENCE_URL}
///
/// Modification History:
///   {VERSION} {DATE} | {AUTHOR} | {CHANGE_DESCRIPTION}
///

// -------------------------------------------------------------------
// Control Options - Modern ILE RPG with SQL Best Practices
// -------------------------------------------------------------------
ctl-opt dftactgrp(*no) actgrp(*caller)
        option(*nodebugio:*srcstmt:*sqlcursorstay)
        bnddir('NICKLITTEN')
        main(MainProcedure)
        alwnull(*usrctl)
        datfmt(*iso)
        timfmt(*iso)
        decedit('0,')
        copyright('{VERSION} - {DESCRIPTION}');

// ---------------------------------------------------------------------------
// Program Information Data Structure
// ---------------------------------------------------------------------------
dcl-ds pgmInfo psds qualified;
  pgmName *proc;
  status *status;
  user char(10) pos(254);
  jobName char(10) pos(244);
  jobUser char(10) pos(254);
  jobNumber char(6) pos(264);
end-ds;

// -------------------------------------------------------------------
// SQL Options
// -------------------------------------------------------------------
exec sql set option
  commit = *none,
  naming = *sql,
  closqlcsr = *endmod,
  datfmt = *iso,
  timfmt = *iso;

// -------------------------------------------------------------------
// File Declarations
// -------------------------------------------------------------------
// dcl-f MYFILE usage(*input) keyed;

// -------------------------------------------------------------------
// Program Interface (if used as a called program)
// -------------------------------------------------------------------
// dcl-pi *n;
//   parmIn char(10);
//   parmOut char(50);
// end-pi;

// -------------------------------------------------------------------
// Procedure Prototypes
// -------------------------------------------------------------------
dcl-pr MainProcedure extpgm('{program_name}');
  // Add parameters here if needed
end-pr;

// Example procedure prototype
// dcl-pr GetCustomerName varchar(50);
//   customerId int(10) const;
// end-pr;

// -------------------------------------------------------------------
// Standalone Variables
// -------------------------------------------------------------------
dcl-s gMessage varchar(100);
dcl-s gReturnCode int(10);
dcl-s gSqlCode int(10);
dcl-s gSqlState char(5);

// -------------------------------------------------------------------
// Constants
// -------------------------------------------------------------------
dcl-c SUCCESS 0;
dcl-c ERROR -1;
dcl-c SQL_SUCCESS 0;
dcl-c SQL_NOT_FOUND 100;

// -------------------------------------------------------------------
// Data Structures
// -------------------------------------------------------------------
dcl-ds ErrorInfo qualified;
  code int(10);
  message varchar(100);
  sqlCode int(10);
  sqlState char(5);
  timestamp timestamp;
end-ds;

// SQL Result Set Structure Example
dcl-ds CustomerData qualified;
  id int(10);
  name varchar(50);
  email varchar(100);
  status char(1);
  createdDate date;
end-ds;

// -------------------------------------------------------------------
// Main Procedure
// -------------------------------------------------------------------
dcl-proc MainProcedure;
  dcl-pi *n;
    // Add parameters here if needed
  end-pi;

  // Local variables
  dcl-s counter int(10);
  dcl-s isValid ind;

  // ---------------------------------------------------------------
  // Main Logic
  // ---------------------------------------------------------------

  // Initialize
  counter = 0;
  isValid = *on;
  gReturnCode = SUCCESS;

  // TODO: Add your main program logic here

  // Example: Execute SQL query
  // exec sql
  //   select id, name, email, status, created_date
  //   into :CustomerData.id, :CustomerData.name, :CustomerData.email,
  //        :CustomerData.status, :CustomerData.createdDate
  //   from myschema.customers
  //   where id = :customerId;
  //
  // if CheckSqlError();
  //   // Handle error
  // endif;

  // Example: Call a procedure
  // gMessage = GetCustomerName(12345);

  // Cleanup and return
  return;

end-proc;

// -------------------------------------------------------------------
// Supporting Procedures
// -------------------------------------------------------------------

// -------------------------------------------------------------------
// Procedure: CheckSqlError
// Purpose  : Check for SQL errors and log them
// Returns  : *on if error occurred, *off if successful
// -------------------------------------------------------------------
dcl-proc CheckSqlError;
  dcl-pi *n ind end-pi;

  dcl-s hasError ind;

  exec sql get diagnostics
    :gSqlCode = db2_returned_sqlcode,
    :gSqlState = returned_sqlstate;

  hasError = (gSqlCode < SQL_SUCCESS and gSqlCode <> SQL_NOT_FOUND);

  if hasError;
    ErrorInfo.code = ERROR;
    ErrorInfo.sqlCode = gSqlCode;
    ErrorInfo.sqlState = gSqlState;
    ErrorInfo.message = 'SQL Error: ' + %char(gSqlCode);
    ErrorInfo.timestamp = %timestamp();

    // Log error (implement your logging here)
    // LogError(ErrorInfo);
  endif;

  return hasError;

end-proc;

// -------------------------------------------------------------------
// Procedure: GetCustomerName
// Purpose  : Retrieve customer name by ID using SQL
// Parameters:
//   customerId - Customer ID to look up
// Returns  : Customer name or empty string if not found
// -------------------------------------------------------------------
// dcl-proc GetCustomerName;
//   dcl-pi *n varchar(50);
//     customerId int(10) const;
//   end-pi;
//
//   dcl-s customerName varchar(50);
//
//   // Initialize
//   customerName = '';
//
//   // Execute SQL query
//   exec sql
//     select name
//     into :customerName
//     from myschema.customers
//     where id = :customerId
//     fetch first 1 row only;
//
//   // Check for errors
//   if CheckSqlError();
//     customerName = '';
//   endif;
//
//   return %trim(customerName);
//
// end-proc;

// -------------------------------------------------------------------
// Procedure: ExecuteQuery
// Purpose  : Example of cursor-based query processing
// Parameters:
//   searchTerm - Search term for filtering
// Returns  : Number of records processed
// -------------------------------------------------------------------
// dcl-proc ExecuteQuery;
//   dcl-pi *n int(10);
//     searchTerm varchar(50) const;
//   end-pi;
//
//   dcl-s recordCount int(10);
//   dcl-s isDone ind;
//
//   // Initialize
//   recordCount = 0;
//   isDone = *off;
//
//   // Declare cursor
//   exec sql declare c1 cursor for
//     select id, name, email, status
//     from myschema.customers
//     where name like :searchTerm
//     order by name
//     for read only;
//
//   // Open cursor
//   exec sql open c1;
//
//   if CheckSqlError();
//     return -1;
//   endif;
//
//   // Fetch records
//   dow not isDone;
//     exec sql fetch next from c1
//       into :CustomerData.id, :CustomerData.name,
//            :CustomerData.email, :CustomerData.status;
//
//     if CheckSqlError();
//       isDone = *on;
//     elseif gSqlCode = SQL_NOT_FOUND;
//       isDone = *on;
//     else;
//       // Process record
//       recordCount += 1;
//       // TODO: Add your record processing logic here
//     endif;
//   enddo;
//
//   // Close cursor
//   exec sql close c1;
//
//   return recordCount;
//
// end-proc;

// -------------------------------------------------------------------
// Procedure: ExecuteUpdate
// Purpose  : Example of SQL UPDATE with error handling
// Parameters:
//   customerId - Customer ID to update
//   newStatus  - New status value
// Returns  : *on if successful, *off if error
// -------------------------------------------------------------------
// dcl-proc ExecuteUpdate;
//   dcl-pi *n ind;
//     customerId int(10) const;
//     newStatus char(1) const;
//   end-pi;
//
//   dcl-s rowsAffected int(10);
//
//   // Execute update
//   exec sql
//     update myschema.customers
//     set status = :newStatus,
//         modified_date = current_date,
//         modified_time = current_time
//     where id = :customerId;
//
//   if CheckSqlError();
//     return *off;
//   endif;
//
//   // Get rows affected
//   exec sql get diagnostics :rowsAffected = row_count;
//
//   return (rowsAffected > 0);
//
// end-proc;

// -------------------------------------------------------------------
// Procedure: ExecuteInsert
// Purpose  : Example of SQL INSERT with error handling
// Parameters:
//   customerData - Customer data structure to insert
// Returns  : New customer ID or -1 if error
// -------------------------------------------------------------------
// dcl-proc ExecuteInsert;
//   dcl-pi *n int(10);
//     customerData likeds(CustomerData) const;
//   end-pi;
//
//   dcl-s newId int(10);
//
//   // Execute insert
//   exec sql
//     insert into myschema.customers
//       (name, email, status, created_date)
//     values
//       (:customerData.name, :customerData.email,
//        :customerData.status, current_date);
//
//   if CheckSqlError();
//     return -1;
//   endif;
//
//   // Get generated ID (if using identity column)
//   exec sql
//     select identity_val_local()
//     into :newId
//     from sysibm.sysdummy1;
//
//   if CheckSqlError();
//     return -1;
//   endif;
//
//   return newId;
//
// end-proc;

// -------------------------------------------------------------------
// End of Program
// -------------------------------------------------------------------