# IBM i Coding Standards for BOB AI Assistant

## Overview

This document defines the coding standards for all IBM i development in the NICKLITTEN project. These standards ensure consistency, maintainability, and best practices across all code.

---

## General Principles

### 1. Documentation Standards

All source files MUST include comprehensive header documentation:
- **RPGLE/SQLRPGLE**: Use triple-slash (`///`) format for better IDE integration and parsing
- **CLLE**: Use block comments (`/* ... */`) format
- **DDS**: Use asterisk (`*`) in column 7 for comments

### 2. Line Separator Character

- **CRITICAL**: Always use `-` (hyphen/dash) as the line separator character in ALL documentation blocks
- **NEVER** use `=` (equals sign) for line separators
- **RPGLE/SQLRPGLE**: `// --------------------------------------------------------------------------`
- **CLLE**: `/* --------------------------------------------------------------------------`

### 3. Version Control

- Version numbers are calculated from the number of modifications in the history
- Format: `V.XXX` where XXX is zero-padded modification count (e.g., V.000, V.001, V.002)
- Initial version is always `V.000`
- Version increments with each modification in the history

### 4. Copyright Statements

All programs MUST include copyright information:

**RPGLE/SQLRPGLE:**
```rpgle
ctl-opt copyright('PROGNAME | V.XXX | Brief description');
```
Format: `PROGNAME | V.XXX | Description` using hyphen separators

**CLLE:**
```clle
COPYRIGHT TEXT('PROGNAME Ver:XXX Brief description')
```
Format: `PROGNAME Ver:XXX Description` (no separators in CLLE)

---

## RPGLE/SQLRPGLE Standards

### File Header Template

```rpgle
**free

///
/// Program: PROGNAME - Brief Program Title
///
/// Description: Comprehensive explanation of the program's purpose and
///              functionality. Use multiple lines as needed with proper
///              indentation for readability.
///
/// Purpose: Educational/Production utility demonstrating:
///   - Key concept or pattern #1
///   - Key concept or pattern #2
///   - Key concept or pattern #3
///   - Additional concepts as needed
///
/// Features:
///   - Specific capability #1
///   - Specific capability #2
///   - Design pattern or best practice demonstrated
///   - Performance considerations
///   - Integration points
///
/// Control Options:
///   - main(mainline): Eliminates RPG cycle overhead
///   - optimize(*full): Maximum optimization
///   - option(*nodebugio:*srcstmt:*nounref): Debug and compile options
///   - pgminfo(*pcml:*module): Embeds parameter metadata
///   - actgrp(*new/*caller): Activation group strategy
///   - indent('| '): Code indentation character
///
/// Usage: CALL PROGNAME or detailed usage instructions
///
/// Parameters (if applicable):
///   - parm1: type - Description of parameter
///   - parm2: type - Description of parameter
///
/// Dependencies:
///   - Required files, service programs, or APIs
///   - External resources needed
///
/// Copybooks Required:
///   - header.rpgleinc: Standard control options
///   - Other includes as needed
///
/// Reference:
/// https://www.nicklitten.com/relevant-blog-post-url
///
/// Modification History:
///   V.000 YYYY-MM-DD | Nick Litten | Initial creation
///   V.001 YYYY-MM-DD | Nick Litten | Description of changes
///

/include 'header.rpgleinc'

ctl-opt
  copyright('PROGNAME | V.XXX | Brief description')
  ;

// ------------------------------------------------------------------------------
// File Declarations
// ------------------------------------------------------------------------------

// ------------------------------------------------------------------------------
// Named Constants
// ------------------------------------------------------------------------------

// ------------------------------------------------------------------------------
// Data Structures
// ------------------------------------------------------------------------------

// ------------------------------------------------------------------------------
// Standalone Variables
// ------------------------------------------------------------------------------

// ------------------------------------------------------------------------------
// Main Program Logic
// ------------------------------------------------------------------------------
dcl-Proc mainline;
  
  // Program logic here
  
  *inlr = *on;
  Return;
  
end-proc;

// ------------------------------------------------------------------------------
// Procedure: ProcedureName
// Description: What this procedure does
// Parameters:
//   - parm1: Description
// Returns: Description of return value
// ------------------------------------------------------------------------------
dcl-Proc ProcedureName;
  
  Dcl-Pi *n;
    // Parameters
  end-pi;
  
  // Procedure logic
  
end-proc;
```

### Key Requirements

