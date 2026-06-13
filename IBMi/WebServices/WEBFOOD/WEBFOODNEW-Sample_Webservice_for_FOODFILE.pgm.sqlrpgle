**free
/// -------------------------------------------------------------------
/// Program Name: WEBFOODNEW
/// Description:  RESTful webservice program providing CRUD operations for
///               FOODFILE database. Implements GET, ADD, UPD, and DLT functions
///               for managing food inventory ingredients using embedded SQL.
///
/// Purpose:
/// - Demonstrate RESTful webservice implementation in SQLRPGLE
/// - Provide backend API for food ingredient management
/// - Show proper CRUD operation handling with SQL and validation
/// - Implement comprehensive error handling with SQLSTATE checking
///
/// Features:
/// - GET: Retrieve ingredient record by ID using SQL SELECT
/// - ADD: Create new ingredient with duplicate validation via SQL INSERT
/// - UPD: Update existing ingredient with SQL UPDATE and row count check
/// - DLT: Delete ingredient with SQL DELETE and existence validation
/// - Comprehensive SQL error handling with SQLSTATE and SQLERRD
/// - PCML generation for webservice integration
/// - Modern embedded SQL approach replacing native IO
///
/// Usage:
///   Call with three parameters:
///   1. function (char 3)  - Operation: 'GET', 'ADD', 'UPD', or 'DLT'
///   2. rtntext (char 100) - Return message/status text (output)
///   3. data (FoodRec DS)  - Data structure containing ingredient info
///
/// Database Schema (FOODFILE):
///   - INGID    : Ingredient ID (key field)
///   - INGNAME  : Ingredient name
///   - CATEGORY : Food category
///   - MEASURE  : Unit of measurement
///   - QUANTITY : Quantity amount
///   - EXPDATE  : Expiration date
///   - ORGANIC  : Organic flag
///
/// Author: Nick Litten
///
/// Modification History:
/// v.001 2025.10.19 njl - Initial creation for online example
/// v.002 2026.06.11 njl - Upgraded from native IO to embedded SQL
/// -------------------------------------------------------------------


// -------------------------------------------------------------------
// Control Options
// -------------------------------------------------------------------
ctl-opt
    main(mainline)
    optimize(*full)
    option(*nodebugio:*srcstmt:*nounref:*sqlcursorstay)
    pgminfo(*pcml:*module)
    dftactgrp(*no)
    actgrp(*caller)
    bnddir('QC2LE')
    indent('| ')
    alwnull(*usrctl)
    copyright('v.002 - RESTful webservice using SQL for FOODFILE CRUD operations');

