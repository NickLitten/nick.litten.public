**free

/// ---------------------------------------------------------------------------
///
/// Service Program: BIGFATSRV - Litten Combined Service Program
///
/// Description: Comprehensive service program combining email notification
///              and user profile query capabilities. Merges all procedures
///              from EMAILSRV and USRPRFSRV into a single reusable service.
///
/// Purpose: Production utility demonstrating:
///   - Combined service program architecture
///   - Email notification services
///   - User profile query services
///   - IBM i QSYS2 service integration
///   - Comprehensive error handling
///   - Type-safe data structures
///
/// Features:
///   - Email Services (6 procedures from EMAILSRV):
///     * Send email with QSYS2.SEND_EMAIL
///     * Build formatted password expiration reports
///     * Build email subject lines
///     * Log messages to job log
///     * Validate email configuration
///     * Escape SQL strings for safety
///   - User Profile Services (4 procedures from USRPRFSRV):
///     * Query users with expiring passwords
///     * Format user profile information
///     * Retrieve system name
///     * Validate warning days parameter
///
/// Exported Procedures:
///   Email Services:
///   - SendEmail: Send email using QSYS2.SEND_EMAIL
///   - BuildPasswordExpiryReport: Format password expiration report
///   - BuildEmailSubject: Build subject line with user count
///   - LogMessage: Send message to job log
///   - ValidateEmailConfig: Validate email configuration
///   - EscapeSqlString: Escape single quotes for SQL safety
///   User Profile Services:
///   - GetExpiringUsers: Returns list of users with expiring passwords
///   - FormatUserInfo: Formats user information for display
///   - GetSystemName: Retrieves current system name
///   - ValidateWarningDays: Validates warning days parameter
///
/// Data Structures:
///   - EmailConfig_t: Email configuration template
///   - EmailResult_t: Email result with success/error details
///   - UserProfile_t: User profile information template
///   - UserList_t: Collection of user profiles
///
/// Prerequisites:
///   - SMTP server configured via CHGSMTPA command
///   - User registered via ADDUSRSMTP command
///   - TCP/IP and SMTP server (*SMTPSVR) subsystem active
///
/// Usage Example:
///   // Email example
///   dcl-ds config likeds(EmailConfig_t);
///   dcl-ds result likeds(EmailResult_t);
///   config.toAddress = 'admin@company.com';
///   config.subject = 'Test Email';
///   config.fromAddress = 'ibmi@company.com';
///   result = SendEmail(config: 'Email body text');
///   
///   // User profile example
///   dcl-ds userList likeds(UserList_t);
///   dcl-s warningDays int(10) inz(7);
///   userList = GetExpiringUsers(warningDays);
///
/// Binding:
///   Create with binder source BIGFATONE.bnd
///
/// Reference:
/// https://youtu.be/xvaZgVMoHhY
///
/// Modification History:
///   V.000 2026-06-01 | Nick Litten | Initial creation - combined service program
///   V.001 2026-06-03 | Nick Litten | Minor Tweaks for VIDEO Overview
///
/// ---------------------------------------------------------------------------

ctl-opt
  nomain
  thread(*serialize)
  alwnull(*inputonly) 
  option(*nodebugio:*srcstmt:*nounref)
  copyright('BIGFATSRV | V.001 | Nicks Big Fat Service Program')
  ;

// temporary global variables for debugging
Dcl-S $debug ind inz('0');
Dcl-S $debugValue char(50);

// ---------------------------------------------------------------------------
// Named Constants
// ---------------------------------------------------------------------------
Dcl-C MAX_EMAIL_BODY_SIZE 32000;
Dcl-C CRLF x'0D25';  // Carriage return + line feed
Dcl-C SQL_SUCCESS 0;
Dcl-C SQL_NO_DATA 100;
Dcl-C MAX_USERS 999;

// Email configuration - These should be set via configuration or parameters
Dcl-C DEFAULT_SMTP_SERVER 'smtp.yourcompany.com';
Dcl-C DEFAULT_EMAIL_FROM 'ibmi-security@yourcompany.com';

// ---------------------------------------------------------------------------
// Data Structures - Exported Types
// ---------------------------------------------------------------------------

// Email configuration structure
Dcl-Ds EmailConfig_t qualified template;
   smtpServer char(256);
   fromAddress char(256);
   toAddress char(256);
   subject char(256);
