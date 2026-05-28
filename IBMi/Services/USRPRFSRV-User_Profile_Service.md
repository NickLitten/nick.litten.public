# USRPRFSRV - User Profile Service Program Lesson

## Overview

[`USRPRFSRV-User_Profile_Service.sqlrpgle`](USRPRFSRV-User_Profile_Service.sqlrpgle) is a production-ready service program that demonstrates modern IBM i development practices for querying user profile information. This lesson breaks down the key concepts and architectural patterns used in this service program.

## What is a Service Program?

A **service program** (SRVPGM) is IBM i's equivalent to a shared library or DLL. It contains reusable procedures that can be called by multiple programs without duplicating code. Key characteristics:

- Created with `ctl-opt nomain` - no main procedure, only exported procedures
- Bound to programs at compile time using a binding directory
- Promotes code reuse and maintainability
- Can be updated without recompiling calling programs (with proper signature management)

## Program Structure

### 1. Control Options (Lines 54-59)

```rpgle
ctl-opt
  nomain
  thread(*serialize)
  option(*nodebugio:*srcstmt:*nounref)
  copyright('USRPRFSRV | V.001 | User Profile Query Service')
  ;
```

**Key Concepts:**
- **`nomain`**: Indicates this is a service program with no main entry point
- **`thread(*serialize)`**: Ensures thread-safe execution by serializing access
- **`*nodebugio`**: Disables debug I/O for better performance
- **`*srcstmt`**: Includes source statement numbers in compiled object for debugging
- **`*nounref`**: Warns about unreferenced variables
- **`copyright()`**: Embeds version and description in the compiled object

### 2. Named Constants (Lines 64-66)

```rpgle
Dcl-C SQL_SUCCESS 0;
Dcl-C SQL_NO_DATA 100;
Dcl-C MAX_USERS 9999;
```

**Concept:** Named constants improve code readability and maintainability. Instead of magic numbers like `0` or `100`, we use descriptive names that explain their purpose.

### 3. Template Data Structures (Lines 73-88)

```rpgle
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

Dcl-Ds UserList_t qualified template;
   count int(10);
   users likeds(UserProfile_t) dim(MAX_USERS);
end-ds;
```

**Key Concepts:**

- **`template`**: Creates a reusable data structure definition (not an actual variable)
- **`qualified`**: Requires field names to be prefixed with the DS name (e.g., `user.userName`)
- **`likeds()`**: Creates a data structure based on a template
- **`dim()`**: Creates an array of data structures

**Why This Matters:** Templates provide type safety and consistency. Any procedure using `UserProfile_t` will have the exact same structure, preventing field mismatch errors.

### 4. Exported Procedures

The service program exports four procedures, each demonstrating different SQL and RPG concepts:

#### A. GetExpiringUsers (Lines 97-167)

**Purpose:** Query users with expiring passwords using SQL cursor

**Key Concepts Demonstrated:**

1. **SQL Cursor Declaration (Lines 110-125)**
```rpgle
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
```

**Cursor Concepts:**
- **Cursor**: A pointer to a result set that allows row-by-row processing
- **`:warningDays`**: Host variable (RPG variable used in SQL)
- **`coalesce()`**: SQL function that returns first non-null value
- **`qsys2.user_info`**: IBM i system catalog view containing user profile data

2. **Cursor Processing Pattern (Lines 128-164)**
```rpgle
exec sql open userCursor;

If (sqlcode <> SQL_SUCCESS);
   Return userList;
EndIf;

exec sql fetch next from userCursor into
   :currentUser.userName,
   :currentUser.userText,
   ...;

dow (sqlcode = SQL_SUCCESS and idx < MAX_USERS);
   idx += 1;
   userList.users(idx) = currentUser;
   userList.count = idx;
   
   exec sql fetch next from userCursor into ...;
enddo;

exec sql close userCursor;
```

**Pattern Breakdown:**
1. **Open** the cursor to execute the query
2. **Check** `sqlcode` for errors
3. **Fetch** first record
4. **Loop** while successful and under limit
5. **Store** each record in array
6. **Fetch** next record
7. **Close** cursor to free resources

