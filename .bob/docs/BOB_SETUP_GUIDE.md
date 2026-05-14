# BOB Setup Guide for IBM i Development

Complete guide to setting up and using BOB for IBM i development with the NickLitten template.

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Profiles](#profiles)
- [Scripts](#scripts)
- [CI/CD Integration](#cicd-integration)
- [Troubleshooting](#troubleshooting)

## Overview

This project is configured with BOB (your AI coding assistant) to enforce IBM i coding standards automatically. BOB provides:

- **Automated Standards Checking** - Real-time validation of coding standards
- **Comment Block Management** - Automatic insertion and validation of header comments
- **Code Scanning** - Detection of common issues and anti-patterns
- **Template Application** - Automatic application of file templates
- **CI/CD Integration** - Pre-commit and pre-push validation

## Quick Start

### 1. Initialize BOB

```bash
./scripts/bob-helper.sh init
```

### 2. Check Your Code

```bash
./scripts/bob-helper.sh check
```

### 3. Auto-Fix Issues

```bash
./scripts/bob-helper.sh fix
```

## Installation

### Prerequisites

- Git
- Bash (Linux/macOS) or Git Bash (Windows)
- VSCode with Code for IBM i extension
- Node.js (optional, for additional tooling)

### Setup Steps

1. **Clone the repository:**

```bash
git clone <repository-url>
cd nick.litten.template
```

2. **Make scripts executable:**

```bash
chmod +x scripts/*.sh
```

3. **Initialize BOB:**

```bash
./scripts/bob-helper.sh init
```

4. **Validate setup:**

```bash
./scripts/bob-helper.sh validate
```

## Configuration

### BOB Profile

The main configuration is in [`.bob-profile.json`](../.bob-profile.json). This file defines:

- **Profiles** - Different rule sets for development, CI/CD, and legacy maintenance
- **Standards** - Reference to the coding standards file
- **Templates** - Template directory and placeholder substitution
- **Hooks** - Actions triggered on file events
- **Linting Rules** - Specific code quality checks

### Coding Standards

Detailed standards are defined in [`standards/ibmi-coding-standards.yml`](../standards/ibmi-coding-standards.yml):

- General formatting rules
- Language-specific standards (RPG, SQL, CL, COBOL, DDS)
- Comment block requirements
- Naming conventions
- Best practices and forbidden patterns

### VSCode Settings

VSCode is configured via [`.vscode/settings.json`](../.vscode/settings.json):

- File associations for IBM i languages
- Formatting preferences
- Code for IBM i extension settings
- Language-specific indentation

## Usage

### Command Line Tools

#### BOB Helper Script

The main utility script provides several commands:

```bash
# Show help
./scripts/bob-helper.sh help

# Initialize project
./scripts/bob-helper.sh init

# Run all checks
./scripts/bob-helper.sh check

# Auto-fix issues
./scripts/bob-helper.sh fix

# Scan for violations
./scripts/bob-helper.sh scan

# Show project statistics
./scripts/bob-helper.sh stats

# View current profile
./scripts/bob-helper.sh profile

# Validate project structure
./scripts/bob-helper.sh validate

# Convert legacy headers to triple-slash format
./scripts/bob-helper.sh convert

# Show template
./scripts/bob-helper.sh template rpgle
```

#### Standards Scanner

Scan code for standards violations:

```bash
# Scan current directory
./scripts/scan-standards.sh .

# Scan specific directory
./scripts/scan-standards.sh src/

# Verbose output
VERBOSE=true ./scripts/scan-standards.sh .
```

#### Comment Block Checker

Ensure all files have proper comment blocks:

```bash
# Check for missing headers
./scripts/ensure-comment-blocks.sh --check .

# Auto-add missing headers
./scripts/ensure-comment-blocks.sh --fix .

# Check specific directory
./scripts/ensure-comment-blocks.sh --check src/
```

### Make Targets

If using the Makefile:

```bash
# Run standards checks
make standards

# Clean build artifacts
make clean

# Show help
make help
```

## Profiles

### Available Profiles

#### 1. Modern RPG Development (Default)

**Profile:** `modern-rpg-dev`

- **Mode:** Development
- **Auto-fix:** Enabled
- **Standards:** Warning level
- **Use Case:** Day-to-day development

```json
{
  "comment_mode": "auto-fix",
  "standards_check": "warning",
  "auto_format": true,
  "strict_mode": false
}
```

#### 2. Modern RPG CI/CD

**Profile:** `modern-rpg-ci`

- **Mode:** CI/CD Pipeline
- **Auto-fix:** Disabled
- **Standards:** Error level
- **Use Case:** Pre-merge validation

```json
{
  "comment_mode": "check",
  "standards_check": "error",
  "auto_format": false,
  "strict_mode": true
}
```

#### 3. Legacy Maintenance

**Profile:** `legacy-maintenance`

- **Mode:** Legacy code
- **Auto-fix:** Disabled
- **Standards:** Info level
- **Use Case:** Maintaining old code

```json
{
  "comment_mode": "check",
  "standards_check": "info",
  "auto_format": false,
  "strict_mode": false
}
```

### Switching Profiles

Edit `.bob-profile.json` and set `"active": true` for the desired profile.

## Scripts

### scan-standards.sh

Comprehensive code scanner that checks for:

- GOTO statements (forbidden)
- Hard-coded QGPL references
- Missing ctl-opt declarations
- DFTACTGRP(*YES) usage
- Missing header comments
- SELECT * usage
- TODO/FIXME markers
- CHAR vs VARCHAR usage

**Exit Codes:**
- `0` - All checks passed
- `1` - Errors found

### ensure-comment-blocks.sh

Manages comment blocks in source files:

- Detects missing headers
- Auto-generates headers with project metadata
- Supports all IBM i languages
- Preserves existing code

**Modes:**
- `--check` - Report missing headers
- `--fix` - Add missing headers

### bob-helper.sh

Main utility script providing:

- Project initialization
- Standards checking
- Auto-fixing
- Template viewing
- Profile management
- Project statistics
- Structure validation

## CI/CD Integration

### GitHub Actions

The project includes a comprehensive GitHub Actions workflow (`.github/workflows/ibmi-standards.yml`) that:

1. **Standards Check** - Validates coding standards
2. **Security Scan** - Checks for hardcoded credentials
3. **Documentation Check** - Ensures required docs exist
4. **Build Validation** - Validates project structure

### Pre-commit Hooks

Set up Git hooks for local validation:

```bash
# Create pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
./scripts/ensure-comment-blocks.sh --check . || exit 1
./scripts/scan-standards.sh . || exit 1
EOF

chmod +x .git/hooks/pre-commit
```

### Pre-push Hooks

```bash
# Create pre-push hook
cat > .git/hooks/pre-push << 'EOF'
#!/bin/bash
./scripts/bob-helper.sh check || exit 1
EOF

chmod +x .git/hooks/pre-push
```

## Troubleshooting

### Common Issues

#### Scripts Not Executable

**Problem:** Permission denied when running scripts

**Solution:**
```bash
chmod +x scripts/*.sh
```

#### Line Ending Issues

**Problem:** Scripts fail on Windows with `\r\n` line endings

**Solution:**
```bash
# Convert to LF
dos2unix scripts/*.sh

# Or use Git to fix
git config core.autocrlf input
git rm --cached -r .
git reset --hard
```

#### Missing Dependencies

**Problem:** Commands not found (e.g., `python3`, `dos2unix`)

**Solution:**
- Install required tools for your platform
- Use Git Bash on Windows
- Install Python 3.x if needed

#### BOB Profile Not Found

**Problem:** BOB can't find `.bob-profile.json`

**Solution:**
```bash
# Ensure you're in project root
cd /path/to/project

# Verify file exists
ls -la .bob-profile.json

# Re-initialize if needed
./scripts/bob-helper.sh init
```

### Getting Help

1. Check the [Coding Standards Guide](CODING_STANDARDS.md)
2. Review the [BOB Profile](.bob-profile.json)
3. Run `./scripts/bob-helper.sh help`
4. Check script output for specific error messages

## Best Practices

### Development Workflow

1. **Start with templates** - Use provided templates for new files
2. **Check frequently** - Run `bob-helper.sh check` regularly
3. **Fix before commit** - Ensure all checks pass before committing
4. **Review warnings** - Address warnings even if not blocking
5. **Keep standards updated** - Review and update standards as needed

### Code Review

1. **Automated checks** - Let CI/CD catch standards violations
2. **Focus on logic** - Review business logic and algorithms
3. **Check comments** - Ensure comments explain "why", not "what"
4. **Verify tests** - Ensure adequate test coverage

### Maintenance

1. **Update templates** - Keep templates current with best practices
2. **Review standards** - Periodically review and update standards
3. **Monitor metrics** - Track code quality metrics over time
4. **Train team** - Ensure team understands standards

## Additional Resources

- [IBM i Documentation](https://www.ibm.com/docs/en/i)
- [Code for IBM i Extension](https://marketplace.visualstudio.com/items?itemName=HalcyonTechLtd.code-for-ibmi)
- [Modern RPG Guide](https://www.ibm.com/docs/en/i/7.5?topic=concepts-free-form-rpg)
- [RPG Cafe](https://www.rpgpgm.com/)

---

**Last Updated:** 2026-05-12
**Version:** 1.0.0
**Maintained by:** NickLitten Team
