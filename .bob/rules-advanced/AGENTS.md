# AGENTS.md - Advanced Mode

This file provides advanced coding guidance for agents working in this IBM i repository.

## Advanced Mode Specific Rules

### Template Usage
- When creating new files, ALWAYS use make targets (not manual copy)
- `make new-rpgle NAME=prog` auto-substitutes placeholders with current USER and date
- Never manually edit placeholder values - let sed handle substitution

### Comment Block Requirements
- RPGLE main headers use `///` triple-slash (not `//`)
- Section separators use `// ---` (dashes, not equals)
- Scripts enforce EXACT format - extra spaces or wrong characters break detection
- Use `make fix-comments` to auto-add missing headers (dev mode only)

### Standards Enforcement
- `make standards` runs both comment checks and code scanning
- Exit code 1 means violations found - must fix before commit
- Dev profile (modern-rpg-dev) auto-fixes, CI profile (modern-rpg-ci) only checks
- TODO markers allowed in dev, forbidden in CI

### IBM i Coding Patterns
- RPGLE: MUST include `ctl-opt dftactgrp(*no) actgrp(*caller)` - not optional
- SQLRPGLE: Add `option(*sqlcursorstay)` to ctl-opt
- CL: Variables use `&VAR` prefix and UPPER_SNAKE_CASE
- All ILE programs: Include `bnddir('QC2LE')`

### File Organization
- Source files go in `src/{language}/` subdirectories (rpgle, sqlrpgle, clle, sql, etc.)
- Includes go in `includes/` at root (not under src/)
- Database files go in `database/` at root
- Templates are in `.bob/templates/ibmi/` (BOB configuration directory)

### Build System Quirks
- Rules.mk uses `:=` for immediate assignment (not `=` deferred)
- Scripts MUST run from project root (relative paths hardcoded)
- sed -i behavior differs on macOS vs Linux (be aware when testing)
- SHELL set to `/bin/bash` - scripts fail with `/bin/sh`

### Critical Gotchas
- Changing templates doesn't update existing files (manual update needed)
- Moving `.bob/standards/ibmi-coding-standards.yml` breaks everything (path hardcoded)
- Profile changes require editing BOTH `iproj.json` AND `.bob-profile.json`
- Comment block format must be EXACT - scripts use regex matching

## Access To
- MCP tools (if configured)
- Browser tools (if configured)
