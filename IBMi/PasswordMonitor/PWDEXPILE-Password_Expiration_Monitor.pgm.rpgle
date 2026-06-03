**free

///
/// Program: PWDEXPILE - Password Expiration Monitor (ILE Modular)
///
/// Description:
///   Monitors IBM i user profiles for upcoming password expirations and sends
///   email notifications to security administrators. This ILE program uses
///   service program procedures for user profile queries and email operations,
///   demonstrating modern modular architecture patterns.
///
/// Purpose:
///   - Proactive password expiration monitoring
///   - Automated security notifications
///   - Modular ILE architecture demonstration
///   - Service program integration example
///
/// Features:
///   - Configurable warning period (days, week, month, year)
///   - SQL-based user profile queries
///   - Email notification via SMTP
///   - Comprehensive logging
///   - Parameter validation
///   - Service program architecture
///   - Error handling and recovery
///
/// Usage:
///   CALL PWDEXPILE PARM('*WEEK')   // Check 7 days ahead
///   CALL PWDEXPILE PARM('*MONTH')  // Check 30 days ahead
///   CALL PWDEXPILE PARM('*YEAR')   // Check 365 days ahead
///   CALL PWDEXPILE PARM('*WEEK' '/tmp/pwdexpmon_report.txt')
///
/// Dependencies:
///   - User Profile Service Program (GetExpiringUsers, FormatUserInfo, etc.)
///   - Email Service Program (SendEmail, BuildPasswordExpiryReport, etc.)
///   - BIGBNDDIR binding directory
///
/// Configuration:
///   Update email constants (lines 112-115):
///   - SMTP_SERVER: Your SMTP server address
///   - EMAIL_FROM: Sender email address
///   - EMAIL_TO: Recipient email address
///   - EMAIL_SUBJECT: Email subject line
///
/// Author: Nick Litten
///
/// Modification History:
///   V.000 2026-02-03 | Nick Litten | Initial creation
///   V.001 2026-02-03 | Nick Litten | Refactored to modular ILE architecture
///   V.002 2026-04-18 | Nick Litten | Applied Nick Litten comment standards
///   V.003 2026-06-02 | Nick Litten | Refreshed header documentation
///

ctl-opt
  main(mainline)
  dftactgrp(*no)
  actgrp(*caller)
  option(*nodebugio:*srcstmt:*nounref)
  bnddir('BIGBNDDIR')
  copyright('V.003 - Password Expiration Monitor - ILE Modular')
  ;

// Prototypes for Service Program Procedures
/include 'prototypes.rpgleinc'

// Data Structures
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
   users likeds(UserProfile_t) dim(999);
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

// Named Constants
Dcl-C DEFAULT_WARNING_DAYS 7;
Dcl-C CRLF x'0D25';

// Email configuration - CUSTOMIZE THESE FOR YOUR ENVIRONMENT
Dcl-C SMTP_SERVER 'smtp.yourcompany.com';
Dcl-C EMAIL_FROM 'ibmi-security@yourcompany.com';
Dcl-C EMAIL_TO 'security-team@yourcompany.com';
Dcl-C EMAIL_SUBJECT 'IBM i Password Expiration Warning';

// -----------------------------------------------------------------------------
// Main Procedure
// -----------------------------------------------------------------------------
Dcl-Proc mainline;
   Dcl-Pi *n;
      parmExpiryPeriod char(6) const;
      parmIfsPath char(256) const options(*nopass);
   end-pi;
   
   Dcl-Ds userList likeds(UserList_t);
   Dcl-Ds emailConfig likeds(EmailConfig_t);
   Dcl-Ds emailResult likeds(EmailResult_t);

   Dcl-S systemName char(256);
   Dcl-S emailBody varchar(32000);
   Dcl-S userLines varchar(32000);
   Dcl-S i int(10);
   Dcl-S numberOfDays int(10);
   Dcl-S ifsOutputPath char(256);
   
   // Set warning days from parameter or use default
   If (%Parms() >= 1);
      If (parmExpiryPeriod = '*WEEK');
         numberOfDays = 7;
      Elseif (parmExpiryPeriod = '*MONTH');
         numberOfDays = 30;
      Elseif (parmExpiryPeriod = '*YEAR');
         numberOfDays = 365;
      Else;
         numberOfDays = 7;
      EndIf;
   Else;
      numberOfDays = DEFAULT_WARNING_DAYS;
   EndIf;
   
   // Validate warning days parameter
   If (not ValidateWarningDays(numberOfDays));
      LogMessage('Invalid warning days: ' + %char(numberOfDays) + 
                 '. Using default: ' + %char(DEFAULT_WARNING_DAYS) : '*DIAG');
      numberOfDays = DEFAULT_WARNING_DAYS;
   EndIf;

   // Resolve optional IFS output path parameter
   ifsOutputPath = '/tmp/pwdexpmon_report.txt';
   If (%Parms() >= 2 and %trim(parmIfsPath) <> '');
      ifsOutputPath = parmIfsPath;
   EndIf;
   
   // Log program start
   LogMessage('PWDEXPMON started - checking for passwords expiring within ' +
              %char(numberOfDays) + ' days' : '*COMP');
   LogMessage('IFS output file path: ' + %trim(ifsOutputPath) : '*COMP');
   
   // Get system name
   systemName = GetSystemName();
   LogMessage('PWDEXPMON running on ' + systemName : '*COMP');

   // Query for expiring user profiles
   userList = GetExpiringUsers(numberOfDays);
   
   // Check if any users found
   If (userList.count = 0);
      LogMessage('No expiring passwords found within ' + 
                 %char(numberOfDays) + ' days' : '*COMP');
      Return;
   Else;
      LogMessage(%char(userList.count) + ' expiring user profiles found within ' + 
                 %char(numberOfDays) + ' days' : '*COMP');
   EndIf;
   
   // Build user lines for email body
   userLines = '';
   for i = 1 to userList.count;
      LogMessage('...Checking ' + %char(FormatUserInfo(userList.users(i))): '*COMP');
      userLines += FormatUserInfo(userList.users(i)) + CRLF;
   endfor;
   
   // write userlines to IFS file
   If (not WriteToIFS(ifsOutputPath : userLines));
      LogMessage('Failed to write report to IFS path: ' + %trim(ifsOutputPath) : '*DIAG');
   Else;
      LogMessage('Report written to IFS path: ' + %trim(ifsOutputPath) : '*COMP');
   EndIf;


   // Build complete email body
   emailBody = BuildPasswordExpiryReport(systemName : 
                                         numberOfDays : 
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