**Why Use Cursors?** When you need to process a large result set row-by-row, cursors are more memory-efficient than loading all rows at once.

#### B. FormatUserInfo (Lines 176-221)

**Purpose:** Format user data for display with proper spacing and urgency indicators

**Key Concepts:**

1. **Date/Timestamp Handling (Lines 187-207)**
```rpgle
If (user.pwdExpDate <> *loval);
   expDateStr = %char(user.pwdExpDate);
Else;
   expDateStr = '*NONE';
EndIf;
```

**Concepts:**
- **`*loval`**: Lowest possible value for a data type (used to detect uninitialized dates)
- **`%char()`**: Built-in function to convert date to character string
- **Defensive coding**: Always check for null/invalid dates before formatting

2. **Conditional Formatting (Lines 194-200)**
```rpgle
If (user.daysUntilExpiry = 0);
   daysStr = '**TODAY**';
elseif (user.daysUntilExpiry = 1);
   daysStr = '1 day';
Else;
   daysStr = %char(user.daysUntilExpiry) + ' days';
EndIf;
```

**Concept:** Business logic in formatting - highlighting urgent cases with special indicators.

3. **String Building with Spacing (Lines 210-218)**
```rpgle
line = %trim(user.userName) + 
       %subst(' ' : 1 : 11 - %len(%trim(user.userName))) +
       %subst(%trim(user.userText) + %trim(' ') : 1 : 30) + ' ' +
       ...;
```

**Concepts:**
- **`%trim()`**: Remove leading/trailing spaces
- **`%subst()`**: Extract substring
- **`%len()`**: Get length of string
- **Dynamic spacing**: Calculate spaces needed for column alignment

#### C. GetSystemName (Lines 228-243)

**Purpose:** Retrieve system name using SQL

**Key Concepts:**

```rpgle
exec sql
   select system_name into :systemName
   from sysibmadm.env_sys_info;

If (sqlcode <> SQL_SUCCESS);
   systemName = '*UNKNOWN';
EndIf;
```

**Concepts:**
- **`sysibmadm.env_sys_info`**: IBM i system catalog view for environment information
- **`into :variable`**: Store single-row result directly into RPG variable
- **Error handling**: Always provide fallback value for failed queries

#### D. ValidateWarningDays (Lines 252-258)

**Purpose:** Validate input parameter

**Key Concepts:**

```rpgle
Dcl-Proc ValidateWarningDays export;
   Dcl-Pi *n ind;
      days int(10) const;
   end-pi;
   
   Return (days >= 1 and days <= 365);
end-proc;
```

**Concepts:**
- **`ind`**: Indicator (boolean) return type
- **`const`**: Parameter is read-only (cannot be modified)
- **Single-line validation**: Return boolean expression directly
- **Business rules**: Enforce valid range (1-365 days)

## SQL Integration Patterns

### 1. Embedded SQL Syntax

```rpgle
exec sql
   SQL statement here;
```

**Key Points:**
- SQL statements embedded directly in RPG code
- Compiled into the program object
- Access to all IBM i SQL features
- Automatic host variable binding

### 2. Host Variables

Variables prefixed with `:` in SQL statements:
```rpgle
:warningDays    // Input parameter
:systemName     // Output variable
:currentUser.userName  // Data structure field
```

### 3. SQLCODE Checking

Always check `sqlcode` after SQL operations:
- `0` = Success
- `100` = No data found
- Negative = Error occurred

## Data Structure Design Patterns

### 1. Template Pattern

```rpgle
Dcl-Ds UserProfile_t qualified template;
   // Field definitions
end-ds;

// Later, create instances:
Dcl-Ds user1 likeds(UserProfile_t);
Dcl-Ds user2 likeds(UserProfile_t);
```

**Benefits:**
- Consistent structure across all instances
- Single point of maintenance
- Type safety
- Self-documenting code

### 2. Collection Pattern

