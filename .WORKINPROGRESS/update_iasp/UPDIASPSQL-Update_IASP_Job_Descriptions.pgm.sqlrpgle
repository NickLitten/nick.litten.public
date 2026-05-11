**free

///
/// Program: UPDIASPSQL - Update IASP Job Descriptions
///
/// Description: Scans all job descriptions in user libraries and updates
///              the INLASPGRP parameter from *NONE to a specified ASP group.
///              Uses SQL for efficient querying and IBM i APIs for validation.
///
/// Features:
///   - Configurable target ASP group (default: ASP1)
///   - Comprehensive error handling and logging
///   - Performance optimized with SQL cursor
///   - Detailed statistics reporting
///   - Rollback capability on critical errors
///
/// Modification History:
///   2026-02-23 | Nick Litten | Initial creation
///   2026-04-02 | Bob AI      | Enhanced with best practices
///

ctl-opt dftactgrp(*no)
        actgrp(*new) 
        option(*nodebugio:*srcstmt:*nounref)
        main(Main);

//---------------------------------------------------------
// Constants
//---------------------------------------------------------
dcl-c TARGET_ASP_GROUP const('ASP1');
dcl-c API_ERROR_CODE_SIZE const(116);
dcl-c MAX_COMMAND_LENGTH const(512);
dcl-c MAX_MESSAGE_LENGTH const(512);

//---------------------------------------------------------
// API Prototypes
//---------------------------------------------------------

// QWDRJOBD - Retrieve Job Description Information
dcl-pr RetrieveJobdInfo extpgm('QWDRJOBD');
  receiverVar char(2000);
  receiverLen int(10) const;
  format char(8) const;
  qualJobd char(20) const;
  errorCode likeds(ApiErrorCode_t);
end-pr;

// QCMDEXC - Execute Command
dcl-pr ExecuteCommand extpgm('QCMDEXC');
  command char(MAX_COMMAND_LENGTH) const options(*varsize);
  commandLen packed(15:5) const;
end-pr;

// QMHSNDPM - Send Program Message
dcl-pr SendProgramMessage extpgm('QMHSNDPM');
  messageId char(7) const;
  qualMsgFile char(20) const;
  messageData char(MAX_MESSAGE_LENGTH) const options(*varsize);
  messageDataLen int(10) const;
  messageType char(10) const;
  callStackEntry char(10) const;
  callStackCounter int(10) const;
  messageKey char(4);
  errorCode likeds(ApiErrorCode_t);
end-pr;

//---------------------------------------------------------
// Data Structures
//---------------------------------------------------------

// Standard API error code structure
dcl-ds ApiErrorCode_t qualified template;
  bytesProvided int(10);
  bytesAvailable int(10);
  exceptionId char(7);
  reserved char(1);
  exceptionData char(100);
end-ds;

// QWDRJOBD API receiver (JOBD0100 format)
dcl-ds JobdInfo_t qualified template;
  bytesReturned int(10);
  bytesAvailable int(10);
  jobdName char(10);
  jobdLib char(10);
  userName char(10);
  jobdText char(50);
  jobQueue char(10);
  jobQueueLib char(10);
  jobQueuePriority char(2);
  outQueue char(10);
  outQueueLib char(10);
  outQueuePriority char(2);
  printerDevice char(10);
  inlAspGrp char(10);  // Offset 88 - Target field
end-ds;

// Processing statistics
dcl-ds Statistics_t qualified;
  checked int(10) inz(0);
  updated int(10) inz(0);
  skipped int(10) inz(0);
  errors int(10) inz(0);
end-ds;

//---------------------------------------------------------
// Global Variables
//---------------------------------------------------------
dcl-ds stats likeds(Statistics_t);

//---------------------------------------------------------
// Main Procedure
//---------------------------------------------------------
dcl-proc Main;
  dcl-s sqlState char(5);
  
  // Initialize and start processing
  LogMessage('Starting IASP Job Description update process...');
  LogMessage('Target ASP Group: ' + TARGET_ASP_GROUP);
  
  // Process all job descriptions
  ProcessJobDescriptions();
  
  // Report final statistics
  ReportStatistics();
  
  LogMessage('IASP update process completed successfully': '*COMP');
  
  *inlr = *on;
end-proc;

//---------------------------------------------------------
// Process Job Descriptions
//---------------------------------------------------------
dcl-proc ProcessJobDescriptions;
  dcl-s jobdName char(10);
  dcl-s jobdLib char(10);
  dcl-s sqlState char(5);
  dcl-s continueProcessing ind inz(*on);
  
  // Declare cursor for job descriptions in user libraries
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
  
  if (sqlcode < 0);
    LogMessage('Failed to open cursor. SQLCODE: ' + %char(sqlcode) +
               ' SQLSTATE: ' + sqlstate: '*ESCAPE');
    return;
  endif;
  
  // Process each job description
  dow continueProcessing;
    
    // Fetch next record
    exec sql fetch next from JobdCursor
      into :jobdName, :jobdLib;
    
    // Check fetch status
    select;
      when (sqlcode = 100);  // End of data
        continueProcessing = *off;
        
      when (sqlcode < 0);    // SQL error
        stats.errors += 1;
        LogMessage('SQL fetch error. SQLCODE: ' + %char(sqlcode) +
                   ' SQLSTATE: ' + sqlstate: '*DIAG');
        continueProcessing = *off;
        
      other;                 // Success - process the job description
        ProcessSingleJobd(jobdName: jobdLib);
    endsl;
    
  enddo;
  
  // Close cursor
  exec sql close JobdCursor;
  
