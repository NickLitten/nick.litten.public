#!/bin/bash
# ==================================================================
# Project: NickLitten/template
# Script : bob-helper.sh
# Desc   : Helper utility for BOB operations and IBM i development
# Author : BOB
# Date   : 2026-05-12
# ==================================================================

set -e

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STANDARDS_FILE="$PROJECT_ROOT/standards/ibmi-coding-standards.yml"
PROFILE_FILE="$PROJECT_ROOT/.bob-profile.json"
TEMPLATES_DIR="$PROJECT_ROOT/templates/ibmi"

# ==================================================================
# Helper Functions
# ==================================================================

print_header() {
    echo -e "${CYAN}=========================================="
    echo -e "$1"
    echo -e "==========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# ==================================================================
# Command Functions
# ==================================================================

show_help() {
    cat << EOF
BOB Helper Utility for IBM i Development

Usage: $0 <command> [options]

Commands:
  init              Initialize BOB for this project
  check             Run all standards checks
  fix               Auto-fix common issues
  scan              Scan code for standards violations
  convert           Convert legacy headers to triple-slash format
  template <type>   Create new file from template
  profile           Show current BOB profile
  switch <profile>  Switch to different profile
  validate          Validate project structure
  stats             Show project statistics
  help              Show this help message

Examples:
  $0 init
  $0 check
  $0 fix
  $0 convert
  $0 template rpgle
  $0 switch modern-rpg-ci
  $0 stats

For more information, see: docs/CODING_STANDARDS.md
EOF
}

cmd_init() {
    print_header "Initializing BOB for IBM i Development"

    # Check if already initialized
    if [ -f "$PROFILE_FILE" ]; then
        print_warning "BOB is already initialized"
        print_info "Profile: $PROFILE_FILE"
        return 0
    fi

    # Create necessary directories
    mkdir -p "$PROJECT_ROOT/.bob-cache"
    mkdir -p "$PROJECT_ROOT/templates/ibmi"
    mkdir -p "$PROJECT_ROOT/standards"
    mkdir -p "$PROJECT_ROOT/scripts"
    mkdir -p "$PROJECT_ROOT/docs"

    print_success "Created project directories"

    # Make scripts executable
    chmod +x "$PROJECT_ROOT/scripts"/*.sh 2>/dev/null || true
    print_success "Made scripts executable"

    print_success "BOB initialization complete!"
    print_info "Run '$0 check' to validate your code"
}

cmd_check() {
    print_header "Running Standards Checks"

    local exit_code=0

    # Check comment blocks
    print_info "Checking comment blocks..."
    if "$PROJECT_ROOT/scripts/ensure-comment-blocks.sh" --check "$PROJECT_ROOT"; then
        print_success "Comment blocks OK"
    else
        print_error "Comment block issues found"
        exit_code=1
    fi

    echo ""

    # Scan standards
    print_info "Scanning coding standards..."
    if "$PROJECT_ROOT/scripts/scan-standards.sh" "$PROJECT_ROOT"; then
        print_success "Standards check passed"
    else
        print_error "Standards violations found"
        exit_code=1
    fi

    return $exit_code
}

cmd_fix() {
    print_header "Auto-fixing Common Issues"

    # Fix comment blocks
    print_info "Adding missing comment blocks..."
    "$PROJECT_ROOT/scripts/ensure-comment-blocks.sh" --fix "$PROJECT_ROOT"

    # Fix line endings
    print_info "Fixing line endings..."
    find "$PROJECT_ROOT" -type f \( -name "*.rpgle" -o -name "*.sqlrpgle" -o -name "*.clle" -o -name "*.sql" \) -exec dos2unix {} \; 2>/dev/null || true

    # Remove trailing whitespace
    print_info "Removing trailing whitespace..."
    find "$PROJECT_ROOT" -type f \( -name "*.rpgle" -o -name "*.sqlrpgle" -o -name "*.clle" -o -name "*.sql" \) -exec sed -i 's/[[:space:]]*$//' {} \; 2>/dev/null || true

    print_success "Auto-fix complete!"
    print_info "Run '$0 check' to verify fixes"
}

cmd_scan() {
    print_header "Scanning Code"
    VERBOSE=true "$PROJECT_ROOT/scripts/scan-standards.sh" "$PROJECT_ROOT"
}

cmd_convert() {
    print_header "Converting Headers to Triple-Slash Format"

    # Ask for confirmation
    print_warning "This will convert all legacy headers to triple-slash format"
    print_info "A dry run will be performed first"
    echo ""

    # Dry run first
    print_info "Running dry run..."
    DRY_RUN=true "$PROJECT_ROOT/scripts/convert-to-triple-slash.sh" "$PROJECT_ROOT"

    echo ""
    read -p "Proceed with conversion? (y/N): " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Converting files..."
        "$PROJECT_ROOT/scripts/convert-to-triple-slash.sh" "$PROJECT_ROOT"
    else
        print_info "Conversion cancelled"
    fi
}

cmd_template() {
    local template_type="$1"

    if [ -z "$template_type" ]; then
        print_error "Template type required"
        echo "Available templates:"
        ls -1 "$TEMPLATES_DIR" | sed 's/-template\.//' | sed 's/\..*//' | sort -u
        return 1
    fi

    local template_file="$TEMPLATES_DIR/${template_type}-template.${template_type}"

    if [ ! -f "$template_file" ]; then
        print_error "Template not found: $template_type"
        return 1
    fi

    print_info "Template: $template_file"
    cat "$template_file"
}

cmd_profile() {
    print_header "Current BOB Profile"

    if [ ! -f "$PROFILE_FILE" ]; then
        print_error "BOB profile not found"
        return 1
    fi

    # Extract active profile
    local active_profile=$(grep -A 1 '"active": true' "$PROFILE_FILE" | grep '"name"' | head -1 | cut -d'"' -f4)

    print_info "Active Profile: $active_profile"
    print_info "Profile File: $PROFILE_FILE"
    echo ""

    # Show profile details
    python3 -m json.tool "$PROFILE_FILE" 2>/dev/null || cat "$PROFILE_FILE"
}

cmd_switch() {
    local profile_name="$1"

    if [ -z "$profile_name" ]; then
        print_error "Profile name required"
        echo "Available profiles:"
        grep '"name":' "$PROFILE_FILE" | cut -d'"' -f4
        return 1
    fi

    print_info "Switching to profile: $profile_name"
    print_warning "Manual profile switching not yet implemented"
    print_info "Edit $PROFILE_FILE to change active profile"
}

cmd_validate() {
    print_header "Validating Project Structure"

    local errors=0

    # Check required directories
    local required_dirs=("templates/ibmi" "standards" "scripts" "docs" ".vscode")
    for dir in "${required_dirs[@]}"; do
        if [ -d "$PROJECT_ROOT/$dir" ]; then
            print_success "Directory exists: $dir"
        else
            print_error "Missing directory: $dir"
            ((errors++))
        fi
    done

    echo ""

    # Check required files
    local required_files=(".bob-profile.json" "standards/ibmi-coding-standards.yml" "docs/CODING_STANDARDS.md")
    for file in "${required_files[@]}"; do
        if [ -f "$PROJECT_ROOT/$file" ]; then
            print_success "File exists: $file"
        else
            print_error "Missing file: $file"
            ((errors++))
        fi
    done

    echo ""

    if [ $errors -eq 0 ]; then
        print_success "Project structure is valid!"
        return 0
    else
        print_error "Found $errors validation error(s)"
        return 1
    fi
}

cmd_stats() {
    print_header "Project Statistics"

    echo "File Counts:"
    echo "  RPGLE:     $(find "$PROJECT_ROOT" -name "*.rpgle" -type f | wc -l)"
    echo "  SQLRPGLE:  $(find "$PROJECT_ROOT" -name "*.sqlrpgle" -type f | wc -l)"
    echo "  CLLE:      $(find "$PROJECT_ROOT" -name "*.clle" -type f | wc -l)"
    echo "  SQL:       $(find "$PROJECT_ROOT" -name "*.sql" -type f | wc -l)"
    echo "  CBLLE:     $(find "$PROJECT_ROOT" -name "*.cblle" -type f | wc -l)"
    echo "  DDS:       $(find "$PROJECT_ROOT" -name "*.pf" -o -name "*.lf" -o -name "*.dspf" -o -name "*.prtf" -type f | wc -l)"

    echo ""
    echo "Lines of Code:"
    local total_lines=$(find "$PROJECT_ROOT" -type f \( -name "*.rpgle" -o -name "*.sqlrpgle" -o -name "*.clle" -o -name "*.sql" \) -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $1}')
    echo "  Total:     ${total_lines:-0}"

    echo ""
    echo "Templates Available:"
    ls -1 "$TEMPLATES_DIR" 2>/dev/null | wc -l
}

# ==================================================================
# Main Logic
# ==================================================================

main() {
    local command="${1:-help}"
    shift || true

    case "$command" in
        init)
            cmd_init "$@"
            ;;
        check)
            cmd_check "$@"
            ;;
        fix)
            cmd_fix "$@"
            ;;
        scan)
            cmd_scan "$@"
            ;;
        convert)
            cmd_convert "$@"
            ;;
        template)
            cmd_template "$@"
            ;;
        profile)
            cmd_profile "$@"
            ;;
        switch)
            cmd_switch "$@"
            ;;
        validate)
            cmd_validate "$@"
            ;;
        stats)
            cmd_stats "$@"
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            print_error "Unknown command: $command"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@"

# Made with Bob
