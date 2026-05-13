# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## Build System

- Uses MAKEI build system (not standard npm/make)
- Build command: `makei build` (from project root)
- Compile single file: `makei compile -f FILENAME.pgm.rpgle`
- Clean: `makei clean`
- Build specific directory: `cd subdirectory && makei build`

## Critical Non-Standard Patterns

### File Naming Convention
- RPGLE programs: `PROGRAMNAME-Description.pgm.rpgle` (dash separator, not underscore)
- SQLRPGLE programs: `PROGRAMNAME-Description.pgm.sqlrpgle`
- CL programs: `PROGRAMNAME-Description.pgm.clle`
- Service programs: `SERVICENAME-Description.sqlrpgle` (no .pgm prefix)
- Binder source: `SERVICENAME-Description.bnd`
- SQL tables: `tablename.table` (lowercase)

### Comment Separator Rule
- MUST use `-` (dash) for comment separators, NEVER `=` (equals)
- This is enforced by BOB and will fail code scanning
- Example: `///-----` not `///=====`

### Copyright Requirements
- RPGLE/SQLRPGLE: MUST include `ctl-opt copyright('{VERSION} - {DESCRIPTION}');`
- CLLE: MUST include `COPYRIGHT TEXT('{VERSION} - {DESCRIPTION}')`
- Version format: `V.NNN` (e.g., V.001, V.002)
- Version increments with each modification history entry

### Standard Control Options (RPGLE)
```rpgle
ctl-opt copyright('V.001 - Program description');
ctl-opt dftactgrp(*no) actgrp(*caller);
ctl-opt option(*srcstmt: *nodebugio);
ctl-opt bnddir('NICKLITTEN');
```

### Standard CL Program Options
```clle
DCLPRCOPT LOG(*NO) DFTACTGRP(*NO) ACTGRP(*CALLER)
COPYRIGHT TEXT('V.001 - Program description')
DCL VAR(&COPYRIGHT) TYPE(*CHAR) LEN(256) VALUE('Nick Litten © 2025 | IBM i V7.5 https://www.nicklitten.com')
```

### Rules.mk Structure
- Root Rules.mk defines global settings and SUBDIRS
- Each subdirectory has its own Rules.mk defining OBJECTS
- Default ACTGRP: NICKLITTEN (not *CALLER for programs)
- Default TGTRLS: V7R4M0
- Build order matters: database → binders → services → codesamples

### Modification History Format
```
/// Modification History:
///   V.001 YYYY-MM-DD | Nick Litten | Initial creation
///   V.002 YYYY-MM-DD | Nick Litten | Description of change
```

## Code Style (Non-Obvious)

- RPGLE comment style: `///` (triple slash) for documentation blocks
- CLLE comment style: `/* */` (block comments)
- SQL comment style: `--` (double dash)
- DDS comment style: `*` in column 7
- Indentation: 2 spaces for RPGLE, 3 spaces for CLLE, 4 spaces for SQL
- Max line length: 100 chars (RPGLE), 80 chars (CLLE)
- Naming: camelCase for procedures/variables, UPPER_SNAKE_CASE for constants, PascalCase for data structures

## Deprecated Syntax (RPGLE)
Never use: MOVE, MOVEL, Z-ADD, Z-SUB, GOTO, TAG
Use modern equivalents: assignment, %TRIM(), %SUBST(), structured programming

## Templates Location
All templates in `templates/` directory with specific naming:
- `rpgle-header-template.txt`
- `clle-header-template.txt`
- `cmd-header-template.txt`
- `dds-header-template.txt`
- `sql-header-template.txt`
- `bnd-header-template.txt`
- `bnddir-header-template.txt`