```rpgle
Dcl-Ds UserList_t qualified template;
   count int(10);
   users likeds(UserProfile_t) dim(MAX_USERS);
end-ds;
```

**Pattern:** Combine a counter with an array for safe collection management.

## Procedure Interface Patterns

### 1. Export Declaration

```rpgle
Dcl-Proc GetExpiringUsers export;
   Dcl-Pi *n likeds(UserList_t);
      warningDays int(10) const;
   end-pi;
```

**Components:**
- **`export`**: Makes procedure available to other programs
- **`Dcl-Pi *n`**: Procedure interface with `*n` (same name as procedure)
- **Return type**: `likeds(UserList_t)` - returns a data structure
- **Parameters**: `const` prevents modification

### 2. Parameter Passing

```rpgle
warningDays int(10) const;
```

**Concepts:**
- **`const`**: Pass by value (read-only)
- Without `const`: Pass by reference (can be modified)
- **Type specification**: `int(10)` = 10-digit integer

## Best Practices Demonstrated

### 1. Error Handling
- Always check `sqlcode` after SQL operations
- Provide meaningful defaults for error conditions
- Return empty/safe values rather than crashing

### 2. Resource Management
- Open cursors only when needed
- Always close cursors after use
- Limit result sets with `MAX_USERS` constant

### 3. Code Organization
- Group related constants together
- Define data structures before procedures
- Use descriptive procedure and variable names
- Include comprehensive comments

### 4. Type Safety
- Use templates for consistent data structures
- Specify exact data types (not generic)
- Use `qualified` to prevent field name conflicts

### 5. Performance
- Use cursors for large result sets
- Order results in SQL (not in RPG)
- Filter data in SQL WHERE clause
- Use `const` parameters to enable compiler optimizations

## Binding and Usage

### Creating the Service Program

1. **Compile the module:**
```
CRTSQLRPGI OBJ(USRPRFSRV) SRCSTMF('USRPRFSRV-User_Profile_Service.sqlrpgle')
```

2. **Create service program with binder source:**
```
CRTSRVPGM SRVPGM(USRPRFSRV) MODULE(USRPRFSRV) SRCSTMF('USRPRFSRV.bnd')
```

### Using in Another Program

```rpgle
**free

// Reference the template
/copy USRPRFSRV,USRPRFSRV_H

// Declare variables
dcl-ds userList likeds(UserList_t);
dcl-s warningDays int(10) inz(7);
dcl-s idx int(10);

// Call the service
userList = GetExpiringUsers(warningDays);

// Process results
for idx = 1 to userList.count;
   dsply FormatUserInfo(userList.users(idx));
endfor;
```

## Key Takeaways

1. **Service programs** promote code reuse and maintainability
2. **SQL cursors** enable efficient processing of large result sets
3. **Template data structures** ensure type safety and consistency
4. **Embedded SQL** provides seamless integration with IBM i database
5. **Error handling** is critical for production code
6. **Qualified data structures** prevent naming conflicts
7. **Const parameters** improve performance and prevent accidental modification
8. **System catalog views** (`qsys2.*`, `sysibmadm.*`) provide rich system information

## Related Examples

- [`PWDEXPILE-Password_Expiration_Monitor.pgm.sqlrpgle`](../PasswordMonitor/PWDEXPILE-Password_Expiration_Monitor.pgm.sqlrpgle) - Program that uses this service
- [`EMAILSRV-Email_Service.sqlrpgle`](EMAILSRV-Email_Service.sqlrpgle) - Another service program example
- [`NICKSRV-Service_Program_for_Lessons.sqlrpgle`](NICKSRV-Service_Program_for_Lessons.sqlrpgle) - Additional service program patterns

## Further Reading

- IBM i SQL Reference: https://www.ibm.com/docs/en/i/7.5?topic=reference-sql
- ILE Concepts: https://www.ibm.com/docs/en/i/7.5?topic=concepts-ile
- QSYS2 Services: https://www.ibm.com/docs/en/i/7.5?topic=services-db2-i
- Nick Litten's Blog: https://www.nicklitten.com/blog/ibmi-user-profile-queries/