end-ds;

// Email result structure
Dcl-Ds EmailResult_t qualified template;
   success ind;
   sqlCode int(10);
   sqlState char(5);
   errorMsg char(256);
end-ds;

// User profile information structure
Dcl-Ds UserProfile_t qualified template;
   userName char(10);
   userText char(50);
   status char(10);
   pwdExpDate char(10);
   pwdExpInterval int(10);
   daysUntilExpiry int(10);
   lastSignOn char(10);
   prevSignOn char(10);
end-ds;

// User list structure
Dcl-Ds UserList_t qualified template;
   count int(10);
   users likeds(UserProfile_t) dim(MAX_USERS);
end-ds;


// ---------------------------------------------------------------------------
// Procedure: SendEmail
// Description: Send email using QSYS2.SEND_EMAIL service
// Parameters:
//   - p_EmailConfig: EmailConfig_t - Email configuration
//   - p_messageBody: varchar(32000) - Email body content
// Returns: EmailResult_t with success status and error details
// ---------------------------------------------------------------------------
Dcl-Proc SendEmail export;
   Dcl-Pi *n likeds(EmailResult_t);
      p_EmailConfig likeds(EmailConfig_t) const;
      p_messageBody varchar(MAX_EMAIL_BODY_SIZE) const;
   end-pi;
   
   Dcl-Ds result likeds(EmailResult_t);
   
   // Local variables for SQL call (cannot use const parameters directly)
   Dcl-S toAddr varchar(256);
   Dcl-S subject varchar(256);
   Dcl-S fromAddr varchar(256);
   Dcl-S body varchar(MAX_EMAIL_BODY_SIZE);
   
   // Initialize result
   result.success = *off;
   result.sqlCode = 0;
   result.sqlState = '00000';
   result.errorMsg = '';
   
   // Validate configuration before attempting to send
   If (not ValidateEmailConfig(p_EmailConfig));
      result.errorMsg = 'Invalid email configuration: ' +
                        'Missing or invalid required fields';
      Return result;
   EndIf;
   
   // Validate message body is not empty
   If (%len(%trim(p_messageBody)) = 0);
      result.errorMsg = 'Email body cannot be empty';
      Return result;
   EndIf;
   
   // Copy const parameters to local variables for SQL call
   toAddr = %trim(p_EmailConfig.toAddress);
   subject = %trim(p_EmailConfig.subject);
   fromAddr = %trim(p_EmailConfig.fromAddress);
   body = p_messageBody;
   
   // Send email via IBM i QSYS2 service
   // NOTE: QSYS2.SEND_EMAIL is the preferred interface (vs SYSTOOLS)
   // This function sends email using SNDSMTPEMM (Send SMTP Email Message)
   // Prerequisites:
   //   1. SMTP server configured via CHGSMTPA (Change SMTP Attributes)
   //   2. User registered via ADDUSRSMTP (Add User SMTP) command
   //   3. TCP/IP and SMTP server (*SMTPSVR) subsystem active
   exec sql
      call qsys2.send_email( :toAddr,
                             :subject,
                             :body,
                             :fromAddr
                             );
   
   // Capture SQL diagnostics immediately after execution
   result.sqlCode = sqlcode;
   result.sqlState = sqlstate;
   
   // Evaluate result and provide detailed error information
   If (sqlcode = SQL_SUCCESS);
      result.success = *on;
      LogMessage('Email sent successfully to: ' + %trim(p_EmailConfig.toAddress));
   Else;
      // Build comprehensive error message with diagnostic details
      result.errorMsg = 'Email send failed: SQLCODE=' +
                        %char(sqlcode) + ' SQLSTATE=' + sqlstate;
      
      // Add specific error context based on common SQLCODE values
      Select;
         When (sqlcode = -443);  // Trigger program or external routine error
            result.errorMsg = %trim(result.errorMsg) + ' - SMTP server configuration issue';
         When (sqlcode = -204);  // Object not found
            result.errorMsg = %trim(result.errorMsg) + ' - QSYS2.SEND_EMAIL function not available';
         When (sqlcode = -901);  // System error
            result.errorMsg = %trim(result.errorMsg) + ' - System resource issue';
         Other;
            result.errorMsg = %trim(result.errorMsg) + ' - Check SMTP configuration and user setup';
      EndSl;
      
      // Log error to job log for system monitoring
      LogMessage(result.errorMsg: '*ESCAPE');
   EndIf;
   
   Return result;
