I want IBM BOB to work as efficiently as possible for our team of IBM-i programmers.

Create coding standards templates for all IBM-i languages, based on best practices for modern RPG application development.

Use file naming for IBM-i TOBi - all source code will be name in the case specific format of OBJECTNAME-The_Description_next.objectype

Rules.mk will follow IBM-i TOBi and MAKEI standards.

Review this project and store all bob configuration files in the .bob folder, including templates, scripts, standards and documentation.

Always use the latest IBM i operating system features and APIs.

Always write new code in fully free-format SQLRPGLE using **FREE using coding standards templates. Never generate fixed-format RPG III code unless specifically requested.

In all SQLRPGLE procedures, use fully qualified object names and always check SQLSTATE after every SQL statement.

Be concise in your responses and code comments. Focus on the technical change without extra explanations unless asked.

Never put "# Made with Bob" into any generated files.

After every code change, write a summary of the interaction into the folder '.bob/internal-monologue'. Name the file starting with a timestamp followed by a concise description.
Example: 2026-05-13_pgmname_action-description.md

## Key Documentation Principles
- For all source types, ALWAYS use '-' as comment line seperator character. Never use '='.
- For RPGLE and SQLRPGLE add 'ctl-opt copyright(version - description)' using the program description and version number calculated from number of modifications in the history
- For CLLE add 'COPYRIGHT TEXT('version - description') using the program description and version number calculated from number of modifications in the history
- for Author use 'Nick Litten'

### 1. Triple-Slash Format (///)
- Use triple slashes for all program-level documentation for RPGLE and SQLRPGLE
- Use /* (comments) */ for all program-level documentation for CLLE and CMD
- ' *' for all DDS comments
- '--' for all SQL comments
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
- Performance considerations
