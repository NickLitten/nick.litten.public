# IBM i Documentation Standardization Plan

## Executive Summary

This document outlines the comprehensive plan to standardize documentation across all IBM i source code in the repository. The goal is to ensure consistent, professional documentation that follows modern IBM i coding standards.

## Current State Analysis

### Documentation Formats Found

1. **RPGLE Programs** (`.pgm.rpgle`)
   - ✅ GOOD: `HELLOWORLD` uses modern triple-slash (`///`) format
   - ❌ NEEDS UPDATE: `CONVERT1` uses old fixed-format with asterisks (`*`)

2. **SQLRPGLE Programs** (`.sqlrpgle`)
   - ✅ GOOD: `NICKSRV` uses triple-slash (`///`) format
   - Status: Need to verify all SQLRPGLE files

3. **CLLE Programs** (`.pgm.clle`)
   - ✅ GOOD: Most use block comment format (`/* */`)
   - ⚠️ INCONSISTENT: Some use dashed separators, some use equals
   - ❌ MISSING: Some lack COPYRIGHT declarations

4. **CMD Files** (`.cmd`)
   - ✅ GOOD: Most use block comment format (`/* */`)
   - ⚠️ INCONSISTENT: Header format varies

5. **SQL Files** (`.sql`)
   - ✅ GOOD: `ALLTABLE` uses double-dash (`--`) format with proper sections
   - Status: Need to verify all SQL files

### Key Issues Identified

1. **Comment Separator Inconsistency**
   - Some files use `/* ------- */` (correct)
   - Some files use `/* ======= */` (incorrect - breaks regex detection)

2. **Missing COPYRIGHT Declarations**
   - CLLE programs should include: `COPYRIGHT TEXT('version - description')`
   - RPGLE/SQLRPGLE should include: `ctl-opt copyright('version - description')`

3. **Inconsistent Version Numbering**
   - Some use `V.001`, some use `v.001`, some use `1.0`
   - Need standardized format

4. **Modification History Format**
   - Various formats found
   - Need consistent date format and structure

## Documentation Standards

### 1. RPGLE and SQLRPGLE Programs

**Format:** Triple-slash (`///`) for all documentation blocks

```rpgle
**free

///
/// Program: PROGRAMNAME - Brief Description
///
/// Description: Detailed explanation of what the program does.
///              Multiple lines as needed.
///
/// Purpose: Educational/Production example demonstrating:
///   - Key concept 1
///   - Key concept 2
///   - Key concept 3
///
/// Features:
///   - Feature 1
///   - Feature 2
///   - Feature 3
///
/// Usage: CALL PROGRAMNAME PARM(param1 param2)
///        Example: CALL PROGRAMNAME PARM('VALUE1' 'VALUE2')
///
/// Parameters:
///   - param1: type - Description
///   - param2: type - Description
///
/// Dependencies:
///   - Required files, libraries, or services
///
/// Reference:
///   - Documentation links
///   - https://www.nicklitten.com/relevant-article
///
/// Modification History:
///   1.0 YYYY-MM-DD | Author Name | Initial creation
///   1.1 YYYY-MM-DD | Author Name | Description of changes
///

ctl-opt dftactgrp(*no) actgrp(*caller)
        copyright('1.1 - Brief program description');
```

**Key Rules:**
- Use `///` for ALL documentation (not `//` or `*`)
- Section separators use dashes: `// ---` (never equals `// ===`)
- Include `ctl-opt copyright('version - description')`
- Author is always "Nick Litten"
- Version format: `1.0`, `1.1`, `2.0` (not `V.001` or `v.001`)

### 2. CLLE Programs

**Format:** Block comments (`/* */`) with consistent structure

