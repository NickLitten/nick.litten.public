**free

///
/// Service Program: USRPROFSRV - User Profile Query Service
///
/// Description: Production-quality service program providing reusable procedures
///              for querying IBM i user profile information, specifically focused
///              on password expiration data. Uses QSYS2.USER_INFO catalog view
///              for comprehensive user profile analysis.
///
/// Purpose: Production utility demonstrating:
///   - Service program with SQL-based user profile queries
///   - QSYS2.USER_INFO catalog view usage
///   - Cursor-based data retrieval
///   - Formatted output generation
///   - Data structure templates for type safety
///   - System information retrieval
///
/// Features:
///   - Query users with expiring passwords
///   - Format user information for display/email
///   - Retrieve system name
///   - Validate warning days parameter
///   - Support for up to 9999 users
///   - Sorted results by urgency
///
/// Exported Procedures:
///   - GetExpiringUsers: Returns list of users with expiring passwords
///   - FormatUserInfo: Formats user information for display
///   - GetSystemName: Retrieves current system name
///   - ValidateWarningDays: Validates warning days parameter
///
/// Data Structures:
///   - UserProfile_t: User profile information template
///   - UserList_t: Collection of user profiles
///
/// Usage Example:
///   dcl-ds userList likeds(UserList_t);
///   dcl-s warningDays int(10) inz(7);
///   userList = GetExpiringUsers(warningDays);
///   // Process userList.users(1) through userList.users(userList.count)
///
/// Binding:
///   Create with binder source USRPROFSRV.bnd
///   Used by PWDEXPILE password monitoring program
///
/// Reference:
/// https://www.nicklitten.com/blog/ibmi-user-profile-queries/
///
/// Modification History:
///   V.000 2026-02-03 | Nick Litten | Initial creation - modular service program
///   V.001 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

ctl-opt
  nomain
  thread(*serialize)
  option(*nodebugio:*srcstmt:*nounref)
  copyright('USRPROFSRV | V.001 | User Profile Query Service')
  ;

// ------------------------------------------------------------------------------
// Named Constants
// ------------------------------------------------------------------------------
Dcl-C SQL_SUCCESS 0;
Dcl-C SQL_NO_DATA 100;
Dcl-C MAX_USERS 9999;

// ------------------------------------------------------------------------------
// Data Structures - Exported Types
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
   users likeds(UserProfile_t) dim(MAX_USERS);
end-ds;

// ------------------------------------------------------------------------------
// Procedure: GetExpiringUsers
// Description: Query database for users with expiring passwords
// Parameters:
//   - warningDays: int(10) - Number of days to look ahead
// Returns: UserList_t structure with matching users
// ------------------------------------------------------------------------------
Dcl-Proc GetExpiringUsers export;
   Dcl-Pi *n likeds(UserList_t);
      warningDays int(10) const;
   end-pi;
   
   Dcl-Ds userList likeds(UserList_t);
   Dcl-Ds currentUser likeds(UserProfile_t);
   Dcl-S idx int(10) inz(0);
   
   // Initialize return structure
   userList.count = 0;
   
   // Declare cursor for user profiles
   exec sql declare userCursor cursor for
      select
         authorization_name,
         coalesce(text_description, ' '),
         status,
         password_expiration_date,
         password_expiration_interval,
         days_until_password_expires,
         last_used_timestamp,
         previous_signon
      from qsys2.user_info
      where status in ('*ENABLED', '*DISABLED')
        and password_expiration_date is not null
        and days_until_password_expires is not null
        and days_until_password_expires between 0 and :warningDays
      order by days_until_password_expires, authorization_name;
   
   // Open cursor
   exec sql open userCursor;
   
   If (sqlcode <> SQL_SUCCESS);
      Return userList;
   EndIf;
   
   // Fetch first record
   exec sql fetch next from userCursor into
      :currentUser.userName,
      :currentUser.userText,
      :currentUser.status,
      :currentUser.pwdExpDate,
      :currentUser.pwdExpInterval,
      :currentUser.daysUntilExpiry,
      :currentUser.lastSignOn,
      :currentUser.prevSignOn;
   
   // Loop through results
   dow (sqlcode = SQL_SUCCESS and idx < MAX_USERS);
      idx += 1;
      userList.users(idx) = currentUser;
      userList.count = idx;
      
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
   enddo;
   
   // Close cursor
   exec sql close userCursor;
   
   Return userList;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: FormatUserInfo
// Description: Format user profile information for display/email
// Parameters:
//   - user: UserProfile_t - User profile to format
// Returns: Formatted string with user details
// ------------------------------------------------------------------------------
Dcl-Proc FormatUserInfo export;
   Dcl-Pi *n varchar(200);
      user likeds(UserProfile_t) const;
   end-pi;
   
   Dcl-S line varchar(200);
   Dcl-S lastSignOnStr char(19);
   Dcl-S expDateStr char(10);
   Dcl-S daysStr char(15);
   
   // Format expiration date
   If (user.pwdExpDate <> *loval);
      expDateStr = %char(user.pwdExpDate);
   Else;
      expDateStr = '*NONE';
   EndIf;
   
   // Format days until expiry with urgency indicator
   If (user.daysUntilExpiry = 0);
      daysStr = '**TODAY**';
   elseif (user.daysUntilExpiry = 1);
      daysStr = '1 day';
   Else;
      daysStr = %char(user.daysUntilExpiry) + ' days';
   EndIf;
   
   // Format last sign on
   If (user.lastSignOn <> *loval);
      lastSignOnStr = %char(%date(user.lastSignOn));
   Else;
      lastSignOnStr = 'Never';
   EndIf;
   
   // Build formatted line with proper spacing
   line = %trim(user.userName) + 
          %subst(' ' : 1 : 11 - %len(%trim(user.userName))) +
          %subst(%trim(user.userText) + %trim(' ') : 1 : 30) + ' ' +
          %trim(user.status) + 
          %subst(' ' : 1 : 11 - %len(%trim(user.status))) +
          expDateStr + ' ' +
          daysStr + 
          %subst(' ' : 1 : 11 - %len(%trim(daysStr))) +
          lastSignOnStr;
   
   Return line;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: GetSystemName
// Description: Retrieve the current IBM i system name
// Returns: System name as character string
// ------------------------------------------------------------------------------
Dcl-Proc GetSystemName export;
   Dcl-Pi *n char(8);
   end-pi;
   
   Dcl-S systemName char(8);
   
   exec sql
      select system_name into :systemName
      from sysibmadm.env_sys_info;
   
   If (sqlcode <> SQL_SUCCESS);
      systemName = '*UNKNOWN';
   EndIf;
   
   Return systemName;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: ValidateWarningDays
// Description: Validate the warning days parameter
// Parameters:
//   - days: int(10) - Number of days to validate
// Returns: *on if valid (1-365), *off if invalid
// ------------------------------------------------------------------------------
Dcl-Proc ValidateWarningDays export;
   Dcl-Pi *n ind;
      days int(10) const;
   end-pi;
   
   Return (days >= 1 and days <= 365);
end-proc;
