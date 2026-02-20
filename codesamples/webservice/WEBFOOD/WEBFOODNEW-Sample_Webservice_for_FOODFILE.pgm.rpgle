**free
//==============================================================================
// Program Name: WEBFOOD-Sample_Webservice_for_FOODFILE.pgm.rpgle
// Description:  RESTful webservice program providing CRUD operations for
//               FOODFILE database. Implements GET, ADD, UPD, and DLT functions
//               for managing food inventory ingredients.
//
// Purpose:      This program serves as a backend webservice that can be called
//               via HTTP requests to manage food ingredient records. It handles
//               all basic database operations with proper error handling and
//               validation.
//
// Usage:        Called with three parameters:
//               1. function (char 3)  - Operation: 'GET', 'ADD', 'UPD', or 'DLT'
//               2. rtntext (char 100) - Return message/status text
//               3. data (FoodRec DS)  - Data structure containing ingredient info
//
// Database:     FOODFILE - Contains ingredient records with fields:
//               - INGID    : Ingredient ID (key field)
//               - INGNAME  : Ingredient name
//               - CATEGORY : Food category
//               - MEASURE  : Unit of measurement
//               - QUANTITY : Quantity amount
//               - EXPDATE  : Expiration date
//               - ORGANIC  : Organic flag
//
// Modification History:
// v.000 2025.10.19 njl - Initial creation for online example
//==============================================================================


//------------------------------------------------------------------------------
// Control Options
//------------------------------------------------------------------------------
ctl-opt
    main(mainline)                              // Entry point procedure
    optimize(*full)                             // Full optimization for performance
    option(*nodebugio:*srcstmt:*nounref)       // Debug options
    pgminfo(*pcml:*module)                     // Generate PCML for webservice
    actgrp(*new)                               // New activation group per call
    indent('| ')                               // Source indentation character
    alwnull(*usrctl)                           // Allow null-capable fields
    copyright('WEBFOOD | V.000 | Sample CGI Webservice');

//------------------------------------------------------------------------------
// File Declarations
//------------------------------------------------------------------------------
// FOODFILE: Main ingredient database file
// - Keyed access by INGID (ingredient ID)
// - User-controlled open (usropn) for explicit file management
// - Record format renamed to RECFOOD for clarity
// - Supports all CRUD operations: INPUT, OUTPUT, UPDATE, DELETE
dcl-f FOODFILE usage(*INPUT:*OUTPUT:*UPDATE:*DELETE) keyed usropn rename(FOODFILE:RECFOOD);

