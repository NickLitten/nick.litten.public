**free

///
/// Program: PWDEXPILE - Password Expiration Monitor (ILE Modular Version)
///
/// Description: Production-quality password expiration monitoring program using
///              modular ILE architecture. Monitors all IBM i user profiles and
///              sends email warnings for passwords expiring within a specified
///              number of days. Demonstrates modern ILE service program integration.
///
/// Purpose: Production utility demonstrating:
///   - Modular ILE program architecture
///   - Service program integration (USRPROFSRV, EMAILSRV)
///   - Main procedure pattern
///   - Binding directory usage
///   - Parameter validation
///   - Comprehensive error handling
///   - Job log integration
///
/// Features:
///   - Configurable warning period (days)
///   - Email notification with formatted report
///   - User profile query via service program
///   - Email formatting via service program
///   - Detailed logging to job log
///   - Parameter validation with defaults
///   - Production-ready error handling
///
/// Architecture:
///   Uses two service programs:
///   - USRPROFSRV: User profile query services
///   - EMAILSRV: Email notification services
///
/// Usage:
///   CALL PWDEXPILE PARM(7)   - Check for passwords expiring in 7 days
///   CALL PWDEXPILE PARM(14)  - Check for passwords expiring in 14 days
///   CALL PWDEXPILE           - Uses default (7 days)
///
/// Parameters:
///   - parmWarningDays: int(10) - Number of days to look ahead (optional)
///
/// Email Configuration:
///   Customize these constants for your environment:
///   - SMTP_SERVER: Your SMTP server address
///   - EMAIL_FROM: Sender email address
///   - EMAIL_TO: Recipient email address
///   - EMAIL_SUBJECT: Base subject line
///
/// Prerequisites:
///   - Service programs USRPROFSRV and EMAILSRV compiled
///   - Binding directory PWDMON created
///   - SMTP server configured (CHGSMTPA)
///   - User registered for SMTP (ADDUSRSMTP)
///
/// Binding:
///   CRTPGM PGM(library/PWDEXPILE) MODULE(PWDEXPILE) +
///          BNDDIR(PWDMON) ACTGRP(*CALLER)
///
/// Reference:
/// https://www.nicklitten.com/blog/password-expiration-monitoring/
///
/// Modification History:
///   V.000 2026-02-03 | Nick Litten | Initial creation
///   V.001 2026-02-03 | Nick Litten | Refactored to modular ILE architecture
///   V.002 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

ctl-opt
  main(mainline)
  dftactgrp(*no)
  actgrp(*caller)
  option(*nodebugio:*srcstmt:*nounref)
  bnddir('PWDMON')
  copyright('PWDEXPILE | V.002 | Password Expiration Monitor - ILE Modular')
  ;

// ------------------------------------------------------------------------------
// Prototypes for Service Program Procedures
// ------------------------------------------------------------------------------

// User Profile Service prototypes
dcl-pr GetExpiringUsers likeds(UserList_t);
   warningDays int(10) const;
end-pr;

dcl-pr FormatUserInfo varchar(200);
   user likeds(UserProfile_t) const;
end-pr;

dcl-pr GetSystemName char(8);
end-pr;

dcl-pr ValidateWarningDays ind;
   days int(10) const;
end-pr;

// Email Service prototypes
dcl-pr SendEmail likeds(EmailResult_t);
   config likeds(EmailConfig_t) const;
   messageBody varchar(32000) const;
end-pr;

dcl-pr BuildPasswordExpiryReport varchar(32000);
   systemName char(8) const;
   warningDays int(10) const;
   userCount int(10) const;
   userLines varchar(32000) const;
end-pr;

dcl-pr BuildEmailSubject varchar(256);
   baseSubject char(256) const;
   userCount int(10) const;
end-pr;

dcl-pr LogMessage;
   message char(256) const;
   messageType char(10) const options(*nopass);
end-pr;

dcl-pr ValidateEmailConfig ind;
   config likeds(EmailConfig_t) const;
end-pr;

// ------------------------------------------------------------------------------
// Data Structures
// ------------------------------------------------------------------------------

