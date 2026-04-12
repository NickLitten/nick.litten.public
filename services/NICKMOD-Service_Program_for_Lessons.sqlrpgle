**free
///
/// Service Program: NICKMOD - Service Program for Lessons
/// Description: This is an ever growing example service program filled with
/// useful procedures and sample code for various scenarios.
///
///
/// Modification History:
/// v.001 2026.04.02 - Nick Litten - Created simple service program example
///

ctl-opt
     nomain
     option(*nodebugio:*srcstmt:*nounref)
     copyright('Service Program for Lessons');

// ------------------------------------------------------------------------------
// Procedure: ReturnSystemName
// Description: Returns the current IBM i system name using SQL CURRENT SERVER
//              special register. The system name is left-justified and padded
//              with blanks to 8 characters.
//
// Parameters:
//   systemname - Output parameter (char 8)
//                Returns the current system name, blank-padded to 8 characters.
//                On SQL error, returns blanks.
//
// Returns: None (void procedure)
//
// SQL Behavior:
//   - Uses CURRENT SERVER special register
//   - No SQL error handling implemented (relies on default *EVENTF behavior)
//   - SQLCODE/SQLSTATE available in calling program if needed
//
// Example Usage:
//   dcl-s mySystem char(8);
//   ReturnSystemName(mySystem);
//   // mySystem now contains system name like 'MYSYSTEM'
//
// Notes:
//   - System name is typically 8 characters or less
//   - Consider adding error handling for production use
//   - Thread-safe (no static variables)
// ------------------------------------------------------------------------------
dcl-proc ReturnSystemName export;
  dcl-pi char(8);
  end-pi;
  
  // Local variables
  dcl-s systemname char(8) inz;
  dcl-s sqlCode int(10);
  dcl-s sqlState char(5);
    
  // Retrieve system name using SQL special register
  exec sql
    VALUES CURRENT SERVER INTO :systemname;
  
  // Capture SQL diagnostics for potential logging/debugging
  exec sql
    GET DIAGNOSTICS :sqlCode = ROW_COUNT,
                    :sqlState = RETURNED_SQLSTATE;
  
  // Note: Error handling could be added here if needed
  // For now, relies on default SQL error handling (*EVENTF)
  
  return systemname;

end-proc;




// ------------------------------------------------------------------------------
// check if job is running interactive or batch
// ------------------------------------------------------------------------------
Dcl-Proc ReturnJobEnvironment Export;
Dcl-PI *n Ind;
end-pi;

// retrieve job information (qusrjobi) api
Dcl-PR RetrieveJobInfo EXTPGM('QUSRJOBI');
  @Receive LIKE(JobStatus);
  @JobLength Int(10);
  @JobFormat Char(8);
  @JobName Char(26) CONST;
  @JobIndent Char(15) CONST;
  @ErrCode LIKE(APIERROR);
End-PR;

// data definition section
// procedure work variables
Dcl-S Interactive Ind;
Dcl-S JobLength Int(10) INZ(%SIZE(JobStatus));
Dcl-S JobFormat Char(8) INZ('JOBI0100');

// job status data-structure
Dcl-DS JobStatus;
  JobBytesRtn Int(10) OVERLAY(JobStatus:*NEXT);
  JobBytesAvl Int(10) OVERLAY(JobStatus:*NEXT);
  JobName Char(10) OVERLAY(JobStatus:*NEXT);
  JobUser Char(10) OVERLAY(JobStatus:*NEXT);
  JobNumber Char(6) OVERLAY(JobStatus:*NEXT);
  JobIdentifier Char(16) OVERLAY(JobStatus:*NEXT);
  JobStatusCode Char(10) OVERLAY(JobStatus:*NEXT);
  JobType Char(1) OVERLAY(JobStatus:*NEXT);
  JobSubtype Char(1) OVERLAY(JobStatus:*NEXT);
  JobReserv1 Char(2) OVERLAY(JobStatus:*NEXT);
  JobRunPriority Int(10) OVERLAY(JobStatus:*NEXT);
  JobTimeSlice Int(10) OVERLAY(JobStatus:*NEXT);
  JobDefaultWait Int(10) OVERLAY(JobStatus:*NEXT);
  JobPurge Char(10) OVERLAY(JobStatus:*NEXT);
