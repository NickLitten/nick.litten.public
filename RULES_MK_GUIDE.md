# Rules.mk Guide for IBM i MAKEI Build System

## Overview

This guide explains how to create and maintain `Rules.mk` files for the NICKLITTEN project using the MAKEI build system with CODE FOR IBM i.

**Version:** 1.0.0  
**Last Updated:** 2026-05-12  
**Build System:** MAKEI  
**Target Platform:** IBM i V7R4M0

---

## Table of Contents

1. [Introduction](#introduction)
2. [File Structure](#file-structure)
3. [Root Level Rules.mk](#root-level-rulesmk)
4. [Subdirectory Rules.mk](#subdirectory-rulesmk)
5. [Object Types](#object-types)
6. [Build Variables](#build-variables)
7. [Dependencies](#dependencies)
8. [Best Practices](#best-practices)
9. [Common Patterns](#common-patterns)
10. [Troubleshooting](#troubleshooting)

---

## Introduction

### What is Rules.mk?

`Rules.mk` is a makefile used by the MAKEI build system to define:
- Which objects to build
- How to build them (compile options)
- Build order (dependencies)
- Target settings (release, optimization, etc.)

### Hierarchy

```
project-root/
├── Rules.mk                    # Root level - defines subdirectories
├── database/
│   └── Rules.mk               # Database objects
├── binders/
│   └── Rules.mk               # Binding directories
├── services/
│   └── Rules.mk               # Service programs
└── codesamples/
    └── Rules.mk               # Sample programs
```

### Build Commands

```bash
# Build entire project
makei build

# Build specific file
makei compile -f MYPGM.pgm.rpgle

# Clean build artifacts
makei clean

# Build specific subdirectory
cd codesamples && makei build
```

---

## Root Level Rules.mk

### Purpose

The root `Rules.mk` defines:
1. Global build settings (defaults for all objects)
2. Subdirectories to process
3. Build order (dependency sequence)

### Standard Template

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

### Key Sections

#### 1. Target Release

```makefile
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.SRVPGM: private TGTRLS := V7R4M0
```

- Sets the IBM i release level for compiled objects
- Use `V7R4M0` for IBM i 7.4
- Use `V7R5M0` for IBM i 7.5
- Use `*CURRENT` to match system release

#### 2. Program Settings

```makefile
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN
```

- `ENTMOD`: Entry module (*PGM for single-module programs)
- `ALWRTVSRC`: Allow retrieve source (*NO for production)
- `OPTIMIZE`: Optimization level (*NONE, *BASIC, *FULL)
- `ACTGRP`: Activation group name

#### 3. Module Settings

```makefile
%.MODULE: private OPTIMIZE := *FULL
%.MODULE: private DBGVIEW := *SOURCE
```

- `OPTIMIZE`: Optimization level
- `DBGVIEW`: Debug view (*NONE, *SOURCE, *LIST, *ALL)

#### 4. Service Program Settings

```makefile
%.SRVPGM: private ACTGRP := *CALLER
%.SRVPGM: private ALWLIBUPD := *NO
%.SRVPGM: private ALWUPD := *YES
```

- `ACTGRP`: *CALLER to run in caller's activation group
- `ALWLIBUPD`: Allow library update
- `ALWUPD`: Allow update (for signature changes)

#### 5. Subdirectories

```makefile
SUBDIRS = database binders services codesamples
```

- Lists subdirectories to build
- **Order matters**: Build dependencies first
- Example: `database` before `services` if services use database files

---

## Subdirectory Rules.mk

### Purpose

Each subdirectory's `Rules.mk` defines:
1. Objects to build in that directory
2. Object-specific overrides
3. Dependencies between objects

### Standard Template

```makefile
# ------------------------------------------------------------------------------
# Rules.mk - [Directory Name] build configuration
# ------------------------------------------------------------------------------
# Description: [What this directory contains]
# ------------------------------------------------------------------------------

# Object targets for this directory
OBJECTS = OBJECT1.PGM OBJECT2.SRVPGM OBJECT3.FILE

# Specific overrides for individual objects (if needed)
OBJECT1.PGM: private ACTGRP := MYACTGRP
OBJECT2.SRVPGM: private BNDDIR := MYBNDDIR

# Dependencies (if needed)
OBJECT1.PGM: OBJECT3.FILE
OBJECT2.SRVPGM: MODULE1.MODULE MODULE2.MODULE
```

### Example: Database Directory

```makefile
# ------------------------------------------------------------------------------
# Rules.mk - Database objects build configuration
# ------------------------------------------------------------------------------
# Description: Physical files, logical files, and SQL tables
# ------------------------------------------------------------------------------

# Object targets
OBJECTS = CUSTOMERS.FILE ORDERS.FILE ORDERITEMS.FILE \
          CUSTOMERLF.FILE SAMPLEDB.TABLE

# No special overrides needed - using defaults from root Rules.mk

# Dependencies
ORDERITEMS.FILE: ORDERS.FILE
ORDERS.FILE: CUSTOMERS.FILE
CUSTOMERLF.FILE: CUSTOMERS.FILE
```

### Example: Services Directory

```makefile
# ------------------------------------------------------------------------------
# Rules.mk - Service programs build configuration
# ------------------------------------------------------------------------------
# Description: Reusable service programs and modules
# ------------------------------------------------------------------------------

# Object targets
OBJECTS = EMAILSRV.SRVPGM NICKSRV.SRVPGM USRPROFSRV.SRVPGM \
          SIMPLEMOD.MODULE

# Service program specific settings
EMAILSRV.SRVPGM: private BNDDIR := NICKLITTEN
NICKSRV.SRVPGM: private BNDDIR := NICKLITTEN
USRPROFSRV.SRVPGM: private BNDDIR := NICKLITTEN

# Dependencies - service programs depend on their modules
EMAILSRV.SRVPGM: EMAILSRV.MODULE
NICKSRV.SRVPGM: NICKSRV.MODULE
USRPROFSRV.SRVPGM: USRPROFSRV.MODULE
```

### Example: Programs Directory

```makefile
# ------------------------------------------------------------------------------
# Rules.mk - Application programs build configuration
# ------------------------------------------------------------------------------
# Description: Main application programs
# ------------------------------------------------------------------------------

# Object targets
OBJECTS = CUSTMAINT.PGM ORDENTRY.PGM RPTGEN.PGM

# Program specific settings
CUSTMAINT.PGM: private ACTGRP := CUSTGRP
ORDENTRY.PGM: private ACTGRP := ORDGRP
RPTGEN.PGM: private ACTGRP := RPTGRP

# All programs use the NICKLITTEN binding directory
%.PGM: private BNDDIR := NICKLITTEN

# Dependencies - programs depend on files and service programs
CUSTMAINT.PGM: CUSTOMERS.FILE NICKSRV.SRVPGM
ORDENTRY.PGM: ORDERS.FILE ORDERITEMS.FILE EMAILSRV.SRVPGM
RPTGEN.PGM: CUSTOMERS.FILE ORDERS.FILE
```

---

## Object Types

### Programs (.PGM)

**Source Extensions:**
- `.pgm.rpgle` - RPGLE program
- `.pgm.sqlrpgle` - SQL RPGLE program
- `.pgm.clle` - CL program

**Build Variables:**
```makefile
MYPGM.PGM: private TGTRLS := V7R4M0
MYPGM.PGM: private ACTGRP := MYACTGRP
MYPGM.PGM: private OPTIMIZE := *FULL
MYPGM.PGM: private DBGVIEW := *SOURCE
MYPGM.PGM: private BNDDIR := MYBNDDIR
```

### Modules (.MODULE)

**Source Extensions:**
- `.rpgle` - RPGLE module
- `.sqlrpgle` - SQL RPGLE module
- `.clle` - CL module

**Build Variables:**
```makefile
MYMODULE.MODULE: private TGTRLS := V7R4M0
MYMODULE.MODULE: private OPTIMIZE := *FULL
MYMODULE.MODULE: private DBGVIEW := *SOURCE
```

### Service Programs (.SRVPGM)

**Source Extensions:**
- `.sqlrpgle` - SQL RPGLE service program source
- `.bnd` - Binder source (required)

**Build Variables:**
```makefile
MYSRVPGM.SRVPGM: private TGTRLS := V7R4M0
MYSRVPGM.SRVPGM: private ACTGRP := *CALLER
MYSRVPGM.SRVPGM: private BNDDIR := MYBNDDIR
MYSRVPGM.SRVPGM: private ALWUPD := *YES
```

**Dependencies:**
```makefile
# Service program depends on its module and binder source
MYSRVPGM.SRVPGM: MYSRVPGM.MODULE MYSRVPGM.BND
```

### Files (.FILE)

**Source Extensions:**
- `.pf` - Physical file (DDS)
- `.lf` - Logical file (DDS)
- `.dspf` - Display file (DDS)
- `.prtf` - Printer file (DDS)
- `.table` - SQL table

**Build Variables:**
```makefile
MYFILE.FILE: private OPTION := *EVENTF
MYFILE.FILE: private GENLVL := 10
```

### Commands (.CMD)

**Source Extensions:**
- `.cmd` - Command definition

**Build Variables:**
```makefile
MYCMD.CMD: private OPTION := *EVENTF
```

**Dependencies:**
```makefile
# Command depends on its processing program
MYCMD.CMD: MYCMDPGM.PGM
```

### Binding Directories (.BNDDIR)

**Source Extensions:**
- `.bnddir` - Binding directory source

**No special variables needed** - uses default settings

---

## Build Variables

### Common Variables

| Variable | Description | Values | Default |
|----------|-------------|--------|---------|
| `TGTRLS` | Target release | V7R4M0, V7R5M0, *CURRENT | V7R4M0 |
| `ACTGRP` | Activation group | name, *CALLER, *NEW | NICKLITTEN |
| `OPTIMIZE` | Optimization level | *NONE, *BASIC, *FULL | *FULL |
| `DBGVIEW` | Debug view | *NONE, *SOURCE, *LIST, *ALL | *SOURCE |
| `BNDDIR` | Binding directory | name | (none) |

### Program-Specific Variables

| Variable | Description | Values | Default |
|----------|-------------|--------|---------|
| `ENTMOD` | Entry module | *PGM, module-name | *PGM |
| `ALWRTVSRC` | Allow retrieve source | *YES, *NO | *NO |

### Service Program-Specific Variables

| Variable | Description | Values | Default |
|----------|-------------|--------|---------|
| `ALWLIBUPD` | Allow library update | *YES, *NO | *NO |
| `ALWUPD` | Allow update | *YES, *NO | *YES |

### File-Specific Variables

| Variable | Description | Values | Default |
|----------|-------------|--------|---------|
| `OPTION` | Compile option | *EVENTF, *NOEVENTF | *EVENTF |
| `GENLVL` | Generation level | 0-99 | 10 |

---

## Dependencies

### Why Dependencies Matter

Dependencies ensure objects are built in the correct order:
1. Files before programs that use them
2. Modules before service programs that include them
3. Service programs before programs that bind to them
4. Binder source before service programs

### Syntax

```makefile
TARGET: DEPENDENCY1 DEPENDENCY2 DEPENDENCY3
```

### Examples

#### Program Depends on File

```makefile
CUSTMAINT.PGM: CUSTOMERS.FILE
```

Build order:
1. `CUSTOMERS.FILE` is created
2. `CUSTMAINT.PGM` is compiled

#### Service Program Depends on Modules

```makefile
MYSRVPGM.SRVPGM: MODULE1.MODULE MODULE2.MODULE MYSRVPGM.BND
```

Build order:
1. `MODULE1.MODULE` is compiled
2. `MODULE2.MODULE` is compiled
3. `MYSRVPGM.BND` is processed
4. `MYSRVPGM.SRVPGM` is created from modules

#### Program Depends on Service Program

```makefile
MYPGM.PGM: MYSRVPGM.SRVPGM MYFILE.FILE
```

Build order:
1. `MYFILE.FILE` is created
2. `MYSRVPGM.SRVPGM` is created
3. `MYPGM.PGM` is compiled and bound

#### Logical File Depends on Physical File

```makefile
CUSTOMERLF.FILE: CUSTOMERPF.FILE
```

Build order:
1. `CUSTOMERPF.FILE` is created
2. `CUSTOMERLF.FILE` is created over physical file

### Cross-Directory Dependencies

Dependencies can span directories:

```makefile
# In codesamples/Rules.mk
MYPGM.PGM: ../database/MYFILE.FILE ../services/MYSRVPGM.SRVPGM
```

**Better approach:** Use subdirectory order in root Rules.mk:

```makefile
# In root Rules.mk
SUBDIRS = database services codesamples
```

This ensures `database` and `services` are built before `codesamples`.

---

## Best Practices

### 1. Use Consistent Naming

```makefile
# Good - clear and consistent
OBJECTS = CUSTMAINT.PGM ORDENTRY.PGM RPTGEN.PGM

# Avoid - inconsistent naming
OBJECTS = custmaint.PGM OrderEntry.pgm RPT_GEN.PGM
```

### 2. Group Related Objects

```makefile
# Good - grouped by type
OBJECTS = \
  CUST001.PGM CUST002.PGM CUST003.PGM \
  ORD001.PGM ORD002.PGM ORD003.PGM \
  RPT001.PGM RPT002.PGM RPT003.PGM
```

### 3. Document Overrides

```makefile
# Good - explains why override is needed
# Use separate activation group for customer maintenance
# to isolate from other programs
CUSTMAINT.PGM: private ACTGRP := CUSTGRP
```

### 4. Minimize Overrides

```makefile
# Good - use defaults when possible
OBJECTS = PGM1.PGM PGM2.PGM PGM3.PGM

# Avoid - unnecessary overrides
PGM1.PGM: private TGTRLS := V7R4M0
PGM2.PGM: private TGTRLS := V7R4M0
PGM3.PGM: private TGTRLS := V7R4M0
```

### 5. Use Pattern Rules for Common Settings

```makefile
# Good - apply to all programs in directory
%.PGM: private BNDDIR := NICKLITTEN
%.PGM: private ACTGRP := MYACTGRP

OBJECTS = PGM1.PGM PGM2.PGM PGM3.PGM
```

### 6. Maintain Dependency Order

```makefile
# Good - dependencies listed in build order
SUBDIRS = database binders services codesamples

# Avoid - wrong order causes build failures
SUBDIRS = codesamples services database binders
```

### 7. Keep Rules.mk Simple

```makefile
# Good - simple and clear
OBJECTS = MYPGM.PGM MYFILE.FILE
MYPGM.PGM: MYFILE.FILE

# Avoid - overly complex
OBJECTS = $(shell find . -name "*.rpgle" | sed 's/.rpgle/.PGM/')
```

### 8. Comment Complex Dependencies

```makefile
# Customer maintenance program requires:
# - Customer file for data access
# - Email service for notifications
# - User profile service for security
CUSTMAINT.PGM: CUSTOMERS.FILE EMAILSRV.SRVPGM USRPROFSRV.SRVPGM
```

---

## Common Patterns

### Pattern 1: Simple Programs

```makefile
# Single-module programs with no special requirements
OBJECTS = HELLO.PGM GOODBYE.PGM

# Use all defaults from root Rules.mk
```

### Pattern 2: Programs with Service Programs

```makefile
# Programs that use service programs
OBJECTS = MYPGM.PGM

MYPGM.PGM: private BNDDIR := NICKLITTEN
MYPGM.PGM: MYSRVPGM.SRVPGM
```

### Pattern 3: Service Program with Module

```makefile
# Service program built from module
OBJECTS = MYSRVPGM.SRVPGM MYSRVPGM.MODULE

MYSRVPGM.SRVPGM: private BNDDIR := NICKLITTEN
MYSRVPGM.SRVPGM: MYSRVPGM.MODULE MYSRVPGM.BND
```

### Pattern 4: Multi-Module Service Program

```makefile
# Service program built from multiple modules
OBJECTS = MYSRVPGM.SRVPGM MODULE1.MODULE MODULE2.MODULE MODULE3.MODULE

MYSRVPGM.SRVPGM: private BNDDIR := NICKLITTEN
MYSRVPGM.SRVPGM: MODULE1.MODULE MODULE2.MODULE MODULE3.MODULE MYSRVPGM.BND
```

### Pattern 5: File Dependencies

```makefile
# Logical file over physical file
OBJECTS = CUSTOMERPF.FILE CUSTOMERLF.FILE

CUSTOMERLF.FILE: CUSTOMERPF.FILE
```

### Pattern 6: Command with Program

```makefile
# Command and its processing program
OBJECTS = MYCMD.CMD MYCMDPGM.PGM

MYCMD.CMD: MYCMDPGM.PGM
```

### Pattern 7: Different Activation Groups

```makefile
# Programs in different activation groups
OBJECTS = BATCH1.PGM BATCH2.PGM ONLINE1.PGM ONLINE2.PGM

# Batch programs share activation group
BATCH1.PGM: private ACTGRP := BATCHGRP
BATCH2.PGM: private ACTGRP := BATCHGRP

# Online programs share different activation group
ONLINE1.PGM: private ACTGRP := ONLINEGRP
ONLINE2.PGM: private ACTGRP := ONLINEGRP
```

### Pattern 8: Debug vs Production

```makefile
# Development - with debug info
%.PGM: private DBGVIEW := *SOURCE
%.PGM: private OPTIMIZE := *NONE

# Production - optimized, no debug
# %.PGM: private DBGVIEW := *NONE
# %.PGM: private OPTIMIZE := *FULL
```

---

## Troubleshooting

### Build Fails: "Object not found"

**Problem:** Dependency not built first

**Solution:** Add dependency:
```makefile
MYPGM.PGM: MYFILE.FILE
```

### Build Fails: "Duplicate object"

**Problem:** Object listed in multiple Rules.mk files

**Solution:** Remove duplicate from one file

### Build Fails: "Circular dependency"

**Problem:** Objects depend on each other

**Example:**
```makefile
PGM1.PGM: PGM2.PGM
PGM2.PGM: PGM1.PGM  # Circular!
```

**Solution:** Restructure to remove circular dependency

### Override Not Working

**Problem:** Override in wrong Rules.mk file

**Solution:** Put override in subdirectory Rules.mk, not root

### Wrong Build Order

**Problem:** Subdirectories built in wrong order

**Solution:** Fix SUBDIRS order in root Rules.mk:
```makefile
# Correct order
SUBDIRS = database services codesamples

# Wrong order
SUBDIRS = codesamples services database
```

### Service Program Won't Bind

**Problem:** Missing binder source dependency

**Solution:** Add .BND dependency:
```makefile
MYSRVPGM.SRVPGM: MYSRVPGM.MODULE MYSRVPGM.BND
```

---

## Quick Reference

### Root Rules.mk Template

```makefile
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.SRVPGM: private TGTRLS := V7R4M0
%.PGM:    private ACTGRP := NICKLITTEN
%.MODULE: private DBGVIEW := *SOURCE
%.SRVPGM: private ACTGRP := *CALLER

SUBDIRS = database binders services codesamples
```

### Subdirectory Rules.mk Template

```makefile
OBJECTS = OBJECT1.PGM OBJECT2.FILE

OBJECT1.PGM: private ACTGRP := MYACTGRP
OBJECT1.PGM: OBJECT2.FILE
```

### Common Build Commands

```bash
makei build              # Build entire project
makei compile -f FILE    # Build specific file
makei clean              # Clean build artifacts
cd DIR && makei build    # Build specific directory
```

---

## Version History

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| V.001 | 2026-05-12 | Nick Litten | Initial creation of Rules.mk guide |

---

**End of Guide**