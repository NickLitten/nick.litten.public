**free
//
// Service Program: EMAILSRV - Email Service
// Description: Provides reusable procedures for sending email notifications
//              via IBM i QSYS2.SEND_EMAIL service
//
// Exports:
//   - SendEmail() - Send email with subject and body
//   - BuildPasswordExpiryReport() - Build formatted email report
//   - LogMessage() - Send message to job log
//
// Modification History:
// v.001 2026.02.03 - Nick Litten - Created modular email service
//

ctl-opt
     nomain
     option(*nodebugio:*srcstmt:*nounref)
     copyright('EMAILSRV | V.001 | Email Service');

// ============================================================================
// Constants
// ============================================================================
dcl-c MAX_EMAIL_BODY_SIZE 32000;
dcl-c CRLF x'0D25';  // Carriage return + line feed
dcl-c SQL_SUCCESS 0;

// Email configuration - These should be set via configuration or parameters
dcl-c DEFAULT_SMTP_SERVER 'smtp.yourcompany.com';
dcl-c DEFAULT_EMAIL_FROM 'ibmi-security@yourcompany.com';

// ============================================================================
// Data Structures - Exported Types
// ============================================================================

// Email configuration structure
dcl-ds EmailConfig_t qualified template;
   smtpServer char(256);
   fromAddress char(256);
   toAddress char(256);
   subject char(256);
end-ds;

// Email result structure
dcl-ds EmailResult_t qualified template;
   success ind;
   sqlCode int(10);
   sqlState char(5);
   errorMsg char(256);
end-ds;

// ============================================================================
// Procedure: SendEmail
// Purpose: Send email using QSYS2.SEND_EMAIL service
// Returns: EmailResult_t with success status and error details
// ============================================================================
dcl-proc SendEmail export;
   dcl-pi *n likeds(EmailResult_t);
      config likeds(EmailConfig_t) const;
      messageBody varchar(MAX_EMAIL_BODY_SIZE) const;
   end-pi;
   
   dcl-ds result likeds(EmailResult_t);
   
   // Local variables for SQL call (cannot use const parameters directly)
   dcl-s toAddr varchar(256);
   dcl-s subject varchar(256);
   dcl-s fromAddr varchar(256);
   dcl-s body varchar(MAX_EMAIL_BODY_SIZE);
   
   // Initialize result
   result.success = *off;
   result.sqlCode = 0;
   result.sqlState = '00000';
   result.errorMsg = '';
   
   // Validate configuration before attempting to send
   if not ValidateEmailConfig(config);
      result.errorMsg = 'Invalid email configuration: ' +
                        'Missing or invalid required fields';
      return result;
   endif;
   
   // Validate message body is not empty
   if %len(%trim(messageBody)) = 0;
      result.errorMsg = 'Email body cannot be empty';
      return result;
   endif;
   
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
   if sqlcode = SQL_SUCCESS;
      result.success = *on;
      LogMessage('Email sent successfully to: ' + %trim(config.toAddress));
   else;
      // Build comprehensive error message with diagnostic details
      result.errorMsg = 'Email send failed: SQLCODE=' +
                        %char(sqlcode) + ' SQLSTATE=' + sqlstate;
      
      // Add specific error context based on common SQLCODE values
      select;
         when sqlcode = -443;  // Trigger program or external routine error
            result.errorMsg = %trim(result.errorMsg) + ' - SMTP server configuration issue';
         when sqlcode = -204;  // Object not found
            result.errorMsg = %trim(result.errorMsg) + ' - QSYS2.SEND_EMAIL function not available';
         when sqlcode = -901;  // System error
            result.errorMsg = %trim(result.errorMsg) + ' - System resource issue';
         other;
            result.errorMsg = %trim(result.errorMsg) + ' - Check SMTP configuration and user setup';
      endsl;
      
      // Log error to job log for system monitoring
      LogMessage(result.errorMsg: '*ESCAPE');
   endif;
   
   return result;
