# AGENTS.md - Ask Mode

This file provides documentation-specific guidance for agents working in this IBM i repository.

## Non-Obvious IBM i Terminology
- "BOB" = IBM i development assistant/tooling (this project)
- "ILE" = Integrated Language Environment (IBM i concept)
- "DDS" = Data Description Specifications (legacy IBM i)
- "QGPL" = General Purpose Library (forbidden in code)
- "QC2LE" = C runtime binding directory (required for ILE)

## File Naming Convention
- Format: `OBJECTNAME-Description_With_Underscores.extension`
- Object name UPPERCASE, description Title_Case with underscores
- Example: `CRUD01TBL-Task_Management.table`

## Comment Block Format (Non-Obvious)
- RPGLE/SQLRPGLE use `///` (triple-slash), not `//`
- Section separators use `// ---` (dashes), never `// ===` (equals)
- Scripts use regex matching - exact format required, extra spaces break detection
- SQL/Table files use `--` with `-` separators
- CLLE/CMD use `/* */` block comments
- DDS files use `*` prefix

## Standards File Location (Hardcoded)
- `.bob/standards/ibmi-coding-standards.yml` path is hardcoded everywhere
- Cannot be moved without breaking scripts
- Contains language-specific sections: rpgle, sqlrpgle, clle, sql, dds, cblle, cmd

## Profile System (Dual-File Requirement)
- Profile changes require editing BOTH `iproj.json` AND `.bob-profile.json`
- Three profiles: modern-rpg-dev (auto-fix), modern-rpg-ci (strict), legacy-maintenance
- Intentional coupling prevents accidental mismatches

## Template System (sed-based)
- Templates in `.bob/templates/ibmi/` use `{placeholder}` format
- Substitution happens via sed at file creation time (not runtime)
- Changing templates doesn't update existing files

## Build System (Non-Standard)
- No Makefile at root - only Rules.mk
- Rules.mk uses `:=` for immediate assignment (not `=` deferred)
- Scripts MUST run from project root (relative paths hardcoded)
- SHELL explicitly set to `/bin/bash` - fails with `/bin/sh`
