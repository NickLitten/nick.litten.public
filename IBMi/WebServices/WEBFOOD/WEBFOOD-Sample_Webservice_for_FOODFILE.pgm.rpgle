**free
/// ----------------------------------------------------------------------------
/// Program Name: WEBFOOD
/// Description:  RESTful webservice program providing CRUD operations for
///               FOODFILE database. Implements GET, ADD, UPD, and DLT functions
///               for managing food inventory ingredients.
///
/// Lesson Introduction:
///   This program teaches the fundamentals of building RESTful webservices in
///   modern RPGLE. You'll learn how to create a backend API that handles all
///   four CRUD operations (Create, Read, Update, Delete) on a database file.
///   The program demonstrates proper parameter handling, database validation,
///   error management, and status messaging - essential skills for building
///   robust webservices that can be consumed by web applications, mobile apps,
///   or other systems. By studying this code, you'll understand how to structure
///   a webservice program, validate input data, perform database operations
///   safely, and return meaningful status messages to the calling application.
///
/// Purpose:
/// - Demonstrate RESTful webservice implementation in RPGLE
/// - Provide backend API for food ingredient management
/// - Show proper CRUD operation handling with validation
/// - Implement error handling and status messaging
///
/// Features:
/// - GET: Retrieve ingredient record by ID
/// - ADD: Create new ingredient with duplicate validation
/// - UPD: Update existing ingredient with existence check
/// - DLT: Delete ingredient with existence validation
/// - Comprehensive error handling and status messages
/// - PCML generation for webservice integration
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
/// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Control Options
// ----------------------------------------------------------------------------
ctl-opt
    main(mainline)
    optimize(*full)
    option(*nodebugio:*srcstmt:*nounref)
    pgminfo(*pcml:*module)
    actgrp(*new)
    indent('| ')
    alwnull(*usrctl)
    copyright('v.001 - RESTful webservice for FOODFILE CRUD operations');

// ----------------------------------------------------------------------------
// File Declarations
// ----------------------------------------------------------------------------
dcl-f FOODFILE usage(*INPUT:*OUTPUT:*UPDATE:*DELETE) keyed usropn rename(FOODFILE:RECFOOD);

// ----------------------------------------------------------------------------
// Main Procedure: mainline
// ----------------------------------------------------------------------------
Dcl-Proc mainline;
   Dcl-Pi *n;
      function char(3);
      rtntext char(100);
      data likeds(FoodRec);
   end-pi;

   // Data structure externally defined from FOODFILE record format
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

         // Open the food ingredient file for processing
         open foodfile;

         // -------------------------------------------------------------------
         // Process Request Based on Function Type
         // -------------------------------------------------------------------
         Select;
               // -------------------------------------------------------------------
               // GET Operation: Retrieve ingredient record by ID
               // -------------------------------------------------------------------
            When (function = 'GET');
               chain (data.INGID) FOODFILE;
               If (%found(FOODFILE));
                  // Record found - populate return data structure
                  data.INGNAME = INGNAME;
                  data.CATEGORY = CATEGORY;
                  data.MEASURE = MEASURE;
                  data.QUANTITY = QUANTITY;
                  data.EXPDATE = EXPDATE;
                  data.ORGANIC = ORGANIC;
                  rtntext = 'Row ' + %char(data.INGID) + ' Successfully Read';
               Else;
                  // Record not found
                  rtntext = '(READ FAIL) Ingredient ID does not exist: ' + %char(data.INGID);
               EndIf;

               // -------------------------------------------------------------------
               // ADD Operation: Create new ingredient record
               // -------------------------------------------------------------------
            When (function = 'ADD');
               // Check if ingredient ID already exists
               chain (data.INGID) FOODFILE;
               If (not %found(FOODFILE));
                  // ID is unique - safe to add new record
                  INGNAME = %trimr(data.INGNAME);
                  CATEGORY = %trimr(data.CATEGORY);
                  MEASURE = %trimr(data.MEASURE);
                  QUANTITY = data.QUANTITY;
                  EXPDATE = data.EXPDATE;
                  ORGANIC = data.ORGANIC;
                  write RECFOOD;
                  rtntext = 'Row ' + %char(data.INGID) + ' Successfully Added';
               Else;
                  // Duplicate ID - cannot add
                  rtntext = '(ADD FAIL) Ingredient ID already exists: ' + %char(data.INGID);
               EndIf;

               // -------------------------------------------------------------------
               // UPD Operation: Update existing ingredient record
               // -------------------------------------------------------------------
            When (function = 'UPD');
               // Locate record to update by ingredient ID
               chain (data.INGID) FOODFILE;
               If (%found(FOODFILE));
                  // Record found - update all fields
                  INGNAME = %trimr(data.INGNAME);
                  CATEGORY = %trimr(data.CATEGORY);
                  MEASURE = %trimr(data.MEASURE);
                  QUANTITY = data.QUANTITY;
                  EXPDATE = data.EXPDATE;
                  ORGANIC = data.ORGANIC;
                  update RECFOOD;
                  rtntext = 'Data Successfully Updated';
               Else;
                  // Record not found - cannot update
                  rtntext = '(UPDATE FAIL) Ingredient ID does not exist for UPDATE: ' + %char(data.INGID);
               EndIf;

               // -------------------------------------------------------------------
               // DLT Operation: Delete ingredient record
               // -------------------------------------------------------------------
            When (function = 'DLT');
               // Locate record to delete by ingredient ID
               chain (data.INGID) FOODFILE;
               If (%found(FOODFILE));
                  // Record found - proceed with deletion
                  delete RECFOOD;
                  rtntext = 'Row ' + %char(data.INGID) + ' Successfully Deleted';
               Else;
                  // Record not found - cannot delete
                  rtntext = '(DELETE FAIL) Ingredient ID does not exist for DELETE: ' + %char(data.INGID);
               EndIf;

         EndSl;

         // Close file after processing
         close foodfile;

      EndIf;

      Return;

      // -------------------------------------------------------------------
      // Error Handler: Catches unexpected errors during processing
      // -------------------------------------------------------------------
   on-error;
      rtntext = '(ERROR) Main Program Error: ' + %char(%status);
   endmon;

end-proc;