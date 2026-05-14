# AGENTS.md - Ask Mode

This file provides documentation-specific guidance for agents working in this IBM i repository.

## Ask Mode Specific Rules

### Non-Obvious Naming
- "BOB" refers to the IBM i development assistant/tooling
- "ILE" = Integrated Language Environment (IBM i concept)
- "DDS" = Data Description Specifications (legacy IBM i)
- "QGPL" = General Purpose Library (forbidden in code)
- "QC2LE" = C runtime binding directory (required for ILE)

### Template System Context
- Templates use `{placeholder}` format for substitution
- Make targets handle placeholder replacement automatically
- Templates are in `.bob/templates/ibmi/` (BOB configuration directory)

### Standards File Context
- `.bob/standards/ibmi-coding-standards.yml` is the single source of truth
- File location is hardcoded in multiple places - cannot be moved
- Contains language-specific sections: rpgle, sqlrpgle, clle, sql, dds, cblle, cmd

### BOB Profile Context
- Three profiles defined in `.bob-profile.json`:
  - modern-rpg-dev: Development with auto-fix
  - modern-rpg-ci: CI/CD with strict checking
  - legacy-maintenance: Relaxed rules for legacy code
- Active profile set in `iproj.json` via IBMI_STANDARD_PROFILE env var

### Build System Context
- Main Makefile only contains `include Rules.mk`
- All build logic is in Rules.mk (not Makefile)
- Make targets require NAME parameter: `make new-rpgle NAME=myprogram`
- Scripts must be run from project root (paths are relative)

### Critical Documentation Gaps
- Comment separator convention (dashes not equals) is enforced but not obvious
- Template placeholder substitution happens via sed in make targets
- Scripts expect exact comment block format - extra spaces break detection
- Profile switching requires editing TWO files (iproj.json AND .bob-profile.json)
