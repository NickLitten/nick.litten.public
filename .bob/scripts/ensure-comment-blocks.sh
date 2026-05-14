#!/bin/bash
# ==================================================================
# Project: NickLitten/template
# Script : ensure-comment-blocks.sh
# Desc   : Ensure all IBM i source files have proper comment blocks
# Author : BOB
# Date   : 2026-05-12
# ==================================================================

set -e

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
MODE="${1:---check}"  # --check or --fix
SCAN_DIR="${2:-.}"
PROJECT_NAME="${PROJECT_NAME:-NickLitten/template}"
AUTHOR_NAME="${AUTHOR_NAME:-${USER}}"
CURRENT_DATE=$(date +%Y-%m-%d)

# Counters
FILES_CHECKED=0
FILES_MISSING=0
FILES_FIXED=0

# ==================================================================
# Helper Functions
# ==================================================================

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# ==================================================================
# Comment Block Templates
# ==================================================================

get_rpgle_header() {
    local member_name="$1"
    local program_name="${member_name%.*}"
    local description="${2:-TODO: Add description}"

    cat <<EOF
///
/// Program: $program_name - $description
///
/// Description: This program requires a detailed description of its purpose,
/// functionality, and how it fits into the larger system.
///
/// Purpose: Educational/Production example demonstrating:
/// - TODO: Add key concepts and features
/// - TODO: Document main functionality
/// - TODO: List important patterns used
///
/// Features:
/// - TODO: List main features
/// - TODO: Document capabilities
/// - TODO: Highlight important aspects
///
/// Usage: CALL $program_name
/// TODO: Add parameter examples if applicable
///
/// Parameters: (if applicable)
/// - TODO: Document parameters
///
/// Dependencies:
/// - QC2LE binding directory
/// - TODO: Add other dependencies
///
/// Control Options:
/// - dftactgrp(*no): Required for ILE procedures
/// - actgrp(*caller): Runs in caller's activation group
///
/// Modification History:
/// 1.0.0 $CURRENT_DATE | $AUTHOR_NAME | Initial creation
///

EOF
}

get_sql_header() {
    local member_name="$1"
    local description="${2:-TODO: Add description}"

    cat <<EOF
-- ------------------------------------------------------------------
-- Project: $PROJECT_NAME
-- Member : $member_name
-- Desc   : $description
-- Author : $AUTHOR_NAME
-- Date   : $CURRENT_DATE
-- ------------------------------------------------------------------

EOF
}

get_clle_header() {
    local member_name="$1"
    local description="${2:-TODO: Add description}"

    cat <<EOF
/* ---------------------------------------------------------------- */
/* Project: $PROJECT_NAME                                          */
/* Member : $member_name                                           */
/* Desc   : $description                                           */
/* Author : $AUTHOR_NAME                                           */
/* Date   : $CURRENT_DATE                                         */
/* ---------------------------------------------------------------- */

EOF
}

get_cblle_header() {
    local member_name="$1"
    local description="${2:-TODO: Add description}"

    cat <<EOF
      * ----------------------------------------------------------------
      * Project: $PROJECT_NAME
      * Member : $member_name
      * Desc   : $description
      * Author : $AUTHOR_NAME
      * Date   : $CURRENT_DATE
      * ----------------------------------------------------------------

EOF
}

get_dds_header() {
    local member_name="$1"
    local description="${2:-TODO: Add description}"

    cat <<EOF
     A* ----------------------------------------------------------------
     A* Project: $PROJECT_NAME
     A* Member : $member_name
     A* Desc   : $description
     A* Author : $AUTHOR_NAME
     A* Date   : $CURRENT_DATE
     A* ----------------------------------------------------------------

EOF
}

# ==================================================================
# Check and Fix Functions
# ==================================================================

check_header_exists() {
    local file="$1"

    # Check for triple-slash style (new format)
    if grep -q "^/// Program:" "$file" 2>/dev/null; then
        return 0  # Header exists (new format)
    # Check for legacy double-slash style
    elif grep -q "Project:.*$PROJECT_NAME" "$file" 2>/dev/null; then
        return 0  # Header exists (legacy format)
    else
        return 1  # Header missing
    fi
}

