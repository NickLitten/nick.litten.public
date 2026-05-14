# IBM i Coding Standards Guide

Complete guide to coding standards for modern IBM i development.

## Table of Contents

- [General Standards](#general-standards)
- [RPG/RPGLE Standards](#rpgrpgle-standards)
- [SQLRPGLE Standards](#sqlrpgle-standards)
- [CL/CLLE Standards](#clclle-standards)
- [SQL Standards](#sql-standards)
- [DDS Standards](#dds-standards)
- [COBOL Standards](#cobol-standards)
- [Comment Standards](#comment-standards)

## General Standards

### File Encoding
- **Encoding:** UTF-8
- **Line Endings:** LF (Unix style)
- **Final Newline:** Required
- **Trailing Whitespace:** Remove

### Formatting
- **Indent Style:** Spaces (not tabs)
- **Indent Size:** 2 spaces
- **Max Line Length:** 100 characters

### Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Programs | UPPER_SNAKE_CASE | MY_PROGRAM |
| Procedures | PascalCase | MyProcedure |
| Variables | camelCase | myVariable |
| Constants | UPPER_SNAKE_CASE | MY_CONSTANT |
| Files | UPPER_SNAKE_CASE | MY_FILE |
| Fields | PascalCase | MyField |

## RPG/RPGLE Standards

### Control Options

**Required:**
```rpgle
ctl-opt dftactgrp(*no) actgrp(*caller)
        option(*nodebugio:*srcstmt)
        bnddir('QC2LE');
```

**Recommended:**
```rpgle
ctl-opt main(MainProcedure)
        alwnull(*usrctl)
        datfmt(*iso)
        timfmt(*iso)
        decedit('0,');
```

### Structure

1. Header comment block
2. Control options (`ctl-opt`)
3. File declarations (`dcl-f`)
4. Program interface (`dcl-pi`)
5. Procedure prototypes (`dcl-pr`)
6. Standalone variables (`dcl-s`)
7. Constants (`dcl-c`)
8. Data structures (`dcl-ds`)
9. Main logic
10. Procedures (`dcl-proc`)

### Best Practices

✅ **DO:**
- Use fully free-format RPG
- Use `dcl-proc` for all procedures
- Use qualified data structures
- Use `const` for read-only parameters
- Use descriptive variable names
- Initialize all variables
- Use modern built-in functions (BIFs)

❌ **DON'T:**
- Use fixed-format code
- Use GOTO statements
- Use global variables
- Hard-code library names
- Use magic numbers
- Reference QGPL library

### Data Types

**Preferred:**
- `varchar` - Variable-length character
- `int` - Integer
- `uns` - Unsigned integer
- `packed` - Packed decimal
- `date` - Date
- `time` - Time
- `timestamp` - Timestamp
- `ind` - Indicator

**Avoid:**
- `char` - Use `varchar` instead
- `numeric` - Use `int` or `packed` instead

### Example

```rpgle
**free

ctl-opt dftactgrp(*no) actgrp(*caller)
        option(*nodebugio:*srcstmt)
        main(MainProcedure);

dcl-proc MainProcedure;
  dcl-pi *n;
    customerId int(10) const;
    customerName varchar(50);
  end-pi;

  dcl-s isValid ind;

  isValid = ValidateCustomer(customerId);

  if isValid;
    customerName = GetCustomerName(customerId);
  endif;

  return;
end-proc;
```

## SQLRPGLE Standards

### SQL Options

```rpgle
exec sql set option
  commit = *none,
  naming = *sql,
  closqlcsr = *endmod,
  datfmt = *iso,
  timfmt = *iso;
```

### Best Practices

✅ **DO:**
- Use embedded SQL for database operations
- Use prepared statements for dynamic SQL
- Use parameter markers to prevent SQL injection
- Check SQLCODE after each operation
- Use descriptive cursor names
- Close cursors when done
- Use proper error handling

❌ **DON'T:**
- Use SELECT *
- Forget to check SQLCODE
- Leave cursors open
- Use string concatenation for SQL

### Error Checking

```rpgle
dcl-proc CheckSqlError;
  dcl-pi *n ind end-pi;

  dcl-s hasError ind;

  exec sql get diagnostics
    :gSqlCode = db2_returned_sqlcode,
    :gSqlState = returned_sqlstate;

  hasError = (gSqlCode < 0);

  return hasError;
end-proc;
```

## CL/CLLE Standards

### Structure

1. Header comment block
2. PGM declaration with parameters
3. Variable declarations (DCL)
4. Constants
5. Global error monitoring (MONMSG)
6. Main logic
7. Error handler
8. ENDPGM

### Best Practices

✅ **DO:**
- Use CLLE (ILE CL) instead of CLP
- Use MONMSG for error handling
- Use descriptive variable names
- Use &VAR for all variables
- Document all parameters
- Use SNDPGMMSG for messages

❌ **DON'T:**
- Hard-code library names
- Reference QGPL
- Leave commands unmonitored
- Skip error handling

### Example

```cl
PGM PARM(&PARM1)

DCL VAR(&PARM1) TYPE(*CHAR) LEN(10)
DCL VAR(&MSG_TEXT) TYPE(*CHAR) LEN(512)

MONMSG MSGID(CPF0000) EXEC(GOTO CMDLBL(ERROR_HANDLER))

/* Main logic here */

GOTO CMDLBL(END_PGM)

ERROR_HANDLER:
  RCVMSG MSGTYPE(*EXCP) MSG(&MSG_TEXT)
  SNDPGMMSG MSG(&MSG_TEXT) TOPGMQ(*PRV) MSGTYPE(*ESCAPE)

END_PGM:
  ENDPGM
```

## SQL Standards

### DDL Standards

✅ **DO:**
- Use CREATE OR REPLACE
- Define primary keys
- Define foreign keys
- Add column comments
- Use CHECK constraints
- Use DEFAULT values
- Use proper data types
- Use schema qualification

❌ **DON'T:**
- Use SELECT *
- Use unqualified table names
- Hard-code values in WHERE
- Skip WHERE clause on UPDATE/DELETE

### Example

```sql
CREATE OR REPLACE TABLE myschema.customers (
  customer_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
  customer_name VARCHAR(50) NOT NULL,
  email VARCHAR(100),
  status CHAR(1) NOT NULL DEFAULT 'A'
    CHECK (status IN ('A', 'I', 'D')),
  created_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT customers_pk PRIMARY KEY (customer_id),
  CONSTRAINT customers_uk1 UNIQUE (email)
);

LABEL ON TABLE myschema.customers IS 'Customer master file';
```

## DDS Standards

> **Note:** DDS is legacy technology. Use SQL DDL for new development.

### Physical File

```dds
A          R MYRECORD           TEXT('Record format')
A            MYKEY              TEXT('Key field')
A            MYFIELD   50A      TEXT('Data field')
A          K MYKEY
```

### Best Practices

✅ **DO:**
- Use meaningful field names
- Use TEXT for descriptions
- Use COLHDG for column headings
- Use proper key fields

## COBOL Standards

### Structure

1. IDENTIFICATION DIVISION
2. ENVIRONMENT DIVISION
3. DATA DIVISION
4. PROCEDURE DIVISION

### Best Practices

✅ **DO:**
- Use ILE COBOL (CBLLE)
- Use COPY for common code
- Use 88-level conditions
- Use EVALUATE instead of nested IF
- Use proper indentation

### Naming

- Data names: KEBAB-CASE (MY-DATA-NAME)
- Paragraph names: KEBAB-CASE (MY-PARAGRAPH)

## Comment Standards

### Header Block

**Required for all source files (Triple-Slash Documentation Style):**

```rpgle
///
/// Program: MYPROGRAM - Brief program title
///
/// Description: Detailed description of what the program does, its purpose,
/// and how it fits into the larger system. Use multiple lines
/// for clarity and readability.
///
/// Purpose: Educational/Production example demonstrating:
/// - Key concept or feature 1
/// - Key concept or feature 2
/// - Key concept or feature 3
///
/// Features:
/// - Feature 1 with brief explanation
/// - Feature 2 with brief explanation
/// - Feature 3 with brief explanation
///
/// Usage: CALL MYPROGRAM PARM('value')
///
/// Parameters: (if applicable)
/// - param1: CHAR(10) - Description of parameter
/// - param2: INT(10) - Description of parameter
///
/// Dependencies:
/// - File/table/service program dependencies
/// - External resources required
///
/// Control Options:
/// - dftactgrp(*no): Required for ILE procedures
/// - actgrp(*caller): Runs in caller's activation group
///
/// Modification History:
/// 1.0.0 2026-05-12 | username | Initial creation
///
```

**Legacy Format (Still Supported):**

```rpgle
// ------------------------------------------------------------------
// Project: NickLitten/template
// Member : myprogram.rpgle
// Desc   : Program description
// Author : username
// Date   : 2026-05-12
// ------------------------------------------------------------------
```

### Procedure Documentation

**Required for all procedures:**

```rpgle
// Procedure: CalculateTotal
// Purpose  : Calculate order total with tax
// Parameters:
//   orderAmount - Base order amount
//   taxRate     - Tax rate as decimal
// Returns  : Total amount including tax
```

### Inline Comments

- Explain complex logic
- Document business rules
- Clarify non-obvious code
- Use TODO/FIXME for temporary items

### Comment Style by Language

| Language | Style | Example |
|----------|-------|---------|
| RPG/RPGLE | `//` | `// This is a comment` |
| SQL | `--` | `-- This is a comment` |
| CL/CLLE | `/* */` | `/* This is a comment */` |
| COBOL | `*` | `* This is a comment` |
| DDS | `A*` | `A* This is a comment` |

## Enforcement

Standards are enforced through:

1. **Automated Scanning** - `scripts/scan-standards.sh`
2. **Comment Checking** - `scripts/ensure-comment-blocks.sh`
3. **Make Targets** - `make standards`
4. **BOB Integration** - Real-time feedback
5. **CI/CD Pipeline** - Pre-merge validation

## References

- [IBM i Documentation](https://www.ibm.com/docs/en/i)
- [RPG Cafe](https://www.rpgpgm.com/)
- [Modern RPG Guide](https://www.ibm.com/docs/en/i/7.5?topic=concepts-free-form-rpg)
