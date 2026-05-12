# BOB Usage Guide for IBM i Development

## Introduction

BOB (your AI assistant) is configured to help maintain coding standards across the NICKLITTEN IBM i project. This guide explains how to work with BOB effectively.

**Version:** 1.0.0  
**Last Updated:** 2026-05-12  
**Configuration File:** `.bob-config.json`

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Common Tasks](#common-tasks)
3. [BOB Commands](#bob-commands)
4. [Automated Features](#automated-features)
5. [Working with Templates](#working-with-templates)
6. [Code Scanning](#code-scanning)
7. [Troubleshooting](#troubleshooting)

---

## Quick Start

### First Time Setup

BOB is pre-configured with the `.bob-config.json` file. No additional setup is required.

### Basic Workflow

1. **Create New File**: BOB will automatically apply the appropriate template
2. **Edit Existing File**: BOB will scan for standards compliance
3. **Before Commit**: BOB will validate all changes
4. **Build**: BOB ensures Rules.mk is properly configured

---

## Common Tasks

### Creating a New RPGLE Program

**Request:**
```
BOB, create a new RPGLE program called MYPGM that processes customer orders
```

**BOB will:**
1. Create file with `.pgm.rpgle` extension
2. Apply RPGLE header template
3. Fill in program name, author, date
4. Prompt for description and purpose
5. Add standard control options
6. Include program status data structure
7. Set up basic structure with comments

**Result:**
```rpgle
**free

///
/// Program: MYPGM
///
/// Description: Process customer orders
///
/// Purpose:
///   - Read customer order file
///   - Validate order data
///   - Update inventory
///
/// Features:
///   - SQL-based data access
///   - Comprehensive error handling
///   - Transaction control
///
/// Usage: CALL MYPGM
///
/// Modification History:
///   V.001 2026-05-12 | Nick Litten | Initial creation
///

ctl-opt copyright('V.001 - Process customer orders');
ctl-opt dftactgrp(*no) actgrp(*caller);
ctl-opt option(*srcstmt: *nodebugio);
ctl-opt bnddir('NICKLITTEN');

// ... rest of program
```

---

### Creating a New CL Program

**Request:**
```
BOB, create a new CL program called BACKUP that backs up the database
```

**BOB will:**
1. Create file with `.pgm.clle` extension
2. Apply CLLE header template
3. Add COPYRIGHT statement
4. Include standard copyright variable
5. Set up DCLPRCOPT
6. Add error handling structure

---

### Creating a New SQL Table

**Request:**
```
BOB, create a new SQL table called ORDERS with customer ID, order date, and amount
```

**BOB will:**
1. Create file with `.table` extension
2. Apply SQL header template
3. Define columns with appropriate types
4. Add audit fields (CREATED_AT, UPDATED_AT)
5. Create primary key constraint
6. Add indexes for common queries
7. Include column comments

---

### Updating an Existing File

**Request:**
```
BOB, update the modification history for this file - I added error handling
```

**BOB will:**
1. Read current modification history
2. Calculate next version number
3. Add new entry with current date
4. Update copyright statement with new version
5. Preserve all existing history

**Example Update:**
```rpgle
/// Modification History:
///   V.001 2026-05-12 | Nick Litten | Initial creation
///   V.002 2026-05-15 | Nick Litten | Added error handling

ctl-opt copyright('V.002 - Process customer orders');
```

---

### Fixing Comment Separators

**Request:**
```
BOB, fix the comment separators in this file
```

**BOB will:**
1. Scan for lines using `=` as separator
2. Replace with `-` (dash)
3. Maintain line length
4. Report number of changes made

**Before:**
```rpgle
///=====================================================================
/// Program: MYPGM
///=====================================================================
```

**After:**
```rpgle
///---------------------------------------------------------------------
/// Program: MYPGM
///---------------------------------------------------------------------
```

---

### Modernizing Legacy RPG Code

**Request:**
```
BOB, modernize this RPG code to use modern syntax
```

**BOB will:**
1. Convert to **free format
2. Replace deprecated opcodes:
   - MOVE → assignment or %TRIM()
   - MOVEL → %SUBST() or assignment
   - Z-ADD → assignment
   - Z-SUB → subtraction
   - GOTO/TAG → structured programming
3. Convert to fully-free syntax
4. Add proper indentation
5. Update documentation
6. Add modification history entry

**Before:**
```rpgle
     C     *ENTRY        PLIST
     C                   PARM                    CUSTNO
     C                   Z-ADD     0             TOTAL
     C                   MOVE      'Y'           FOUND
     C                   GOTO      PROCESS
```

**After:**
```rpgle
**free

dcl-pi *n;
  custNo char(10);
end-pi;

dcl-s total packed(15:2) inz(0);
dcl-s found char(1) inz('Y');

// Process customer
processCustomer();
```

---

## BOB Commands

### File Operations

| Command | Description | Example |
|---------|-------------|---------|
| `create new [type] [name]` | Create new source file | `create new RPGLE program MYPGM` |
| `apply standards to this file` | Apply standards to current file | `apply standards to this file` |
| `update modification history` | Add history entry | `update modification history - fixed bug` |
| `add missing copyright` | Add copyright statement | `add missing copyright` |

### Code Quality

| Command | Description | Example |
|---------|-------------|---------|
| `fix comment separators` | Replace = with - | `fix comment separators` |
| `modernize this code` | Convert to modern syntax | `modernize this RPG code` |
| `check indentation` | Verify indentation | `check indentation in this file` |
| `validate this file` | Run all checks | `validate this file` |

### Project Operations

| Command | Description | Example |
|---------|-------------|---------|
| `scan project` | Scan all files | `scan the project for violations` |
| `validate Rules.mk` | Check build config | `validate Rules.mk` |
| `generate compliance report` | Create report | `generate compliance report` |
| `list non-compliant files` | Show violations | `list non-compliant files` |

### Documentation

| Command | Description | Example |
|---------|-------------|---------|
| `add documentation` | Add missing docs | `add documentation to this procedure` |
| `update header` | Refresh header block | `update header with new description` |
| `explain this code` | Add explanatory comments | `explain this code section` |

---

## Automated Features

### On File Creation

BOB automatically:
- Detects file type by extension
- Applies appropriate template
- Fills in author (Nick Litten)
- Sets creation date (current date)
- Initializes version to V.001
- Creates modification history

### On File Save

BOB can automatically (if configured):
- Validate coding standards
- Check for deprecated syntax
- Verify indentation
- Check line lengths
- Update modification date

### On Commit

BOB automatically:
- Scans changed files
- Reports violations
- Blocks commit if errors found
- Suggests fixes for warnings

---

## Working with Templates

### Available Templates

Located in `templates/` directory:

- `rpgle-header-template.txt` - RPGLE/SQLRPGLE programs
- `clle-header-template.txt` - CL programs  
- `cmd-header-template.txt` - Command definitions
- `dds-header-template.txt` - DDS files
- `sql-header-template.txt` - SQL objects
- `bnd-header-template.txt` - Binder source
- `bnddir-header-template.txt` - Binding directories

### Template Variables

Templates use `{VARIABLE_NAME}` placeholders:

**Automatic (BOB fills in):**
- `{AUTHOR}` → Nick Litten
- `{DATE}` → Current date (YYYY-MM-DD)
- `{VERSION}` → V.001 (for new files)

**Prompted (BOB asks you):**
- `{PROGRAM_NAME}` → Name of program
- `{DESCRIPTION}` → Brief description
- `{PURPOSE}` → Purpose statement
- `{FEATURE_N}` → Feature list items
- `{USAGE_EXAMPLE}` → Usage examples

### Customizing Templates

To modify a template:

1. Edit the template file in `templates/`
2. Use `{VARIABLE_NAME}` for placeholders
3. Maintain comment style for language
4. Keep separator as `-` not `=`
5. Test with BOB before committing

**Example Custom Variable:**
```rpgle
/// Project: {PROJECT_NAME}
/// Module: {MODULE_NAME}
```

Then tell BOB:
```
BOB, when creating files, also prompt for PROJECT_NAME and MODULE_NAME
```

---

## Code Scanning

### Manual Scan

**Request:**
```
BOB, scan this file for standards violations
```

**BOB will check:**
- Header block completeness
- Comment separator usage
- Copyright statement presence
- Modification history format
- Indentation consistency
- Line length limits
- Deprecated syntax usage
- Naming conventions

**Report Format:**
```
Standards Violations Found:

ERRORS (must fix):
  - Line 45: Using deprecated MOVE opcode
  - Line 67: Missing copyright statement

WARNINGS (should fix):
  - Line 12: Using = instead of - for separator
  - Line 89: Line exceeds 100 characters

INFO (suggestions):
  - Consider adding usage examples
  - Procedure 'calcTotal' could use more documentation
```

### Project-Wide Scan

**Request:**
```
BOB, scan the entire project for violations
```

**BOB will:**
1. Scan all source files
2. Categorize by severity
3. Group by violation type
4. Generate summary report
5. Offer to fix auto-fixable issues

**Summary Report:**
```
Project Scan Results
====================

Files Scanned: 156
Compliant: 142 (91%)
Non-Compliant: 14 (9%)

Violations by Severity:
  Errors: 3
  Warnings: 18
  Info: 27

Top Issues:
  1. Incorrect comment separator (12 files)
  2. Missing modification history (5 files)
  3. Deprecated syntax (3 files)

Auto-fixable: 15 violations
Manual review needed: 33 violations
```

### Auto-Fix

**Request:**
```
BOB, fix all auto-fixable violations in this file
```

**BOB will:**
1. Fix comment separators (= → -)
2. Add missing copyright statements
3. Correct indentation
4. Add missing modification history
5. Update outdated headers
6. Report all changes made

**Confirmation:**
```
Auto-Fix Complete
=================

Changes Made:
  ✓ Fixed 3 comment separators
  ✓ Added copyright statement
  ✓ Corrected indentation (12 lines)
  ✓ Added modification history entry

Manual Review Needed:
  ⚠ Line 45: Deprecated MOVE opcode (suggest: use assignment)
  ⚠ Line 67: Line too long (suggest: break into multiple lines)
```

---

## Troubleshooting

### BOB Doesn't Recognize File Type

**Problem:** BOB applies wrong template or no template

**Solution:**
1. Check file extension matches `.bob-config.json`
2. Ensure extension is in correct format:
   - RPGLE: `.pgm.rpgle` or `.sqlrpgle`
   - CLLE: `.pgm.clle`
   - CMD: `.cmd`
   - DDS: `.pf`, `.lf`, `.dspf`, `.prtf`
   - SQL: `.table`, `.view`, `.sql`

**Manual Override:**
```
BOB, treat this file as RPGLE and apply the RPGLE template
```

---

### Version Number Not Incrementing

**Problem:** Version stays at V.001 after modifications

**Solution:**
1. Ensure modification history is being updated
2. Check `.bob-config.json` has `"versionCalculation": "modificationCount"`
3. Manually specify version:
```
BOB, update modification history to V.002
```

---

### Copyright Statement Not Added

**Problem:** RPGLE/CLLE file missing copyright

**Solution:**
```
BOB, add the missing copyright statement using version V.001 and description "Process customer orders"
```

BOB will add:
```rpgle
ctl-opt copyright('V.001 - Process customer orders');
```

---

### Comment Separators Keep Reverting

**Problem:** Fixed separators change back to =

**Solution:**
1. Check if other tools are modifying files
2. Add to `.gitattributes`:
```
*.rpgle text eol=lf
*.clle text eol=lf
```
3. Configure editor to preserve formatting

---

### BOB Suggests Wrong Modernization

**Problem:** BOB's modernization doesn't fit your needs

**Solution:**
```
BOB, modernize this code but keep the CHAIN operation instead of using SQL
```

Or:
```
BOB, show me the modernization options for this code without applying them
```

---

## Best Practices

### Working with BOB

1. **Be Specific**: Clear requests get better results
   - ❌ "Fix this"
   - ✅ "Fix the comment separators in this file"

2. **Review Changes**: Always review BOB's changes before committing
   - Use `git diff` to see what changed
   - Verify logic is preserved

3. **Incremental Updates**: Make one type of change at a time
   - First: Fix standards violations
   - Then: Modernize syntax
   - Finally: Add features

4. **Document Decisions**: When you override standards, document why
   ```rpgle
   /// Note: Using CHAIN instead of SQL for performance in this high-volume program
   ```

5. **Keep Templates Updated**: As standards evolve, update templates
   - Test changes on sample files first
   - Update documentation
   - Notify team of changes

---

## Integration with Development Workflow

### Daily Development

```
1. Start work
   ↓
2. BOB creates/opens file with standards applied
   ↓
3. Write code
   ↓
4. BOB validates on save (if configured)
   ↓
5. Fix any violations
   ↓
6. BOB updates modification history
   ↓
7. Commit changes
   ↓
8. BOB validates on commit
```

### Code Review

```
1. Reviewer opens file
   ↓
2. BOB scans for violations
   ↓
3. If violations found:
   - BOB reports issues
   - Developer fixes
   - Re-submit for review
   ↓
4. If compliant:
   - Review logic and design
   - Approve changes
```

### Project Maintenance

**Weekly:**
```
BOB, scan the project and generate a compliance report
```

**Monthly:**
```
BOB, list all files with deprecated syntax
BOB, show files that haven't been updated in 6 months
```

**Quarterly:**
```
BOB, analyze the project for modernization opportunities
BOB, suggest improvements to coding standards
```

---

## Advanced Usage

### Custom Scanning Rules

Add custom rules to `.bob-config.json`:

```json
"codeScanning": {
  "rules": {
    "customRule1": {
      "severity": "warning",
      "pattern": "SELECT \\*",
      "message": "Avoid SELECT *, specify columns explicitly",
      "autoFix": false
    }
  }
}
```

### Batch Operations

Process multiple files:
```
BOB, apply standards to all RPGLE files in the codesamples directory
BOB, fix comment separators in all CL programs
BOB, update modification history for all files changed this week
```

### Integration with Git Hooks

Configure pre-commit hook:
```bash
#!/bin/bash
# .git/hooks/pre-commit

echo "Running BOB standards check..."
bob scan --staged --fail-on-error

if [ $? -ne 0 ]; then
  echo "Standards violations found. Commit blocked."
  echo "Run 'bob fix --staged' to auto-fix issues."
  exit 1
fi
```

---

## Quick Reference

### Most Common Commands

```
# Create new file
BOB, create a new RPGLE program called MYPGM

# Fix standards
BOB, apply standards to this file
BOB, fix comment separators

# Update documentation
BOB, update modification history - added error handling
BOB, add missing copyright

# Modernize code
BOB, modernize this RPG code
BOB, convert this to fully-free format

# Validate
BOB, scan this file for violations
BOB, validate Rules.mk

# Project-wide
BOB, scan the project
BOB, list non-compliant files
```

---

## Support

### Getting Help

**Ask BOB:**
```
BOB, explain the coding standards for RPGLE
BOB, show me examples of proper CLLE documentation
BOB, what are the Rules.mk best practices?
```

**Documentation:**
- `CODING_STANDARDS.md` - Complete standards reference
- `.bob-config.json` - Configuration details
- `templates/` - Template examples

**Resources:**
- [Nick Litten's Blog](https://www.nicklitten.com)
- [CODE FOR IBM i](https://marketplace.visualstudio.com/items?itemName=HalcyonTechLtd.code-for-ibmi)
- [IBM i Documentation](https://www.ibm.com/docs/en/i)

---

## Version History

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| V.001 | 2026-05-12 | Nick Litten | Initial creation of BOB usage guide |

---

**End of Guide**