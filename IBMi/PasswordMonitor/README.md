# Password Expiration Monitor Solution

## Overview

The Password Expiration Monitor is a production-quality IBM i solution that automatically monitors user profiles for expiring passwords and sends email notifications to security administrators. The solution demonstrates modern ILE architecture with modular service programs and proper separation of concerns.

## Architecture

### Component Overview

```
PWDEXPMON (Command)
    ↓
PWDEXPMON (CL Wrapper)
    ↓
PWDEXPILE (SQLRPGLE Main Program)
    ↓
    ├─→ USRPROFSRV (Service Program) - User profile queries
    └─→ EMAILSRV (Service Program) - Email notifications
```

### Files in This Solution

| File | Type | Purpose |
|------|------|---------|
| `PWDEXPMON-Password_Expiration_Monitor.cmd` | CMD | Command interface with parameter validation |
| `PWDEXPMON-Password_Expiration_Monitor.pgm.clle` | CLLE | CL wrapper program for error handling |
| `PWDEXPILE-Password_Expiration_Monitor.pgm.sqlrpgle` | SQLRPGLE | Main monitoring logic using service programs |
| `SCHEDULE-Setup_Password_Monitor_Schedule.pgm.clle` | CLLE | Job scheduler setup utility |

### Service Program Dependencies

The solution requires two service programs (located in `../Services/`):

1. **USRPROFSRV** - User Profile Service
   - `GetExpiringUsers()` - Query users with expiring passwords
   - `FormatUserInfo()` - Format user information for reports
   - `GetSystemName()` - Retrieve system name
   - `ValidateWarningDays()` - Validate day parameter

2. **EMAILSRV** - Email Service
   - `SendEmail()` - Send formatted email notifications
   - `BuildPasswordExpiryReport()` - Generate email body
   - `BuildEmailSubject()` - Create dynamic subject line
   - `ValidateEmailConfig()` - Validate email settings
   - `LogMessage()` - Write to job log

## Installation

### Prerequisites

1. **Service Programs**: Compile USRPROFSRV and EMAILSRV first
2. **Binding Directory**: Create BIGBNDDIR with service program entries
3. **SMTP Configuration**: Configure system SMTP settings
   ```
   CHGSMTPA RLYHOST('smtp.yourcompany.com')
   ADDUSRSMTP USRPRF(QSECOFR) USRID('security@yourcompany.com')
   ```

### Build Steps

```bash
# 1. Compile service programs (if not already done)
cd ../Services
make USRPROFSRV.srvpgm
make EMAILSRV.srvpgm

# 2. Create binding directory
CRTBNDDIR BNDDIR(library/BIGBNDDIR)
ADDBNDDIRE BNDDIR(library/BIGBNDDIR) OBJ((library/USRPROFSRV *SRVPGM))
ADDBNDDIRE BNDDIR(library/BIGBNDDIR) OBJ((library/EMAILSRV *SRVPGM))

# 3. Compile password monitor programs
cd ../PasswordMonitor
make all

# 4. Create command
CRTCMD CMD(library/PWDEXPMON) PGM(library/PWDEXPMON) +
       SRCFILE(library/QCMDSRC) SRCMBR(PWDEXPMON)
```

### Configuration

Edit `PWDEXPILE-Password_Expiration_Monitor.pgm.sqlrpgle` and update these constants:

```rpgle
Dcl-C SMTP_SERVER 'smtp.yourcompany.com';
Dcl-C EMAIL_FROM 'ibmi-security@yourcompany.com';
Dcl-C EMAIL_TO 'security-team@yourcompany.com';
Dcl-C EMAIL_SUBJECT 'IBM i Password Expiration Warning';
```

## Usage

### Manual Execution

```
PWDEXPMON DAYS(7)    // Check for passwords expiring in 7 days
PWDEXPMON DAYS(14)   // Check for passwords expiring in 14 days
PWDEXPMON            // Uses default (7 days)
```

### Automated Scheduling

Run the SCHEDULE program to set up automatic daily monitoring:

```
CALL SCHEDULE
```

This creates two job schedule entries:
- **PWDEXPMON**: Runs daily at 8:00 AM (7-day warning)
- **PWDEXP14**: Runs daily at 8:05 AM (14-day warning)

Manage schedules with:
```
WRKJOBSCDE           // View all schedules
RMVJOBSCDE JOB(PWDEXPMON)  // Remove a schedule
```

## Email Notification Format

The email notification includes:

- System name and timestamp
- Warning period (days)
- Count of expiring passwords
- Detailed list of affected users:
  - User profile name
  - User description
  - Days until expiration
  - Expiration date
  - Last sign-on timestamp

## Error Handling

The solution includes comprehensive error handling:

1. **Parameter Validation**: Days parameter must be 1-999
2. **Email Configuration**: Validates SMTP settings before sending
3. **SQL Error Checking**: All SQL operations check SQLSTATE
4. **Job Log Integration**: All operations logged with appropriate severity
5. **Graceful Degradation**: Continues processing even if email fails

## Monitoring and Troubleshooting

### Check Job Logs

```
DSPJOBLOG JOB(PWDEXPMON)
```

Look for messages:
- `PWDEXPMON started` - Program execution began
- `No expiring passwords found` - No action needed
- `Email notification sent successfully` - Email sent
- Error messages with diagnostic information

### Verify Schedules

```
WRKJOBSCDE
```

Ensure schedules are active and have correct parameters.

### Test Email Configuration

Run manually first to verify email settings work:
```
PWDEXPMON DAYS(999)  // Large number to catch all users
```

## Best Practices

1. **Warning Periods**: Use multiple warning periods (7, 14, 30 days)
2. **Schedule Timing**: Run during off-peak hours
3. **Email Recipients**: Send to security team distribution list
4. **Regular Testing**: Test monthly to ensure email delivery works
5. **Log Review**: Periodically review job logs for errors

## Security Considerations

- Program runs with caller's authority
- Requires `*ALLOBJ` or equivalent to query all user profiles
- Email contains sensitive user information - secure recipient list
- Consider encrypting email if sent externally

## Performance

- Typical execution time: < 5 seconds for 1000 users
- SQL queries use system catalog views (efficient)
- Minimal system impact when run during off-peak hours

## Customization

### Modify Warning Periods

Edit the SCHEDULE program to change times or add more schedules:

```clle
ADDJOBSCDE JOB(PWDEXP30) +
           CMD(CALL PGM(library/PWDEXPMON) PARM(30)) +
           SCDTIME('080000')
```

### Change Email Format

Modify `BuildPasswordExpiryReport()` in EMAILSRV service program.

### Add Additional Checks

Extend USRPROFSRV to include:
- Disabled user profiles
- Profiles with *NONE password
- Profiles not signed on in X days

## Related Documentation

- [IBM i Security Reference](https://www.ibm.com/docs/en/i/)
- [Password Policy Management](https://www.ibm.com/docs/en/i/7.5?topic=security-password-policy)
- [Nick Litten's Blog](https://www.nicklitten.com/blog/password-expiration-monitoring/)

## Support

For issues or questions:
- Review job logs for error messages
- Check SMTP configuration with `WRKSYSSTS`
- Verify service programs are in library list
- Ensure binding directory is correctly configured

## Version History

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| V.000 | 2026-02-03 | Nick Litten | Initial creation |
| V.001 | 2026-02-03 | Nick Litten | Refactored to modular ILE |
| V.002 | 2026-04-18 | Nick Litten | Applied coding standards |
| V.003 | 2026-05-28 | Nick Litten | Enhanced documentation |

## License

Copyright © 2026 Nick Litten. All rights reserved.