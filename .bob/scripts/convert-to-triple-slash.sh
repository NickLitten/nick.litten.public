#!/bin/bash
# ==================================================================
# Project: NickLitten/template
# Script : convert-to-triple-slash.sh
# Desc   : Convert legacy comment headers to triple-slash format
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
SCAN_DIR="${1:-.}"
DRY_RUN="${DRY_RUN:-false}"

# Counters
FILES_CONVERTED=0
FILES_SKIPPED=0

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
# Conversion Functions
# ==================================================================

extract_legacy_info() {
    local file="$1"
    local project=""
    local member=""
    local desc=""
    local author=""
    local date=""

    # Extract information from legacy header
    project=$(grep "^// Project:" "$file" 2>/dev/null | sed 's/^\/\/ Project: *//' | xargs)
    member=$(grep "^// Member" "$file" 2>/dev/null | sed 's/^\/\/ Member *: *//' | xargs)
    desc=$(grep "^// Desc" "$file" 2>/dev/null | sed 's/^\/\/ Desc *: *//' | xargs)
    author=$(grep "^// Author" "$file" 2>/dev/null | sed 's/^\/\/ Author *: *//' | xargs)
    date=$(grep "^// Date" "$file" 2>/dev/null | sed 's/^\/\/ Date *: *//' | xargs)

    # Return as pipe-delimited string
    echo "${project}|${member}|${desc}|${author}|${date}"
}

generate_triple_slash_header() {
    local member="$1"
    local desc="$2"
    local author="$3"
    local date="$4"
    local program_name="${member%.*}"

    cat <<EOF
///
/// Program: ${program_name^^} - ${desc}
///
/// Description: This program requires a detailed description of its purpose,
/// functionality, and how it fits into the larger system. Please update
/// this section with comprehensive information about what the program does.
///
/// Purpose: Educational/Production example demonstrating:
/// - TODO: Document key concepts and features
/// - TODO: Describe main functionality
/// - TODO: List important patterns used
///
/// Features:
/// - TODO: List main features and capabilities
/// - TODO: Document important functionality
/// - TODO: Highlight key aspects of implementation
///
/// Usage: CALL ${program_name^^}
/// TODO: Add parameter examples if applicable
///
/// Parameters: (if applicable)
/// - TODO: Document input/output parameters
///
/// Dependencies:
/// - QC2LE binding directory
/// - TODO: Add other dependencies as needed
///
/// Control Options:
/// - dftactgrp(*no): Required for ILE procedures
/// - actgrp(*caller): Runs in caller's activation group
/// - TODO: Document other significant control options
///
/// Modification History:
/// 1.0.0 ${date} | ${author} | Initial creation
///
EOF
}

convert_rpgle_file() {
    local file="$1"
    local temp_file="${file}.tmp"

    # Check if already using triple-slash format
    if grep -q "^/// Program:" "$file"; then
        log_info "Already using triple-slash format: $file"
        ((FILES_SKIPPED++))
        return 0
    fi

    # Check if has legacy format
    if ! grep -q "^// Project:" "$file"; then
        log_warning "No legacy header found: $file"
        ((FILES_SKIPPED++))
        return 0
    fi

    # Extract legacy information
    local info=$(extract_legacy_info "$file")
    IFS='|' read -r project member desc author date <<< "$info"

    if [ -z "$member" ]; then
        member=$(basename "$file")
    fi
    if [ -z "$desc" ]; then
        desc="TODO: Add description"
    fi
    if [ -z "$author" ]; then
        author="Unknown"
    fi
    if [ -z "$date" ]; then
        date=$(date +%Y-%m-%d)
    fi

    log_info "Converting: $file"
    log_info "  Member: $member"
    log_info "  Description: $desc"
    log_info "  Author: $author"
    log_info "  Date: $date"

    if [ "$DRY_RUN" = "true" ]; then
        log_warning "DRY RUN - Would convert: $file"
        ((FILES_CONVERTED++))
        return 0
    fi

    # Find where legacy header ends
    local header_end=$(awk '/^\/\/ --/,/^\/\/ --/ {count++; if (count==2) {print NR; exit}}' "$file")

    if [ -z "$header_end" ]; then
        log_error "Could not find end of legacy header: $file"
        return 1
    fi

    # Check if file starts with **free
    local has_free=false
    if head -n 1 "$file" | grep -q "^\*\*free"; then
        has_free=true
    fi

    # Build new file
    if [ "$has_free" = true ]; then
        {
            echo "**free"
            echo ""
            generate_triple_slash_header "$member" "$desc" "$author" "$date"
            tail -n +$((header_end + 1)) "$file" | sed '/^$/d' | sed '1s/^/\n/'
        } > "$temp_file"
    else
        {
            generate_triple_slash_header "$member" "$desc" "$author" "$date"
            tail -n +$((header_end + 1)) "$file" | sed '/^$/d' | sed '1s/^/\n/'
        } > "$temp_file"
    fi

    # Replace original file
    mv "$temp_file" "$file"
    log_success "Converted: $file"
    ((FILES_CONVERTED++))
}

# ==================================================================
# Main Logic
# ==================================================================

echo "=========================================="
echo "Legacy to Triple-Slash Header Converter"
echo "=========================================="
echo "Directory: $SCAN_DIR"
if [ "$DRY_RUN" = "true" ]; then
    echo "Mode: DRY RUN (no changes will be made)"
else
    echo "Mode: LIVE (files will be modified)"
fi
echo ""

# Find and convert all RPGLE/SQLRPGLE files
while IFS= read -r -d '' file; do
    convert_rpgle_file "$file"
done < <(find "$SCAN_DIR" -type f \( -name "*.rpgle" -o -name "*.sqlrpgle" \) -print0)

# ==================================================================
# Summary
# ==================================================================

echo ""
echo "=========================================="
echo "Conversion Summary"
echo "=========================================="
echo "Files converted: $FILES_CONVERTED"
echo "Files skipped: $FILES_SKIPPED"
echo ""

if [ "$DRY_RUN" = "true" ]; then
    log_warning "DRY RUN completed - no files were modified"
    log_info "Run without DRY_RUN=true to apply changes"
else
    if [ $FILES_CONVERTED -gt 0 ]; then
        log_success "Conversion complete!"
        log_info "Review the changes and update TODO items in headers"
    else
        log_info "No files needed conversion"
    fi
fi

exit 0

# Made with Bob
