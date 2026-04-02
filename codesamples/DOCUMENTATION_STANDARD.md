# RPG/SQLRPGLE Documentation Standard

## Triple-Slash Documentation Template

All RPG and SQLRPGLE programs in this repository should follow this documentation standard for consistency and better IDE integration.

---

## Standard Header Template

```rpgle
**free

///
/// Program: [PROGRAM_NAME] - [Brief Title]
///
/// Description: [Detailed description of what the program does, its purpose,
///              and how it fits into the larger system. Use multiple lines
///              for clarity and readability.]
///
/// Purpose: Educational/Production example demonstrating:
///   - [Key concept or feature 1]
///   - [Key concept or feature 2]
///   - [Key concept or feature 3]
///   - [Additional concepts as needed]
///
/// Features:
///   - [Feature 1 with brief explanation]
///   - [Feature 2 with brief explanation]
///   - [Feature 3 with brief explanation]
///   - [Additional features as needed]
///
/// Usage: [How to call/use the program]
///        [Example: CALL PROGRAM PARM('value')]
///
/// Parameters: (if applicable)
///   - param1: [Type] - [Description]
///   - param2: [Type] - [Description]
///
/// Dependencies: (if applicable)
///   - [File/table/service program dependencies]
///   - [External resources required]
///
/// Control Options: (if notable)
///   - [option]: [Explanation of why this option is used]
///
/// Modification History:
///   [Version] [Date] | [Author] | [Description of changes]
///   2026-04-02 | Bob AI | Added comprehensive documentation
///
```

---

## Service Program Template

```rpgle
**free

///
/// Service Program: [SRVPGM_NAME] - [Brief Title]
///
/// Description: [Detailed description of the service program's purpose
///              and the services it provides to calling programs.]
///
/// Exported Procedures:
///   - [ProcedureName1]: [Brief description]
///   - [ProcedureName2]: [Brief description]
///   - [Additional procedures as needed]
///
/// Purpose: Provides reusable services for:
///   - [Service category 1]
///   - [Service category 2]
///   - [Additional categories as needed]
///
/// Features:
///   - [Feature 1]
///   - [Feature 2]
///   - [Thread safety considerations if applicable]
///
/// Usage Example:
///   ```rpgle
///   dcl-pr ProcedureName;
///     param1 char(10) const;
///   end-pr;
///   
///   result = ProcedureName('value');
///   ```
///
/// Binding Directory: [BNDDIR name if applicable]
///
/// Modification History:
///   [Version] [Date] | [Author] | [Description]
///   2026-04-02 | Bob AI | Added comprehensive documentation
///
```

---

## Key Documentation Principles

### 1. Triple-Slash Format (///)
- Use triple slashes for all program-level documentation
- Provides better IDE integration and parsing
- Distinguishes documentation from regular comments

### 2. Clear Structure
- **Program/Service Name**: Always include at the top
- **Description**: Comprehensive explanation of purpose
- **Purpose**: Bullet list of key concepts demonstrated
- **Features**: Specific capabilities and highlights
- **Usage**: Clear examples of how to use the program
- **Modification History**: Track all changes with dates

### 3. Feature Lists
Use bullet points to highlight:
- Technical capabilities
- Design patterns demonstrated
- Best practices implemented
- Integration points
- Performance considerations

### 4. Educational Value
For example programs, emphasize:
- What concepts are being taught
- Why certain approaches are used
- How the code demonstrates best practices
- Links to related examples or documentation

### 5. Practical Information
Include:
- How to compile the program
- Required dependencies
- Parameter descriptions
- Expected input/output
- Error handling approach

---

## Category-Specific Guidelines

### Hello World Programs
Focus on:
- Simplicity and clarity
- Basic RPG concepts
- Entry-level learning objectives
- Minimal dependencies

### CRUD Operations
Emphasize:
- Database operations performed
- File/table dependencies
- Transaction handling
- Error recovery

### Subfile Programs
Highlight:
- Display file dependencies
- Subfile loading strategy (full/page-at-a-time)
- User interaction flow
- Performance considerations

### Service Programs
Detail:
- Exported procedures
- Thread safety
- Binding requirements
- Usage examples for each procedure

### Web Service Programs
Include:
- API endpoints or services consumed
- JSON/XML handling
- Authentication requirements
- Error handling for network issues

### Security Programs
Document:
- Security implications
- Required authorities
- Audit trail considerations
- Compliance requirements

---

## Examples by Category

### Simple Program
```rpgle
///
/// Program: HELLOWORLD - Simple Hello World
///
/// Description: The simplest possible RPG program demonstrating basic output.
///
/// Purpose: Educational example showing:
///   - Minimal RPG free-format syntax
///   - DSPLY operation for console output
///   - Program termination with RETURN
///
/// Usage: CALL HELLOWORLD
///
/// Features:
///   - Ultra-simple 3-line program
///   - No parameters required
///   - Perfect starting point for RPG beginners
///
```

### Complex Program
```rpgle
///
/// Program: CRUD01RPG - Task Administrator with Subfile
///
/// Description: Full-featured CRUD application demonstrating modern RPGLE
///              practices for database operations with interactive subfile
///              display. Manages task records with create, read, update,
///              and delete operations.
///
/// Purpose: Production-quality example demonstrating:
///   - Complete CRUD operations with SQL
///   - Subfile processing with user interaction
///   - Input validation and error handling
///   - Transaction management
///   - Professional code organization
///
/// Features:
///   - Interactive subfile with multiple options
///   - Real-time data validation
///   - Confirmation dialogs for destructive operations
///   - Comprehensive error handling
///   - Audit trail logging
///
/// Usage: CALL CRUD01RPG
///
/// Display File: CRUD01PNL
/// Database: TASKS table
///
```

---

## Benefits of This Standard

1. **IDE Integration**: Triple-slash comments are recognized by modern IDEs
2. **Consistency**: All programs follow the same documentation pattern
3. **Searchability**: Structured format makes finding information easier
4. **Maintainability**: Clear history and purpose aid future modifications
5. **Learning**: Educational value is explicitly documented
6. **Professional**: Demonstrates enterprise-quality code standards

---

## Implementation Checklist

When documenting a program, ensure you include:

- [ ] Triple-slash header block
- [ ] Program name and brief title
- [ ] Comprehensive description
- [ ] Purpose with bullet points
- [ ] Feature list
- [ ] Usage instructions
- [ ] Dependencies (if any)
- [ ] Modification history
- [ ] Control options explanation (if notable)
- [ ] Parameters (if applicable)

---

*Document Version: 1.0*  
*Last Updated: 2026-04-02*  
*Maintained by: Bob AI*