// User profile information structure
Dcl-Ds UserProfile_t qualified template;
   userName char(10);
   userText char(50);
   status char(10);
   pwdExpDate date;
   pwdExpInterval int(10);
   daysUntilExpiry int(10);
   lastSignOn timestamp;
   prevSignOn timestamp;
end-ds;

// User list structure
Dcl-Ds UserList_t qualified template;
   count int(10);
   users likeds(UserProfile_t) dim(9999);
end-ds;

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
// Named Constants
// ------------------------------------------------------------------------------
Dcl-C DEFAULT_WARNING_DAYS 7;
Dcl-C CRLF x'0D25';

// Email configuration - CUSTOMIZE THESE FOR YOUR ENVIRONMENT
Dcl-C SMTP_SERVER 'smtp.yourcompany.com';
Dcl-C EMAIL_FROM 'ibmi-security@yourcompany.com';
Dcl-C EMAIL_TO 'security-team@yourcompany.com';
Dcl-C EMAIL_SUBJECT 'IBM i Password Expiration Warning';

// ------------------------------------------------------------------------------
// Standalone Variables
// ------------------------------------------------------------------------------
Dcl-S warningDays int(10);

// ------------------------------------------------------------------------------
// Main Procedure
// ------------------------------------------------------------------------------
Dcl-Proc mainline;
   Dcl-Pi *n;
      parmWarningDays int(10) const options(*nopass);
   end-pi;
   
   Dcl-Ds userList likeds(UserList_t);
   Dcl-Ds emailConfig likeds(EmailConfig_t);
   Dcl-Ds emailResult likeds(EmailResult_t);
   Dcl-S systemName char(8);
   Dcl-S emailBody varchar(32000);
   Dcl-S userLines varchar(32000);
   Dcl-S i int(10);
   
   // Set warning days from parameter or use default
   If (%Parms() >= 1);
      warningDays = parmWarningDays;
   Else;
      warningDays = DEFAULT_WARNING_DAYS;
   EndIf;
   
   // Validate warning days parameter
   If (not ValidateWarningDays(warningDays));
      LogMessage('Invalid warning days: ' + %char(warningDays) + 
                 '. Using default: ' + %char(DEFAULT_WARNING_DAYS) : '*DIAG');
      warningDays = DEFAULT_WARNING_DAYS;
   EndIf;
   
   // Log program start
   LogMessage('PWDEXPMON started - checking for passwords expiring within ' +
              %char(warningDays) + ' days' : '*COMP');
   
   // Get system name
   systemName = GetSystemName();
   
   // Query for expiring user profiles
   userList = GetExpiringUsers(warningDays);
   
   // Check if any users found
   If (userList.count = 0);
      LogMessage('No expiring passwords found within ' + 
                 %char(warningDays) + ' days' : '*COMP');
      Return;
   EndIf;
   
   // Build user lines for email body
   userLines = '';
   for i = 1 to userList.count;
      userLines += FormatUserInfo(userList.users(i)) + CRLF;
   endfor;
   
   // Build complete email body
   emailBody = BuildPasswordExpiryReport(systemName : 
                                         warningDays : 
                                         userList.count : 
                                         userLines);
   
   // Configure email settings
   emailConfig.smtpServer = SMTP_SERVER;
   emailConfig.fromAddress = EMAIL_FROM;
   emailConfig.toAddress = EMAIL_TO;
   emailConfig.subject = BuildEmailSubject(EMAIL_SUBJECT : userList.count);
   
   // Validate email configuration
   If (not ValidateEmailConfig(emailConfig));
      LogMessage('Invalid email configuration - check settings' : '*DIAG');
      Return;
   EndIf;
   
   // Send email notification
   emailResult = SendEmail(emailConfig : emailBody);
   
   If (emailResult.success);
      LogMessage('Email notification sent successfully to ' + 
                 %trim(EMAIL_TO) : '*COMP');
   Else;
      LogMessage(emailResult.errorMsg : '*DIAG');
   EndIf;
   
   // Log completion
   LogMessage('PWDEXPMON completed - ' + %char(userList.count) + 
              ' expiring passwords found' : '*COMP');
   
   Return;
end-proc;