1. **Always use `**free` format** - No fixed-format code
2. **Main procedure pattern** - Use `ctl-opt main(mainline)` to eliminate RPG cycle
3. **Named constants** - Use `Dcl-C` for all constants, never magic numbers
4. **Qualified data structures** - Always use `qualified` keyword
5. **Proper indentation** - Use `indent('| ')` in control options
6. **Section separators** - Use `// ======` format with descriptive headers
7. **Procedure documentation** - Document all procedures with purpose, parameters, and return values
8. **SQL options** - For SQLRPGLE, include `exec sql set option commit = *none, closqlcsr = *endmod;`

### Naming Conventions

- **Programs**: UPPERCASE, descriptive, max 10 characters
- **Procedures**: PascalCase (e.g., `LoadSubfilePage`, `ProcessSelections`)
- **Variables**: camelCase (e.g., `currentPage`, `totalRecords`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `PAGE_SIZE`, `SQL_SUCCESS`)
- **Data structures**: PascalCase with `qualified` keyword
- **File fields**: UPPERCASE for display file fields

---

## CLLE Standards

### File Header Template

```clle
/* Program: PROGNAME - Brief Program Title                                 */
/*                                                                          */
/* Description: Comprehensive explanation of the program's purpose and     */
/*              functionality. Use multiple lines as needed with proper    */
/*              indentation for readability.                               */
/*                                                                          */
/* Purpose: Production utility demonstrating:                              */
/*   - Key concept or pattern #1                                           */
/*   - Key concept or pattern #2                                           */
/*   - Key concept or pattern #3                                           */
/*                                                                          */
/* Features:                                                                */
/*   - Specific capability #1                                              */
/*   - Specific capability #2                                              */
/*   - Error handling approach                                             */
/*   - Resource management                                                 */
/*                                                                          */
/* Usage: CALL PROGNAME PARM(parm1 parm2 parm3)                            */
/*        Where parameters are described below                             */
/*                                                                          */
/* Parameters:                                                              */
/*   - &PARM1: char(10) - Description of parameter                         */
/*   - &PARM2: char(10) - Description of parameter                         */
/*   - &RESULT: char(3) - Return value description                         */
/*                                                                          */
/* Dependencies:                                                            */
/*   - Required commands or programs                                       */
/*   - System resources needed                                             */
/*                                                                          */
/* Reference:                                                               */
/* https://www.nicklitten.com/relevant-blog-post-url                       */
/*                                                                          */
/* Modification History:                                                    */
/* V.000 YYYY-MM-DD | Author Name | Initial creation                       */
/* V.001 YYYY-MM-DD | Author Name | Description of changes                 */

PGM        PARM(&PARM1 &PARM2 &RESULT)

DCLPRCOPT  LOG(*NO) DFTACTGRP(*NO) ACTGRP(*CALLER)

COPYRIGHT  TEXT('PROGNAME Ver:XXX Brief description')
DCL        VAR(&COPYRIGHT) TYPE(*CHAR) LEN(256) +
              VALUE('Nick Litten © YYYY | IBM i V7.5 https://www.nicklitten.com')
DCL        VAR(&COPYRIGHTP) TYPE(*PTR) STG(*DEFINED) DEFVAR(&COPYRIGHT)

/* Variable declarations */
DCL        VAR(&PARM1) TYPE(*CHAR) LEN(10)
DCL        VAR(&PARM2) TYPE(*CHAR) LEN(10)
DCL        VAR(&RESULT) TYPE(*CHAR) LEN(3)

/* Program logic here */

/* Error handling routines */

/* Cleanup routine */
CLEANUP:

RETURN

ENDPGM
```

### Key Requirements

1. **Block comment documentation** - Use `/* ... */` format with right-aligned closing on each line
2. **COPYRIGHT statement** - Include version and description
3. **DCLPRCOPT** - Always specify `LOG(*NO) DFTACTGRP(*NO) ACTGRP(*CALLER)`
4. **Error handling** - Use labeled sections (e.g., `SQL_ERROR:`, `CLEANUP:`)
5. **MONMSG** - Monitor for specific message IDs, not CPF0000 unless necessary
6. **Comments** - Use `/* */` for inline comments
7. **Indentation** - Consistent spacing for readability

### Naming Conventions

- **Programs**: UPPERCASE, descriptive, max 10 characters
- **Variables**: &UPPERCASE with descriptive names
- **Labels**: UPPERCASE with descriptive names (e.g., `SQL_ERROR:`, `CLEANUP:`)

---

## DDS (Display Files & Physical Files) Standards

### Display File Header