```clle
/* Program: PROGRAMNAME - Brief Description                        */
/*                                                                  */
/* Description: Detailed explanation of what the program does.     */
/*              Multiple lines as needed.                          */
/*                                                                  */
/* Purpose: Educational/Production example demonstrating:          */
/*   - Key concept 1                                               */
/*   - Key concept 2                                               */
/*   - Key concept 3                                               */
/*                                                                  */
/* Features:                                                       */
/*   - Feature 1                                                   */
/*   - Feature 2                                                   */
/*   - Feature 3                                                   */
/*                                                                  */
/* Usage: CALL PROGRAMNAME PARM(param1 param2)                    */
/*        Example: CALL PROGRAMNAME PARM('VALUE1' 'VALUE2')       */
/*                                                                  */
/* Parameters:                                                     */
/*   - param1: type - Description                                  */
/*   - param2: type - Description                                  */
/*                                                                  */
/* Dependencies:                                                   */
/*   - Required files, libraries, or services                      */
/*                                                                  */
/* Reference:                                                      */
/*   - Documentation links                                         */
/*   - https://www.nicklitten.com/relevant-article                 */
/*                                                                  */
/* Modification History:                                           */
/*   1.0 YYYY-MM-DD | Author Name | Initial creation               */
/*   1.1 YYYY-MM-DD | Author Name | Description of changes         */
/* --------------------------------------------------------------- */

PGM PARM(&PARAM1 &PARAM2)

DCLPRCOPT LOG(*NO) DFTACTGRP(*NO) ACTGRP(*CALLER)

COPYRIGHT TEXT('1.1 - Brief program description')
DCL VAR(&COPYRIGHT) TYPE(*CHAR) LEN(256) +
      VALUE('Nick Litten © 2025 | IBM i V7.5 https://www.nicklitten.com')
DCL VAR(&COPYRIGHTP) TYPE(*PTR) STG(*DEFINED) DEFVAR(&COPYRIGHT)
```

**Key Rules:**
- Use `/* */` block comments (not `///`)
- Section separators use dashes: `/* --- */` (never equals)
- Include `COPYRIGHT TEXT('version - description')`
- Include copyright variable declaration
- Author is always "Nick Litten"

### 3. CMD Files

**Format:** Block comments (`/* */`) with consistent structure

```cmd
/******************************************************************************/
/* Command: COMMANDNAME - Brief Description                                  */
/* Description: Detailed explanation of what the command does                */
/*                                                                            */
/* Parameters:                                                                */
/*   PARM1   - Description of parameter 1                                    */
/*   PARM2   - Description of parameter 2                                    */
/*                                                                            */
/* Usage Examples:                                                            */
/*   COMMANDNAME PARM1(value1) PARM2(value2)                                 */
/*   COMMANDNAME PARM1('example')                                            */
/*                                                                            */
/* Reference:                                                                 */
/*   - Documentation links                                                    */
/*   - https://www.nicklitten.com/relevant-article                           */
/*                                                                            */
/* Modification History:                                                      */
/*   1.0 YYYY-MM-DD | Author Name | Initial creation                         */
/*   1.1 YYYY-MM-DD | Author Name | Description of changes                   */
/******************************************************************************/

             CMD        PROMPT('Command Description')
```

**Key Rules:**
- Use `/***...*/` style header block
- No internal section separators needed
- Author is always "Nick Litten"
- Version format: `1.0`, `1.1`, `2.0`

### 4. SQL Files

**Format:** Double-dash (`--`) comments with consistent structure

```sql
-- ---------------------------------------------------------------------------
-- SQL Object: OBJECTNAME
-- Description: Brief description of the SQL object
-- Author: Nick Litten
-- Created: YYYY-MM-DD
-- ---------------------------------------------------------------------------
-- Purpose: Demonstrate specific SQL concepts
--   - Key concept 1
--   - Key concept 2
--   - Key concept 3
--
-- Features:
--   - Feature 1
--   - Feature 2
--   - Feature 3
--
-- Usage: Example SQL statements
--   SELECT * FROM OBJECTNAME WHERE condition;
--   INSERT INTO OBJECTNAME VALUES (...);
--
-- Columns/Parameters:
--   - column1: Description
--   - column2: Description
--
-- Dependencies:
--   - Required objects or privileges
--
-- Reference:
--   - Documentation links
--   - https://www.nicklitten.com/relevant-article
--
-- Modification History:
--   1.0 YYYY-MM-DD | Nick Litten | Initial creation
--   1.1 YYYY-MM-DD | Nick Litten | Description of changes
-- ---------------------------------------------------------------------------
```

**Key Rules:**
- Use `--` for all comments (not `/* */`)
- Section separators use dashes: `-- ---` (never equals)
- Author is always "Nick Litten"
- Version format: `1.0`, `1.1`, `2.0`

## Implementation Plan

### Phase 1: Documentation Standards Document (Current)
- [x] Create this comprehensive standards document
- [ ] Review and approve standards with team

### Phase 2: Automated Analysis
- [ ] Create script to scan all source files
- [ ] Identify files needing updates
- [ ] Generate detailed report by file type

### Phase 3: Update by File Type

