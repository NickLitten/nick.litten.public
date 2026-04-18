# BOB AI Assistant - IBM i Coding Standards System

## Overview

This directory contains the complete coding standards system for the NICKLITTEN IBM i development project. BOB (your AI assistant) uses these standards to ensure consistent, high-quality code across all IBM i languages.

---

## Directory Structure

```
.bob/
├── README.md                    # This file - system documentation
├── CRITICAL-RULES.md            # ⚠️ MANDATORY rules - READ FIRST
├── coding-standards.md          # Complete coding standards reference
├── bob-profile.md               # BOB AI assistant profile and behavior
├── config.json                  # BOB configuration and rules
├── scripts/                     # Helper scripts
│   ├── calculate-version.js    # Calculate version from modification history
│   └── update-copyright.js     # Update copyright statements
└── templates/                   # (Reference only - actual templates in /templates)
```

---

## Quick Start

### For Developers

1. **Review Critical Rules**: Read [`CRITICAL-RULES.md`](CRITICAL-RULES.md) first - these are mandatory
2. **Review the Standards**: Read [`coding-standards.md`](coding-standards.md) for complete guidelines
3. **Use Templates**: Copy from `/templates` directory when creating new files
4. **Let BOB Help**: BOB automatically applies standards when you ask for code reviews or modifications

### For BOB AI Assistant

⚠️ **CRITICAL**: Before ANY task, review [`CRITICAL-RULES.md`](CRITICAL-RULES.md)

When working with code in this project:

1. **ALWAYS reference** [`CRITICAL-RULES.md`](CRITICAL-RULES.md) - these rules are MANDATORY
2. **Always reference** [`config.json`](config.json) for project-specific rules
3. **Apply standards** from [`coding-standards.md`](coding-standards.md)
4. **Follow profile** in [`bob-profile.md`](bob-profile.md)
5. **Use templates** from `/templates` directory for new files
6. **Calculate versions** using modification history count
7. **Update copyright** statements with correct version and description
8. **Use "Nick Litten"** as author name in ALL files
9. **Use `-` (hyphen)** for line separators, NEVER `=` (equals)

---

## Key Features

### 1. Automatic Standards Enforcement