```
      * ----------------------------------------------------------------------------
      * Display File: FILENAME - Brief Description
      * ----------------------------------------------------------------------------
      * Description: Comprehensive explanation of the display file's purpose
      *
      * Features:
      *   - Subfile with XX records per page
      *   - Function key support (F3=Exit, F5=Refresh, etc.)
      *   - Input validation
      *
      * Record Formats:
      *   - SFLCTL: Subfile control record
      *   - SFLREC: Subfile detail record
      *   - FOOTREC: Footer record with function keys
      *
      * Modification History:
      * V.000 YYYY-MM-DD | Author Name | Initial creation
      * ----------------------------------------------------------------------------
```

### Physical File Header

```
      * ----------------------------------------------------------------------------
      * Physical File: FILENAME - Brief Description
      * ----------------------------------------------------------------------------
      * Description: Comprehensive explanation of the file's purpose
      *
      * Key Fields:
      *   - FIELD1: Primary key
      *   - FIELD2: Secondary key
      *
      * Modification History:
      * V.000 YYYY-MM-DD | Author Name | Initial creation
      * ----------------------------------------------------------------------------
```

### Key Requirements

1. **Header block** - Use `A*` prefix with separator lines
2. **Field descriptions** - Use `TEXT()` keyword for all fields
3. **Key specifications** - Clearly document key fields
4. **Function keys** - Document all function keys in header
5. **Indicators** - Document indicator usage

---

## SQL (DDL) Standards

### Table Creation Header

```sql
-- ------------------------------------------------------------------------------
-- Table: TABLENAME - Brief Description
-- ------------------------------------------------------------------------------
-- Description: Comprehensive explanation of the table's purpose
--
-- Features:
--   - Primary key on FIELD1
--   - Foreign key relationships
--   - Indexes for performance
--
-- Modification History:
-- V.000 YYYY-MM-DD | Author Name | Initial creation
-- ------------------------------------------------------------------------------

CREATE OR REPLACE TABLE LIBRARY.TABLENAME (
    FIELD1 CHAR(10) NOT NULL,
    FIELD2 VARCHAR(100) NOT NULL,
    FIELD3 DECIMAL(15,2) DEFAULT 0,
    FIELD4 DATE,
    FIELD5 TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (FIELD1)
);

LABEL ON TABLE LIBRARY.TABLENAME IS 'Brief Description';
LABEL ON COLUMN LIBRARY.TABLENAME (
    FIELD1 TEXT IS 'Field 1 Description',
    FIELD2 TEXT IS 'Field 2 Description',
    FIELD3 TEXT IS 'Field 3 Description'
);
```

### Key Requirements

1. **Header comments** - Use `--` with separator lines
2. **CREATE OR REPLACE** - For maintainability
3. **NOT NULL constraints** - Specify where appropriate
4. **DEFAULT values** - Provide sensible defaults
5. **LABEL statements** - Document table and columns
6. **Indexes** - Create appropriate indexes with documentation

---

## Code Review Checklist

BOB will automatically check for:

### Documentation
- [ ] Triple-slash header present
- [ ] Program description complete
- [ ] Purpose section with bullet points
- [ ] Features section with bullet points
- [ ] Modification history present
- [ ] Copyright statement with correct version

### Code Quality
- [ ] No magic numbers (use named constants)
- [ ] Proper error handling
- [ ] Consistent naming conventions
- [ ] Appropriate comments for complex logic
- [ ] No hardcoded values that should be parameters
- [ ] Proper resource cleanup

### Best Practices
- [ ] Modern RPG free format (no fixed format)
- [ ] Main procedure pattern used
- [ ] Qualified data structures
- [ ] SQL options set appropriately
- [ ] Activation group specified
- [ ] Proper indentation

---

## Auto-Correction Rules

BOB will automatically:

1. **Insert missing headers** - Add template header if missing
2. **Update copyright** - Calculate version from modification count
3. **Fix indentation** - Ensure consistent spacing
4. **Add section separators** - Insert `// ======` blocks where appropriate
5. **Convert to free format** - Modernize fixed-format code
6. **Add procedure documentation** - Document undocumented procedures

---

## Version Calculation

Version numbers are calculated as follows:

1. Count entries in "Modification History" section
2. Format as `V.XXX` with zero-padding (e.g., V.000, V.001, V.042)
3. Update copyright statement with calculated version
4. For new files, start with `V.000`

---

## References

- [Nick Litten's Blog](https://www.nicklitten.com)
- [IBM i Documentation](https://www.ibm.com/docs/en/i)
- [RPG Cafe](https://www.rpgpgm.com)

---

**Last Updated:** 2026-04-18
**Maintained By:** Nick Litten / BOB AI Assistant