//==============================================================================
// Main Procedure: mainline
//
// Purpose: Entry point for webservice. Processes CRUD operations on FOODFILE
//          based on the function parameter received.
//
// Parameters:
//   function (input)  - Operation code: 'GET', 'ADD', 'UPD', or 'DLT'
//   rtntext (output)  - Status message returned to caller
//   data (input/output) - Data structure containing ingredient information
//
// Returns: Status message in rtntext parameter
//==============================================================================
dcl-proc mainline;
    dcl-pi *n;
        function char(3);           // Operation: GET/ADD/UPD/DLT
        rtntext char(100);          // Return status message
        data likeds(FoodRec);       // Ingredient data structure
    end-pi;

    //--------------------------------------------------------------------------
    // Data Structure: FoodRec
    // Externally defined from FOODFILE record format
    // Contains all fields from the ingredient database record
    //--------------------------------------------------------------------------
    dcl-ds FoodRec extname('FOODFILE':*input) qualified inz;
    end-ds;

    //--------------------------------------------------------------------------
    // Main Processing Logic with Error Handling
    //--------------------------------------------------------------------------
    monitor;

        // Validate function parameter - must be one of four valid operations
        if function <> 'GET' and function <> 'ADD' and function <> 'UPD' and function <> 'DLT';
            rtntext = '(INVALID) Function must be GET/ADD/UPD/DLT: ' + %trim(function);
        else;

            // Open the food ingredient file for processing
            open foodfile;

            //------------------------------------------------------------------
            // Process Request Based on Function Type
            //------------------------------------------------------------------
            select;
                //--------------------------------------------------------------
                // GET Operation: Retrieve ingredient record by ID
                // Returns all ingredient details if found
                //--------------------------------------------------------------
                when function = 'GET';
                    // Attempt to read record using ingredient ID as key
                    chain (data.INGID) FOODFILE;
                    
                    if %found(FOODFILE);
                        // Record found - populate return data structure
                        data.INGNAME = INGNAME;
                        data.CATEGORY = CATEGORY;
                        data.MEASURE = MEASURE;
                        data.QUANTITY = QUANTITY;
                        data.EXPDATE = EXPDATE;
                        data.ORGANIC = ORGANIC;
                        rtntext = 'Row ' + %char(data.INGID) + ' Successfully Read';
                    else;
                        // Record not found - return error message
                        rtntext = '(READ FAIL) Ingredient ID does not exist: ' + %char(data.INGID);
                    endif;

                //--------------------------------------------------------------
                // ADD Operation: Create new ingredient record
                // Validates that ID doesn't already exist before adding
                //--------------------------------------------------------------
                when function = 'ADD';
                    // Check if ingredient ID already exists
                    chain (data.INGID) FOODFILE;
                    
                    if not %found(FOODFILE);
                        // ID is unique - safe to add new record
                        // Trim trailing spaces from character fields
                        INGNAME = %trimr(data.INGNAME);
                        CATEGORY = %trimr(data.CATEGORY);
                        MEASURE = %trimr(data.MEASURE);
                        QUANTITY = data.QUANTITY;
                        EXPDATE = data.EXPDATE;
                        ORGANIC = data.ORGANIC;
                        
                        // Write new record to database
                        write RECFOOD;
                        rtntext = 'Row ' + %char(data.INGID) + ' Successfully Added';
                    else;
                        // Duplicate ID - cannot add
                        rtntext = '(ADD FAIL) Ingredient ID already exists: ' + %char(data.INGID);
                    endif;

                //--------------------------------------------------------------
                // UPD Operation: Update existing ingredient record
                // Validates that record exists before updating
                //--------------------------------------------------------------
                when function = 'UPD';
                    // Locate record to update by ingredient ID
                    chain (data.INGID) FOODFILE;
                    
                    if %found(FOODFILE);
                        // Record found - update all fields
                        // Trim trailing spaces from character fields
                        INGNAME = %trimr(data.INGNAME);
                        CATEGORY = %trimr(data.CATEGORY);
                        MEASURE = %trimr(data.MEASURE);
                        QUANTITY = data.QUANTITY;
                        EXPDATE = data.EXPDATE;
                        ORGANIC = data.ORGANIC;
                        
                        // Commit changes to database
                        update RECFOOD;
                        rtntext = 'Data Successfully Updated';
                    else;
                        // Record not found - cannot update
                        rtntext = '(UPDATE FAIL) Ingredient ID does not exist for UPDATE: ' + %char(data.INGID);
                    endif;

                //--------------------------------------------------------------
                // DLT Operation: Delete ingredient record
                // Validates that record exists before deleting
                //--------------------------------------------------------------
                when function = 'DLT';
                    // Locate record to delete by ingredient ID
                    chain (data.INGID) FOODFILE;
                    
                    if %found(FOODFILE);
                        // Record found - proceed with deletion
                        delete RECFOOD;
                        rtntext = 'Row ' + %char(data.INGID) + ' Successfully Deleted';
                    else;
                        // Record not found - cannot delete
                        rtntext = '(DELETE FAIL) Ingredient ID does not exist for DELETE: ' + %char(data.INGID);
                    endif;

            endsl;

            // Close file after processing - ensures proper cleanup
            close foodfile;

        endif;

        // Normal procedure exit
        return;

    //--------------------------------------------------------------------------
    // Error Handler
    // Catches any unexpected errors during processing
    // Returns error status code to caller
    //--------------------------------------------------------------------------
    on-error;
        rtntext = '(ERROR) Main Program Error: ' + %char(%status);
    endmon;

end-proc;