// -------------------------------------------------------------------
// Main Procedure: mainline
//
// Purpose: Entry point for webservice. Processes CRUD operations on FOODFILE
//          using embedded SQL based on the function parameter received.
//
// Parameters:
///   function (input)  - Operation code: 'GET', 'ADD', 'UPD', or 'DLT'
///   rtntext (output)  - Status message returned to caller
///   data (input/output) - Data structure containing ingredient information
//
// Returns: Status message in rtntext parameter
// -------------------------------------------------------------------
Dcl-Proc mainline;
   Dcl-Pi *n;
      function char(3);           // Operation: GET/ADD/UPD/DLT
      rtntext char(100);          // Return status message
      data likeds(FoodRec);       // Ingredient data structure
   end-pi;

   // -------------------------------------------------------------------
   // Data Structure: FoodRec
   // Externally defined from FOODFILE record format
   // Contains all fields from the ingredient database record
   // -------------------------------------------------------------------
   Dcl-Ds FoodRec extname('FOODFILE':*input) qualified inz;
   end-ds;

   // -------------------------------------------------------------------
   // Main Processing Logic with Error Handling
   // -------------------------------------------------------------------
   monitor;

      // Validate function parameter - must be one of four valid operations
      If (function <> 'GET' and function <> 'ADD' and function <> 'UPD' and function <> 'DLT');
         rtntext = '(INVALID) Function must be GET/ADD/UPD/DLT: ' + %trim(function);
      Else;

         // -------------------------------------------------------------------
         // Process Request Based on Function Type
         // -------------------------------------------------------------------
         Select;
               // -------------------------------------------------------------------
               // GET Operation: Retrieve ingredient record by ID using SQL SELECT
               // Returns all ingredient details if found
               // -------------------------------------------------------------------
            When (function = 'GET');
               exec sql
                  SELECT INGNAME, CATEGORY, MEASURE, QUANTITY, EXPDATE, ORGANIC
                  INTO :data.INGNAME, :data.CATEGORY, :data.MEASURE,
                       :data.QUANTITY, :data.EXPDATE, :data.ORGANIC
                  FROM FOODLIB.FOODFILE
                  WHERE INGID = :data.INGID;

               // Check SQL execution status
               If (SQLSTATE = '00000');
                  // Record found - data populated in data structure
                  rtntext = 'Row ' + %char(data.INGID) + ' Successfully Read';
               Else;
                  // Record not found or SQL error
                  rtntext = '(READ FAIL) Ingredient ID does not exist: ' + %char(data.INGID);
               EndIf;

               // -------------------------------------------------------------------
               // ADD Operation: Create new ingredient record using SQL INSERT
               // SQL handles duplicate key validation automatically
               // -------------------------------------------------------------------
            When (function = 'ADD');
               exec sql
                  INSERT INTO FOODLIB.FOODFILE (INGID, INGNAME, CATEGORY, MEASURE, QUANTITY, EXPDATE, ORGANIC)
                  VALUES (:data.INGID, :data.INGNAME, :data.CATEGORY, :data.MEASURE,
                          :data.QUANTITY, :data.EXPDATE, :data.ORGANIC);

               // Check SQL execution status
               If (SQLSTATE = '00000');
                  // Record successfully inserted
                  rtntext = 'Row ' + %char(data.INGID) + ' Successfully Added';
               elseif (SQLSTATE = '23505');
                  // Duplicate key error - ID already exists
                  rtntext = '(ADD FAIL) Ingredient ID already exists: ' + %char(data.INGID);
               Else;
                  // Other SQL error
                  rtntext = '(ADD FAIL) SQL Error: ' + SQLSTATE;
               EndIf;

               // -------------------------------------------------------------------
               // UPD Operation: Update existing ingredient record using SQL UPDATE
               // Validates that record exists by checking rows affected
               // -------------------------------------------------------------------
            When (function = 'UPD');
               exec sql
                  UPDATE FOODLIB.FOODFILE
                  SET INGNAME = :data.INGNAME,
                      CATEGORY = :data.CATEGORY,
                      MEASURE = :data.MEASURE,
                      QUANTITY = :data.QUANTITY,
                      EXPDATE = :data.EXPDATE,
                      ORGANIC = :data.ORGANIC
                  WHERE INGID = :data.INGID;

               // Check SQL execution status and rows affected
               If (SQLSTATE = '00000' and SQLERRD(3) > 0);
                  // Record successfully updated
                  rtntext = 'Data Successfully Updated';
               elseif (SQLERRD(3) = 0);
                  // No rows affected - record not found
                  rtntext = '(UPDATE FAIL) Ingredient ID does not exist: ' + %char(data.INGID);
               Else;
                  // SQL error
                  rtntext = '(UPDATE FAIL) SQL Error: ' + SQLSTATE;
               EndIf;

               // -------------------------------------------------------------------
               // DLT Operation: Delete ingredient record using SQL DELETE
               // Validates that record exists by checking rows affected
               // -------------------------------------------------------------------
            When (function = 'DLT');
               exec sql
                  DELETE FROM FOODLIB.FOODFILE
                  WHERE INGID = :data.INGID;

               // Check SQL execution status and rows affected
               If (SQLSTATE = '00000' and SQLERRD(3) > 0);
                  // Record successfully deleted
                  rtntext = 'Row ' + %char(data.INGID) + ' Successfully Deleted';
               elseif (SQLERRD(3) = 0);
                  // No rows affected - record not found
                  rtntext = '(DELETE FAIL) Ingredient ID does not exist: ' + %char(data.INGID);
               Else;
                  // SQL error
                  rtntext = '(DELETE FAIL) SQL Error: ' + SQLSTATE;
               EndIf;

         EndSl;

      EndIf;

      // Normal procedure exit
      Return;

      // -------------------------------------------------------------------
      // Error Handler
      // Catches any unexpected errors during processing
      // Returns error status code to caller
      // -------------------------------------------------------------------
   on-error;
      rtntext = '(ERROR) Main Program Error: ' + %char(%status);
   endmon;

end-proc;