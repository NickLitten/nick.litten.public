# BOB Configuration for Nick Litten IBM i Project

This directory contains IBM BOB (AI Assistant) configuration files and coding standards for the Nick Litten IBM i project.

---

## Contents

### Coding Standards
- **coding-standards-rpgle.md** - RPG/RPGLE coding standards and best practices
- **coding-standards-clle.md** - CL/CLLE coding standards and best practices
- **coding-standards-dds.md** - DDS coding standards and best practices
- **coding-standards-sql.md** - SQL coding standards and best practices

### Configuration
- **bob-profile.json** - BOB AI assistant configuration and rules
- **README.md** - This file

### Templates (to be created)
- **templates/template.rpgle** - RPGLE program template
- **templates/template.sqlrpgle** - SQLRPGLE program template
- **templates/template-srvpgm.rpgle** - Service program template
- **templates/template.clle** - CLLE program template
- **templates/template.dds** - DDS file template
- **templates/template.sql** - SQL script template

---

## Key Principles

### 1. Comment Separators
**ALWAYS use dash (-) characters for separators, NEVER equals (=)**

✅ Correct:
```
// ------------------------------------------------------------------------------
A*-------------------------------------------------------------------------
/*---------------------------------------------------------------------------*/
-------------------------------------------------------------------------------
```

❌ Incorrect:
```
// ==============================================================================
A*=========================================================================
/*===========================================================================*/
===============================================================================
```

### 2. Comment Styles by Language

#### RPGLE/SQLRPGLE
- **File headers**: Triple-slash (`///`)
- **Procedure headers**: Double-slash (`//`)
- **Inline comments**: Double-slash (`//`)
- **Section separators**: Dash lines with `//`

#### CLLE
- **All comments**: Block style (`/* */`)
- **Section separators**: Dash lines within `/* */`

#### DDS
- **All comments**: Asterisk in position 7 (`A*`)
- **Section separators**: Dash lines with `A*`

#### SQL
- **All comments**: Double-dash (`--`)
- **Section separators**: Dash lines with `--`

### 3. Author Field
**Always use**: `Nick Litten`

### 4. Copyright Statement

#### RPGLE/SQLRPGLE
```rpgle
ctl-opt copyright('v.002 - Brief Description');
```

#### CLLE
```cl
COPYRIGHT TEXT('v.002 - Brief Description')
```

Version number is calculated from modification history count.

### 5. Modification History Format
```
v.001 YYYY.MM.DD - Nick Litten - Initial creation
v.002 YYYY.MM.DD - Nick Litten - Description of change
v.003 YYYY.MM.DD - Nick Litten - Another change
```

---

## BOB Configuration

The `bob-profile.json` file configures BOB's behavior for this project:

### Code Scanning
- Automatically scans code for standards violations
- Checks separator characters (- vs =)
- Validates comment styles
- Ensures copyright statements exist
- Verifies author fields
- Tracks modification history

### Auto-Correction
- Replaces equals (=) with dashes (-) in separators
- Formats comment blocks
- Aligns indentation
- Removes trailing whitespace

### Template Insertion
- Auto-inserts file headers on new files
- Auto-inserts procedure documentation
- Uses placeholders for dynamic content

### Version Control
- Tracks modifications automatically
- Auto-increments version numbers
- Updates copyright statements
- Adds history entries

### Best Practices Enforcement
- Enforces modern RPG syntax
- Requires error handling
- Validates parameter checking
- Promotes qualified data structures
- Encourages meaningful naming

---

## Usage

### For BOB AI Assistant

When BOB processes files in this project, it will:

1. **Read** the appropriate coding standard file
2. **Apply** the rules from bob-profile.json
3. **Check** code against standards
4. **Suggest** or **auto-correct** violations
5. **Insert** proper documentation headers
6. **Update** version and modification history

### For Developers

1. **Review** the coding standards for your language
2. **Use** the templates when creating new files
3. **Follow** the naming conventions
4. **Include** all required documentation sections
5. **Update** modification history when making changes

---

## Standards Summary

### Required in All Files
- [ ] Proper file header with description
- [ ] Author: Nick Litten
- [ ] Modification history
- [ ] Copyright statement (RPGLE/CLLE)
- [ ] Dash (-) separators only
- [ ] Appropriate comment style for language

### RPGLE/SQLRPGLE Specific
- [ ] Triple-slash (///) file headers
- [ ] `ctl-opt copyright('v.XXX - Description')`
- [ ] Modern syntax (dcl-s, dcl-ds, dcl-pi, etc.)
- [ ] Qualified data structures
- [ ] Procedure documentation with examples
- [ ] Error handling (monitor/on-error)

### CLLE Specific
- [ ] Block comments (/* */)
- [ ] `COPYRIGHT TEXT('v.XXX - Description')`
- [ ] Descriptive variable names
- [ ] Error handling (MONMSG)
- [ ] Proper indentation

### DDS Specific
- [ ] Asterisk (A*) comments
- [ ] TEXT keywords for fields and records
- [ ] COLHDG for all fields
- [ ] Proper key specifications
- [ ] Audit fields where appropriate

### SQL Specific
- [ ] Double-dash (--) comments
- [ ] Explicit column lists
- [ ] Transaction control
- [ ] Error handling in procedures
- [ ] Proper constraints and indexes

---

## Examples

See the coding standards files for comprehensive examples of:
- File headers
- Procedure documentation
- Error handling patterns
- Naming conventions
- Best practices

---

## Maintenance

### Adding New Standards
1. Update the appropriate `coding-standards-*.md` file
2. Update `bob-profile.json` if new rules are needed
3. Create or update templates as needed
4. Document changes in this README

### Updating BOB Configuration
1. Edit `bob-profile.json`
2. Test with sample files
3. Document changes in this README

---

## Support

For questions or issues with these standards:
1. Review the coding standards documentation
2. Check the examples in the standards files
3. Consult with the project lead (Nick Litten)

---

## Version History

- v.001 2026.05.06 - Initial creation of BOB configuration and standards