end-proc;





// ---------------------------------------------------------------------------
// Procedure: BuildPasswordExpiryReport
// Description: Build formatted email body for password expiration report
// Parameters:
//   - systemName: char(8) - IBM i system name
//   - warningDays: int(10) - Warning period in days
//   - userCount: int(10) - Number of affected users
//   - userLines: varchar(32000) - Formatted user detail lines
// Returns: Formatted email body as varchar
// ---------------------------------------------------------------------------
Dcl-Proc BuildPasswordExpiryReport export;
   Dcl-Pi *n varchar(MAX_EMAIL_BODY_SIZE);
      systemName char(256) const;
      warningDays int(10) const;
      userCount int(10) const;
      userLines varchar(MAX_EMAIL_BODY_SIZE) const;
   end-pi;
   
   Dcl-S emailBody varchar(MAX_EMAIL_BODY_SIZE);
   
   // Build email header
   emailBody = 'IBM i Password Expiration Warning Report' + CRLF +
               '----------------------------------------' + CRLF +
               CRLF +
               'Generated: ' + %char(%timestamp()) + CRLF +
               'System: ' + %trim(systemName) + CRLF +
               'Warning Period: Next ' + %char(warningDays) + ' days' + CRLF +
               CRLF +
               'The following user profiles have passwords expiring soon:' + CRLF +
               CRLF +
               'User - Description - Status - Days Left - Last Sign On' + CRLF +
               '------------------------------------------------------ ' + CRLF;
   
   // Add user lines
   emailBody += userLines;
   
   // Add footer
   emailBody += CRLF +
                '----------------------------------------' + CRLF +
                'Total users with expiring passwords: ' + 
                %char(userCount) + CRLF +
                CRLF +
                'Action Required:' + CRLF +
                '- Contact affected users to change their passwords' + CRLF +
                '- Review disabled accounts for potential cleanup' + CRLF +
                '- Update password policies if needed' + CRLF +
                CRLF +
                'This is an automated message from the IBM i ' +
                'Password Expiration Monitor.' + CRLF;
   
   Return emailBody;
end-proc;





// ---------------------------------------------------------------------------
// Procedure: BuildEmailSubject
// Description: Build email subject line with user count
// Parameters:
//   - p_baseSubject: char(256) - Base subject text
//   - userCount: int(10) - Number of affected users
// Returns: Formatted subject line
// ---------------------------------------------------------------------------
Dcl-Proc BuildEmailSubject export;
   Dcl-Pi *n varchar(256);
      p_baseSubject char(256) const;
      p_userCount int(10) const;
   end-pi;
   
   Dcl-S subject varchar(256);
   
   If (p_userCount = 1);
      subject = %trim(p_baseSubject) + ' - 1 User Affected';
   Else;
      subject = %trim(p_baseSubject) + ' - ' + 
                %char(p_userCount) + ' Users Affected';
   EndIf;
   
   Return subject;
end-proc;





// ---------------------------------------------------------------------------
// Procedure: LogMessage
// Description: Send message to job log
// Parameters:
//   - message: char(256) - Message text
//   - messageType: char(10) - Message type (*COMP, *DIAG, *ESCAPE, etc.)
// ---------------------------------------------------------------------------
Dcl-Proc LogMessage export;
   Dcl-Pi *n;
      p_message char(256) const;
      p_msgType char(10) const options(*nopass);
   end-pi;
   
   Dcl-S message char(256);
   Dcl-S msgType char(10);
   Dcl-S length int(5) ;
   
   message = p_message;
   length = %len(%trimr(message)) ;

   // Default to completion message if not specified
   If (%Parms() >= 2);
      msgType = p_msgType;
   Else;
      msgType = '*COMP';
   EndIf;

   MONITOR;

      // TO BE FIXED !!!!!!!!!!!!!!!!!!!!!!!!!!!
      // Why doesnt SND-MSG accept a *COMP/*DIAG for the message?
      // snd-msgh message %TARGET(*CALLER : 1);

      // If (msgType = '*COMP');
      // snd-msg *comp message %TARGET(*CALLER : 1);
      // Elseif (msgType = '*DIAG');
      // snd-msg *diag message %TARGET(*CALLER : 1);
      // Elseif (msgType = '*INFO');
      // snd-msg *info message %TARGET(*CALLER : 1);
      // Elseif (msgType = '*ESCAPE');
      // snd-msg *escape message %TARGET(*CALLER : 1);
      // Elseif (msgType = '*NOTIFY');
      // snd-msg *notify message %TARGET(*CALLER : 1);
      // Elseif (msgType = '*STATUS');
      // snd-msg *status message %TARGET(*CALLER : 1);
      // Else;
      snd-msg message %TARGET(*CALLER : 1);
      // EndIf;

   ON-ERROR 126;
      DSPLY 'SND-MSG error';
   ON-ERROR 9999;
      DSPLY 'Escape message';
   ENDMON;


