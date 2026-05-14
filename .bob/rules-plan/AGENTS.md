# AGENTS.md - Plan Mode

This file provides architectural guidance for agents working in this IBM i repository.

## Project Architecture (Non-Obvious)
- This is a CODE SAMPLES repository, not a template project
- Contains working examples across multiple IBM i languages
- Organized by category in `codesamples/` subdirectories
- Each subdirectory has its own Rules.mk for local builds

## File Naming Architecture (Critical)
- ALL source files use: `OBJECTNAME-Description_With_Underscores.extension`
- Object name UPPERCASE, description Title_Case with underscores
- This convention is enforced but not documented in most places
- Example: `CRUD01TBL-Task_Management.table`

## Comment Block Architecture (Regex-Based)
- Scripts use regex to detect comment blocks - EXACT format required
- RPGLE/SQLRPGLE: `///` for headers, `// ---` for sections (dashes only)
- SQL/Table: `--` with `-` separators (never `=`)
- Extra spaces or wrong separator characters break detection
- This is the #1 cause of script failures

## Standards Enforcement Architecture
- `.bob/standards/ibmi-coding-standards.yml` path is hardcoded everywhere
- Two-phase checking: comment blocks + code scanning
- Scripts exit 1 on violations for CI integration
- Scripts MUST run from project root (relative paths hardcoded)

## Profile System Architecture (Dual-File Coupling)
- Profile changes require editing BOTH `iproj.json` AND `.bob-profile.json`
- Intentional coupling prevents accidental mismatches
- Three profiles: modern-rpg-dev (auto-fix), modern-rpg-ci (strict), legacy-maintenance

## Build System Architecture (Non-Standard)
- No Makefile at root - only Rules.mk
- Rules.mk uses `:=` for immediate assignment (not `=` deferred)
- SHELL explicitly set to `/bin/bash` - scripts fail with `/bin/sh`
- sed -i behavior differs macOS vs Linux

## Template System Architecture (sed-based)
- Templates in `.bob/templates/ibmi/` use `{placeholder}` format
- Substitution happens via sed at file creation time (not runtime)
- Changing templates doesn't update existing files (manual update needed)

## Directory Structure Constraints
- `includes/` and `database/` at root level (not under src/)
- `.bob/templates/ibmi/` subdirectory required
- `.bob/standards/ibmi-coding-standards.yml` path hardcoded
- `codesamples/` contains working examples with subdirectories

## Critical Architectural Dependencies
- All ILE programs depend on QC2LE or NICKLITTEN binding directory
- Scripts depend on exact comment block format (regex matching)
- Standards checking depends on running from project root
- Template system depends on sed being available
