# IBM i Coding Standards for NICKLITTEN Project

## Overview

This document defines the coding standards for all IBM i development in the NICKLITTEN project. These standards ensure consistency, maintainability, and quality across all source code types.

**Author:** Nick Litten  
**Version:** 1.0.0  
**Last Updated:** 2026-05-12  
**BOB Configuration:** `.bob-config.json`

---

## Table of Contents

1. [General Principles](#general-principles)
2. [Documentation Standards](#documentation-standards)
3. [Language-Specific Standards](#language-specific-standards)
4. [Rules.mk Standards](#rulesmk-standards)
5. [Code Scanning Rules](#code-scanning-rules)
6. [BOB Integration](#bob-integration)

---

## General Principles

### Core Values

- **Clarity over Cleverness**: Write code that is easy to understand
- **Consistency**: Follow established patterns throughout the codebase
- **Modern Practices**: Use current IBM i best practices and syntax
- **Documentation**: Every program must have comprehensive headers
- **Maintainability**: Code should be easy to modify and extend

### Universal Rules

1. **Comment Separator**: Always use `-` (dash) as the comment line separator character, never `=` (equals)
2. **Author**: All code authored by "Nick Litten"
3. **Date Format**: Use ISO 8601 format (YYYY-MM-DD)
4. **Version Format**: Use V.NNN format (e.g., V.001, V.002)
5. **Encoding**: UTF-8 for all source files
6. **Line Endings**: LF (Unix-style) preferred

---

## Documentation Standards

### Required Header Elements

All source files must include:

1. **Program/Object Name**: Clear identification
2. **Description**: Comprehensive explanation of purpose
3. **Author**: Nick Litten
4. **Modification History**: Complete change log

### Optional but Recommended

- **Purpose**: Bullet list of key concepts
- **Features**: Specific capabilities
- **Usage**: Clear examples
- **Parameters**: Detailed parameter descriptions
- **Dependencies**: Required libraries/objects
- **Reference**: Links to documentation

### Modification History Format

```
{VERSION} {DATE} | {AUTHOR} | {CHANGE_DESCRIPTION}
```

Example:
```
V.001 2026-05-12 | Nick Litten | Initial creation
V.002 2026-05-15 | Nick Litten | Added error handling
```

### Version Calculation

Version numbers are calculated based on the number of modifications in the history:
- First version: V.001
- After first modification: V.002
- After second modification: V.003
- And so on...

---

## Language-Specific Standards

### RPGLE and SQLRPGLE

#### Comment Style
Use triple-slash (`///`) for all program-level documentation:

```rpgle
**free

///
/// Program: MYPGM
///
/// Description: Sample program demonstrating standards
///
/// Purpose:
///   - Demonstrate modern RPG syntax
///   - Show proper documentation
///   - Implement best practices
///
/// Modification History:
///   V.001 2026-05-12 | Nick Litten | Initial creation
///

ctl-opt copyright('V.001 - Sample program demonstrating standards');
```

#### Copyright Control Option

**Required**: Add `ctl-opt copyright()` using the program description and version number:

```rpgle
ctl-opt copyright('{VERSION} - {DESCRIPTION}');
```

Example:
```rpgle
ctl-opt copyright('V.001 - Sample program demonstrating standards');
```

#### Control Options

Standard control options for all programs:

```rpgle
ctl-opt dftactgrp(*no) actgrp(*caller);
ctl-opt option(*srcstmt: *nodebugio);
ctl-opt bnddir('NICKLITTEN');
```

#### Naming Conventions

- **Procedures**: camelCase (e.g., `calculateTotal`, `processRecord`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `MAX_RECORDS`, `DEFAULT_VALUE`)
- **Variables**: camelCase (e.g., `recordCount`, `customerName`)
- **Data Structures**: PascalCase (e.g., `CustomerInfo`, `OrderHeader`)

#### Modern Syntax Requirements

- **Always use `**free` format** - no fixed-format code
- **Use fully-free RPG** - no column-based syntax
- **Avoid deprecated opcodes**: MOVE, MOVEL, Z-ADD, Z-SUB, GOTO, TAG
- **Use built-in functions**: %TRIM(), %SUBST(), %SCAN(), etc.
- **Prefer SQL over native I/O** when appropriate

#### Indentation

- **2 spaces** per indentation level
- No tabs

#### Line Length

- Maximum **100 characters** per line
- Break long lines logically

#### Example Structure

```rpgle
**free

///
/// Program: EXAMPLE
/// Description: Example program structure
/// Modification History:
///   V.001 2026-05-12 | Nick Litten | Initial creation
///

ctl-opt copyright('V.001 - Example program structure');
ctl-opt dftactgrp(*no) actgrp(*caller);
ctl-opt option(*srcstmt: *nodebugio);
ctl-opt bnddir('NICKLITTEN');

// ---------------------------------------------------------------------------
// Program Information Data Structure
// ---------------------------------------------------------------------------
dcl-ds pgmInfo psds qualified;
  pgmName *proc;
  status *status;
end-ds;

// ---------------------------------------------------------------------------
// Main Program Logic
// ---------------------------------------------------------------------------

dsply 'Program started';

*inlr = *on;
return;

// ---------------------------------------------------------------------------
// Procedures
// ---------------------------------------------------------------------------

dcl-proc myProcedure;
  dcl-pi *n;
    parmIn char(10) const;
    parmOut char(10);
  end-pi;
  
  parmOut = %trim(parmIn);
end-proc;
```

---

### CLLE (Control Language)

#### Comment Style

Use block comments (`/* */`) for all program-level documentation:

```clle
/* Program: MYPGM                                                           */
/*                                                                          */
/* Description: Sample CL program demonstrating standards                  */
/*                                                                          */
/* Modification History:                                                    */
/*   V.001 2026-05-12 | Nick Litten | Initial creation                     */
```

#### Copyright Statement

**Required**: Add `COPYRIGHT TEXT()` using the program description and version:

```clle
COPYRIGHT TEXT('V.001 - Sample CL program demonstrating standards')
```

#### Standard Copyright Variable

Include the standard copyright variable declaration:

```clle
DCL        VAR(&COPYRIGHT) TYPE(*CHAR) LEN(256) +
              VALUE('Nick Litten © 2025 | IBM i V7.5 https://www.nicklitten.com')
DCL        VAR(&COPYRIGHTP) TYPE(*PTR) STG(*DEFINED) DEFVAR(&COPYRIGHT)
```

#### Program Options

Standard program options:

```clle
DCLPRCOPT  LOG(*NO) DFTACTGRP(*NO) ACTGRP(*CALLER)
```

#### Naming Conventions

- **Variables**: UPPER_CASE with & prefix (e.g., `&CUSTOMER_NAME`, `&RECORD_COUNT`)
- **Labels**: UPPER_CASE (e.g., `ERROR`, `CLEANUP`, `PROCESS_LOOP`)

#### Indentation

- **3 spaces** for continuation lines
- Align parameters vertically when possible

#### Line Length

- Maximum **80 characters** per line

#### Example Structure

```clle
/* Program: EXAMPLE                                                         */
/* Description: Example CL program structure                                */
/* Modification History:                                                    */
/*   V.001 2026-05-12 | Nick Litten | Initial creation                     */

             PGM        PARM(&PARM1)

             DCLPRCOPT  LOG(*NO) DFTACTGRP(*NO) ACTGRP(*CALLER)

             COPYRIGHT  TEXT('V.001 - Example CL program structure')
             DCL        VAR(&COPYRIGHT) TYPE(*CHAR) LEN(256) +
                          VALUE('Nick Litten © 2025 | IBM i V7.5 https://www.nicklitten.com')
             DCL        VAR(&COPYRIGHTP) TYPE(*PTR) STG(*DEFINED) DEFVAR(&COPYRIGHT)

/* --------------------------------------------------------------------------
   Variable Declarations
   -------------------------------------------------------------------------- */

             DCL        VAR(&PARM1) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7)

/* --------------------------------------------------------------------------
   Main Program Logic
   -------------------------------------------------------------------------- */

             SNDPGMMSG  MSG('Program started') TOPGMQ(*EXT)

/* --------------------------------------------------------------------------
   Cleanup and Exit
   -------------------------------------------------------------------------- */

             RETURN

             ENDPGM
```

---

### CMD (Command Definitions)

#### Comment Style

Use block comments (`/* */`):

```cmd
/* Command: MYCMD                                                           */
/* Description: Sample command demonstrating standards                     */
/* Modification History:                                                    */
/*   V.001 2026-05-12 | Nick Litten | Initial creation                     */
```

#### Structure

```cmd
             CMD        PROMPT('Command Prompt Text')

/* --------------------------------------------------------------------------
   Parameter Definitions
   -------------------------------------------------------------------------- */

             PARM       KWD(PARM1) TYPE(*CHAR) LEN(10) +
                          PROMPT('Parameter 1 prompt')
```

#### Indentation

- **15 spaces** for parameter alignment

---

### DDS (Data Description Specifications)

#### Comment Style

Use asterisk (`*`) in column 7 for comments:

```dds
      *---------------------------------------------------------------------
      * Physical File: MYFILE
      * Description: Sample file demonstrating standards
      * Author: Nick Litten
      * Created: 2026-05-12
      *---------------------------------------------------------------------
```

#### Comment Separator

Always use `-` (dash), never `=` (equals):

```dds
      *---------------------------------------------------------------------  ✓ CORRECT
      *=====================================================================  ✗ WRONG
```

#### Structure

```dds
     A          R MYRECORD                  TEXT('Record format description')
      *
      *---------------------------------------------------------------------
      * Field Definitions
      *---------------------------------------------------------------------
     A            FIELD1        10A         TEXT('Field 1 description')
     A            FIELD2         7P 2       TEXT('Field 2 description')
```

#### Indentation

- **6 spaces** for field definitions (column 7-12)

---

### SQL (Tables, Views, Procedures)

#### Comment Style

Use double-dash (`--`) for SQL comments:

```sql
-- ---------------------------------------------------------------------------
-- Table: MYTABLE
-- Description: Sample table demonstrating standards
-- Author: Nick Litten
-- Created: 2026-05-12
-- ---------------------------------------------------------------------------
```

#### Comment Separator

Always use `-` (dash), never `=` (equals):

```sql
-- ---------------------------------------------------------------------------  ✓ CORRECT
-- ===========================================================================  ✗ WRONG
```

#### Structure

```sql
-- ---------------------------------------------------------------------------
-- Table: CUSTOMERS
-- Description: Customer master data
-- Modification History:
--   V.001 2026-05-12 | Nick Litten | Initial creation
-- ---------------------------------------------------------------------------

CREATE OR REPLACE TABLE
    CUSTOMERS (
        -- Primary Key
        CUSTOMER_ID INT NOT NULL GENERATED ALWAYS AS IDENTITY,
        
        -- Customer Information
        CUSTOMER_NAME VARCHAR(100) NOT NULL,
        EMAIL VARCHAR(100),
        
        -- Audit Fields
        CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
        UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
        
        -- Constraints
        CONSTRAINT PK_CUSTOMERS PRIMARY KEY (CUSTOMER_ID)
    ) RCDFMT CUSTREC;
```

#### Indentation

- **4 spaces** per level

#### Case Convention

- **Keywords**: Can be UPPER or lower case (project preference: lower case for readability)
- **Object names**: PascalCase or UPPER_CASE (be consistent)

---

### BND (Binder Source)

#### Comment Style

Use block comments (`/* */`):

```bnd
/* ---------------------------------------------------------------------------
   Binder Source: MYSRVPGM
   Description: Service program exports
   Modification History:
     V.001 2026-05-12 | Nick Litten | Initial creation
   --------------------------------------------------------------------------- */

STRPGMEXP PGMLVL(*CURRENT) SIGNATURE('MySignature_V1')

  EXPORT SYMBOL('myProcedure1')
  EXPORT SYMBOL('myProcedure2')

ENDPGMEXP
```

---

### BNDDIR (Binding Directory)

#### Comment Style

Use exclamation mark (`!`) for comments:

```bnddir
! ---------------------------------------------------------------------------
! Binding Directory: MYBNDDIR
! Description: Service program binding directory
! Modification History:
!   V.001 2026-05-12 | Nick Litten | Initial creation
! ---------------------------------------------------------------------------

!DLTOBJ OBJ(&O/&N) OBJTYPE(*BNDDIR)
CRTBNDDIR BNDDIR(&O/&N) TEXT('My Binding Directory')
ADDBNDDIRE BNDDIR(&O/&N) OBJ((*LIBL/MYSRVPGM *SRVPGM))
```

---

## Rules.mk Standards

### Structure

The `Rules.mk` file follows the MAKEI build system standards for CODE FOR IBM i.

#### Root Level Rules.mk

```makefile
# ------------------------------------------------------------------------------
# Rules.mk - Root level build configuration for IBM i project
# ------------------------------------------------------------------------------
# This file defines subdirectories and common build settings for the project.
# Each subdirectory contains its own Rules.mk with specific object targets.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Global Build Settings (can be overridden in subdirectory Rules.mk files)
# ------------------------------------------------------------------------------

# Default target release for all objects
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.SRVPGM: private TGTRLS := V7R4M0

# Default program settings
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# Default module settings
%.MODULE: private OPTIMIZE := *FULL
%.MODULE: private DBGVIEW := *SOURCE

# Default service program settings
%.SRVPGM: private ACTGRP := *CALLER
%.SRVPGM: private ALWLIBUPD := *NO
%.SRVPGM: private ALWUPD := *YES

# Default file settings
%.FILE:   private OPTION := *EVENTF
%.FILE:   private GENLVL := 10

# Default command settings
%.CMD:    private OPTION := *EVENTF

# Subdirectories to process during build (order matters for dependencies)
SUBDIRS = database binders services codesamples
```

#### Subdirectory Rules.mk

```makefile
# ------------------------------------------------------------------------------
# Rules.mk - Subdirectory build configuration
# ------------------------------------------------------------------------------

# Object targets for this directory
OBJECTS = MYPGM.PGM MYSRVPGM.SRVPGM MYFILE.FILE

# Specific overrides for individual objects
MYPGM.PGM: private ACTGRP := MYACTGRP
MYSRVPGM.SRVPGM: private BNDDIR := MYBNDDIR

# Dependencies
MYPGM.PGM: MYFILE.FILE
MYSRVPGM.SRVPGM: MYMODULE.MODULE
```

### Best Practices

1. **Order Matters**: List subdirectories in dependency order
2. **Override Sparingly**: Only override defaults when necessary
3. **Document Changes**: Comment why specific overrides are needed
4. **Consistent Naming**: Use consistent activation group names
5. **Target Release**: Keep consistent across project unless specific need

---

## Code Scanning Rules

### Automated Checks

BOB will automatically scan for:

1. **Missing Headers**: Programs without proper documentation
2. **Outdated Headers**: Headers that don't match current standards
3. **Missing Copyright**: RPGLE/CLLE without copyright statements
4. **Incorrect Comment Separator**: Use of `=` instead of `-`
5. **Missing Modification History**: Programs without change tracking
6. **Inconsistent Indentation**: Code not following indentation rules
7. **Long Lines**: Lines exceeding maximum length
8. **Deprecated Syntax**: Use of old RPG opcodes (MOVE, GOTO, etc.)

### Severity Levels

- **Error**: Must be fixed before commit
- **Warning**: Should be fixed, can be committed with justification
- **Info**: Suggestions for improvement

### Auto-Fix Capabilities

BOB can automatically fix:

- Missing or outdated headers
- Incorrect comment separators
- Missing copyright statements
- Inconsistent indentation
- Missing modification history entries

---

## BOB Integration

### Configuration File

All BOB settings are stored in `.bob-config.json` at the project root.

### Using BOB

#### Apply Standards to New File

When creating a new file, BOB will:
1. Detect the file type by extension
2. Apply the appropriate template
3. Fill in known values (author, date, etc.)
4. Prompt for required information (description, purpose, etc.)

#### Update Existing File

When modifying an existing file, BOB will:
1. Scan for standards compliance
2. Offer to fix any issues found
3. Update modification history
4. Increment version number if configured

#### Scan Project

To scan the entire project:
```
BOB, scan the project for coding standards violations
```

BOB will:
1. Check all source files
2. Report violations by severity
3. Offer to fix auto-fixable issues
4. Generate a compliance report

### BOB Commands

- `BOB, apply standards to this file` - Apply standards to current file
- `BOB, update modification history` - Add entry to modification history
- `BOB, fix comment separators` - Replace `=` with `-` in comments
- `BOB, modernize this RPG code` - Convert old syntax to modern
- `BOB, add missing copyright` - Add copyright statement
- `BOB, validate Rules.mk` - Check Rules.mk for issues

---

## Templates

All templates are stored in the `templates/` directory:

- `rpgle-header-template.txt` - RPGLE/SQLRPGLE programs
- `clle-header-template.txt` - CL programs
- `cmd-header-template.txt` - Command definitions
- `dds-header-template.txt` - DDS files (PF/LF/DSPF/PRTF)
- `sql-header-template.txt` - SQL objects (TABLE/VIEW)
- `bnd-header-template.txt` - Binder source
- `bnddir-header-template.txt` - Binding directories

### Template Variables

Templates use placeholder variables in `{VARIABLE_NAME}` format:

- `{PROGRAM_NAME}` - Name of the program/object
- `{DESCRIPTION}` - Brief description
- `{AUTHOR}` - Author name (default: Nick Litten)
- `{DATE}` - Creation date (ISO format)
- `{VERSION}` - Version number (V.NNN format)
- `{PURPOSE}` - Purpose statement
- `{FEATURE_N}` - Feature descriptions
- `{USAGE_EXAMPLE}` - Usage examples
- `{PARAM_N}` - Parameter descriptions

---

## Compliance Checklist

Before committing code, ensure:

- [ ] Proper header block with all required elements
- [ ] Comment separator is `-` not `=`
- [ ] Copyright statement included (RPGLE/CLLE)
- [ ] Modification history is up to date
- [ ] Version number is correct
- [ ] Code follows language-specific standards
- [ ] No deprecated syntax (RPGLE)
- [ ] Indentation is consistent
- [ ] Lines don't exceed maximum length
- [ ] All procedures/functions are documented
- [ ] Rules.mk is updated if new objects added

---

## References

- [CODE FOR IBM i Extension](https://marketplace.visualstudio.com/items?itemName=HalcyonTechLtd.code-for-ibmi)
- [MAKEI Build System](https://github.com/IBM/ibmi-bob)
- [Nick Litten's Blog](https://www.nicklitten.com)
- [IBM i Documentation](https://www.ibm.com/docs/en/i)

---

## Version History

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| V.001 | 2026-05-12 | Nick Litten | Initial creation of coding standards |

---

**End of Document**