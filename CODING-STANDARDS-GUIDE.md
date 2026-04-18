# IBM i Coding Standards - Quick Reference Guide

## 🎯 Purpose

This guide provides quick reference for the NICKLITTEN project coding standards. For complete details, see [`.bob/coding-standards.md`](.bob/coding-standards.md).

---

## 📋 Quick Checklist

Before committing code, ensure:

- [ ] Triple-slash (`///`) header documentation present
- [ ] Copyright statement with correct version
- [ ] Modification history entry added
- [ ] Purpose and Features sections complete
- [ ] No magic numbers (use named constants)
- [ ] Proper error handling
- [ ] Consistent naming conventions
- [ ] Line separator character is `-` (hyphen)

---

## 🚀 Getting Started

### 1. Use Templates

Copy from `/templates` directory:
- `template.rpgle` - Free-format RPG programs
- `template.sqlrpgle` - SQL RPG programs
- `template.clle` - CL programs
- `template.dspf` - Display files
- `template.pf` - Physical files
- `template.table` - SQL tables
- `template.cmd` - Commands
- `template.bnd` - Binder source

### 2. Documentation Format

All files use **triple-slash format** (`///`):

```rpgle
///
/// Program: PROGNAME - Brief Title
///
/// Description: Comprehensive explanation of purpose
///
/// Purpose: Educational/Production utility demonstrating:
///   - Key concept #1
///   - Key concept #2
///
/// Features:
///   - Specific capability #1
///   - Specific capability #2
///
/// Usage: CALL PROGNAME
///
/// Modification History:
///   V.000 YYYY-MM-DD | Author | Initial creation
///
```

### 3. Copyright Statements

**RPGLE/SQLRPGLE:**
```rpgle
ctl-opt
  copyright('PROGNAME | V.XXX | Description')
  ;
```

**CLLE:**
```clle
COPYRIGHT TEXT('PROGNAME Ver:XXX Description')
```

---

## 📊 Version Management

Version = Count of modification history entries

| Entries | Version | Format |
|---------|---------|--------|
| 1 | V.000 | Initial |
| 2 | V.001 | First update |
| 43 | V.042 | 43rd version |

**Example:**
```rpgle
/// Modification History:
///   V.000 2020-03-14 | Nick Litten | Initial creation
///   V.001 2021-05-20 | Nick Litten | Added error handling
///   V.002 2026-04-18 | Bob AI | Enhanced documentation
```
Current version: **V.002**

---

## 🎨 Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Programs | UPPERCASE | `HELLOADV` |
| Procedures | PascalCase | `LoadSubfilePage` |
| Variables | camelCase | `currentPage` |
| Constants | UPPER_SNAKE_CASE | `PAGE_SIZE` |
| Data Structures | PascalCase + qualified | `Indicators qualified` |

---

## 📐 Line Separators

**Always use `-` (hyphen) as separator:**

**RPGLE:**
```rpgle
// ------------------------------------------------------------------------------
// Section Title
// ------------------------------------------------------------------------------
```

**CLLE:**
```clle
/* ------------------------------------------------------------------------------
   Section Title
   ------------------------------------------------------------------------------ */
```

**DDS:**
```
      * ----------------------------------------------------------------------------
      * Section Title
      * ----------------------------------------------------------------------------
```

---

## 🔧 BOB AI Assistant

BOB automatically:
- ✅ Validates documentation standards
- ✅ Calculates version numbers
- ✅ Updates copyright statements
- ✅ Suggests improvements
- ✅ Enforces best practices

### Ask BOB to:
- Review code for standards compliance
- Add missing documentation
- Update version numbers
- Modernize legacy code
- Apply templates to new files

---

## 📚 Language-Specific Standards

### RPGLE/SQLRPGLE

**Required:**
- `**free` format (no fixed format)
- `main(mainline)` procedure pattern
- Named constants (no magic numbers)
- Qualified data structures
- Section separators with `// ======`

