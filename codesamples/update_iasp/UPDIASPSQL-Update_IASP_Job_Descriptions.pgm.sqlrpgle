**FREE


// *****************************************
// *** WIP WORK IN PROGRESS
// *****************************************






// Program: UPDIASPSQL
// Description: Find all job descriptions in USER libraries and
//              update INLASPGRP parameter from *NONE to ASP1

// This program uses SQL to query QSYS2.OBJECT_STATISTICS to find
// all job descriptions in non-system libraries, then uses the
// QWDRJOBD API to check the INLASPGRP parameter and updates it
// to ASP1 if it's currently set to *NONE.

// Modification History               
// 2026-02-23 | Nick Litten | Created 

ctl-opt dftactgrp(*no) actgrp(*new) option(*nodebugio:*srcstmt);

// Retrieve_Job_Description_Information API
dcl-pr Retrieve_Job_Description_Information extpgm('QWDRJOBD');
  ReceiverVar char(2000);
  ReceiverLen int(10) const;
  Format char(8) const;
  QualJobd char(20) const;
  ErrorCode char(116);
end-pr;

// QCMDEXC - Execute Command API
dcl-pr QCMDEXC extpgm('QCMDEXC');
  Command char(512) const options(*varsize);
  CommandLen packed(15:5) const;
end-pr;

// QMHSNDPM - Send Program Message API
dcl-pr QMHSNDPM extpgm('QMHSNDPM');
  MessageId char(7) const;
  QualMsgF char(20) const;
  MessageData char(512) const options(*varsize);
  MessageDataLen int(10) const;
  MessageType char(10) const;
  CallStackEntry char(10) const;
  CallStackCounter int(10) const;
  MessageKey char(4);
  ErrorCode likeds(ErrorCode);
end-pr;

// Error code structure for APIs
dcl-ds ErrorCode qualified;
  BytesProvided int(10) inz(116);
  BytesAvailable int(10) inz(0);
  ExceptionId char(7);
  Reserved char(1);
  ExceptionData char(100);
end-ds;

// Receiver variable for QWDRJOBD API (JOBD0100 format)
dcl-ds JobdInfo qualified;
  BytesReturned int(10);
  BytesAvailable int(10);
  JobdName char(10);
  JobdLib char(10);
  UserName char(10);
  JobdText char(50);
  JobQueue char(10);
  JobQueueLib char(10);
  JobQueuePriority char(2);
  OutQueue char(10);
  OutQueueLib char(10);
  OutQueuePriority char(2);
  PrinterDevice char(10);
  InlAspGrp char(10);  // Offset 88 - This is what we need to check
  // Additional fields exist but not needed for this program
end-ds;


dcl-s JobdName char(10);
dcl-s JobdLib char(10);
dcl-s QualJobd char(20);
dcl-s Command char(512);
dcl-s CommandLen packed(15:5);
dcl-s CheckCount int(10) inz(0);
dcl-s UpdateCount int(10) inz(0);
dcl-s ErrorCount int(10) inz(0);
dcl-s Message char(512);
dcl-s MessageKey char(4);

// Send start message
SendMsg ('Starting IASP Job Description update process...');

// SQL cursor to find all job descriptions in USER libraries
exec sql declare JobdCursor cursor for
  select objname, objlib
  from table(qsys2.object_statistics('*ALL', '*JOBD'))
  where objlib not like 'Q%'
    and objlib not like '#%'
  order by objlib, objname;

exec sql open JobdCursor;

// Process each job description
dow (1=1);
  
  // Fetch next job description
  exec sql fetch next from JobdCursor
    into :JobdName, :JobdLib;
  
  // Check for end of data
  if (sqlcode = 100);
    leave;
  endif;
  
  // Check for SQL errors
  if (sqlcode < 0);
    ErrorCount += 1;
    Message = 'SQL error: ' + %char(sqlcode);
    SendMsg(Message: '*DIAG');
    leave;
  endif;
  
  CheckCount += 1;
  
  // Build qualified job description name for API
  QualJobd = JobdName + JobdLib;
  
  // Reset error code structure
  ErrorCode.BytesProvided = 116;
  ErrorCode.BytesAvailable = 0;
  
  // Call QWDRJOBD API to retrieve job description details
  Retrieve_Job_Description_Information (JobdInfo: %size(JobdInfo): 'JOBD0100': QualJobd: ErrorCode);
  
  // Check for API errors
  if (ErrorCode.BytesAvailable > 0);
    ErrorCount += 1;
    Message = 'API error for ' + %trim(JobdLib) + '/' + %trim(JobdName) +
              ': ' + ErrorCode.ExceptionId;
    SendMsg(Message: '*DIAG');
    iter;
  endif;
  
  // Check if INLASPGRP is *NONE
  if (JobdInfo.InlAspGrp = '*NONE');
    
    // Build CHGJOBD command
    Command = 'CHGJOBD JOBD(' + %trim(JobdLib) + '/' + 
              %trim(JobdName) + ') INLASPGRP(ASP1)';
    CommandLen = %len(%trim(Command));
    
    // Execute the command
    monitor;
      QCMDEXC(Command: CommandLen);
      UpdateCount += 1;
      Message = 'Updated ' + %trim(JobdLib) + '/' + %trim(JobdName) +
                ' INLASPGRP: *NONE -> ASP1';
      SendMsg(Message: '*INFO');
    on-error;
      ErrorCount += 1;
      Message = 'Error updating ' + %trim(JobdLib) + '/' + %trim(JobdName);
      SendMsg(Message: '*DIAG');
    endmon;
    
  endif;
  
enddo;

// Close cursor
exec sql close JobdCursor;

// Send completion message
Message = 'IASP update complete. Checked: ' + %char(CheckCount) +
          ' Updated: ' + %char(UpdateCount) +
          ' Errors: ' + %char(ErrorCount);
SendMsg(Message: '*COMP');

*inlr = *on;
return;

// ================================================================
// Procedures
// ================================================================

// Send message to joblog
dcl-proc SendMsg;
  dcl-pi *n;
    MsgText char(512) const;
    MsgType char(10) const options(*nopass);
  end-pi;
  
  dcl-s LocalMsgType char(10);
  dcl-s MsgLen int(10);
  dcl-s LocalMsgKey char(4);
  
  dcl-ds LocalErrorCode qualified;
    BytesProvided int(10) inz(116);
    BytesAvailable int(10) inz(0);
    ExceptionId char(7);
    Reserved char(1);
    ExceptionData char(100);
  end-ds;
  
  // Default to *INFO if not specified
  if %parms() < 2;
    LocalMsgType = '*INFO';
  else;
    LocalMsgType = MsgType;
  endif;
  
  MsgLen = %len(%trim(MsgText));
  
  // Reset error code
  LocalErrorCode.BytesProvided = 116;
  LocalErrorCode.BytesAvailable = 0;
  
  QMHSNDPM('CPF9897': 'QCPFMSG   *LIBL': MsgText: MsgLen:
           LocalMsgType: '*PGMBDY': 1: LocalMsgKey: LocalErrorCode);
end-proc;