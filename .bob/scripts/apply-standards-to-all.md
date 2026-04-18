# Apply Standards to All Files - Implementation Guide

## Overview

This document provides guidance for systematically applying coding standards to all files in the codesamples directory.

## File Count Summary

Based on the directory listing, there are approximately:
- **50+ RPGLE files** (.pgm.rpgle, .mod.rpgle)
- **20+ SQLRPGLE files** (.pgm.sqlrpgle, .sqlrpgle)
- **25+ CLLE files** (.pgm.clle, .clle)
- **10+ DDS files** (.dspf, .pf)
- **10+ SQL/Table files** (.sql, .table)
- **5+ CMD files** (.cmd)
- **Total: 120+ source files**

## Critical Standards to Apply

### 1. Line Separators
- **Find**: `// ====` or `/* ====` or similar with equals signs
- **Replace**: `// ----` or `/* ----` with hyphens
- **Length**: Approximately 74-76 characters

### 2. Author Names
- **Find**: "Author Name", "Your Name", or any placeholder
- **Replace**: "Nick Litten"

### 3. Documentation Headers
- **RPGLE/SQLRPGLE**: Must use `///` format
- **CLLE**: Must use `/* */` block comment format
- **DDS**: Must use `A*` format
- **SQL**: Must use `--` format

### 4. Copyright Statements
- **RPGLE/SQLRPGLE**: `ctl-opt copyright('PROGNAME | V.XXX | Description');`
- **CLLE**: `COPYRIGHT TEXT('PROGNAME Ver:XXX Description')`

## Systematic Approach

### Phase 1: Already Completed ✅
- [x] check_subsystem_active/ (4 files)
- [x] subfile/SAMPLESFL-Single_Page_Subfile_SQL/ (1 file)

### Phase 2: High Priority Directories
- [ ] hello_world/ (3 RPGLE files)
- [ ] rpg_code/ (3 RPGLE files - duplicates of hello_world)
- [ ] services/ (1 SQLRPGLE file)
- [ ] crud/ (2 files: 1 RPGLE, 1 SQLRPGLE)

### Phase 3: Medium Priority Directories
- [ ] rpg_modernization/ (13 RPGLE/SQLRPGLE files)
- [ ] subfile/SIMPLE-Full_Load_Subfile/ (3 RPGLE files)
- [ ] subfile/NOOB-Full_Load_Subfile_Modernization/ (4 RPGLE files)
- [ ] security/ (4 files: 2 SQLRPGLE, 2 CLLE)

### Phase 4: Utility Directories
- [ ] cl_code_snippets/ (4 CLLE files)
- [ ] conversion/ (6 files: 4 RPGLE, 1 SQLRPGLE, 1 RPG)
- [ ] debug/ (2 files: 1 CLLE, 1 RPGLE)
- [ ] email_csv_file/ (1 CLLE file)
- [ ] email_outq/ (1 CLLE file)
- [ ] list_libraries/ (1 CLLE file)
- [ ] mysql_server/ (1 CLLE file)
- [ ] read_directory_qshell/ (1 CLLE file)
- [ ] update_iasp/ (2 files: 1 CLLE, 1 SQLRPGLE)
- [ ] upload_files/ (2 CLLE files)
- [ ] clear_bob_logs/ (1 CLLE file)
- [ ] clear_pfrdata/ (1 CLLE file)

### Phase 5: Advanced Examples
- [ ] webservice/JSNIFSSQL/ (1 SQLRPGLE file)
- [ ] webservice/SIMPWEBSQL/ (1 SQLRPGLE file)
- [ ] webservice/WEBFOOD/ (2 RPGLE files)
- [ ] sqlrpgle_dynamic/ (1 SQLRPGLE file)
- [ ] stored_procs/ (2 files: 1 RPGLE, 1 SQLRPGLE)
- [ ] sql_encryption/ (1 SQLRPGLE file)

### Phase 6: Work in Progress
- [ ] subfile/WORKINPROGRESS/CRUD-ChangeReadUpdateDelete/ (1 SQLRPGLE file)
- [ ] subfile/WORKINPROGRESS/PERSONSFL-Expanding_Page_NativeIO/ (1 SQLRPGLE file)
- [ ] subfile/WORKINPROGRESS/SORTSFL-Column_Sorting_Subfile/ (1 SQLRPGLE file)

### Phase 7: DDS and Supporting Files
- [ ] All .dspf files (display files)
- [ ] All .pf files (physical files)
- [ ] All .table files (SQL table definitions)
- [ ] All .cmd files (command definitions)
- [ ] All .sql files (SQL scripts)

## Automation Strategy

### Option 1: Manual BOB Processing (Recommended)
Process files in batches by directory:
1. Request BOB to update specific directory
2. Review changes
3. Move to next directory
4. Track progress in this document

### Option 2: Bulk Search and Replace
Use VS Code's search and replace across files:
1. Search: `^(//|/\*)\s*=+\s*$`
2. Replace with appropriate hyphen separator
3. Verify each change manually

### Option 3: Script-Based (Future Enhancement)
Create Node.js script to:
1. Scan all files
2. Identify violations
3. Apply fixes automatically
4. Generate report

## Progress Tracking

Update this section as directories are completed:

```
Total Directories: 30+
Completed: 2
In Progress: 0
Remaining: 28+
Completion: ~7%
```

## Verification Commands

After applying standards, verify with these searches:

```bash
# Find files with equals separators
grep -r "^//\s*=\+\s*$" codesamples/

# Find files with equals in comments
grep -r "^/\*\s*=\+" codesamples/

# Find placeholder author names
grep -r "Author Name\|Your Name" codesamples/
```

## Notes

- Some files may be intentionally legacy format (check file purpose)
- Files in WORKINPROGRESS may not need full standards yet
- Original RPG files (.rpg) may be kept as-is for comparison
- Always verify compilation after changes

## Estimated Time

- Per file: 2-5 minutes
- Total files: 120+
- Estimated total: 4-10 hours of focused work
- Recommended: Process in multiple sessions

## Next Steps

1. Choose starting directory from Phase 2
2. Request BOB to apply standards
3. Review and verify changes
4. Update progress tracking
5. Repeat for next directory