end-proc;

// ============================================================================
// Procedure: BuildPasswordExpiryReport
// Purpose: Build formatted email body for password expiration report
// Returns: Formatted email body as varchar
// ============================================================================
dcl-proc BuildPasswordExpiryReport export;
   dcl-pi *n varchar(MAX_EMAIL_BODY_SIZE);
      systemName char(8) const;
      warningDays int(10) const;
      userCount int(10) const;
      userLines varchar(MAX_EMAIL_BODY_SIZE) const;
   end-pi;
   
   dcl-s emailBody varchar(MAX_EMAIL_BODY_SIZE);
   
   // Build email header
   emailBody = 'IBM i Password Expiration Warning Report' + CRLF +
               '========================================' + CRLF +
               CRLF +
               'Generated: ' + %char(%timestamp()) + CRLF +
               'System: ' + %trim(systemName) + CRLF +
               'Warning Period: Next ' + %char(warningDays) + ' days' + CRLF +
               CRLF +
               'The following user profiles have passwords expiring soon:' + CRLF +
               CRLF +
               'User       Description                    Status     ' +
               'Exp Date   Days Left  Last Sign On' + CRLF +
               '========== ============================== ========== ' +
               '========== ========== ===================' + CRLF;
   
   // Add user lines
   emailBody += userLines;
   
   // Add footer
   emailBody += CRLF +
                '========================================' + CRLF +
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
   
   return emailBody;
end-proc;

// ============================================================================
// Procedure: BuildEmailSubject
// Purpose: Build email subject line with user count
// Returns: Formatted subject line
// ============================================================================
dcl-proc BuildEmailSubject export;
   dcl-pi *n varchar(256);
      baseSubject char(256) const;
      userCount int(10) const;
   end-pi;
   
   dcl-s subject varchar(256);
   
   if userCount = 1;
      subject = %trim(baseSubject) + ' - 1 User Affected';
   else;
      subject = %trim(baseSubject) + ' - ' + 
                %char(userCount) + ' Users Affected';
   endif;
   
   return subject;
end-proc;

// ============================================================================
// Procedure: LogMessage
// Purpose: Send message to job log
// ============================================================================
dcl-proc LogMessage export;
   dcl-pi *n;
      message char(256) const;
      messageType char(10) const options(*nopass);
   end-pi;
   
   dcl-s cmdString varchar(512);
   dcl-s msgType char(10);
   
   // Default to completion message if not specified
   if %parms() >= 2;
      msgType = messageType;
   else;
      msgType = '*COMP';
   endif;
   
   // Build and execute SNDPGMMSG command
   cmdString = 'SNDPGMMSG MSG(''' + 
               %trim(%scanrpl('''':'''''':message)) + 
               ''') TOPGMQ(*EXT) MSGTYPE(' + %trim(msgType) + ')';
   
   exec sql call qsys2.qcmdexc(:cmdString);
end-proc;

// ============================================================================
// Procedure: ValidateEmailConfig
// Purpose: Validate email configuration parameters
// Returns: *on if valid, *off if invalid
// ============================================================================
dcl-proc ValidateEmailConfig export;
   dcl-pi *n ind;
      config likeds(EmailConfig_t) const;
   end-pi;
   
   // Check required fields are not blank
   if %trim(config.toAddress) = '';
      return *off;
   endif;
   
   if %trim(config.subject) = '';
      return *off;
   endif;
   
   // Basic email format validation (contains @)
   if %scan('@' : %trim(config.toAddress)) = 0;
      return *off;
   endif;
   
   return *on;
end-proc;

// ============================================================================
// Procedure: EscapeSqlString
// Purpose: Escape single quotes in strings for SQL safety
// Returns: Escaped string
// ============================================================================
dcl-proc EscapeSqlString export;
   dcl-pi *n varchar(1000);
      inputString varchar(1000) const;
   end-pi;
   
   return %scanrpl('''':'''''':inputString);
end-proc;