BOB automatically checks and enforces:
- ✅ Proper documentation headers (/// for RPGLE/SQLRPGLE, /* */ for CLLE)
- ✅ Line separators use `-` (hyphen), NEVER `=` (equals)
- ✅ Author name is "Nick Litten" in all files
- ✅ Copyright statements with version numbers
- ✅ Modification history tracking
- ✅ Proper code structure and formatting
- ✅ Naming conventions
- ✅ Best practices for each language

### 2. Version Management

Version numbers are **automatically calculated** from modification history:
- Count entries in "Modification History" section
- Format as `V.XXX` (e.g., V.000, V.001, V.042)
- Initial version is always `V.000`
- Each modification entry increments the version

**Example:**
```rpgle
/// Modification History:
///   V.000 2020-03-14 | Nick Litten | Initial creation
///   V.001 2021-05-20 | Nick Litten | Added error handling
///   V.002 2026-04-18 | Bob AI | Enhanced documentation
```
Current version: **V.002** (3 entries = version 2)

### 3. Copyright Statements

**RPGLE/SQLRPGLE Format:**
```rpgle
ctl-opt
  copyright('PROGNAME | V.XXX | Brief description')
  ;
```

**CLLE Format:**
```clle
COPYRIGHT TEXT('PROGNAME Ver:XXX Brief description')
```

### 4. Documentation Standards

All files MUST include:
- **Program/File Name**: Clear identifier
- **Description**: Comprehensive explanation
- **Purpose**: Bullet list of key concepts
- **Features**: Specific capabilities
- **Usage**: How to use the program
- **Modification History**: All changes with dates

---

## Templates

Templates are located in the `/templates` directory:

| Template | Description | Use For |
|----------|-------------|---------|
| [`template.rpgle`](../templates/template.rpgle) | Free-format RPG | New RPG programs |
| [`template.sqlrpgle`](../templates/template.sqlrpgle) | SQL RPG | Programs using embedded SQL |
| [`template.clle`](../templates/template.clle) | CL programs | Control language programs |
| [`template.dspf`](../templates/template.dspf) | Display files | Screen definitions |
| [`template.pf`](../templates/template.pf) | Physical files | DDS database files |
| [`template.table`](../templates/template.table) | SQL tables | DDL table definitions |
| [`template.cmd`](../templates/template.cmd) | Commands | Command definitions |
| [`template.bnd`](../templates/template.bnd) | Binder source | Service program exports |

---

## Helper Scripts

### Calculate Version

Calculate version number from modification history:

```bash
node .bob/scripts/calculate-version.js path/to/file.rpgle
```

**Output:**
```json
{
  "filepath": "path/to/file.rpgle",
  "fileType": "rpgle",
  "modificationCount": 3,
  "version": "V.002"
}
```

### Update Copyright

Update copyright statement with version and description:

```bash
node .bob/scripts/update-copyright.js path/to/file.rpgle V.042 "Program Description"
```

**Output:**
```json
{
  "success": true,
  "filepath": "path/to/file.rpgle",
  "programName": "PROGNAME",
  "version": "V.042",
  "description": "Program Description",
  "fileType": "rpgle"
}
```

---

## BOB Configuration

The [`config.json`](config.json) file controls BOB's behavior:

### Key Settings

```json
{
  "coding_standards": {
    "enabled": true,
    "auto_apply": true,
    "strict_mode": false
  },
  "version_control": {
    "auto_calculate_version": true,
    "version_format": "V.XXX",
    "initial_version": "V.000"
  },
  "auto_corrections": {
    "enabled": true,
    "insert_missing_header": true,
    "update_copyright_version": true,
    "fix_indentation": true
  }
}
```

---

## Code Review Rules

BOB automatically checks for:

### Documentation Issues
- ❌ Missing header documentation
- ❌ Missing modification history
- ❌ Incomplete descriptions
- ⚠️ Missing purpose or features sections

### Code Quality Issues
- ❌ Magic numbers (use named constants)
- ❌ Hardcoded values
- ❌ Missing error handling
- ⚠️ Inconsistent naming conventions
- ℹ️ Missing comments for complex logic

### Best Practices
- ❌ Fixed-format RPG (must use free format)
- ⚠️ No main procedure pattern
- ⚠️ Unqualified data structures
- ⚠️ Missing SQL options
- ⚠️ No activation group specified

---

## Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Programs | UPPERCASE | `HELLOADV`, `SAMPLESFL` |
| Procedures | PascalCase | `LoadSubfilePage`, `ProcessSelections` |
| Variables | camelCase | `currentPage`, `totalRecords` |
| Constants | UPPER_SNAKE_CASE | `PAGE_SIZE`, `SQL_SUCCESS` |
| Data Structures | PascalCase + qualified | `Indicators qualified` |
| File Fields | UPPERCASE | `SFLSEL`, `CCODE` |

---

## Line Separator Character

**Always use `-` (hyphen/dash)** as the line separator:

```rpgle
// ------------------------------------------------------------------------------
// Section Title
// ------------------------------------------------------------------------------
```

```clle
/* ------------------------------------------------------------------------------
   Section Title
   ------------------------------------------------------------------------------ */
```

```
      * ----------------------------------------------------------------------------
      * Section Title
      * ----------------------------------------------------------------------------
```

---

## Usage Examples

### Creating a New Program

1. Copy appropriate template from `/templates`
2. Replace placeholders (PROGNAME, descriptions, etc.)
3. Add your code
4. BOB will automatically validate and suggest improvements

### Updating Existing Code

1. Ask BOB to review the code
2. BOB will identify standards violations
3. BOB will suggest or apply corrections
4. Version number updates automatically

### Adding Modification History

When you modify a file, add an entry:

```rpgle
/// Modification History:
///   V.000 2020-03-14 | Nick Litten | Initial creation
///   V.001 2026-04-18 | Your Name | Description of changes
```

BOB will calculate the new version (V.001) and update the copyright statement.

---

## Integration with Development Tools

### VS Code

- Templates available via snippets
- BOB provides real-time suggestions
- Automatic formatting on save (if configured)

### Git

- Version numbers track with commits
- Modification history provides change log
- Standards ensure consistent code reviews

---

## Maintenance

### Updating Standards

1. Edit [`coding-standards.md`](coding-standards.md)
2. Update [`config.json`](config.json) if rules change
3. Notify team of changes
4. BOB will apply new standards going forward

### Adding New Templates

1. Create template in `/templates` directory
2. Add entry to [`config.json`](config.json) under `templates.files`
3. Document in this README
4. Update [`coding-standards.md`](coding-standards.md) if needed

---

## Troubleshooting

### BOB Not Applying Standards

1. Check [`config.json`](config.json) - ensure `enabled: true`
2. Verify file patterns match your files
3. Check exclusions - file might be excluded

### Version Calculation Issues

1. Ensure modification history uses correct format
2. Run `calculate-version.js` script manually to test
3. Check for proper date format: `YYYY-MM-DD`

### Copyright Not Updating

1. Verify copyright statement exists in file
2. Check file type detection
3. Run `update-copyright.js` script manually

---

## Support

For questions or issues:

1. Review [`coding-standards.md`](coding-standards.md)
2. Check this README
3. Ask BOB for help
4. Visit [Nick Litten's Blog](https://www.nicklitten.com)

---

## References

- [IBM i Documentation](https://www.ibm.com/docs/en/i)
- [RPG Cafe](https://www.rpgpgm.com)
- [Nick Litten's Blog](https://www.nicklitten.com)
- [Modern RPG Best Practices](https://www.nicklitten.com/category/rpg/)

---

**Last Updated:** 2026-04-18  
**Version:** 1.0  
**Maintained By:** Nick Litten / BOB AI Assistant