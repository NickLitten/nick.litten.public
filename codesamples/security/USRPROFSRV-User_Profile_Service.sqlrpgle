**free
//
// Service Program: USRPROFSRV - User Profile Query Service
// Description: Provides reusable procedures for querying user profile information
//              including password expiration data
//
// Exports:
//   - GetExpiringUsers() - Returns list of users with expiring passwords
//   - GetUserCount() - Returns total count of users checked
//   - FormatUserInfo() - Formats user information for display
//
// Modification History:
// v.001 2026.02.03 - Nick Litten - Created modular service program
//

ctl-opt
     nomain
     option(*nodebugio:*srcstmt:*nounref)
     copyright('USRPROFSRV | V.001 | User Profile Service');

// ============================================================================
// Constants
// ============================================================================
dcl-c SQL_SUCCESS 0;
dcl-c SQL_NO_DATA 100;
dcl-c MAX_USERS 9999;

// ============================================================================
// Data Structures - Exported Types
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
   users likeds(UserProfile_t) dim(MAX_USERS);
end-ds;

// ============================================================================
// Procedure: GetExpiringUsers
// Purpose: Query database for users with expiring passwords
// Returns: UserList_t structure with matching users
// ============================================================================
dcl-proc GetExpiringUsers export;
   dcl-pi *n likeds(UserList_t);
      warningDays int(10) const;
   end-pi;
   
   dcl-ds userList likeds(UserList_t);
   dcl-ds currentUser likeds(UserProfile_t);
   dcl-s idx int(10) inz(0);
   
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
   
   if sqlcode <> SQL_SUCCESS;
      return userList;
   endif;
   
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
   dow sqlcode = SQL_SUCCESS and idx < MAX_USERS;
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
   
   return userList;
end-proc;

// ============================================================================
// Procedure: FormatUserInfo
// Purpose: Format user profile information for display/email
// Returns: Formatted string with user details
// ============================================================================
dcl-proc FormatUserInfo export;
   dcl-pi *n varchar(200);
      user likeds(UserProfile_t) const;
   end-pi;
   
   dcl-s line varchar(200);
   dcl-s lastSignOnStr char(19);
   dcl-s expDateStr char(10);
   dcl-s daysStr char(15);
   
   // Format expiration date
   if user.pwdExpDate <> *loval;
      expDateStr = %char(user.pwdExpDate);
   else;
      expDateStr = '*NONE';
   endif;
   
   // Format days until expiry with urgency indicator
   if user.daysUntilExpiry = 0;
      daysStr = '**TODAY**';
   elseif user.daysUntilExpiry = 1;
      daysStr = '1 day';
   else;
      daysStr = %char(user.daysUntilExpiry) + ' days';
   endif;
   
   // Format last sign on
   if user.lastSignOn <> *loval;
      lastSignOnStr = %char(%date(user.lastSignOn));
   else;
      lastSignOnStr = 'Never';
   endif;
   
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
   
   return line;
end-proc;

// ============================================================================
// Procedure: GetSystemName
// Purpose: Retrieve the current system name
// Returns: System name as character string
// ============================================================================
dcl-proc GetSystemName export;
   dcl-pi *n char(8);
   end-pi;
   
   dcl-s systemName char(8);
   
   exec sql
      select system_name into :systemName
      from sysibmadm.env_sys_info;
   
   if sqlcode <> SQL_SUCCESS;
      systemName = '*UNKNOWN';
   endif;
   
   return systemName;
end-proc;

// ============================================================================
// Procedure: ValidateWarningDays
// Purpose: Validate the warning days parameter
// Returns: *on if valid, *off if invalid
// ============================================================================
dcl-proc ValidateWarningDays export;
   dcl-pi *n ind;
      days int(10) const;
   end-pi;
   
   return (days >= 1 and days <= 365);
end-proc;