# IBM i RPG/RPGLE Coding Standards
## Nick Litten Project - Modern RPG Best Practices

---

## 1. File Header Documentation

### RPGLE/SQLRPGLE Programs
Use triple-slash (///) format for all program-level documentation:

```rpgle
**free
///
/// Program: PROGRAMNAME - Brief Description
/// Description: Comprehensive explanation of what this program does and why
///              it exists. Multiple lines are fine.
///
/// Purpose:
///   - Key concept #1 demonstrated
///   - Key concept #2 demonstrated
///   - Key concept #3 demonstrated
///
/// Features:
///   - Specific capability #1
///   - Specific capability #2
///   - Design pattern used
///   - Best practice implemented
///
/// Usage:
///   CALL PROGRAMNAME PARM('value1' 'value2')
///   // Or provide other usage examples
///
/// Parameters:
///   parm1 - char(10) - Description of parameter 1
///   parm2 - packed(7:2) - Description of parameter 2
///
/// Returns:
///   *NONE or description of return value
///
/// Dependencies:
///   - Service program: SRVPGM1
///   - File: FILENAME
///   - API: APINAME
///
/// Compilation:
///   CRTRPGMOD MODULE(LIB/PROGRAMNAME) SRCFILE(LIB/QRPGLESRC)
///   CRTPGM PGM(LIB/PROGRAMNAME) MODULE(LIB/PROGRAMNAME)
///
/// Author: Nick Litten
///
/// Modification History:
/// v.001 YYYY.MM.DD - Nick Litten - Initial creation
/// v.002 YYYY.MM.DD - Nick Litten - Description of change
///

ctl-opt dftactgrp(*no) actgrp(*new)
        option(*nodebugio:*srcstmt:*nounref)
        copyright('v.002 - Brief Description');
```

### Service Programs (NOMAIN)
```rpgle
**free
///
/// Service Program: SRVPGMNAME - Brief Description
/// Description: Comprehensive explanation of service program purpose
///
/// Exported Procedures:
///   - ProcedureName1() - Brief description
///   - ProcedureName2() - Brief description
///
/// Purpose:
///   - Reusable business logic
///   - Centralized error handling
///   - Common utility functions
///
/// Features:
///   - Thread-safe procedures
///   - Comprehensive error handling
///   - Performance optimized
///
/// Compilation:
///   CRTRPGMOD MODULE(LIB/SRVPGMNAME) SRCFILE(LIB/QRPGLESRC)
///   CRTSRVPGM SRVPGM(LIB/SRVPGMNAME) MODULE(LIB/SRVPGMNAME) +
///             EXPORT(*ALL) BNDDIR(LIB/BNDDIR)
///
/// Author: Nick Litten
///
/// Modification History:
/// v.001 YYYY.MM.DD - Nick Litten - Initial creation
///

ctl-opt nomain
        option(*nodebugio:*srcstmt:*nounref)
        copyright('v.001 - Brief Description');
```

---

## 2. Procedure Documentation

### Exported Procedures
Use separator lines with dashes (-) only:

```rpgle
// ------------------------------------------------------------------------------
// PROCEDURE: ProcedureName
// ------------------------------------------------------------------------------
// Description: Clear, concise description of what the procedure does
//
// Parameters:
//   p_input1  - char(10) const - Description of input parameter
//   p_input2  - int(10) const - Description of input parameter
//   p_output  - char(256) options(*nopass:*omit) - Optional output parameter
//
// Returns:
//   ind - *ON if successful, *OFF if failed
//
// Error Handling:
//   - Returns *OFF on validation failure
//   - Sets p_output with error message if provided
//   - Logs errors to QSYSOPR if critical
//
// Example Usage:
//   dcl-s result ind;
//   dcl-s errMsg char(256);
//   result = ProcedureName('TEST' : 123 : errMsg);
//   if not result;
//      // Handle error using errMsg
//   endif;
//
// Notes:
//   - Thread-safe (no static variables)
//   - Performance: O(n) complexity
//   - Validates all inputs before processing
// ------------------------------------------------------------------------------
dcl-proc ProcedureName export;
   dcl-pi *n ind;
      p_input1 char(10) const;
      p_input2 int(10) const;
      p_output char(256) options(*nopass:*omit);
   end-pi;
   
   // Procedure implementation
   
end-proc;
```

### Internal Procedures
```rpgle
// ------------------------------------------------------------------------------
// PROCEDURE: internalHelper (Internal)
// ------------------------------------------------------------------------------
// Description: Brief description of internal helper procedure
//
// Parameters:
//   p_param - type - Description
//
// Returns:
//   type - Description
// ------------------------------------------------------------------------------
dcl-proc internalHelper;
   dcl-pi *n returnType;
      p_param paramType const;
   end-pi;
   
   // Implementation
   
end-proc;
```

---

## 3. Code Structure Standards

### Constants
```rpgle
// ------------------------------------------------------------------------------
// CONSTANTS
// ------------------------------------------------------------------------------
dcl-c SUCCESS_CODE '00000';
dcl-c ERROR_PREFIX 'ERR';
dcl-c MAX_RETRIES 3;
dcl-c DEFAULT_TIMEOUT 30;
```

### Global Data Structures
```rpgle
// ------------------------------------------------------------------------------
// GLOBAL DATA STRUCTURES
// ------------------------------------------------------------------------------

// Template for API error handling
dcl-ds ApiError_t qualified template;
   bytesProv int(10);
   bytesAvail int(10);
   exceptionId char(7);
   reserved char(1);
   exceptionData char(256);
end-ds;

// Application-specific structure
dcl-ds CustomerInfo_t qualified template;
   customerId packed(9:0);
   customerName char(50);
   customerStatus char(1);
end-ds;
```

### Prototypes
```rpgle
// ------------------------------------------------------------------------------
// PROTOTYPES
// ------------------------------------------------------------------------------

// IBM i API prototypes
dcl-pr QCMDEXC extpgm('QCMDEXC');
   command char(32000) const options(*varsize);
   commandLength packed(15:5) const;
end-pr;

// External program prototypes
dcl-pr ProcessOrder extpgm('PROCESSORD');
   orderId packed(9:0) const;
   status char(1);
end-pr;
```

---

## 4. Naming Conventions

### Variables
- **Parameters**: Prefix with `p_` (e.g., `p_customerId`)
- **Local variables**: Descriptive camelCase (e.g., `customerName`, `isValid`)
- **Global constants**: UPPER_SNAKE_CASE (e.g., `MAX_RECORDS`)
- **Data structures**: PascalCase with `_t` suffix for templates (e.g., `CustomerInfo_t`)

### Procedures
- **Exported**: PascalCase, descriptive (e.g., `GetCustomerInfo`, `ValidateOrder`)
- **Internal**: camelCase, descriptive (e.g., `validateInput`, `formatMessage`)

### Files and Members
- **Programs**: UPPERCASE, max 10 chars (e.g., `CUSTMAINT`)
- **Service programs**: UPPERCASE, descriptive (e.g., `CUSTSRV`, `ORDERSRV`)
- **Modules**: Match program/service program name

---

## 5. Comment Standards

### Inline Comments
```rpgle
// Single-line comment for brief explanations

// Multi-line comment for more detailed
// explanations that span multiple lines
// and provide context

dcl-s counter int(10) inz(0); // Initialize counter
```

### Section Separators
Use dashes (-) only, never equals (=):

```rpgle
// ------------------------------------------------------------------------------
// SECTION NAME
// ------------------------------------------------------------------------------
```

### TODO/FIXME/NOTE Comments
```rpgle
// TODO: Implement error logging
// FIXME: Handle edge case when value is negative
// NOTE: This assumes input is already validated
```

---

## 6. Error Handling Patterns

### Monitor/On-Error
```rpgle
monitor;
   // Code that might fail
   result = riskyOperation();
   
on-error;
   // Handle error
   errorMsg = 'Operation failed';
   return *off;
endmon;
```

### Validation Pattern
```rpgle
// Validate inputs early
if %trim(p_input) = '';
   setErrorMessage(p_errorMsg : 'Input cannot be empty');
   return *off;
endif;

if p_value < 0;
   setErrorMessage(p_errorMsg : 'Value must be positive');
   return *off;
endif;
```

### API Error Checking
```rpgle
// Initialize API error structure
apiError.bytesProv = %size(apiError);
apiError.bytesAvail = 0;

// Call API
CallAPI(parameters : apiError);

// Check for errors
if apiError.bytesAvail > 0;
   // Handle API error
   return *off;
endif;
```

---

## 7. SQL Standards (SQLRPGLE)

### Embedded SQL
```rpgle
// Use clear, formatted SQL
exec sql
   SELECT customer_name, customer_status
     INTO :customerName, :customerStatus
     FROM customers
    WHERE customer_id = :p_customerId;

// Check SQLSTATE immediately
if SQLSTATE <> '00000';
   // Handle SQL error
   return *off;
endif;
```

### SQLSTATE Error Handling
```rpgle
// Use SQLSTATE class checking for efficiency
dcl-s sqlStateClass char(2);

exec sql
   SELECT field INTO :variable FROM table WHERE condition;

sqlStateClass = %subst(SQLSTATE:1:2);

select;
   when sqlStateClass = '00'; // Success
      // Process result
   when sqlStateClass = '01'; // Warning
      // Log warning, continue
   when sqlStateClass = '02'; // No data
      // Handle no data found
   other; // Error
      // Handle error
endsl;
```

---

## 8. Performance Best Practices

### Use Qualified Data Structures
```rpgle
// Good - Qualified
dcl-ds customer qualified;
   id packed(9:0);
   name char(50);
end-ds;

customer.id = 12345;
customer.name = 'John Doe';
```

### Avoid Unnecessary String Operations
```rpgle
// Good - Check before trimming
if p_input <> '';
   processValue(%trim(p_input));
endif;

// Bad - Always trims even if empty
processValue(%trim(p_input));
```

### Use Constants Instead of Literals
```rpgle
// Good
dcl-c MAX_RETRIES 3;
if retryCount > MAX_RETRIES;

// Bad
if retryCount > 3;
```

---

## 9. Testing and Debugging

### Debug-Friendly Code
```rpgle
// Include meaningful variable names
dcl-s recordsProcessed int(10) inz(0);
dcl-s errorCount int(10) inz(0);

// Add debug checkpoints
if debugMode;
   DisplayWindow('Processing record: ' + %char(recordId));
endif;
```

### Assertion Pattern
```rpgle
// Validate assumptions
if p_customerId <= 0;
   // This should never happen
   DisplayWindow('ASSERTION FAILED: Invalid customer ID');
   return *off;
endif;
```

---

## 10. Version Control

### Modification History Format
```rpgle
/// Modification History:
/// v.001 2026.01.15 - Nick Litten - Initial creation
/// v.002 2026.02.20 - Nick Litten - Added error handling
/// v.003 2026.03.10 - Nick Litten - Performance optimization
```

### Copyright Statement
Calculate version from modification count:
```rpgle
// 2 modifications = v.002
ctl-opt copyright('v.002 - Customer Maintenance Program');
```

---

## 11. Code Organization

### File Structure
1. **Header documentation** (///)
2. **Control options** (ctl-opt)
3. **Constants** (dcl-c)
4. **Global data structures** (dcl-ds)
5. **Prototypes** (dcl-pr)
6. **Main procedure** (if program)
7. **Exported procedures** (if service program)
8. **Internal procedures**

### Procedure Structure
1. **Procedure header** (documentation)
2. **Procedure interface** (dcl-pi)
3. **Local prototypes** (if needed)
4. **Local data structures** (if needed)
5. **Local variables** (dcl-s)
6. **Validation logic**
7. **Main processing logic**
8. **Return statement**

---

## 12. Modern RPG Features to Use

### Always Use
- `**free` format
- `dcl-` declarations (dcl-s, dcl-ds, dcl-pi, dcl-pr, dcl-c)
- Qualified data structures
- `const` for read-only parameters
- `options(*nopass:*omit)` for optional parameters
- `monitor/on-error` for exception handling
- Built-in functions (%trim, %subst, %len, etc.)

### Avoid
- Fixed-format RPG
- Factor 1/Factor 2 syntax
- GOTO statements
- TAG/BEGSR subroutines (use procedures instead)
- Global variables (use parameters instead)

---

## Summary Checklist

- [ ] Triple-slash (///) documentation at file level
- [ ] Dash (-) separators only, never equals (=)
- [ ] ctl-opt copyright with version and description
- [ ] Author: Nick Litten
- [ ] Comprehensive modification history
- [ ] Clear procedure documentation
- [ ] Consistent naming conventions
- [ ] Proper error handling
- [ ] Performance considerations
- [ ] Modern RPG syntax only
- [ ] Qualified data structures
- [ ] Constants for magic values
- [ ] Meaningful variable names
- [ ] Example usage in documentation