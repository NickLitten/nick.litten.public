**free
//
// Program Name: PWDEXPILE - Password Expiration Monitor (ILE Modular Version)
// Description:  Monitors all IBM i user profiles and sends email warnings for
//               passwords expiring within a specified number of days
//
// Architecture: Modular ILE program using service programs:
//               - USRPROFSRV: User profile query services
//               - EMAILSRV: Email notification services
//
// Usage: PWDEXPMON DAYS(7)  - Check for passwords expiring in 7 days
//        PWDEXPMON DAYS(14) - Check for passwords expiring in 14 days
//
// Modification History:
// v.002 2026.02.03 - Nick Litten - Refactored to modular ILE architecture
// v.001 2026.02.03 - Nick Litten - Created password expiration monitoring program
//

ctl-opt
     dftactgrp(*no)
     actgrp(*caller)
     option(*nodebugio:*srcstmt:*nounref)
     main(Main)
     bnddir('PWDMON')
     copyright('PWDEXPMON | V.002 | Password Expiration Monitor - ILE');

// ============================================================================
// Prototypes for Service Program Procedures
// ============================================================================

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

// ============================================================================
// Data Structures (must match service program definitions)
// ============================================================================

// User profile information structure
dcl-ds UserProfile_t qualified template;
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
dcl-ds UserList_t qualified template;
   count int(10);
   users likeds(UserProfile_t) dim(9999);
end-ds;

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
// Constants
// ============================================================================
dcl-c DEFAULT_WARNING_DAYS 7;
dcl-c CRLF x'0D25';

// Email configuration - CUSTOMIZE THESE FOR YOUR ENVIRONMENT
dcl-c SMTP_SERVER 'smtp.yourcompany.com';
dcl-c EMAIL_FROM 'ibmi-security@yourcompany.com';
dcl-c EMAIL_TO 'security-team@yourcompany.com';
dcl-c EMAIL_SUBJECT 'IBM i Password Expiration Warning';

// ============================================================================
// Global Variables
// ============================================================================
dcl-s warningDays int(10);

// ============================================================================
// Main Procedure
// ============================================================================
dcl-proc Main;
   dcl-pi *n;
      parmWarningDays int(10) const options(*nopass);
   end-pi;
   
   dcl-ds userList likeds(UserList_t);
   dcl-ds emailConfig likeds(EmailConfig_t);
   dcl-ds emailResult likeds(EmailResult_t);
   dcl-s systemName char(8);
   dcl-s emailBody varchar(32000);
   dcl-s userLines varchar(32000);
   dcl-s i int(10);
   
   // Set warning days from parameter or use default
   if %parms() >= 1;
      warningDays = parmWarningDays;
   else;
      warningDays = DEFAULT_WARNING_DAYS;
   endif;
   
   // Validate warning days parameter
   if not ValidateWarningDays(warningDays);
      LogMessage('Invalid warning days: ' + %char(warningDays) + 
                 '. Using default: ' + %char(DEFAULT_WARNING_DAYS) : '*DIAG');
      warningDays = DEFAULT_WARNING_DAYS;
   endif;
   
   // Log program start
   LogMessage('PWDEXPMON started - checking for passwords expiring within ' +
              %char(warningDays) + ' days' : '*COMP');
   
   // Get system name
   systemName = GetSystemName();
   
   // Query for expiring user profiles
   userList = GetExpiringUsers(warningDays);
   
   // Check if any users found
   if userList.count = 0;
      LogMessage('No expiring passwords found within ' + 
                 %char(warningDays) + ' days' : '*COMP');
      return;
   endif;
   
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
   if not ValidateEmailConfig(emailConfig);
      LogMessage('Invalid email configuration - check settings' : '*DIAG');
      return;
   endif;
   
   // Send email notification
   emailResult = SendEmail(emailConfig : emailBody);
   
   if emailResult.success;
      LogMessage('Email notification sent successfully to ' + 
                 %trim(EMAIL_TO) : '*COMP');
   else;
      LogMessage(emailResult.errorMsg : '*DIAG');
   endif;
   
   // Log completion
   LogMessage('PWDEXPMON completed - ' + %char(userList.count) + 
              ' expiring passwords found' : '*COMP');
   
   return;
end-proc;