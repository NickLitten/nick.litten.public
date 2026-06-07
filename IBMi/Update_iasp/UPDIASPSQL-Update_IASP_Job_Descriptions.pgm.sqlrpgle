**free

///
/// Program: UPDIASPSQL - Update IASP Job Descriptions
///
/// Description: Scans all job descriptions in user libraries and updates
///              the INLASPGRP parameter from *NONE to a specified ASP group.
///              Uses SQL for efficient querying via qsys2.job_description_info.
///
/// Purpose:
///   - Demonstrate modern SQLRPGLE with SQL cursor and table function processing
///   - Show SQL-based job description information retrieval
///   - Implement comprehensive logging and statistics
///   - Use service program procedures for reusability
///
/// Features:
///   - Configurable target ASP group (default: ASP1)
///   - Comprehensive error handling and logging
///   - Performance optimized with SQL cursor and read-only access
///   - Detailed statistics reporting
///   - Proper cursor cleanup with on-exit handler
///   - Validates ASP group before updates
///   - Handles edge cases (empty values, system libraries)
///   - Uses qsys2.job_description_info for modern SQL-based retrieval
///
/// Usage:
///   CALL UPDIASPSQL
///   (No parameters required - uses TARGET_ASP_GROUP constant)
///
/// Dependencies:
///   - BIGBNDDIR binding directory
///   - Service programs: BIGFATSRV (LogMessage, ExecuteCommand)
///   - QSYS2.OBJECT_STATISTICS table function
///   - qsys2.job_description_info table function
///   - Authority to change job descriptions
///
/// Performance Notes:
///   - Uses SQL cursor with FOR READ ONLY for optimal performance
///   - Filters system libraries at SQL level (not in RPG)
///   - Processes one job description at a time to minimize memory
///   - SQL table functions provide efficient data access
///
/// Modification History:
///   2026-02-23 | Nick Litten | Initial creation
///   2026-06-02 | Nick Litten | Replaced QWDRJOBD API with SQL JOBDESC_INFO
///

ctl-opt
  main(mainline)
  dftactgrp(*no)
  actgrp(*caller)
  option(*nodebugio:*srcstmt:*nounref)
  bnddir('BIGBNDDIR')
  copyright('V.003 - Update IASP Job Descriptions')
  ;

// Prototypes for Service Program Procedures
/include 'globals.rpgleinc'
/include 'prototypes.rpgleinc'

// ---
// Constants
// ---
Dcl-C TARGET_ASP_GROUP const('ASP1');
Dcl-C SQL_NO_DATA const(100);
Dcl-C SQL_ERROR const(-1);

// ---
// Data Structures
// ---

// Processing statistics
Dcl-Ds Statistics_t qualified;
   checked int(10) inz(0);
   updated int(10) inz(0);
   skipped int(10) inz(0);
   errors int(10) inz(0);
end-ds;

Dcl-Ds stats likeds(Statistics_t);

// ---
// Main Procedure
// ---
Dcl-Proc mainline;
   Dcl-S message char(256);
  
   // Initialize and start processing
   LogMessage('Starting IASP Job Description update process...');
   message = 'Target ASP Group: ' + TARGET_ASP_GROUP;
   LogMessage(message);
  
   // Validate target ASP group exists (optional enhancement)
   If (not ValidateAspGroup(TARGET_ASP_GROUP));
      message = 'WARNING: Target ASP group ' + TARGET_ASP_GROUP + 
                ' may not exist on system';
      LogMessage(message: '*DIAG');
   EndIf;
  
   // Process all job descriptions
   ProcessJobDescriptions();
  
   // Report final statistics
   ReportStatistics();
  
   // Determine completion status
   If (stats.errors = 0);
      LogMessage('IASP update process completed successfully': '*COMP');
   Else;
      LogMessage('IASP update process completed with errors': '*COMP');
   EndIf;
  
   *inlr = *on;
end-proc;

// ---
// Process Job Descriptions
// ---
Dcl-Proc ProcessJobDescriptions;
   Dcl-S jobdName char(10);
   Dcl-S jobdLib char(10);
   Dcl-S sqlState char(5);
   Dcl-S continueProcessing ind inz(*on);
   Dcl-S recordCount int(10) inz(0);
   Dcl-S errMsg char(256);
   Dcl-S fetchErr char(256);
   Dcl-S procMsg char(256);
  
   // Declare cursor for job descriptions in user libraries
   // Filter system libraries at SQL level for better performance
   exec sql declare JobdCursor cursor for
    select objname, objlib
    from table(qsys2.object_statistics('*ALL', '*JOBD'))
    where objlib not like 'Q%'
      and objlib not like '#%'
      and objtype = '*JOBD'
    order by objlib, objname
    for read only;
  
   // Open cursor with error handling
   exec sql open JobdCursor;
  
   If (sqlcode < 0);
      errMsg = 'Failed to open cursor. SQLCODE: ' + %char(sqlcode);
      LogMessage(errMsg: '*ESCAPE');
      Return;
   EndIf;
  
   LogMessage('Cursor opened successfully. Processing job descriptions...');
  
   // Process each job description
   dow (continueProcessing);
    
      // Fetch next record
      exec sql fetch next from JobdCursor
      into :jobdName, :jobdLib;
    
      // Check fetch status
      Select;
         When (sqlcode = SQL_NO_DATA);  // End of data
            continueProcessing = *off;
        
         When (sqlcode < SQL_ERROR);    // SQL error
            stats.errors += 1;
            fetchErr = 'SQL fetch error. SQLCODE: ' + %char(sqlcode);
            LogMessage(fetchErr: '*DIAG');
            continueProcessing = *off;
        
         Other;                       // Success - process the job description
            recordCount += 1;
            ProcessSingleJobd(jobdName: jobdLib);
      EndSl;
    
   enddo;
  
   procMsg = 'Processed ' + %char(recordCount) + ' job description(s)';
   LogMessage(procMsg);
  
   // Close cursor
   exec sql close JobdCursor;
  
   on-exit;
      // Ensure cursor is closed even on abnormal exit
      exec sql close JobdCursor;
