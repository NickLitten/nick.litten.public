# Nick Litten's IBM i Code Repository

A comprehensive collection of modern IBM i development examples, utilities, and best practices using RPGLE, SQLRPGLE, CL, and SQL.

## 🎯 Overview

This repository demonstrates modern IBM i programming techniques with fully-free format code, comprehensive documentation, and automated standards enforcement through BOB (AI assistant) integration.

**Author:** Nick Litten  
**Website:** [nicklitten.com](https://www.nicklitten.com)  
**Target Platform:** IBM i V7.4M0+  
**Build System:** MAKEI with CODE FOR IBM i

---

## 📚 Documentation

| Document | Description |
|----------|-------------|
| **[CODING_STANDARDS.md](CODING_STANDARDS.md)** | Complete coding standards for all IBM i languages |
| **[BOB_USAGE_GUIDE.md](BOB_USAGE_GUIDE.md)** | How to use BOB AI assistant for standards enforcement |
| **[RULES_MK_GUIDE.md](RULES_MK_GUIDE.md)** | MAKEI build system configuration guide |
| **[AGENTS.md](AGENTS.md)** | Quick reference for AI agents working with this code |

---

## 🚀 Quick Start

### Prerequisites

- IBM i V7.4M0 or higher
- [CODE FOR IBM i](https://marketplace.visualstudio.com/items?itemName=HalcyonTechLtd.code-for-ibmi) VS Code extension
- MAKEI build system

### Building the Project

```bash
# Build entire project
makei build

# Build specific file
makei compile -f MYPGM.pgm.rpgle

# Build specific subdirectory
cd codesamples && makei build

# Clean build artifacts
makei clean
```

---

## 📁 Repository Structure

```
nick.litten.public/
├── .bob/                      # BOB configuration and standards
│   ├── templates/             # Code templates for all languages
│   ├── standards/             # Coding standards YAML files
│   └── scripts/               # Automation scripts
├── binders/                   # Binding directories
├── code_starters/             # Template files for new programs
├── codesamples/               # Example programs organized by topic
│   ├── hello_world/           # Basic examples
│   ├── conversion/            # Data conversion examples
│   ├── webservice/            # Web service consumption
│   ├── security/              # Security and password monitoring
│   ├── email_*/               # Email utilities
│   └── ...                    # Many more examples
├── database/                  # Database files and tables
├── includes/                  # Copybooks and include files
│   ├── modern/                # Modern API prototypes
│   └── legacy/                # Legacy API prototypes
├── services/                  # Service programs
├── CODING_STANDARDS.md        # Complete coding standards
├── BOB_USAGE_GUIDE.md         # BOB usage guide
├── RULES_MK_GUIDE.md          # Build system guide
└── Rules.mk                   # Root build configuration
```

---

## 💡 Featured Examples

### Hello World Series
- **HELLOWORLD** - Simple "Hello World" program
- **HELLOINC** - Using copybooks/includes
- **HELLOADV** - Advanced features demonstration

### Data Conversion
- **CONVERT1-4** - Progressive modernization examples
- **CONVSRV** - Conversion service program
- Demonstrates EBCDIC to ASCII conversion

### Web Services
- **SIMPWEBSQL** - Simple web service consumption
- **JSNIFSSQL** - JSON parsing with SQL
- **WEBFOOD** - Complete web service example

### Security
- **PWDEXPMON** - Password expiration monitoring
- **SCHEDULE** - Automated job scheduling
- Demonstrates security best practices

### Email Utilities
- **EMLCSVFILE** - Email CSV files
- **EMLOUTQ** - Email output queue contents

### Database Examples
- **SQLREAD** - Dynamic SQL file reading
- **SAMPLESFL** - Subfile with SQL
- **STOREPRC*** - Stored procedure examples

---

## 🎨 Coding Standards

### Key Principles

1. **Comment Separator**: Always use `-` (dash), never `=` (equals)
2. **Modern Syntax**: Fully-free format (`**free`), no deprecated opcodes
3. **Documentation**: Triple-slash (`///`) for RPGLE, block comments for CL
4. **Copyright**: Include version and description in all programs
5. **Modification History**: Track all changes with version numbers

### Example RPGLE Header

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

### Example CL Header

```clle
/* Program: MYPGM                                                           */
/*                                                                          */
/* Description: Process customer orders                                    */
/*                                                                          */
/* Modification History:                                                    */
/*   V.001 2026-05-12 | Nick Litten | Initial creation                     */

             PGM

             DCLPRCOPT  LOG(*NO) DFTACTGRP(*NO) ACTGRP(*CALLER)

             COPYRIGHT  TEXT('V.001 - Process customer orders')
             DCL        VAR(&COPYRIGHT) TYPE(*CHAR) LEN(256) +
                          VALUE('Nick Litten © 2025 | IBM i V7.5')
```

---

## 🤖 BOB Integration

BOB (AI assistant) is configured to automatically:

- Apply templates when creating new files
- Scan for standards violations
- Auto-fix common issues (comment separators, indentation)
- Update modification history
- Calculate version numbers
- Enforce modern syntax

### Common BOB Commands

```
# Create new file
BOB, create a new RPGLE program called MYPGM

# Apply standards
BOB, apply standards to this file

# Fix issues
BOB, fix comment separators

# Update history
BOB, update modification history - added error handling

# Scan project
BOB, scan the project for standards violations
```

---

## 🏗️ Build System

The project uses MAKEI with hierarchical `Rules.mk` files:

### Root Rules.mk
Defines global settings and subdirectory build order:

```makefile
%.PGM: private TGTRLS := V7R4M0
%.PGM: private ACTGRP := NICKLITTEN

SUBDIRS = database binders services codesamples
```

### Subdirectory Rules.mk
Defines objects to build and dependencies:

```makefile
OBJECTS = MYPGM.PGM MYFILE.FILE

MYPGM.PGM: MYFILE.FILE
```

See [RULES_MK_GUIDE.md](RULES_MK_GUIDE.md) for complete details.

---

## 📦 Key Components

### Binding Directories
- **NICKLITTEN** - Main binding directory for project
- **SIMPLEBND** - Simple example binding directory
- **PWDMON** - Password monitoring binding directory

### Service Programs
Located in `services/` directory - reusable code modules

### Database Files
Located in `database/` directory:
- Physical files (`.pf`)
- Logical files (`.lf`)
- SQL tables (`.table`)

### Include Files
Located in `includes/` directory:
- **modern/** - Modern API prototypes (fully-free format)
- **legacy/** - Legacy API prototypes (for reference)
- Standard copybooks and data structures

---

## 🎓 Learning Path

### Beginner
1. Start with `codesamples/hello_world/`
2. Review `CODING_STANDARDS.md`
3. Explore `code_starters/` templates

### Intermediate
1. Study `codesamples/conversion/` for modernization techniques
2. Review `codesamples/sqlrpgle_dynamic/` for SQL examples
3. Explore `codesamples/subfile/` for interactive programs

### Advanced
1. Study `codesamples/webservice/` for API integration
2. Review `services/` for service program patterns
3. Explore `codesamples/security/` for security implementations

---

## 🔧 Development Workflow

### Creating New Programs

1. Use BOB to create from template:
   ```
   BOB, create a new RPGLE program called MYPGM
   ```

2. BOB will:
   - Apply appropriate template
   - Fill in author and date
   - Create modification history
   - Add copyright statement

3. Write your code following standards

4. BOB validates on save (if configured)

### Modifying Existing Programs

1. Make your changes

2. Update modification history:
   ```
   BOB, update modification history - added error handling
   ```

3. BOB will:
   - Increment version number
   - Add history entry
   - Update copyright statement

4. Validate before commit:
   ```
   BOB, scan this file for violations
   ```

---

## ✅ Standards Compliance Checklist

Before committing code:

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
- [ ] Rules.mk updated if new objects added

---

## 🌟 Best Practices

### Modern RPG
- Use fully-free format (`**free`)
- Avoid deprecated opcodes (MOVE, GOTO, Z-ADD, etc.)
- Use built-in functions (%TRIM, %SUBST, %SCAN)
- Prefer SQL over native I/O when appropriate
- Use proper error handling

### Documentation
- Document purpose and usage
- Include modification history
- Add inline comments for complex logic
- Use descriptive variable names

### Build System
- Keep Rules.mk simple
- Document overrides
- Maintain proper dependency order
- Use consistent naming

---

## 🔗 Resources

- **Blog:** [nicklitten.com](https://www.nicklitten.com)
- **CODE FOR IBM i:** [VS Code Extension](https://marketplace.visualstudio.com/items?itemName=HalcyonTechLtd.code-for-ibmi)
- **IBM i Documentation:** [IBM Docs](https://www.ibm.com/docs/en/i)
- **MAKEI Build System:** [GitHub](https://github.com/IBM/ibmi-bob)

---

## 📄 License

This code is provided as educational examples and utilities for IBM i development.

**Copyright © 2025 Nick Litten**  
**Website:** https://www.nicklitten.com

---

## 🤝 Contributing

This is a personal repository demonstrating IBM i best practices. Feel free to:
- Use these examples in your projects
- Learn from the coding patterns
- Adapt the standards to your needs

---

## 📞 Support

For questions or discussions:
- Visit [nicklitten.com](https://www.nicklitten.com)
- Review the documentation files in this repository
- Use BOB for coding assistance

---

## 📊 Version History

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| V.001 | 2026-05-14 | Nick Litten | Initial README creation |

---

**Happy Coding on IBM i! 🚀**