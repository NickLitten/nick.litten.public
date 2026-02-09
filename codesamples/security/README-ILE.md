# Password Expiration Monitor - ILE Modular Architecture

## Overview

This is the **modular ILE version** of the Password Expiration Monitor, refactored into reusable service programs for better maintainability, testability, and code reuse.

## Architecture

### Modular Design

```
┌─────────────────────────────────────────────────────────────┐
│                    PWDEXPMON (Main Program)                  │
│                                                              │
│  - Orchestrates the monitoring workflow                     │
│  - Handles parameter processing                             │
│  - Coordinates service program calls                        │
└──────────────────┬──────────────────────┬───────────────────┘
                   │                      │
                   ▼                      ▼
    ┌──────────────────────┐  ┌──────────────────────┐
    │   USRPROFSRV         │  │    EMAILSRV          │
    │  (Service Program)   │  │  (Service Program)   │
    │                      │  │                      │
    │ - GetExpiringUsers() │  │ - SendEmail()        │
    │ - FormatUserInfo()   │  │ - BuildReport()      │
    │ - GetSystemName()    │  │ - LogMessage()       │
    │ - ValidateWarningDays│  │ - ValidateConfig()   │
    └──────────────────────┘  └──────────────────────┘
                   │                      │
                   └──────────┬───────────┘
                              ▼
                    ┌──────────────────┐
                    │  PWDMON          │
                    │ (Binding Dir)    │
                    └──────────────────┘
```

## Components

### 1. Service Programs

#### USRPROFSRV - User Profile Service
**File**: [`USRPROFSRV-User_Profile_Service.sqlrpgle`](USRPROFSRV-User_Profile_Service.sqlrpgle:1-213)

Provides reusable procedures for querying user profile information:

- **`GetExpiringUsers(warningDays)`** - Returns list of users with expiring passwords
- **`FormatUserInfo(user)`** - Formats user information for display
- **`GetSystemName()`** - Retrieves current system name
- **`ValidateWarningDays(days)`** - Validates warning period parameter

**Exports**: Defined in [`USRPROFSRV.bnd`](USRPROFSRV.bnd:1-14)

#### EMAILSRV - Email Service
**File**: [`EMAILSRV-Email_Service.sqlrpgle`](EMAILSRV-Email_Service.sqlrpgle:1-213)

Provides reusable procedures for email notifications:

- **`SendEmail(config, body)`** - Sends email via QSYS2.SEND_EMAIL
- **`BuildPasswordExpiryReport()`** - Builds formatted email report
- **`BuildEmailSubject()`** - Creates subject line with user count
- **`LogMessage(message, type)`** - Sends messages to job log
- **`ValidateEmailConfig(config)`** - Validates email configuration
- **`EscapeSqlString(input)`** - SQL injection prevention

**Exports**: Defined in [`EMAILSRV.bnd`](EMAILSRV.bnd:1-16)

### 2. Main Program

**File**: [`PWDEXPMON-Password_Expiration_Monitor_ILE.pgm.sqlrpgle`](PWDEXPMON-Password_Expiration_Monitor_ILE.pgm.sqlrpgle:1-223)

Orchestrates the monitoring workflow by:
1. Validating input parameters
2. Calling `GetExpiringUsers()` to query database
3. Formatting results using `FormatUserInfo()`
4. Building email report via `BuildPasswordExpiryReport()`
5. Sending notification using `SendEmail()`
6. Logging results with `LogMessage()`

### 3. Binding Directory

**File**: [`PWDMON-Password_Monitor_Binding_Directory.bnddir`](../../binders/PWDMON-Password_Monitor_Binding_Directory.bnddir:1-19)

Contains references to both service programs, allowing the main program to bind to them at compile time.

## Benefits of Modular Architecture

### 1. **Reusability**
Service programs can be used by other applications:
```rpgle
// Another program can use the same services
dcl-pr GetExpiringUsers likeds(UserList_t);
   warningDays int(10) const;
end-pr;

userList = GetExpiringUsers(30);  // Reuse in different context
```

