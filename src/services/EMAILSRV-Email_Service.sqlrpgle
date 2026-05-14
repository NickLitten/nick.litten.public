**free

///
/// Service Program: EMAILSRV - Email Notification Service
///
/// Description: Production-quality service program providing reusable email
///              notification procedures using IBM i QSYS2.SEND_EMAIL service.
///              Includes email validation, formatting, and comprehensive error
///              handling for password expiration monitoring and other notifications.
///
/// Purpose: Production utility demonstrating:
///   - Service program architecture with multiple exported procedures
///   - IBM i QSYS2.SEND_EMAIL integration
///   - Email configuration and validation
///   - Formatted report generation
///   - Comprehensive error handling and diagnostics
///   - Job log integration for monitoring
///
/// Features:
///   - Send email with subject and body
///   - Build formatted password expiration reports
///   - Email configuration validation
///   - SQL string escaping for safety
///   - Detailed error diagnostics with SQLCODE/SQLSTATE
///   - Job log message integration
///   - Template data structures for type safety
///
/// Exported Procedures:
///   - SendEmail: Send email using QSYS2.SEND_EMAIL
///   - BuildPasswordExpiryReport: Format password expiration report
///   - BuildEmailSubject: Build subject line with user count
///   - LogMessage: Send message to job log
///   - ValidateEmailConfig: Validate email configuration
///   - EscapeSqlString: Escape single quotes for SQL safety
///
/// Data Structures:
///   - EmailConfig_t: Email configuration template
///   - EmailResult_t: Email result with success/error details
///
/// Prerequisites:
///   - SMTP server configured via CHGSMTPA command
///   - User registered via ADDUSRSMTP command
///   - TCP/IP and SMTP server (*SMTPSVR) subsystem active
///
/// Usage Example:
///   dcl-ds config likeds(EmailConfig_t);
///   dcl-ds result likeds(EmailResult_t);
///   config.toAddress = 'admin@company.com';
///   config.subject = 'Test Email';
///   config.fromAddress = 'ibmi@company.com';
///   result = SendEmail(config: 'Email body text');
///
/// Binding:
///   Create with binder source EMAILSRV.bnd
///   Used by PWDEXPILE password monitoring program
///
/// Reference:
/// https://www.nicklitten.com/blog/ibmi-email-notifications/
///
/// Modification History:
///   V.000 2026-02-03 | Nick Litten | Initial creation - modular email service
///   V.001 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

ctl-opt
  nomain
  thread(*serialize)
  option(*nodebugio:*srcstmt:*nounref)
  copyright('EMAILSRV | V.001 | Email Notification Service')
  ;

// ------------------------------------------------------------------------------
// Named Constants
// ------------------------------------------------------------------------------
Dcl-C MAX_EMAIL_BODY_SIZE 32000;
Dcl-C CRLF x'0D25';  // Carriage return + line feed
Dcl-C SQL_SUCCESS 0;

// Email configuration - These should be set via configuration or parameters
Dcl-C DEFAULT_SMTP_SERVER 'smtp.yourcompany.com';
Dcl-C DEFAULT_EMAIL_FROM 'ibmi-security@yourcompany.com';

// ------------------------------------------------------------------------------
// Data Structures - Exported Types
// ------------------------------------------------------------------------------

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

