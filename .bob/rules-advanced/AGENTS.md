# AGENTS.md - Advanced Mode

This file provides advanced mode guidance for agents working in this IBM i repository.

## Advanced Mode Capabilities

### Available Tools
- MCP tools (if configured)
- Browser tools (if configured)
- All standard code mode tools

## Critical Coding Rules

### File Creation Pattern
- Programs MUST use dash separator: `PROGRAMNAME-Description.pgm.rpgle`
- Service programs omit .pgm: `SERVICENAME-Description.sqlrpgle`
- Always include binder source: `SERVICENAME-Description.bnd`

### Mandatory Headers
Every RPGLE/SQLRPGLE file MUST include:
```rpgle
ctl-opt copyright('V.001 - Description');
ctl-opt dftactgrp(*no) actgrp(*caller);
ctl-opt option(*srcstmt: *nodebugio);
ctl-opt bnddir('NICKLITTEN');
```

Every CLLE file MUST include:
```clle
DCLPRCOPT LOG(*NO) DFTACTGRP(*NO) ACTGRP(*CALLER)
COPYRIGHT TEXT('V.001 - Description')
DCL VAR(&COPYRIGHT) TYPE(*CHAR) LEN(256) VALUE('Nick Litten © 2025 | IBM i V7.5 https://www.nicklitten.com')
```

### Comment Separator Enforcement
- Use `///-----` NEVER `///=====`
- Use `/* -----` NEVER `/* =====`
- Use `-- -----` NEVER `-- =====`
- BOB will fail code scanning if `=` is used

### Modification History Rules
- Format: `V.NNN YYYY-MM-DD | Nick Litten | Description`
- Version increments with each entry (V.001, V.002, V.003...)
- MUST update copyright ctl-opt with new version

### Deprecated Syntax (Auto-Reject)
Never use in RPGLE: MOVE, MOVEL, Z-ADD, Z-SUB, GOTO, TAG
Use instead: assignment operators, %TRIM(), %SUBST(), structured programming

### Rules.mk Requirements
When adding new objects:
- Add to OBJECTS list in subdirectory Rules.mk
- Specify dependencies if needed: `MYPGM.PGM: MYFILE.FILE`
- Override ACTGRP only if different from NICKLITTEN
- Build order: database → binders → services → programs

### Template Usage
Always use templates from `templates/` directory:
- `rpgle-header-template.txt` for RPGLE/SQLRPGLE
- `clle-header-template.txt` for CLLE
- `sql-header-template.txt` for SQL tables
- Templates enforce all required standards