### 2. **Maintainability**
- Changes to email logic only require recompiling EMAILSRV
- Changes to user queries only require recompiling USRPROFSRV
- Main program doesn't need recompilation for service changes

### 3. **Testability**
Each service program can be tested independently:
```rpgle
// Test user profile service
testUsers = GetExpiringUsers(7);
assert(testUsers.count > 0);

// Test email service
testConfig.toAddress = 'test@example.com';
assert(ValidateEmailConfig(testConfig) = *on);
```

### 4. **Performance**
- Service programs are loaded once and shared across jobs
- Reduced memory footprint compared to monolithic programs
- Faster activation in high-volume environments

### 5. **Separation of Concerns**
- User profile logic isolated from email logic
- Each component has single, well-defined responsibility
- Easier to understand and modify

## Installation

### Quick Build (Recommended)

```bash
# Build the ILE modular version
make security_ile
```

This will:
1. Compile USRPROFSRV module and create service program
2. Compile EMAILSRV module and create service program
3. Create PWDMON binding directory
4. Compile main program with service program bindings
5. Create command and setup program

### Manual Build Steps

```cl
/* 1. Create User Profile Service Program */
CRTSQLRPGI OBJ(YOURLIB/USRPROFSRV) 
           SRCSTMF('/path/to/USRPROFSRV-User_Profile_Service.sqlrpgle')
           OBJTYPE(*MODULE) 
           COMMIT(*NONE) 
           DBGVIEW(*SOURCE)

CRTSRVPGM SRVPGM(YOURLIB/USRPROFSRV) 
          MODULE(YOURLIB/USRPROFSRV)
          SRCSTMF('/path/to/USRPROFSRV.bnd')
          ACTGRP(*CALLER)

/* 2. Create Email Service Program */
CRTSQLRPGI OBJ(YOURLIB/EMAILSRV)
           SRCSTMF('/path/to/EMAILSRV-Email_Service.sqlrpgle')
           OBJTYPE(*MODULE)
           COMMIT(*NONE)
           DBGVIEW(*SOURCE)

CRTSRVPGM SRVPGM(YOURLIB/EMAILSRV)
          MODULE(YOURLIB/EMAILSRV)
          SRCSTMF('/path/to/EMAILSRV.bnd')
          ACTGRP(*CALLER)

/* 3. Create Binding Directory */
CRTBNDDIR BNDDIR(YOURLIB/PWDMON)

ADDBNDDIRE BNDDIR(YOURLIB/PWDMON) 
           OBJ((YOURLIB/USRPROFSRV *SRVPGM))

ADDBNDDIRE BNDDIR(YOURLIB/PWDMON)
           OBJ((YOURLIB/EMAILSRV *SRVPGM))

/* 4. Create Main Program */
CRTSQLRPGI OBJ(YOURLIB/PWDEXPMON)
           SRCSTMF('/path/to/PWDEXPMON-Password_Expiration_Monitor_ILE.pgm.sqlrpgle')
           COMMIT(*NONE)
           DBGVIEW(*SOURCE)
           BNDDIR(YOURLIB/PWDMON)

/* 5. Create Command */
CRTCMD CMD(YOURLIB/PWDEXPMON)
       PGM(YOURLIB/PWDEXPMON)
       SRCSTMF('/path/to/PWDEXPMON-Password_Expiration_Monitor.cmd')
```

## Usage

Same as the monolithic version:

```cl
/* Check for passwords expiring in next 7 days */
PWDEXPMON DAYS(7)

/* Check for passwords expiring in next 14 days */
PWDEXPMON DAYS(14)
```

## Comparison: Monolithic vs Modular

| Aspect | Monolithic | Modular ILE |
|--------|-----------|-------------|
| **File Count** | 1 SQLRPGLE file | 3 SQLRPGLE files + 2 binder sources |
| **Compile Time** | Faster initial | Slower initial, faster incremental |
| **Reusability** | None | High - services can be shared |
| **Maintainability** | Lower | Higher - isolated changes |
| **Testing** | Difficult | Easy - test each service independently |
| **Memory** | Higher per job | Lower - shared service programs |
| **Complexity** | Lower | Higher - more components |
| **Best For** | Simple, standalone use | Enterprise, multiple consumers |

