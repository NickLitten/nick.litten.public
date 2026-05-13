# AGENTS.md - Plan Mode

This file provides planning and architectural guidance for agents working with this IBM i repository.

## Non-Obvious Architectural Constraints

### Build Dependencies (Critical Order)
Build order MUST follow: database → binders → services → codesamples
- Database objects must exist before programs reference them
- Binding directories must exist before service programs use them
- Service programs must exist before programs call them
- Violating order causes compilation failures

### Activation Group Strategy
- Programs default to ACTGRP(NICKLITTEN) - shared activation group
- Service programs default to ACTGRP(*CALLER) - inherit caller's group
- This is OPPOSITE of typical IBM i defaults (*NEW for programs)
- Override only when isolation required (batch jobs, long-running processes)

### File Naming Impact on Build
- Dash separator in filenames is REQUIRED for build system parsing
- `PROGRAM-Description.pgm.rpgle` → creates PROGRAM.PGM object
- `SERVICE-Description.sqlrpgle` → creates SERVICE.SRVPGM object
- Underscore separator will break MAKEI object name extraction

### Service Program Pattern
Service programs MUST have matching binder source:
- `MYSRV-Description.sqlrpgle` requires `MYSRV-Description.bnd`
- Binder defines exported procedures with STRPGMEXP/ENDPGMEXP
- Missing binder source causes link-time failures
- Signature in binder must match service program version

### Template-Driven Development
- All new files should use templates from `templates/` directory
- Templates enforce copyright, modification history, standard options
- Skipping templates causes BOB code scanning failures
- Manual header creation often misses required elements

### Version Management Strategy
- Version numbers auto-increment based on modification history entries
- Copyright ctl-opt MUST match latest version in history
- Mismatch between copyright and history fails BOB validation
- Version format strictly V.NNN (three digits, zero-padded)

### Rules.mk Maintenance Pattern
When adding new objects to subdirectory:
1. Add to OBJECTS list in subdirectory Rules.mk
2. Declare dependencies: `NEWPGM.PGM: REQUIREDFILE.FILE`
3. Override defaults only if needed: `NEWPGM.PGM: private ACTGRP := CUSTOM`
4. Test build in subdirectory before root build

### Code Organization Philosophy
- `codesamples/` organized by topic (not by object type)
- Each topic subdirectory has own Rules.mk
- Working examples only (non-compiling code in `code_snippets_NOCOMPILE/`)
- Service programs centralized in `services/` (shared across samples)

### Documentation Standards Impact
- Comment separator (`-` vs `=`) affects automated scanning
- BOB scans on save/commit and blocks violations
- Triple-slash (`///`) for RPGLE is non-negotiable
- Changing comment style breaks template matching