End-DS;

// Use API to retrieve job running status

RetrieveJobInfo (JobStatus:JobLength:JobFormat: '*':' ':apiError);

If JobType = 'I';
  Interactive = *ON;
Else;
  Interactive = *OFF;
EndIf;

Return Interactive;

End-Proc;














// -----------------------------------------------------------------------
// service program procedure called 'ExecuteCommand'
// Executes IBM i CL commands with comprehensive error handling
// -----------------------------------------------------------------------
dcl-proc ExecuteCommand export;
  dcl-pi ExecuteCommand ind; // Returns *ON if successful
    p_command char(512) const;
    p_errorMsg char(256) options(*nopass:*omit); // Optional error message output
  end-pi;
    
  // IBM i Command Execution API
  dcl-pr QCMDEXC extpgm('QCMDEXC');
    *n char(32000) const options(*varsize);
    *n packed(15:5) const;
  end-pr;

  dcl-s cmdLength packed(15:5);
  dcl-s success ind inz(*off);
  dcl-s errorMessage char(256);
  
  // Validate input command
  if %trim(p_command) = '';
    errorMessage = 'ERROR: Empty command string provided';
    if %parms >= 2 and %addr(p_errorMsg) <> *null;
      p_errorMsg = errorMessage;
    endif;
    return *off;
  endif;

  // Calculate actual command length for efficiency
  cmdLength = %len(%trim(p_command));
  
  // Execute the command with proper error handling
  monitor;
    QCMDEXC(p_command : cmdLength);
    success = *on;
    
  on-error;
    // Capture error details for diagnostics
    errorMessage = 'Command execution failed: ' + %trim(p_command);
    
    // Return error message if parameter provided
    if %parms >= 2 and %addr(p_errorMsg) <> *null;
      p_errorMsg = errorMessage;
    endif;
    
    success = *off;
  endmon;

  return success;

end-proc;









// -----------------------------------------------------------------------
// (DisplayWindow) display text in an IBM i 5250 pop-up window
// -----------------------------------------------------------------------
// Replacement (partial) for the DSPLY opcode:
//    1. Accepts text lenths much great than 52.
//    2. Does not accept input.
//
//  Uses the Display Long Text (QUILNGTX) API to display a pop-up
//  window containing the passed string.
//  API doesn't display bidirectional right to left text.
//
// Error Messages
// Message ID Error Message Text
// CPF3C90 E Literal value cannot be changed
// CPF6A4C E At least one parameter value is not correct. Reason code is &1
// CPF9871 E Error occurred while processing
dcl-proc DisplayWindow ;
  dcl-pi DisplayWindow;
    p_Text varchar(8192) const;
    p_MsgId char(7) Options(*nopass:*omit);
    p_MsgFile char(21) Options(*nopass:*omit);
  end-pi;

  dcl-ds myApiError ;
    APIEProv int(10) inz(%SIZE(APIEData)) pos(1);
    APIEAvail int(10) inz(0) pos(5);
    APIErrID char(7) pos(9);
    APIErrRsv char(1);
    APIEData char(256);
  end-ds;

  dcl-pr QUILNGTX extpgm('QUILNGTX');
    *n char(8192) const; // MsgText
    *n int(10) const; // MsgLength
    *n char(7) const; // MessageId
    *n char(21) const; // MessageFile
    *n options( *omit: *varsize ) like( myApierror ); // ErrorDS
  end-pr;

  dcl-s MsgId like(p_MsgId);
  dcl-s MsgFile like(p_MsgFile);

  If %Parms = 1;
    MsgId = 'CAE0103'; // 'Press Enter to continue.'
    MsgFile = 'QCPFMSG   *LIBL';
  Elseif %Parms = 2;
    MsgId = p_MsgId;
    MsgFile = 'QCPFMSG   *LIBL';
  Elseif %Parms = 3;
    MsgId = p_MsgId;
    MsgFile = p_MsgFile;
  Endif;
  APIEAvail = 0;  // Errors cause a crash.
  QUILNGTX ( p_Text
         : %Len(p_Text)
         : MsgId
         : MsgFile
         : myApiError
         );
  return;
end-proc;