## Extending the Architecture

### Adding New Services

Create a new service program for additional functionality:

```rpgle
**free
// AUDITSRV - Audit Logging Service
ctl-opt nomain;

dcl-proc LogPasswordChange export;
   dcl-pi *n;
      userName char(10) const;
      changeDate date const;
   end-pi;
   
   // Implementation
end-proc;
```

Add to binding directory:
```cl
ADDBNDDIRE BNDDIR(YOURLIB/PWDMON) 
           OBJ((YOURLIB/AUDITSRV *SRVPGM))
```

### Creating Additional Consumers

Other programs can use the same services:

```rpgle
**free
// PWDRPT - Password Report Program
ctl-opt bnddir('PWDMON');

// Use existing service
dcl-pr GetExpiringUsers likeds(UserList_t);
   warningDays int(10) const;
end-pr;

// Generate report
userList = GetExpiringUsers(30);
// Process results...
```

## Debugging

### Service Program Debugging

```cl
/* Start debug session */
STRDBG PGM(YOURLIB/PWDEXPMON) 
       UPDPROD(*YES)

/* Add service programs to debug */
ADDBKP SRVPGM(YOURLIB/USRPROFSRV) STMT(50)
ADDBKP SRVPGM(YOURLIB/EMAILSRV) STMT(75)
```

### Viewing Service Program Exports

```cl
/* Display service program information */
DSPSRVPGM SRVPGM(YOURLIB/USRPROFSRV)

/* Display binding directory contents */
DSPBNDDIR BNDDIR(YOURLIB/PWDMON)
```

## Performance Considerations

### Service Program Activation

Service programs use `ACTGRP(*CALLER)`, meaning:
- They activate in the caller's activation group
- No additional activation group overhead
- Shared across all callers in same activation group

### Memory Usage

```
Monolithic Program:  ~500KB per job
Modular ILE:        ~200KB per job (service programs shared)
```

### Compile Dependencies

When you change:
- **USRPROFSRV**: Only recompile USRPROFSRV service program
- **EMAILSRV**: Only recompile EMAILSRV service program  
- **Main program**: Only recompile PWDEXPMON program
- **Binder source**: Recompile affected service program only

## Troubleshooting

### Common Issues

**Issue**: Program can't find service program
```
CPF2105: Object USRPROFSRV in library *LIBL type *SRVPGM not found
```
**Solution**: Ensure binding directory is in library list or specify library

**Issue**: Signature mismatch
```
RNX0301: Signature for service program does not match
```
**Solution**: Recompile service program and dependent programs

**Issue**: Export not found
```
RNX0302: Export GetExpiringUsers not found
```
**Solution**: Verify binder source includes the export

## Best Practices

1. **Version Control**: Update signature in binder source when changing exports
2. **Documentation**: Document each exported procedure's parameters and return values
3. **Error Handling**: Service programs should return status, not throw errors
4. **Testing**: Create test programs for each service program
5. **Naming**: Use consistent naming conventions (e.g., *SRV suffix for services)

## Migration Path

To migrate from monolithic to modular:

1. **Phase 1**: Build both versions side-by-side
2. **Phase 2**: Test ILE version thoroughly
3. **Phase 3**: Update job scheduler to use ILE version
4. **Phase 4**: Deprecate monolithic version
5. **Phase 5**: Remove monolithic version after validation period

## Additional Resources

- [IBM i ILE Concepts](https://www.ibm.com/docs/en/i/7.4?topic=concepts-ile)
- [Service Program Best Practices](https://www.ibm.com/docs/en/i/7.4?topic=programs-service)
- [Binding Directories](https://www.ibm.com/docs/en/i/7.4?topic=programs-binding-directory)

## Support

For issues or questions about the modular architecture, refer to the main [`README.md`](README.md) or project documentation.