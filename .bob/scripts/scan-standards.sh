#!/bin/bash
# ==================================================================
# Project: NickLitten/template
# Script : scan-standards.sh
# Desc   : Comprehensive IBM i coding standards scanner
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

# Counters
ERROR_COUNT=0
WARNING_COUNT=0
INFO_COUNT=0

# Configuration
STANDARDS_FILE=".bob/standards/ibmi-coding-standards.yml"
SCAN_DIR="${1:-.}"
VERBOSE="${VERBOSE:-false}"

# ==================================================================
# Helper Functions
# ==================================================================

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    ((ERROR_COUNT++))
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
    ((WARNING_COUNT++))
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
    ((INFO_COUNT++))
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# ==================================================================
# Scanning Functions
# ==================================================================

scan_rpgle_file() {
    local file="$1"
    local filename=$(basename "$file")

    if [ "$VERBOSE" = "true" ]; then
        echo "Scanning RPGLE: $file"
    fi

    # Check for GOTO statements
    if grep -n "GOTO" "$file" > /dev/null 2>&1; then
        log_error "$file: GOTO statements are forbidden in modern RPG"
    fi

    # Check for hard-coded QGPL
    if grep -n "QGPL/" "$file" > /dev/null 2>&1; then
        log_error "$file: Hard-coded QGPL library reference found"
    fi

    # Check for ctl-opt
    if ! grep -q "ctl-opt" "$file"; then
        log_error "$file: Missing ctl-opt declaration"
    fi

    # Check for DFTACTGRP(*YES)
    if grep -n "DFTACTGRP(\*YES)" "$file" > /dev/null 2>&1; then
        log_warning "$file: Should use DFTACTGRP(*NO) for ILE programs"
    fi

    # Check for header comment block (triple-slash or legacy format)
    if ! grep -q "^/// Program:" "$file" && ! grep -q "Project:" "$file"; then
        log_error "$file: Missing standard header comment block"
    fi

    # Check for *INLR usage in procedures
    if grep -n "\*INLR.*=.*\*ON" "$file" > /dev/null 2>&1; then
        log_warning "$file: Use 'return' instead of *INLR in procedures"
    fi

    # Check for CHAR usage (suggest VARCHAR)
    if grep -n "CHAR(" "$file" > /dev/null 2>&1; then
        log_info "$file: Consider using VARCHAR instead of CHAR for variable-length data"
    fi

    # Check for TODO/FIXME markers
    if grep -n "TODO\|FIXME" "$file" > /dev/null 2>&1; then
        log_warning "$file: TODO/FIXME marker found"
    fi
}

scan_sqlrpgle_file() {
    local file="$1"

    if [ "$VERBOSE" = "true" ]; then
        echo "Scanning SQLRPGLE: $file"
    fi

    # Run RPGLE checks
    scan_rpgle_file "$file"

    # Check for SELECT *
    if grep -n "SELECT \*" "$file" > /dev/null 2>&1; then
        log_error "$file: SELECT * is forbidden - specify columns explicitly"
    fi

    # Check for SQL error handling
    if grep -q "exec sql" "$file" && ! grep -q "SQLCODE\|SQLSTATE" "$file"; then
        log_warning "$file: SQL statements found but no error checking detected"
    fi
}

scan_clle_file() {
    local file="$1"

    if [ "$VERBOSE" = "true" ]; then
        echo "Scanning CLLE: $file"
    fi

    # Check for hard-coded QGPL
    if grep -n "QGPL/" "$file" > /dev/null 2>&1; then
        log_error "$file: Hard-coded QGPL library reference found"
    fi

    # Check for header comment block
    if ! grep -q "Project:" "$file"; then
        log_error "$file: Missing standard header comment block"
    fi

    # Check for MONMSG
    if grep -q "PGM" "$file" && ! grep -q "MONMSG" "$file"; then
        log_warning "$file: No MONMSG found - error handling may be missing"
    fi
}

scan_sql_file() {
    local file="$1"

    if [ "$VERBOSE" = "true" ]; then
        echo "Scanning SQL: $file"
    fi

    # Check for SELECT *
    if grep -n "SELECT \*" "$file" > /dev/null 2>&1; then
        log_error "$file: SELECT * is forbidden - specify columns explicitly"
    fi

    # Check for header comment block
    if ! grep -q "Project:" "$file"; then
        log_error "$file: Missing standard header comment block"
    fi

    # Check for unqualified table names in production code
    if grep -n "FROM [A-Z][A-Z0-9_]*\s" "$file" > /dev/null 2>&1; then
        log_warning "$file: Possible unqualified table name - use schema.table"
    fi
}

scan_cblle_file() {
    local file="$1"

    if [ "$VERBOSE" = "true" ]; then
        echo "Scanning CBLLE: $file"
    fi

    # Check for header comment block
    if ! grep -q "Project:" "$file"; then
        log_error "$file: Missing standard header comment block"
    fi

    # Check for IDENTIFICATION DIVISION
    if ! grep -q "IDENTIFICATION DIVISION" "$file"; then
        log_error "$file: Missing IDENTIFICATION DIVISION"
    fi
}

scan_dds_file() {
    local file="$1"

    if [ "$VERBOSE" = "true" ]; then
        echo "Scanning DDS: $file"
    fi

    # Check for header comment block
    if ! grep -q "Project:" "$file"; then
        log_error "$file: Missing standard header comment block"
    fi

    # Suggest SQL DDL instead
    log_info "$file: DDS is legacy - consider using SQL DDL for new development"
}

# ==================================================================
# Main Scanning Logic
# ==================================================================

echo "=========================================="
echo "IBM i Coding Standards Scanner"
echo "=========================================="
echo "Scanning directory: $SCAN_DIR"
echo ""

# Find and scan all relevant files
while IFS= read -r -d '' file; do
    case "$file" in
        *.rpgle)
            scan_rpgle_file "$file"
            ;;
        *.sqlrpgle)
            scan_sqlrpgle_file "$file"
            ;;
        *.clle)
            scan_clle_file "$file"
            ;;
        *.sql)
            scan_sql_file "$file"
            ;;
        *.cblle)
            scan_cblle_file "$file"
            ;;
        *.pf|*.lf|*.dspf|*.prtf)
            scan_dds_file "$file"
            ;;
    esac
done < <(find "$SCAN_DIR" -type f \( -name "*.rpgle" -o -name "*.sqlrpgle" -o -name "*.clle" -o -name "*.sql" -o -name "*.cblle" -o -name "*.pf" -o -name "*.lf" -o -name "*.dspf" -o -name "*.prtf" \) -print0)

# ==================================================================
# Summary
# ==================================================================

echo ""
echo "=========================================="
echo "Scan Summary"
echo "=========================================="
echo -e "${RED}Errors:   $ERROR_COUNT${NC}"
echo -e "${YELLOW}Warnings: $WARNING_COUNT${NC}"
echo -e "${BLUE}Info:     $INFO_COUNT${NC}"
echo ""

if [ $ERROR_COUNT -eq 0 ] && [ $WARNING_COUNT -eq 0 ]; then
    log_success "All standards checks passed!"
    exit 0
elif [ $ERROR_COUNT -eq 0 ]; then
    log_success "No errors found (warnings present)"
    exit 0
else
    echo -e "${RED}Standards violations found!${NC}"
    exit 1
fi

# Made with Bob
