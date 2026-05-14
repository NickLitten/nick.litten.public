# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## File Naming Standard (CRITICAL)
- ALL source files MUST use format: `OBJECTNAME-Description_With_Underscores.extension`
- Object name: UPPERCASE (e.g., CRUD01TBL, ALLFILE, SAMPLEDB)
- Description: Title_Case with underscores (e.g., Task_Management, All_Field_Types)
- Extension: lowercase (e.g., .table, .pf, .rpgle, .sqlrpgle, .clle)
- Example: `CRUD01TBL-Task_Management.table`, `ALLFILE-All_Field_Types.pf`

## Comment Standards (EXACT Format Required)
- RPGLE/SQLRPGLE: `///` triple-slash for headers, `// ---` for sections (dashes only, not equals)
- SQL/Table files: `--` with `-` separators (never `=`)
- CLLE/CMD: `/* */` block comments
- DDS (.pf/.dspf): `*` prefix
- Scripts use regex matching - extra spaces or wrong characters break detection

## IBM i Coding Requirements
- RPGLE: MUST include `ctl-opt dftactgrp(*no) actgrp(*caller)` (not optional)
- SQLRPGLE: Add `option(*sqlcursorstay)` to ctl-opt
- All ILE programs: Include `bnddir('QC2LE')` or `bnddir('NICKLITTEN')`
- SQLRPGLE: Always check SQLSTATE after SQL statements, use fully qualified names

## Build System Quirks
- Rules.mk uses `:=` for immediate assignment (not `=` deferred)
- Scripts MUST run from project root (relative paths hardcoded)
- sed -i behavior differs on macOS vs Linux
- SHELL set to `/bin/bash` - scripts fail with `/bin/sh`

## Critical Gotchas
- Moving `.bob/standards/ibmi-coding-standards.yml` breaks everything (path hardcoded)
- Profile changes require editing BOTH `iproj.json` AND `.bob-profile.json`
- Comment separator convention (dashes not equals) is enforced but not obvious
- Template placeholder substitution happens via sed in make targets
- Scripts expect exact comment block format - extra spaces break detection

## File Organization
- Includes: `includes/` at root (not under src/)
- Database: `database/` at root
- Templates: `.bob/templates/ibmi/`
- Code samples: `codesamples/` with subdirectories by category