fix_rpgle_header() {
    local file="$1"
    local member_name=$(basename "$file")
    local temp_file="${file}.tmp"
    local has_free=false
    local skip_lines=0

    # Check if file has **free
    if head -n 1 "$file" | grep -q "^\*\*free"; then
        has_free=true
    fi

    # Detect and remove existing header (triple-slash or legacy format)
    if grep -q "^///" "$file"; then
        # Find end of triple-slash header block
        skip_lines=$(awk '/^\/\/\//,/^[^\/]/ {if (/^[^\/]/) {print NR-1; exit}}' "$file")
        if [ -z "$skip_lines" ]; then
            skip_lines=$(grep -n "^///" "$file" | tail -1 | cut -d: -f1)
        fi
    elif grep -q "^// --" "$file"; then
        # Find end of legacy header block (two dashed lines)
        skip_lines=$(awk '/^\/\/ --/,/^\/\/ --/ {count++; if (count==2) {print NR; exit}}' "$file")
    fi

    # Build new file with updated header
    if [ "$has_free" = true ]; then
        {
            echo "**free"
            echo ""
            get_rpgle_header "$member_name"
            if [ "$skip_lines" -gt 0 ]; then
                tail -n +$((skip_lines + 1)) "$file" | sed '/^$/d' | sed '1s/^/\n/'
            else
                tail -n +2 "$file"
            fi
        } > "$temp_file"
    else
        {
            get_rpgle_header "$member_name"
            if [ "$skip_lines" -gt 0 ]; then
                tail -n +$((skip_lines + 1)) "$file" | sed '/^$/d' | sed '1s/^/\n/'
            else
                cat "$file"
            fi
        } > "$temp_file"
    fi

    mv "$temp_file" "$file"
    log_success "Updated header in: $file"
    ((FILES_FIXED++))
}

fix_sql_header() {
    local file="$1"
    local member_name=$(basename "$file")
    local temp_file="${file}.tmp"

    {
        get_sql_header "$member_name"
        cat "$file"
    } > "$temp_file"

    mv "$temp_file" "$file"
    log_success "Added header to: $file"
    ((FILES_FIXED++))
}

fix_clle_header() {
    local file="$1"
    local member_name=$(basename "$file")
    local temp_file="${file}.tmp"

    {
        get_clle_header "$member_name"
        cat "$file"
    } > "$temp_file"

    mv "$temp_file" "$file"
    log_success "Added header to: $file"
    ((FILES_FIXED++))
}

fix_cblle_header() {
    local file="$1"
    local member_name=$(basename "$file")
    local temp_file="${file}.tmp"

    {
        get_cblle_header "$member_name"
        cat "$file"
    } > "$temp_file"

    mv "$temp_file" "$file"
    log_success "Added header to: $file"
    ((FILES_FIXED++))
}

fix_dds_header() {
    local file="$1"
    local member_name=$(basename "$file")
    local temp_file="${file}.tmp"

    {
        get_dds_header "$member_name"
        cat "$file"
    } > "$temp_file"

    mv "$temp_file" "$file"
    log_success "Added header to: $file"
    ((FILES_FIXED++))
}

process_file() {
    local file="$1"
    local extension="${file##*.}"

    ((FILES_CHECKED++))

    if check_header_exists "$file"; then
        if [ "$MODE" = "--check" ]; then
            log_info "Header OK: $file"
        fi
        return 0
    fi

    # Header is missing
    ((FILES_MISSING++))

    if [ "$MODE" = "--check" ]; then
        log_warning "Missing header: $file"
        return 1
    elif [ "$MODE" = "--fix" ]; then
        case "$extension" in
            rpgle|sqlrpgle)
                fix_rpgle_header "$file"
                ;;
            sql)
                fix_sql_header "$file"
                ;;
            clle)
                fix_clle_header "$file"
                ;;
            cblle)
                fix_cblle_header "$file"
                ;;
            pf|lf|dspf|prtf)
                fix_dds_header "$file"
                ;;
            *)
                log_warning "Unknown file type: $file"
                ;;
        esac
    fi
}

# ==================================================================
# Main Logic
# ==================================================================

echo "=========================================="
echo "IBM i Comment Block Checker"
echo "=========================================="
echo "Mode: $MODE"
echo "Directory: $SCAN_DIR"
echo "Project: $PROJECT_NAME"
echo ""

if [ "$MODE" != "--check" ] && [ "$MODE" != "--fix" ]; then
    log_error "Invalid mode. Use --check or --fix"
    echo "Usage: $0 [--check|--fix] [directory]"
    exit 1
fi

# Process all IBM i source files
while IFS= read -r -d '' file; do
    process_file "$file"
done < <(find "$SCAN_DIR" -type f \( -name "*.rpgle" -o -name "*.sqlrpgle" -o -name "*.clle" -o -name "*.sql" -o -name "*.cblle" -o -name "*.pf" -o -name "*.lf" -o -name "*.dspf" -o -name "*.prtf" \) -print0)

# ==================================================================
# Summary
# ==================================================================

echo ""
echo "=========================================="
echo "Summary"
echo "=========================================="
echo "Files checked: $FILES_CHECKED"
echo "Missing headers: $FILES_MISSING"

if [ "$MODE" = "--fix" ]; then
    echo "Files fixed: $FILES_FIXED"
fi

echo ""

if [ $FILES_MISSING -eq 0 ]; then
    log_success "All files have proper comment blocks!"
    exit 0
elif [ "$MODE" = "--check" ]; then
    log_error "$FILES_MISSING file(s) missing comment blocks"
    echo "Run with --fix to automatically add headers"
    exit 1
else
    log_success "Fixed $FILES_FIXED file(s)"
    exit 0
fi

# Made with Bob
