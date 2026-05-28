---
# MAKEi Folder Exclusion Guide
---
# How to Ignore Folders in Rules.mk with MAKEi for IBM i
---

## Overview

MAKEi uses the `SUBDIRS` variable in [`Rules.mk`](../../Rules.mk) files to control which directories are processed during the build. To ignore a folder, simply **omit it from the SUBDIRS list**.

---

## Basic Syntax

```makefile
SUBDIRS := folder1 folder2 folder3
```

**Key Points:**
- Only folders listed in `SUBDIRS` are processed
- Folders not listed are automatically ignored
- Order matters - folders are processed left to right
- Use `:=` for immediate assignment (not `=`)

---

## Current Project Structure

### Root Level ([`Rules.mk`](../../Rules.mk))
```makefile
SUBDIRS := IBMi
```

### IBMi Level ([`IBMi/Rules.mk`](../../IBMi/Rules.mk))
```makefile
SUBDIRS := ClearBobLogs ClearPfrdata CodeSamples Conversion Database Debug EmailCsvFile EmailOutq HelloWorld ListLibraries MySqlServer Services StoredProcs UploadFiles
```

**Currently Ignored Folders:**
- `IBMi/.CodeSnippets/` - Not in SUBDIRS list
- Any other subdirectories not explicitly listed

---

## How to Ignore Folders

### Method 1: Remove from SUBDIRS List

**Before:**
```makefile
SUBDIRS := ClearBobLogs ClearPfrdata CodeSamples Conversion Database
```

**After (ignoring CodeSamples):**
```makefile
SUBDIRS := ClearBobLogs ClearPfrdata Conversion Database
```

### Method 2: Comment Out

```makefile
SUBDIRS := ClearBobLogs ClearPfrdata \
           # CodeSamples \
           Conversion Database
```

**Note:** This approach can cause issues with line continuation. Better to remove entirely.

### Method 3: Multi-line Format (Recommended for Readability)

```makefile
SUBDIRS := \
    ClearBobLogs \
    ClearPfrdata \
    Conversion \
    Database \
    Debug \
    EmailCsvFile
```

To ignore a folder, simply delete or comment out its line.

---

## Common Use Cases

### Example 1: Ignore Work-in-Progress Folders

```makefile
# Ignore .WorkInProgress and experimental folders
SUBDIRS := ClearBobLogs Database Services
# Not including: .WorkInProgress Experimental Testing
```

### Example 2: Ignore Code Snippets and Examples

```makefile
# Production build - ignore examples and snippets
SUBDIRS := Services Database
# Not including: .CodeSnippets CodeSamples HelloWorld
```

### Example 3: Ignore Specific Categories

```makefile
# Build only core services, ignore utilities
SUBDIRS := Services Database StoredProcs
# Not including: Debug EmailCsvFile EmailOutq ClearBobLogs
```

### Example 4: Development vs Production

**Development [`Rules.mk`](../../IBMi/Rules.mk):**
```makefile
SUBDIRS := ClearBobLogs ClearPfrdata CodeSamples Conversion Database Debug EmailCsvFile EmailOutq HelloWorld ListLibraries MySqlServer Services StoredProcs UploadFiles
```

**Production [`Rules.mk`](../../IBMi/Rules.mk):**
```makefile
SUBDIRS := Database Services StoredProcs
```

---

## Important Notes

### 1. No Wildcard Support
MAKEi does not support wildcards or patterns in SUBDIRS:
```makefile
# ❌ This does NOT work:
SUBDIRS := $(filter-out Test%, $(wildcard */))

# ✅ This works:
SUBDIRS := Database Services
```

### 2. Nested Rules.mk Files
Each subdirectory can have its own [`Rules.mk`](../../IBMi/Rules.mk) with its own SUBDIRS:

```
IBMi/Rules.mk          → Controls which IBMi/* folders to build
IBMi/Services/Rules.mk → Controls which Services/* folders to build
```

### 3. Dependencies Matter
If folder B depends on folder A, ensure A comes before B:
```makefile
# ✅ Correct order:
SUBDIRS := Database Services StoredProcs

# ❌ Wrong order (Services needs Database):
SUBDIRS := Services Database StoredProcs
```

### 4. Hidden Folders
Folders starting with `.` are typically ignored by convention:
- `.CodeSnippets/` - Not in SUBDIRS
- `.WorkInProgress/` - Not in SUBDIRS
- `.vscode/` - Not in SUBDIRS

---

## Verification

To verify which folders are being processed:

1. Check the [`Rules.mk`](../../Rules.mk) file in the directory
2. Look at the `SUBDIRS :=` line
3. Only listed folders will be built

**Example Check:**
```bash
# View current SUBDIRS configuration
grep "SUBDIRS :=" IBMi/Rules.mk
```

---

## Best Practices

1. **Keep SUBDIRS Organized**
   - List folders in logical order
   - Group related folders together
   - Add comments for clarity

2. **Document Exclusions**
   ```makefile
   # Build only production components
   # Excluded: CodeSamples, Debug, HelloWorld (development only)
   SUBDIRS := Database Services StoredProcs
   ```

3. **Use Consistent Formatting**
   ```makefile
   # Single line for short lists
   SUBDIRS := Database Services
   
   # Multi-line for longer lists
   SUBDIRS := \
       ClearBobLogs \
       Database \
       Services
   ```

4. **Maintain Separate Configurations**
   - Keep development and production [`Rules.mk`](../../Rules.mk) files separate
   - Use version control to track changes
   - Document why folders are excluded

---

## Quick Reference

| Action | Method |
|--------|--------|
| Ignore a folder | Remove from SUBDIRS list |
| Temporarily ignore | Comment out in SUBDIRS |
| Ignore multiple folders | Remove all from SUBDIRS |
| Check what's ignored | Compare directory listing to SUBDIRS |
| Re-enable a folder | Add back to SUBDIRS list |

---

## Example: Current Project

**Folders in `IBMi/` directory:**
```
.CodeSnippets/     ← Ignored (not in SUBDIRS)
ClearBobLogs/      ← Built (in SUBDIRS)
ClearPfrdata/      ← Built (in SUBDIRS)
CodeSamples/       ← Built (in SUBDIRS)
Conversion/        ← Built (in SUBDIRS)
Database/          ← Built (in SUBDIRS)
Debug/             ← Built (in SUBDIRS)
EmailCsvFile/      ← Built (in SUBDIRS)
EmailOutq/         ← Built (in SUBDIRS)
HelloWorld/        ← Built (in SUBDIRS)
ListLibraries/     ← Built (in SUBDIRS)
MySqlServer/       ← Built (in SUBDIRS)
Services/          ← Built (in SUBDIRS)
StoredProcs/       ← Built (in SUBDIRS)
UploadFiles/       ← Built (in SUBDIRS)
```

**To ignore `.CodeSnippets/`:** Already ignored (not in SUBDIRS)

**To ignore `Debug/`:** Remove from SUBDIRS in [`IBMi/Rules.mk`](../../IBMi/Rules.mk)

---

## Summary

**The simplest way to ignore a folder in MAKEi:**

1. Open the [`Rules.mk`](../../Rules.mk) file in the parent directory
2. Find the `SUBDIRS :=` line
3. Remove the folder name from the list
4. Save the file

**That's it!** MAKEi will skip any folder not listed in SUBDIRS.

---