end-proc;

// ---
// Process Single Job Description
// ---
Dcl-Proc ProcessSingleJobd;
   Dcl-Pi *n;
      jobdName char(10) const;
      jobdLib char(10) const;
   end-pi;
  
   Dcl-S currentAspGrp char(10);
   Dcl-S qualName varchar(50);
   Dcl-S message char(256);
  
   stats.checked += 1;
   qualName = %trim(jobdLib) + '/' + %trim(jobdName);
  
   // Use SQL to retrieve job description information from qsys2.job_description_info
   // This modern approach replaces the QWDRJOBD API call
   exec sql
      select initial_asp_group
      into :currentAspGrp
      from table(qsys2.job_description_info(
         job_description_library => :jobdLib,
         job_description_name => :jobdName
      ));
  
   // Check SQL execution status
   Select;
      When (sqlcode = SQL_NO_DATA);
         stats.errors += 1;
         message = 'Job description not found: ' + qualName;
         LogMessage(message: '*DIAG');
         Return;
        
      When (sqlcode < SQL_ERROR);
         stats.errors += 1;
         message = 'SQL error for ' + qualName + ' SQLCODE: ' + %char(sqlcode);
         LogMessage(message: '*DIAG');
         Return;
   EndSl;
  
   // Validate data was retrieved
   If (%trim(currentAspGrp) = '');
      currentAspGrp = '*NONE';
   EndIf;
  
   // Check if update is needed
   Select;
      When (currentAspGrp = TARGET_ASP_GROUP);
         stats.skipped += 1;
         // Already set to target - no action needed
      
      When (currentAspGrp = '*NONE' or %trim(currentAspGrp) = '');
         // Update from *NONE to target ASP group
         UpdateJobdAspGroup(jobdName: jobdLib: currentAspGrp);
      
      Other;
         stats.skipped += 1;
         message = 'Skipped ' + qualName + ' - Current INLASPGRP: ' +
                 %trim(currentAspGrp);
         LogMessage(message: '*INFO');
   EndSl;
  
end-proc;

// ---
// Update Job Description ASP Group
// ---
Dcl-Proc UpdateJobdAspGroup;
   Dcl-Pi *n;
      jobdName char(10) const;
      jobdLib char(10) const;
      oldValue char(10) const;
   end-pi;
  
   Dcl-S command varchar(1024);
   Dcl-S errorMsg char(256);
   Dcl-S qualName varchar(50);
   Dcl-S message char(256);
  
   qualName = %trim(jobdLib) + '/' + %trim(jobdName);
  
   // Build CHGJOBD command
   command = 'CHGJOBD JOBD(' + qualName + ') INLASPGRP(' +
            %trim(TARGET_ASP_GROUP) + ')';
  
   // Execute command with error handling
   If (ExecuteCommand(command: errorMsg));
      // Update successful
      stats.updated += 1;
      message = 'Updated ' + qualName + ' INLASPGRP to ' +
               %trim(TARGET_ASP_GROUP);
      LogMessage(message: '*INFO');
   Else;
      // Update failed
      stats.errors += 1;
      message = 'Update FAILED for ' + qualName;
      LogMessage(message: '*DIAG');
   EndIf;
  
end-proc;

// ---
// Validate ASP Group Exists
// ---
Dcl-Proc ValidateAspGroup;
   Dcl-Pi *n ind;
      aspGroup char(10) const;
   end-pi;
  
   Dcl-S aspCount int(10) inz(0);
  
   // Check if ASP group exists using SQL
   exec sql select count(*)
    into :aspCount
    from qsys2.asp_info
    where asp_number > 0
      and resource_name = :aspGroup;
  
   // If SQL fails or no rows, assume ASP doesn't exist
   If (sqlcode <> 0 or aspCount = 0);
      Return *off;
   EndIf;
  
   Return *on;
end-proc;

// ---
// Report Statistics
// ---
Dcl-Proc ReportStatistics;
   Dcl-S message char(256);
   Dcl-S successRate packed(5:2);
  
   message = 'IASP Update Statistics: ' +
            'Checked=' + %char(stats.checked) +
            ' | Updated=' + %char(stats.updated) +
            ' | Skipped=' + %char(stats.skipped) +
            ' | Errors=' + %char(stats.errors);
  
   LogMessage(message: '*COMP');
  
   // Log warning if errors occurred
   If (stats.errors > 0);
      message = 'WARNING: ' + %char(stats.errors) +
               ' error(s) occurred during processing';
      LogMessage(message: '*DIAG');
   EndIf;
  
   // Log success rate if any updates were attempted
   If (stats.checked > 0);
      successRate = (stats.updated * 100.00) / stats.checked;
      message = 'Success rate: ' + %char(successRate) + '%';
      LogMessage(message: '*INFO');
   EndIf;
  
end-proc;