**Example:**
```rpgle
**free

ctl-opt
  main(mainline)
  copyright('PROGNAME | V.000 | Description')
  ;

// ------------------------------------------------------------------------------
// Named Constants
// ------------------------------------------------------------------------------
dcl-C PAGE_SIZE 20;

// ------------------------------------------------------------------------------
// Main Program Logic
// ------------------------------------------------------------------------------
dcl-Proc mainline;
  // Code here
  *inlr = *on;
end-proc;
```

### CLLE

**Required:**
- Block comment header with right-aligned `*/` on each line
- `DCLPRCOPT LOG(*NO) DFTACTGRP(*NO) ACTGRP(*CALLER)`
- COPYRIGHT statement
- Labeled error handling sections
- MONMSG for specific errors

**Example:**
```clle
/* Program: PROGNAME - Description                                         */
/*                                                                          */
/* Modification History:                                                    */
/* V.000 YYYY-MM-DD | Author | Initial creation                            */

PGM        PARM(&PARM1 &RESULT)

DCLPRCOPT  LOG(*NO) DFTACTGRP(*NO) ACTGRP(*CALLER)

COPYRIGHT  TEXT('PROGNAME Ver:000 Description')

/* Program logic */

CLEANUP:
RETURN
ENDPGM
```

### SQL Tables

**Required:**
- Header with `--` comments
- `CREATE OR REPLACE TABLE`
- `LABEL ON TABLE` and `LABEL ON COLUMN`
- Appropriate indexes
- Comments for complex logic

**Example:**
```sql
-- ------------------------------------------------------------------------------
-- Table: TABLENAME - Description
-- ------------------------------------------------------------------------------

CREATE OR REPLACE TABLE LIBRARY.TABLENAME (
    FIELD1 CHAR(10) NOT NULL,
    FIELD2 VARCHAR(100),
    PRIMARY KEY (FIELD1)
);

LABEL ON TABLE LIBRARY.TABLENAME IS 'Description';
```

---

## 🛠️ Helper Scripts

### Calculate Version
```bash
node .bob/scripts/calculate-version.js path/to/file.rpgle
```

### Update Copyright
```bash
node .bob/scripts/update-copyright.js path/to/file.rpgle V.042 "Description"
```

---

## 📖 Resources

- **Complete Standards**: [`.bob/coding-standards.md`](.bob/coding-standards.md)
- **BOB Configuration**: [`.bob/config.json`](.bob/config.json)
- **System Documentation**: [`.bob/README.md`](.bob/README.md)
- **Templates**: [`/templates`](templates/)
- **Nick Litten's Blog**: https://www.nicklitten.com

---

## 🎓 Best Practices

### DO:
- ✅ Use templates for new files
- ✅ Add modification history entries
- ✅ Use named constants
- ✅ Document all procedures
- ✅ Handle errors properly
- ✅ Use modern free-format RPG
- ✅ Let BOB help with standards

### DON'T:
- ❌ Use magic numbers
- ❌ Skip documentation
- ❌ Use fixed-format RPG
- ❌ Hardcode values
- ❌ Ignore error handling
- ❌ Use inconsistent naming
- ❌ Forget version updates

---

## 💡 Tips

1. **Start with Templates**: Always copy from `/templates` directory
2. **Let BOB Review**: Ask BOB to review before committing
3. **Update History**: Add entry for every significant change
4. **Use Constants**: Replace all magic numbers with named constants
5. **Document Why**: Explain complex logic in comments
6. **Test Standards**: Run helper scripts to verify compliance

---

## 🆘 Common Issues

### Missing Header
**Problem**: File has no documentation header  
**Solution**: Copy from appropriate template or ask BOB to add

### Wrong Version
**Problem**: Version doesn't match modification count  
**Solution**: Run `calculate-version.js` or ask BOB to update

### Magic Numbers
**Problem**: Hardcoded values in code  
**Solution**: Create named constants with descriptive names

### Fixed Format
**Problem**: Using old column-based RPG  
**Solution**: Convert to `**free` format or ask BOB to modernize

---

**Last Updated:** 2026-04-18  
**Maintained By:** Nick Litten / BOB AI Assistant

For questions, ask BOB or visit https://www.nicklitten.com