// ------------------------------------------------------------------------------
// Procedure: SendEmail
// Description: Send email using QSYS2.SEND_EMAIL service
// Parameters:
//   - config: EmailConfig_t - Email configuration
//   - messageBody: varchar(32000) - Email body content
// Returns: EmailResult_t with success status and error details
// ------------------------------------------------------------------------------
Dcl-Proc SendEmail export;
   Dcl-Pi *n likeds(EmailResult_t);
      config likeds(EmailConfig_t) const;
      messageBody varchar(MAX_EMAIL_BODY_SIZE) const;
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
   If (not ValidateEmailConfig(config));
      result.errorMsg = 'Invalid email configuration: ' +
                        'Missing or invalid required fields';
      Return result;
   EndIf;
   
   // Validate message body is not empty
   If (%len(%trim(messageBody)) = 0);
      result.errorMsg = 'Email body cannot be empty';
      Return result;
   EndIf;
   
   // Copy const parameters to local variables for SQL call
   toAddr = %trim(config.toAddress);
   subject = %trim(config.subject);
   fromAddr = %trim(config.fromAddress);
   body = messageBody;
   
   // Send email via IBM i QSYS2 service
   // NOTE: QSYS2.SEND_EMAIL is the preferred interface (vs SYSTOOLS)
   // This function sends email using SNDSMTPEMM (Send SMTP Email Message)
   // Prerequisites:
   //   1. SMTP server configured via CHGSMTPA (Change SMTP Attributes)
   //   2. User registered via ADDUSRSMTP (Add User SMTP) command
   //   3. TCP/IP and SMTP server (*SMTPSVR) subsystem active
   exec sql
      call qsys2.send_email(
         :toAddr,
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
      LogMessage('Email sent successfully to: ' + %trim(config.toAddress));
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

// ------------------------------------------------------------------------------
// Procedure: BuildPasswordExpiryReport
// Description: Build formatted email body for password expiration report
// Parameters:
//   - systemName: char(8) - IBM i system name
//   - warningDays: int(10) - Warning period in days
//   - userCount: int(10) - Number of affected users
//   - userLines: varchar(32000) - Formatted user detail lines
// Returns: Formatted email body as varchar
// ------------------------------------------------------------------------------
Dcl-Proc BuildPasswordExpiryReport export;
   Dcl-Pi *n varchar(MAX_EMAIL_BODY_SIZE);
      systemName char(8) const;
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
               'User       Description                    Status     ' +
               'Exp Date   Days Left  Last Sign On' + CRLF +
               '---------- ------------------------------ ---------- ' +
               '---------- ---------- ---------------' + CRLF;
   
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

// ------------------------------------------------------------------------------
// Procedure: BuildEmailSubject
// Description: Build email subject line with user count
// Parameters:
//   - baseSubject: char(256) - Base subject text
//   - userCount: int(10) - Number of affected users
// Returns: Formatted subject line
// ------------------------------------------------------------------------------
Dcl-Proc BuildEmailSubject export;
   Dcl-Pi *n varchar(256);
      baseSubject char(256) const;
      userCount int(10) const;
   end-pi;
   
   Dcl-S subject varchar(256);
   
   If (userCount = 1);
      subject = %trim(baseSubject) + ' - 1 User Affected';
   Else;
      subject = %trim(baseSubject) + ' - ' + 
                %char(userCount) + ' Users Affected';
   EndIf;
   
   Return subject;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: LogMessage
// Description: Send message to job log
// Parameters:
//   - message: char(256) - Message text
//   - messageType: char(10) - Message type (*COMP, *DIAG, *ESCAPE, etc.)
// ------------------------------------------------------------------------------
Dcl-Proc LogMessage export;
   Dcl-Pi *n;
      message char(256) const;
      messageType char(10) const options(*nopass);
   end-pi;
   
   Dcl-S cmdString varchar(512);
   Dcl-S msgType char(10);
   
   // Default to completion message if not specified
   If (%Parms() >= 2);
      msgType = messageType;
   Else;
      msgType = '*COMP';
   EndIf;
   
   // Build and execute SNDPGMMSG command
   cmdString = 'SNDPGMMSG MSG(''' + 
               %trim(%scanrpl('''':'''''':message)) + 
               ''') TOPGMQ(*EXT) MSGTYPE(' + %trim(msgType) + ')';
   
   exec sql call qsys2.qcmdexc(:cmdString);
end-proc;

// ------------------------------------------------------------------------------
// Procedure: ValidateEmailConfig
// Description: Validate email configuration parameters
// Parameters:
//   - config: EmailConfig_t - Email configuration to validate
// Returns: *on if valid, *off if invalid
// ------------------------------------------------------------------------------
Dcl-Proc ValidateEmailConfig export;
   Dcl-Pi *n ind;
      config likeds(EmailConfig_t) const;
   end-pi;
   
   // Check required fields are not blank
   If (%trim(config.toAddress) = '');
      Return *off;
   EndIf;
   
   If (%trim(config.subject) = '');
      Return *off;
   EndIf;
   
   // Basic email format validation (contains @)
   If (%scan('@' : %trim(config.toAddress)) = 0);
      Return *off;
   EndIf;
   
   Return *on;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: EscapeSqlString
// Description: Escape single quotes in strings for SQL safety
// Parameters:
//   - inputString: varchar(1000) - String to escape
// Returns: Escaped string with doubled single quotes
// ------------------------------------------------------------------------------
Dcl-Proc EscapeSqlString export;
   Dcl-Pi *n varchar(1000);
      inputString varchar(1000) const;
   end-pi;
   
   Return %scanrpl('''':'''''':inputString);
end-proc;
