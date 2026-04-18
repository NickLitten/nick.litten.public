# CRITICAL RULES FOR BOB AI ASSISTANT

## ⚠️ MANDATORY RULES - NEVER VIOLATE THESE

### 1. Line Separator Character

**CRITICAL**: 
- ✅ **ALWAYS** use `-` (hyphen/dash) for line separators
- ❌ **NEVER** use `=` (equals sign) for line separators

**Examples:**

**CORRECT:**
```rpgle
// --------------------------------------------------------------------------
```

```clle
/* --------------------------------------------------------------------------
```

**INCORRECT:**
```rpgle
// ==========================================================================
```

```clle
/* ==========================================================================
```

---

### 2. Author Name

**CRITICAL**:
- ✅ **ALWAYS** use "Nick Litten" as the author name
- ❌ **NEVER** use "Author Name", "Your Name", or any other placeholder

**Examples:**

**CORRECT:**
```rpgle
/// Modification History:
///   V.000 2024-01-15 | Nick Litten | Initial creation
```

**INCORRECT:**
```rpgle
/// Modification History:
///   V.000 2024-01-15 | Author Name | Initial creation
```

---

### 3. Documentation Format by Language

**CRITICAL**: Use the correct comment format for each language type:

| Language | Format | Example |
|----------|--------|---------|
| RPGLE | Triple-slash (`///`) | `/// Program: PROGNAME` |
| SQLRPGLE | Triple-slash (`///`) | `/// Program: PROGNAME` |
| CLLE | Block comment (`/* */`) | `/* Program: PROGNAME */` |
| CMD | Block comment (`/* */`) | `/* Command: CMDNAME */` |
| DDS | Asterisk (`*`) | `      * Program: PROGNAME` |
| SQL | Double-dash (`--`) | `-- Program: PROGNAME` |

**IMPORTANT**:
- RPGLE and SQLRPGLE files use triple-slash (`///`) for program-level documentation
- CLLE and CMD files use block comments (`/* */`) for program-level documentation
- DDS files use asterisk (`*`) for comments
- SQL files use double-dash (`--`) for comments

---

### 4. Copyright Format

**CRITICAL**: Use the correct copyright format for each language:

**RPGLE/SQLRPGLE:**
```rpgle
ctl-opt copyright('PROGNAME | V.XXX | Brief description');
```
- Format: `PROGNAME | V.XXX | Description`
- Use pipe (`|`) separators with spaces
- Use hyphen (`-`) in version separator

**CLLE:**
```clle
COPYRIGHT TEXT('PROGNAME Ver:XXX Brief description')
```
- Format: `PROGNAME Ver:XXX Description`
- Use `Ver:` prefix (no spaces around colon)
- No pipe separators in CLLE

---

### 5. Version Calculation

**CRITICAL**: Version numbers are calculated from modification history:

- Count the number of entries in modification history
- Subtract 1 to get version number
- Format as `V.XXX` with zero-padding

**Examples:**
- 1 history entry = `V.000` (initial version)
- 2 history entries = `V.001` (first modification)
- 3 history entries = `V.002` (second modification)
- 43 history entries = `V.042` (42nd modification)

---

### 6. Section Separators

**CRITICAL**: Use consistent section separators with hyphens:

**RPGLE/SQLRPGLE:**
```rpgle
/// --------------------------------------------------------------------------
/// Section Name
/// --------------------------------------------------------------------------
```

**For inline code comments (not program-level documentation):**
```rpgle
// This is an inline comment explaining code logic
```

**CLLE:**
```clle
/* --------------------------------------------------------------------------
   Section Name
   -------------------------------------------------------------------------- */
```

**Length**: Approximately 74-76 characters of hyphens

---

### 7. Modification History Format

**CRITICAL**: Always include complete modification history:

**RPGLE/SQLRPGLE (Program-level documentation):**
```rpgle
/// Modification History:
///   V.000 YYYY-MM-DD | Nick Litten | Initial creation
///   V.001 YYYY-MM-DD | Nick Litten | Description of changes
///   V.002 YYYY-MM-DD | Nick Litten | Another change description
```

**Note**: Use `///` for program-level documentation headers. Use `//` for inline code comments.

**CLLE:**
```clle
/* Modification History:                                                    */
/* V.000 YYYY-MM-DD | Nick Litten | Initial creation                       */
/* V.001 YYYY-MM-DD | Nick Litten | Description of changes                 */
```

---

## 🔍 VALIDATION CHECKLIST

Before completing any task, verify:

- [ ] All line separators use `-` (hyphen), not `=` (equals)
- [ ] Author name is "Nick Litten" in all modification history entries
- [ ] Documentation format matches language type:
  - [ ] `///` for RPGLE/SQLRPGLE program-level documentation
  - [ ] `/* */` for CLLE/CMD program-level documentation
  - [ ] `*` for DDS comments
  - [ ] `--` for SQL comments
- [ ] Copyright format is correct for language type
- [ ] Version number matches modification history count
- [ ] Section separators are consistent and use hyphens
- [ ] All required sections are present (Description, Purpose, Features, etc.)

---

## 📋 QUICK REFERENCE

### When Creating New Files:
1. Use appropriate template from `templates/` directory
2. Replace PROGNAME with actual program name
3. Add comprehensive description
4. Set version to V.000
5. Set author to "Nick Litten"
6. Use current date in YYYY-MM-DD format

### When Modifying Existing Files:
1. Add new entry to modification history
2. Increment version number (V.000 → V.001 → V.002, etc.)
3. Update copyright statement with new version
4. Set author to "Nick Litten"
5. Use current date in YYYY-MM-DD format
6. Describe what changed

### When Reviewing Code:
1. Check line separator character (must be `-`)
2. Check author name (must be "Nick Litten")
3. Check documentation format matches language
4. Check copyright format is correct
5. Check version matches history count
6. Check all required sections present

---

## 🚫 COMMON MISTAKES TO AVOID

1. ❌ Using `=` for line separators instead of `-`
2. ❌ Using triple-slash (`///`) in CLLE/CMD files (should use `/* */`)
3. ❌ Using block comments (`/* */`) in RPGLE/SQLRPGLE program headers (should use `///`)
4. ❌ Using "Author Name" instead of "Nick Litten"
5. ❌ Incorrect copyright format for language type
6. ❌ Version number doesn't match history count
7. ❌ Missing modification history entries
8. ❌ Inconsistent section separator lengths
9. ❌ Missing required documentation sections
10. ❌ Mixing `//` and `///` incorrectly (use `///` for headers, `//` for inline comments)

---

## 📚 REFERENCE FILES

- **Complete Standards**: [`.bob/coding-standards.md`](.bob/coding-standards.md)
- **BOB Profile**: [`.bob/bob-profile.md`](.bob/bob-profile.md)
- **Configuration**: [`.bob/config.json`](.bob/config.json)
- **Quick Guide**: [`CODING-STANDARDS-GUIDE.md`](../CODING-STANDARDS-GUIDE.md)
- **Templates**: [`templates/`](../templates/)

---

## 🎯 REMEMBER

These rules are **MANDATORY** and **NON-NEGOTIABLE**. They ensure:
- Consistency across all code
- Proper version tracking
- Correct attribution
- Professional documentation
- Easy maintenance
- Team collaboration

**When in doubt, refer to the templates in the `templates/` directory!**