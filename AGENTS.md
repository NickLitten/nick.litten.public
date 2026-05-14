# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## Build System (Non-Standard)
- Uses MAKEI (not make/npm) - `makei build` from project root
- Single file: `makei compile -f FILENAME.pgm.rpgle`
- Subdirectory builds: `cd subdirectory && makei build` (not from root)

## Critical Non-Standard Patterns

### File Naming (Dash Separator Required)
- Programs: `NAME-Description.pgm.rpgle` (dash, NOT underscore)
- Services: `NAME-Description.sqlrpgle` (NO .pgm prefix)
- Tables: `name.table` (lowercase only)

### Comment Separator (BOB Enforced)
- MUST use `-` (dash), NEVER `=` (equals) - `///-----` not `///=====`
- BOB code scanning fails on `=` separators

### Copyright (Auto-Calculated Version)
- RPGLE/SQLRPGLE: `ctl-opt copyright('V.NNN - description');`
- CLLE: `COPYRIGHT TEXT('V.NNN - description')`
- Version = modification history count (V.001, V.002, etc.)

### Rules.mk Quirks
- Default ACTGRP: NICKLITTEN (not *CALLER for .PGM files)
- Uses `:=` immediate assignment (not `=` deferred)
- Build order critical: database → binders → services → codesamples
- Scripts MUST run from project root (paths hardcoded)

### Binder Directory Format (.bnddir files)
```
!DLTOBJ OBJ(&O/&N) OBJTYPE(*BNDDIR)
CRTBNDDIR BNDDIR(&O/&N) TEXT('description')
ADDBNDDIRE BNDDIR(&O/&N) OBJ((*LIBL/SRVPGM *SRVPGM))
```
Uses `&O` (library) and `&N` (name) substitution variables

### Service Program Control Options
- MUST use `ctl-opt nomain` (not main program structure)
- Standard bnddir: `bnddir('NICKLITTEN')` but service programs often omit this