#### 3.1 RPGLE Programs (`.pgm.rpgle`)
- [ ] Convert fixed-format headers to `///` format
- [ ] Add `ctl-opt copyright()` where missing
- [ ] Standardize version numbers
- [ ] Fix comment separators (dashes not equals)
- [ ] Update modification history format

#### 3.2 SQLRPGLE Programs (`.sqlrpgle`)
- [ ] Verify all use `///` format
- [ ] Add `ctl-opt copyright()` where missing
- [ ] Standardize version numbers
- [ ] Fix comment separators
- [ ] Update modification history format

#### 3.3 CLLE Programs (`.pgm.clle`)
- [ ] Verify all use `/* */` format
- [ ] Add `COPYRIGHT TEXT()` where missing
- [ ] Add copyright variable declarations
- [ ] Fix comment separators (dashes not equals)
- [ ] Standardize version numbers
- [ ] Update modification history format

#### 3.4 CMD Files (`.cmd`)
- [ ] Verify all use `/***...*/` format
- [ ] Standardize header structure
- [ ] Fix version numbers
- [ ] Update modification history format

#### 3.5 SQL Files (`.sql`)
- [ ] Verify all use `--` format
- [ ] Fix comment separators (dashes not equals)
- [ ] Standardize version numbers
- [ ] Update modification history format

### Phase 4: Quality Assurance
- [ ] Run standards checker script
- [ ] Verify all files pass validation
- [ ] Manual review of sample files
- [ ] Update any files that fail validation

### Phase 5: Documentation
- [ ] Create summary report of all changes
- [ ] Update project README with standards reference
- [ ] Document any exceptions or special cases

## File Inventory

### Files Requiring Updates

#### RPGLE Programs
- `conversion/CONVERT1-Original.pgm.rpgle` - Convert from fixed-format to `///`
- `conversion/CONVERT2-Modernized.pgm.rpgle` - Verify format
- `conversion/CONVERT3-Modernized_Improved.pgm.rpgle` - Verify format
- `conversion/CONVERT4-Convert_EBCDIC_to_ASCII_with_SRVPGM.pgm.rpgle` - Verify format
- All subfile programs - Verify format
- All stored procedure programs - Verify format

#### SQLRPGLE Programs
- `services/NICKSRV-Service_Program_for_Lessons.sqlrpgle` - Verify format
- `services/EMAILSRV-Email_Service.sqlrpgle` - Verify format
- `services/USRPRFSRV-User_Profile_Service.sqlrpgle` - Verify format
- `services/SIMPLEMOD-Simple_Service_Program.sqlrpgle` - Verify format
- `conversion/CONVSRV-Conversion_Service.sqlrpgle` - Verify format
- All other SQLRPGLE files - Verify format

#### CLLE Programs
- All CLLE programs - Verify COPYRIGHT declarations
- All CLLE programs - Fix comment separators
- All CLLE programs - Standardize version numbers

#### CMD Files
- All CMD files - Standardize header format
- All CMD files - Fix version numbers

#### SQL Files
- All SQL files - Verify `--` format
- All SQL files - Fix comment separators

## Success Criteria

1. ✅ All RPGLE/SQLRPGLE files use `///` format
2. ✅ All CLLE files use `/* */` format with COPYRIGHT
3. ✅ All CMD files use `/***...*/` format
4. ✅ All SQL files use `--` format
5. ✅ All comment separators use dashes (not equals)
6. ✅ All files have consistent version numbering
7. ✅ All files have standardized modification history
8. ✅ All files pass automated standards checker
9. ✅ Documentation is complete and accurate

## Timeline

- **Phase 1**: 1 day (Documentation standards)
- **Phase 2**: 1 day (Automated analysis)
- **Phase 3**: 3-5 days (Updates by file type)
- **Phase 4**: 1 day (Quality assurance)
- **Phase 5**: 1 day (Final documentation)

**Total Estimated Time**: 7-9 days

## Notes

- All changes will be tracked in modification history
- Version numbers will increment based on significance of changes
- Author for all files is "Nick Litten"
- Copyright year should reflect actual creation/modification year
- All URLs should point to www.nicklitten.com where applicable

## Approval

This plan requires approval before implementation begins. Once approved, work will proceed through Code mode to implement the standardization.

---

**Document Version**: 1.0  
**Created**: 2026-05-23  
**Author**: IBM Bob (Plan Mode)  
**Status**: Awaiting Approval