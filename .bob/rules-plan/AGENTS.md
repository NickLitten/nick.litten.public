# AGENTS.md - Plan Mode

This file provides architectural guidance for agents working in this IBM i repository.

## Plan Mode Specific Rules

### Project Architecture
- This is a TEMPLATE project for IBM i development, not an application
- Purpose: Provide starting point for new IBM i projects with modern standards
- Core components: Templates, Standards, Scripts, Documentation
- No runtime application code - only templates and tooling

### Template System Architecture
- Templates in `.bob/templates/ibmi/` for 10 IBM i languages
- Make targets copy templates and substitute placeholders via sed
- Placeholder format: `{project_name}`, `{author_name}`, `{creation_date}`, etc.
- Substitution happens at file creation time (not runtime)

### Standards Enforcement Architecture
- Two-phase checking: comment blocks + code scanning
- `ensure-comment-blocks.sh` checks/fixes header comments
- `scan-standards.sh` scans against YAML rules
- Both scripts exit 1 on violations for CI integration
- Scripts must run from project root (hardcoded relative paths)

### BOB Profile Architecture
- Profile system controls behavior: dev (auto-fix) vs CI (check-only)
- Profiles defined in `.bob-profile.json` (3 profiles)
- Active profile set in `iproj.json` via environment variables
- Profile switching requires editing BOTH files (intentional coupling)

### Build System Architecture
- Makefile delegates to Rules.mk (single include statement)
- Rules.mk defines all targets using immediate assignment (`:=`)
- Environment variables exported for scripts: IBMI_PROJECT_NAME, etc.
- Make targets create files in language-specific subdirectories

### Directory Structure Constraints
- `includes/` and `database/` at root level (not under src/)
- `.bob/templates/ibmi/` subdirectory required (BOB configuration directory)
- `.bob/standards/ibmi-coding-standards.yml` path hardcoded everywhere

### Critical Architectural Decisions
- Comment separators use dashes (---) not equals (===) - enforced by regex
- Template placeholders use curly braces - sed substitution at creation
- Scripts assume bash (not sh) - SHELL explicitly set in Rules.mk
- sed -i behavior differs macOS vs Linux - be aware for cross-platform
- Profile changes require dual-file edit - prevents accidental mismatches

### Non-Obvious Dependencies
- All ILE programs depend on QC2LE binding directory
- Scripts depend on exact comment block format (regex matching)
- Make targets depend on NAME parameter being set
- Standards checking depends on running from project root
- Template system depends on sed being available