end-proc;





// ---------------------------------------------------------------------------
// Procedure: ValidateEmailConfig
// Description: Validate email configuration parameters
// Parameters:
//   - config: EmailConfig_t - Email configuration to validate
// Returns: *on if valid, *off if invalid
// ---------------------------------------------------------------------------
Dcl-Proc ValidateEmailConfig export;
   Dcl-Pi *n ind;
      p_EmailConfig likeds(EmailConfig_t) const;
   end-pi;
   
   // Check required fields are not blank
   If (%trim(p_EmailConfig.toAddress) = '');
      Return *off;
   EndIf;
   
   If (%trim(p_EmailConfig.subject) = '');
      Return *off;
   EndIf;
   
   // Basic email format validation (contains @)
   If (%scan('@' : %trim(p_EmailConfig.toAddress)) = 0);
      Return *off;
   EndIf;
   
   Return *on;
end-proc;





// ---------------------------------------------------------------------------
// Procedure: EscapeSqlString
// Description: Escape single quotes in strings for SQL safety
// Parameters:
//   - inputString: varchar(1000) - String to escape
// Returns: Escaped string with doubled single quotes
// ---------------------------------------------------------------------------
Dcl-Proc EscapeSqlString export;
   Dcl-Pi *n varchar(1000);
      inputString varchar(1000) const;
   end-pi;
   
   Return %scanrpl('''':'''''':inputString);
end-proc;





// ---------------------------------------------------------------------------
// User Profile Service Procedures (from USRPRFSRV)
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Procedure: GetExpiringUsers
// Description: Query database for users with expiring passwords
// Parameters:
//   - warningDays: int(10) - Number of days to look ahead
// Returns: UserList_t structure with matching users
// ---------------------------------------------------------------------------
Dcl-Proc GetExpiringUsers export;
   Dcl-Pi *n likeds(UserList_t);
      p_warningDays int(10) const;
   end-pi;
   
   Dcl-Ds userList likeds(UserList_t);
   Dcl-Ds currentUser likeds(UserProfile_t);
   Dcl-S idx int(10) inz(0);
   
   // Initialize return structure
   clear userList;
   
   // Declare cursor for user profiles
   exec sql declare userCursor cursor for
      select
         authorization_name,
         coalesce(text_description, ' '),
         status,
         coalesce(char(date_password_expires), ''),
         password_expiration_interval,
         days_until_password_expires,
         coalesce(char(last_used_timestamp), ' '),
         coalesce(char(previous_signon), ' ')
      from qsys2.user_info
      where status in ('*ENABLED', '*DISABLED')
        and days_until_password_expires is not null
        and days_until_password_expires between 0 and :p_warningDays
      order by days_until_password_expires, authorization_name;
   
   // Open cursor
   exec sql open userCursor;

   // display value of currentUser.userName to screen
   If ($debug);
      $debugValue = 'SQL Code:' + %char(sqlcode);
      Dsply $debugValue;
   EndIf;

   If (sqlcode = SQL_SUCCESS);
   
      // Loop through results
      dou (idx = MAX_USERS);

         // Fetch next record
         exec sql fetch next from userCursor into
         :currentUser.userName,
         :currentUser.userText,
         :currentUser.status,
         :currentUser.pwdExpDate,
         :currentUser.pwdExpInterval,
         :currentUser.daysUntilExpiry,
         :currentUser.lastSignOn,
         :currentUser.prevSignOn;

         // display value of currentUser.userName to screen
         If ($debug);
            $debugValue = 'FETCH SQL Code:' + %char(sqlcode);
            Dsply $debugValue;
         EndIf;

         If (sqlcode <> SQL_SUCCESS or idx >= MAX_USERS);
            leave;
         EndIf;

         // display value of currentUser.userName to screen
         If ($debug);
            $debugValue = 'User:' + currentUser.userName;
            Dsply $debugValue;
         EndIf;

         idx += 1;
         userList.count = idx;
         userList.users(idx) = currentUser;

      enddo;
   
      // Close cursor
      exec sql close userCursor;

   EndIf;
   
   Return userList;
end-proc;





// ---------------------------------------------------------------------------
// Procedure: FormatUserInfo
// Description: Format user profile information for display/email
// Parameters:
//   - user: UserProfile_t - User profile to format
// Returns: Formatted string with user details
// ---------------------------------------------------------------------------
Dcl-Proc FormatUserInfo export;
   Dcl-Pi *n char(200);
      p_User likeds(UserProfile_t) const;
   end-pi;
   
   Dcl-S line varchar(200);
   Dcl-S lastSignOnStr char(19);
   Dcl-S expDateStr char(10);
   Dcl-S daysStr char(15);
   
   // Format expiration date
   If (p_User.pwdExpDate <> *loval);
      expDateStr = %char(p_User.pwdExpDate);
   Else;
      expDateStr = '*NONE';
   EndIf;
   
   // Format days until expiry with urgency indicator
   If (p_User.daysUntilExpiry = 0);
      daysStr = '**TODAY**';
   elseif (p_User.daysUntilExpiry = 1);
      daysStr = '1 day';
   Else;
      daysStr = %char(p_User.daysUntilExpiry) + ' days';
   EndIf;
   
   // Format last sign on
   If (p_User.lastSignOn <> *loval);
      lastSignOnStr = p_User.lastSignOn;
   Else;
      lastSignOnStr = 'Never';
   EndIf;
   
   // Build formatted line with proper spacing
   line = %trim(p_User.userName) + ' - ' + 
          %trim(p_User.userText) + ' - ' + 
          %trim(p_User.status) + ' - ' + 
          daysStr + ' - ' + 
          lastSignOnStr;
   
   Return line;
end-proc;





// ---------------------------------------------------------------------------
// Procedure: GetSystemName
// Description: Retrieve the current IBM i system name
// Returns: System name as character string
// ---------------------------------------------------------------------------
Dcl-Proc GetSystemName export;
   Dcl-Pi *n char(256);
   end-pi;
   
   Dcl-S systemName char(256);
   
   exec sql select host_name into :systemName
            from sysibmadm.env_sys_info;
   
   If (sqlcode <> SQL_SUCCESS);
      systemName = '*UNKNOWN';
   EndIf;
   
   Return systemName;
end-proc;





// ---------------------------------------------------------------------------
// Procedure: ValidateWarningDays
// Description: Validate the warning days parameter
// Parameters:
//   - days: int(10) - Number of days to validate
// Returns: *on if valid (1-365), *off if invalid
// ---------------------------------------------------------------------------
Dcl-Proc ValidateWarningDays export;
   Dcl-Pi *n ind;
      p_days int(10) const;
   end-pi;
   
   Return (p_days >= 1 and p_days <= 365);
end-proc;






// ---------------------------------------------------------------------------
// Procedure: WriteToIFS
// Description: Write report content to an IBM i IFS stream file using SQL
// Parameters:
//   - p_IfsPath: char(256) - Target IFS path (for example /tmp/report.txt)
//   - p_Content: varchar(32000) - Text content to write
// Returns: *on if write succeeds, *off if path is blank or SQL write fails
// Notes:
//   - Uses QSYS2.IFS_WRITE service with OVERWRITE = 'REPLACE'
//   - Uses END_OF_LINE = 'NONE' so caller controls line breaks in content
// ---------------------------------------------------------------------------
Dcl-Proc WriteToIFS export;
   Dcl-Pi *n ind;
      p_IfsPath char(256);
      p_Content varchar(32000);
   end-pi;

   Dcl-S ifsPath varchar(256);

   ifsPath = %trim(p_IfsPath);
   If (ifsPath = '');
      Return *off;
   EndIf;

   exec sql
      call qsys2.ifs_write(
         path_name => :ifsPath,
         line => :p_Content,
         overwrite => 'REPLACE',
         file_ccsid => 1208,
         end_of_line => 'CRLF');

   If (sqlstate <> '00000');
      Return *off;
   EndIf;

   Return *on;
end-proc;
