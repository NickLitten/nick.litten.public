# AGENTS.md - Ask Mode

This file provides documentation-focused guidance for agents in Ask mode working with this IBM i repository.

## Non-Obvious Documentation Context

### File Organization (Counterintuitive)
- `code_snippets_NOCOMPILE/` contains educational examples that don't compile
- `codesamples/` contains working, compilable examples organized by topic
- `templates/` directory contains header templates with `{VARIABLE}` placeholders
- `.bob-config.json` is the master configuration for all coding standards

### Documentation Files
- `CODING_STANDARDS.md` - Complete standards reference (715 lines)
- `BOB_USAGE_GUIDE.md` - How to use BOB assistant (738 lines)
- `RULES_MK_GUIDE.md` - MAKEI build system guide
- `README_BOB_STANDARDS.md` - Quick reference summary

### Hidden Patterns
- Version numbers calculated from modification history count (not manual)
- Copyright statement MUST match modification history version
- Comment separators enforced by automated scanning (dash only, never equals)
- File extensions determine which template is applied automatically

### Build System Context
- MAKEI is IBM i-specific, not standard make/npm
- Root Rules.mk defines SUBDIRS build order (dependencies matter)
- Each subdirectory has own Rules.mk with OBJECTS list
- Default ACTGRP is NICKLITTEN (not *CALLER) for programs
- Service programs use ACTGRP(*CALLER) by default

### Template System
- Templates in `templates/` use `{VARIABLE_NAME}` format
- BOB auto-fills: {AUTHOR}, {DATE}, {VERSION}
- BOB prompts for: {DESCRIPTION}, {PURPOSE}, {FEATURE_N}
- Template selection based on file extension from `.bob-config.json`

### Non-Standard Naming
- Programs: `NAME-Description.pgm.rpgle` (dash separator required)
- Services: `NAME-Description.sqlrpgle` (no .pgm prefix)
- Binders: `NAME-Description.bnd` (matches service program name)
- Tables: `name.table` (lowercase, not uppercase)

### Code Organization
- `database/` - SQL tables and DDS files
- `binders/` - Binding directories (.bnddir files)
- `services/` - Service programs with binder source
- `codesamples/` - Working examples organized by subdirectory
- `includes/` - Copybooks split into legacy/ and modern/ subdirectories