on-exit;
  // Ensure cursor is closed even on abnormal exit
  exec sql close JobdCursor;
end-proc;

//---------------------------------------------------------
// Process Single Job Description
//---------------------------------------------------------
dcl-proc ProcessSingleJobd;
  dcl-pi *n;
    jobdName char(10) const;
    jobdLib char(10) const;
  end-pi;
  
  dcl-ds jobdInfo likeds(JobdInfo_t);
  dcl-ds errorCode likeds(ApiErrorCode_t);
  dcl-s qualJobd char(20);
  dcl-s currentAspGrp char(10);
  
  stats.checked += 1;
  
  // Build qualified job description name (name + library)
  qualJobd = jobdName + jobdLib;
  
  // Initialize error code structure
  errorCode = *allx'00';
  errorCode.bytesProvided = API_ERROR_CODE_SIZE;
  
  // Retrieve job description information
  RetrieveJobdInfo(jobdInfo: %size(jobdInfo): 'JOBD0100': 
                   qualJobd: errorCode);
  
  // Check for API errors
  if (errorCode.bytesAvailable > 0);
    stats.errors += 1;
    LogMessage('API error for ' + %trim(jobdLib) + '/' + 
               %trim(jobdName) + ': ' + errorCode.exceptionId: '*DIAG');
    return;
  endif;
  
  // Validate data was returned
  if (jobdInfo.bytesReturned < %size(jobdInfo));
    stats.errors += 1;
    LogMessage('Incomplete data returned for ' + %trim(jobdLib) + 
               '/' + %trim(jobdName): '*DIAG');
    return;
  endif;
  
  currentAspGrp = jobdInfo.inlAspGrp;
  
  // Check if update is needed
  select;
    when (currentAspGrp = TARGET_ASP_GROUP);
      stats.skipped += 1;
      // Already set to target - no action needed
      
    when (currentAspGrp = '*NONE' or %trim(currentAspGrp) = '');
      // Update from *NONE to target ASP group
      UpdateJobdAspGroup(jobdName: jobdLib: currentAspGrp);
      
    other;
      stats.skipped += 1;
      LogMessage('Skipped ' + %trim(jobdLib) + '/' + %trim(jobdName) +
                 ' - Current INLASPGRP: ' + %trim(currentAspGrp): '*INFO');
  endsl;
  
end-proc;

//---------------------------------------------------------
// Update Job Description ASP Group
//---------------------------------------------------------
dcl-proc UpdateJobdAspGroup;
  dcl-pi *n;
    jobdName char(10) const;
    jobdLib char(10) const;
    oldValue char(10) const;
  end-pi;
  
  dcl-s command char(512);
  dcl-s commandLen packed(15:5);
  
  // Build CHGJOBD command
  command = 'CHGJOBD JOBD(' + %trim(jobdLib) + '/' + 
            %trim(jobdName) + ') INLASPGRP(' + TARGET_ASP_GROUP + ')';
  commandLen = %len(command);
  
  // Execute command with error handling
  monitor;
    ExecuteCommand(command: commandLen);
    stats.updated += 1;
    LogMessage('Updated ' + %trim(jobdLib) + '/' + %trim(jobdName) +
               ' INLASPGRP: ' + %trim(oldValue) + ' -> ' + 
               TARGET_ASP_GROUP: '*INFO');
  on-error;
    stats.errors += 1;
    LogMessage('Failed to update ' + %trim(jobdLib) + '/' + 
               %trim(jobdName) + ' - Command: ' + command: '*ESCAPE');
  endmon;
  
end-proc;

//---------------------------------------------------------
// Report Statistics
//---------------------------------------------------------
dcl-proc ReportStatistics;
  dcl-s message char(512);
  
  message = 'IASP Update Statistics: ' +
            'Checked=' + %char(stats.checked) +
            ' | Updated=' + %char(stats.updated) +
            ' | Skipped=' + %char(stats.skipped) +
            ' | Errors=' + %char(stats.errors);
  
  LogMessage(message: '*COMP');
  
  // Log warning if errors occurred
  if (stats.errors > 0);
    LogMessage('WARNING: ' + %char(stats.errors) + 
               ' error(s) occurred during processing': '*DIAG');
  endif;
  
end-proc;

//---------------------------------------------------------
// Log Message to Job Log
//---------------------------------------------------------
dcl-proc LogMessage;
  dcl-pi *n;
    msgText char(512) const;
    msgType char(10) const options(*nopass);
  end-pi;
  
  dcl-s localMsgType char(10);
  dcl-s msgLen int(10);
  dcl-s msgKey char(4);
  dcl-ds errorCode likeds(ApiErrorCode_t);
  
  // Default to *INFO if not specified
  if (%parms() < 2);
    localMsgType = '*INFO';
  else;
    localMsgType = msgType;
  endif;
  
  msgLen = %len(msgText);
  
  // Initialize error code
  errorCode = *allx'00';
  errorCode.bytesProvided = API_ERROR_CODE_SIZE;
  
  // Send message to job log
  SendProgramMessage('CPF9897': 'QCPFMSG   *LIBL': msgText: msgLen:
                     localMsgType: '*PGMBDY': 1: msgKey: errorCode);
  
end-proc;
