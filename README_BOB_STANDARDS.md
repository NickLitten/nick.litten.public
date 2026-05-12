# IBM i Coding Standards & BOB Configuration

## Quick Start

This project uses comprehensive coding standards and BOB (AI assistant) integration to maintain high-quality IBM i code.

### 📚 Documentation Files

| File | Purpose |
|------|---------|
| **[CODING_STANDARDS.md](CODING_STANDARDS.md)** | Complete coding standards for all IBM i languages |
| **[BOB_USAGE_GUIDE.md](BOB_USAGE_GUIDE.md)** | How to use BOB for standards enforcement |
| **[RULES_MK_GUIDE.md](RULES_MK_GUIDE.md)** | MAKEI build system configuration guide |
| **[.bob-config.json](.bob-config.json)** | BOB configuration file |

### 🎯 Key Principles

1. **Comment Separator**: Always use `-` (dash), never `=` (equals)
2. **Author**: All code by Nick Litten
3. **Copyright**: RPGLE/CLLE must include copyright statement with version
4. **Documentation**: Triple-slash (`///`) for RPGLE, block comments (`/* */`) for CLLE
5. **Modern Syntax**: Fully-free format, no deprecated opcodes

### 🚀 Quick Commands

```bash
# Create new RPGLE program
BOB, create a new RPGLE program called MYPGM

# Apply standards to current file
BOB, apply standards to this file

# Fix comment separators
BOB, fix comment separators

# Update modification history
BOB, update modification history - added error handling

# Scan project for violations
BOB, scan the project for standards violations

# Build project
makei build
```

### 📁 Templates

All templates are in the `templates/` directory:

- `rpgle-header-template.txt` - RPGLE/SQLRPGLE programs
- `clle-header-template.txt` - CL programs
- `cmd-header-template.txt` - Command definitions
- `dds-header-template.txt` - DDS files (PF/LF/DSPF/PRTF)
- `sql-header-template.txt` - SQL objects (TABLE/VIEW)
- `bnd-header-template.txt` - Binder source
- `bnddir-header-template.txt` - Binding directories

### 🔍 Code Scanning

BOB automatically scans for:

- ❌ Missing or outdated headers
- ❌ Incorrect comment separators (= instead of -)
- ❌ Missing copyright statements
- ❌ Deprecated syntax (MOVE, GOTO, etc.)
- ❌ Inconsistent indentation
- ❌ Lines exceeding maximum length

### ✅ Standards Compliance

Before committing code, ensure:

- [ ] Proper header block with all required elements
- [ ] Comment separator is `-` not `=`
- [ ] Copyright statement included (RPGLE/CLLE)
- [ ] Modification history is up to date
- [ ] Version number is correct
- [ ] Code follows language-specific standards
- [ ] No deprecated syntax (RPGLE)
- [ ] Indentation is consistent

### 📖 Example: RPGLE Header

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
```

### 📖 Example: CLLE Header

```clle
/* Program: MYPGM                                                           */
/*                                                                          */
/* Description: Process customer orders                                    */
/*                                                                          */
/* Modification History:                                                    */
/*   V.001 2026-05-12 | Nick Litten | Initial creation                     */

             PGM        PARM(&PARM1)

             DCLPRCOPT  LOG(*NO) DFTACTGRP(*NO) ACTGRP(*CALLER)

             COPYRIGHT  TEXT('V.001 - Process customer orders')
             DCL        VAR(&COPYRIGHT) TYPE(*CHAR) LEN(256) +
                          VALUE('Nick Litten © 2025 | IBM i V7.5 https://www.nicklitten.com')
```

### 🏗️ Build System

The project uses MAKEI with `Rules.mk` files:

```makefile
# Root Rules.mk - defines global settings and subdirectories
%.PGM: private TGTRLS := V7R4M0
%.PGM: private ACTGRP := NICKLITTEN
SUBDIRS = database binders services codesamples

# Subdirectory Rules.mk - defines objects to build
OBJECTS = MYPGM.PGM MYFILE.FILE
MYPGM.PGM: MYFILE.FILE
```

### 🤖 BOB Integration

BOB is configured via `.bob-config.json` to:

- Apply templates automatically on file creation
- Scan for standards violations on save
- Auto-fix common issues (comment separators, indentation)
- Update modification history
- Calculate version numbers
- Enforce modern syntax

### 📞 Support

- **Documentation**: See the three main guide files
- **Configuration**: Edit `.bob-config.json`
- **Templates**: Modify files in `templates/` directory
- **Questions**: Ask BOB for help

### 🔗 Resources

- [Nick Litten's Blog](https://www.nicklitten.com)
- [CODE FOR IBM i Extension](https://marketplace.visualstudio.com/items?itemName=HalcyonTechLtd.code-for-ibmi)
- [IBM i Documentation](https://www.ibm.com/docs/en/i)

---

## Version History

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| V.001 | 2026-05-12 | Nick Litten | Initial creation of standards system |

---

**For detailed information, see the individual guide files.**