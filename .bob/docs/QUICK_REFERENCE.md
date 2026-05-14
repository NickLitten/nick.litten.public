# IBM i BOB Quick Reference

Fast reference guide for common BOB operations and IBM i development tasks.

## Quick Commands

### BOB Helper

```bash
# Initialize BOB
./scripts/bob-helper.sh init

# Check all standards
./scripts/bob-helper.sh check

# Auto-fix issues
./scripts/bob-helper.sh fix

# Convert legacy headers to triple-slash format
./scripts/bob-helper.sh convert

# Show statistics
./scripts/bob-helper.sh stats

# Validate structure
./scripts/bob-helper.sh validate
```

### Standards Checking

```bash
# Scan for violations
./scripts/scan-standards.sh .

# Check comment blocks
./scripts/ensure-comment-blocks.sh --check .

# Fix comment blocks
./scripts/ensure-comment-blocks.sh --fix .
```

### Make Commands

```bash
make standards    # Run standards checks
make clean        # Clean build artifacts
make help         # Show available targets
```

## File Templates

### Create New Files

Use templates from `templates/ibmi/`:

- `rpgle-template.rpgle` - Free-format RPG
- `sqlrpgle-template.sqlrpgle` - RPG with embedded SQL
- `clle-template.clle` - ILE CL program
- `sql-template.sql` - SQL DDL script
- `cblle-template.cblle` - ILE COBOL
- `pf-template.pf` - Physical file (DDS)
- `lf-template.lf` - Logical file (DDS)
- `dspf-template.dspf` - Display file (DDS)
- `prtf-template.prtf` - Printer file (DDS)
- `cmd-template.cmd` - Command definition

### View Template

```bash
./scripts/bob-helper.sh template rpgle
```

## Common Checks

### RPG/RPGLE

✅ **Required:**
- `ctl-opt` declaration
- Header comment block
- `dftactgrp(*no)`
- Free-format code

❌ **Forbidden:**
- GOTO statements
- Hard-coded QGPL
- Magic numbers
- Global variables

### SQLRPGLE

✅ **Required:**
- All RPG requirements
- SQL error checking
- `exec sql set option`
- Explicit column lists

❌ **Forbidden:**
- `SELECT *`
- Unqualified table names
- String concatenation in SQL

### CL/CLLE

✅ **Required:**
- Header comment block
- MONMSG for error handling
- Descriptive variable names
- `&VAR` for variables

❌ **Forbidden:**
- Hard-coded libraries
- Unmonitored commands

### SQL

✅ **Required:**
- Schema qualification
- Primary keys
- Column comments
- `CREATE OR REPLACE`

❌ **Forbidden:**
- `SELECT *`
- Unqualified names
- Missing WHERE on UPDATE/DELETE

## Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Programs | UPPER_SNAKE_CASE | MY_PROGRAM |
| Procedures | PascalCase | MyProcedure |
| Variables | camelCase | myVariable |
| Constants | UPPER_SNAKE_CASE | MY_CONSTANT |
| Files | UPPER_SNAKE_CASE | MY_FILE |
| Fields | PascalCase | MyField |

## Comment Block Format

### RPG/RPGLE (Triple-Slash Style - Recommended)

```rpgle
///
/// Program: MYPROGRAM - Brief program title
///
/// Description: Detailed description of what the program does.
///
/// Purpose: Educational/Production example demonstrating:
/// - Key concept 1
/// - Key concept 2
///
/// Features:
/// - Feature 1
/// - Feature 2
///
/// Usage: CALL MYPROGRAM
///
/// Modification History:
/// 1.0.0 2026-05-12 | username | Initial creation
///
```

### RPG/RPGLE (Legacy Style - Still Supported)

```rpgle
// ------------------------------------------------------------------
// Project: NickLitten/template
// Member : myprogram.rpgle
// Desc   : Program description
// Author : username
// Date   : 2026-05-12
// ------------------------------------------------------------------
```

### SQL

```sql
-- ------------------------------------------------------------------
-- Project: NickLitten/template
-- Member : myscript.sql
-- Desc   : Script description
-- Author : username
-- Date   : 2026-05-12
-- ------------------------------------------------------------------
```

### CL/CLLE

```cl
/* ---------------------------------------------------------------- */
/* Project: NickLitten/template                                     */
/* Member : myprogram.clle                                          */
/* Desc   : Program description                                     */
/* Author : username                                                */
/* Date   : 2026-05-12                                             */
/* ---------------------------------------------------------------- */
```

## Procedure Documentation

```rpgle
// Procedure: CalculateTotal
// Purpose  : Calculate order total with tax
// Parameters:
//   orderAmount - Base order amount
//   taxRate     - Tax rate as decimal
// Returns  : Total amount including tax
```

## Error Codes

### scan-standards.sh

- `0` - All checks passed
- `1` - Errors found

### ensure-comment-blocks.sh

- `0` - All headers present or fixed
- `1` - Missing headers (check mode)

## VSCode Shortcuts

### Code for IBM i

- `Ctrl+E` - Connect to IBM i
- `Ctrl+Shift+I` - Compile current source
- `Ctrl+Shift+D` - Debug program
- `F12` - Go to definition

### Editing

- `Ctrl+/` - Toggle comment
- `Shift+Alt+F` - Format document
- `Ctrl+Space` - Trigger IntelliSense
- `F2` - Rename symbol

## Git Workflow

### Before Commit

```bash
# Check standards
./scripts/bob-helper.sh check

# Fix issues
./scripts/bob-helper.sh fix

# Stage changes
git add .

# Commit
git commit -m "feat: Add new feature"
```

### Commit Message Format

```
<type>: <description>

Types: feat, fix, docs, style, refactor, test, chore
```

Examples:
- `feat: Add customer lookup procedure`
- `fix: Correct tax calculation logic`
- `docs: Update API documentation`
- `refactor: Simplify error handling`

## Profiles

### Switch Profile

Edit `.bob-profile.json` and set `"active": true` for desired profile:

- `modern-rpg-dev` - Development (auto-fix enabled)
- `modern-rpg-ci` - CI/CD (strict checking)
- `legacy-maintenance` - Legacy code (relaxed rules)

## Troubleshooting

### Permission Denied

```bash
chmod +x scripts/*.sh
```

### Line Ending Issues

```bash
dos2unix scripts/*.sh
```

### BOB Not Found

```bash
# Ensure in project root
cd /path/to/project

# Verify profile exists
ls -la .bob-profile.json
```

## Environment Variables

```bash
# Set project name
export PROJECT_NAME="NickLitten/template"

# Set author name
export AUTHOR_NAME="Your Name"

# Enable verbose output
export VERBOSE=true
```

## File Extensions

| Extension | Language | Description |
|-----------|----------|-------------|
| .rpgle | RPG | Free-format RPG |
| .sqlrpgle | RPG | RPG with embedded SQL |
| .clle | CL | ILE Control Language |
| .cblle | COBOL | ILE COBOL |
| .sql | SQL | SQL scripts |
| .pf | DDS | Physical file |
| .lf | DDS | Logical file |
| .dspf | DDS | Display file |
| .prtf | DDS | Printer file |
| .cmd | CMD | Command definition |
| .bnd | Binder | Binding directory |

## Resources

- [Full Documentation](BOB_SETUP_GUIDE.md)
- [Coding Standards](CODING_STANDARDS.md)
- [IBM i Docs](https://www.ibm.com/docs/en/i)
- [Code for IBM i](https://marketplace.visualstudio.com/items?itemName=HalcyonTechLtd.code-for-ibmi)

---

**Quick Tip:** Run `./scripts/bob-helper.sh help` for more commands!
