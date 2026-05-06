# IBM i CL/CLLE Coding Standards
## Nick Litten Project - Modern CL Best Practices

---

## 1. File Header Documentation

### CL Programs (CLLE)
Use /* */ block comments for all program-level documentation:

```cl
             PGM        PARM(&PARM1 &PARM2)

/*---------------------------------------------------------------------------*/
/* Program: PROGRAMNAME - Brief Description                                  */
/* Description: Comprehensive explanation of what this program does and why  */
/*              it exists. Multiple lines are fine.                          */
/*                                                                            */
/* Purpose:                                                                   */
/*   - Key concept #1 demonstrated                                           */
/*   - Key concept #2 demonstrated                                           */
/*   - Key concept #3 demonstrated                                           */
/*                                                                            */
/* Features:                                                                  */
/*   - Specific capability #1                                                */
/*   - Specific capability #2                                                */
/*   - Design pattern used                                                   */
/*   - Best practice implemented                                             */
/*                                                                            */
/* Usage:                                                                     */
/*   CALL PROGRAMNAME PARM('value1' 'value2')                                */
/*                                                                            */
/* Parameters:                                                                */
/*   &PARM1 - *CHAR 10 - Description of parameter 1                          */
/*   &PARM2 - *DEC (7 2) - Description of parameter 2                        */
/*                                                                            */
/* Returns:                                                                   */
/*   Message ID in *ESCAPE format if error occurs                            */
/*                                                                            */
/* Dependencies:                                                              */
/*   - Program: PGMNAME                                                       */
/*   - File: FILENAME                                                         */
/*   - Command: CMDNAME                                                       */
/*                                                                            */
/* Compilation:                                                               */
/*   CRTCLPGM PGM(LIB/PROGRAMNAME) SRCFILE(LIB/QCLSRC)                       */
/*                                                                            */
/* Author: Nick Litten                                                        */
/*                                                                            */
/* Modification History:                                                      */
/* v.001 YYYY.MM.DD - Nick Litten - Initial creation                         */
/* v.002 YYYY.MM.DD - Nick Litten - Description of change                    */
/*---------------------------------------------------------------------------*/

             COPYRIGHT  TEXT('v.002 - Brief Description')

             DCL        VAR(&PARM1) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PARM2) TYPE(*DEC) LEN(7 2)
```

### CL Modules (CLLE with NOMAIN)
```cl
/*---------------------------------------------------------------------------*/
/* Module: MODULENAME - Brief Description                                    */
/* Description: Comprehensive explanation of module purpose                  */
/*                                                                            */
/* Exported Procedures:                                                       */
/*   - ProcedureName1 - Brief description                                    */
/*   - ProcedureName2 - Brief description                                    */
/*                                                                            */
/* Purpose:                                                                   */
/*   - Reusable CL logic                                                     */
/*   - Centralized command execution                                         */
/*   - Common utility functions                                              */
/*                                                                            */
/* Compilation:                                                               */
/*   CRTCLMOD MODULE(LIB/MODULENAME) SRCFILE(LIB/QCLSRC)                     */
/*                                                                            */
/* Author: Nick Litten                                                        */
/*                                                                            */
/* Modification History:                                                      */
/* v.001 YYYY.MM.DD - Nick Litten - Initial creation                         */
/*---------------------------------------------------------------------------*/

             COPYRIGHT  TEXT('v.001 - Brief Description')
```

---

## 2. Section Documentation

### Major Sections
Use dash (-) separators only:

```cl
/*---------------------------------------------------------------------------*/
/* SECTION: Variable Declarations                                            */
/*---------------------------------------------------------------------------*/

             DCL        VAR(&CUSTOMER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&STATUS) TYPE(*CHAR) LEN(1)
             DCL        VAR(&COUNTER) TYPE(*DEC) LEN(5 0) VALUE(0)

/*---------------------------------------------------------------------------*/
/* SECTION: Main Processing                                                  */
/*---------------------------------------------------------------------------*/

             /* Processing logic here */
```

### Subsections
```cl
/*---------------------------------------------------------------------------*/
/* Validate Input Parameters                                                 */
/*---------------------------------------------------------------------------*/

             IF         COND(&CUSTOMER *EQ ' ') THEN(DO)
                SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                           MSGDTA('Customer ID required') +
                           MSGTYPE(*ESCAPE)
             ENDDO
```

---

## 3. Code Structure Standards

### Variable Declarations
Group by type and purpose:

```cl
/*---------------------------------------------------------------------------*/
/* Variable Declarations                                                     */
/*---------------------------------------------------------------------------*/

/* Input Parameters */
             DCL        VAR(&CUSTID) TYPE(*CHAR) LEN(10)
             DCL        VAR(&ORDERID) TYPE(*DEC) LEN(9 0)

/* Working Variables */
             DCL        VAR(&STATUS) TYPE(*CHAR) LEN(1)
             DCL        VAR(&ERRMSG) TYPE(*CHAR) LEN(256)
             DCL        VAR(&COUNTER) TYPE(*DEC) LEN(5 0) VALUE(0)

/* Return Variables */
             DCL        VAR(&RESULT) TYPE(*LGL) VALUE('0')
```

### Constants
Use meaningful names and document:

```cl
/* Constants */
             DCL        VAR(&TRUE) TYPE(*LGL) VALUE('1')
             DCL        VAR(&FALSE) TYPE(*LGL) VALUE('0')
             DCL        VAR(&MAXRETRY) TYPE(*DEC) LEN(3 0) VALUE(3)
             DCL        VAR(&TIMEOUT) TYPE(*DEC) LEN(5 0) VALUE(30)
```

---

## 4. Naming Conventions

### Variables
- **Parameters**: Descriptive, uppercase (e.g., `&CUSTID`, `&ORDERNUM`)
- **Working variables**: Descriptive, uppercase (e.g., `&STATUS`, `&COUNTER`)
- **Logical variables**: Prefix with IS/HAS (e.g., `&ISVALID`, `&HASERROR`)
- **Constants**: Descriptive, uppercase (e.g., `&MAXRETRY`, `&TRUE`)

### Programs and Commands
- **Programs**: UPPERCASE, max 10 chars (e.g., `CUSTMAINT`, `ORDPROC`)
- **Commands**: UPPERCASE, descriptive (e.g., `WRKCUST`, `PRCORDER`)

---

## 5. Comment Standards

### Inline Comments
```cl
/* Single-line comment for brief explanations */

/* Multi-line comment for more detailed
   explanations that span multiple lines
   and provide context */

             CHGVAR     VAR(&COUNTER) VALUE(&COUNTER + 1) /* Increment */
```

### Section Separators
Use dashes (-) only, never equals (=):

```cl
/*---------------------------------------------------------------------------*/
/* SECTION NAME                                                              */
/*---------------------------------------------------------------------------*/
```

### TODO/FIXME/NOTE Comments
```cl
/* TODO: Implement error logging */
/* FIXME: Handle edge case when value is negative */
/* NOTE: This assumes input is already validated */
```

---

## 6. Error Handling Patterns

### Monitor Message (MONMSG)
```cl
/*---------------------------------------------------------------------------*/
/* Execute Command with Error Handling                                       */
/*---------------------------------------------------------------------------*/

             DLTF       FILE(QTEMP/TEMPFILE)
             MONMSG     MSGID(CPF2105) /* File not found - ignore */

             CRTDUPOBJ  OBJ(SOURCEFILE) FROMLIB(SOURCELIB) +
                        OBJTYPE(*FILE) TOLIB(QTEMP) +
                        NEWOBJ(TEMPFILE)
             MONMSG     MSGID(CPF0000) EXEC(DO)
                SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                           MSGDTA('Failed to create temp file') +
                           MSGTYPE(*ESCAPE)
             ENDDO
```

### Validation Pattern
```cl
/*---------------------------------------------------------------------------*/
/* Validate Input Parameters                                                 */
/*---------------------------------------------------------------------------*/

             IF         COND(&CUSTID *EQ ' ') THEN(DO)
                CHGVAR     VAR(&ERRMSG) VALUE('Customer ID required')
                GOTO       CMDLBL(ERROR)
             ENDDO

             IF         COND(&ORDERID *LE 0) THEN(DO)
                CHGVAR     VAR(&ERRMSG) VALUE('Order ID must be positive')
                GOTO       CMDLBL(ERROR)
             ENDDO
```

### Error Exit Pattern
```cl
/*---------------------------------------------------------------------------*/
/* Error Handling                                                            */
/*---------------------------------------------------------------------------*/

 ERROR:      SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                        MSGDTA(&ERRMSG) MSGTYPE(*ESCAPE)
             GOTO       CMDLBL(ENDPGM)

 ENDPGM:     ENDPGM
```

---

## 7. Command Standards

### Command Formatting
Use continuation characters for readability:

```cl
/* Good - Readable formatting */
             OVRDBF     FILE(CUSTOMER) TOFILE(QTEMP/CUSTTEMP) +
                        OVRSCOPE(*CALLLVL) SHARE(*YES)

             CALL       PGM(PROCESSORD) PARM(&ORDERID &STATUS +
                        &ERRMSG)

/* Bad - Hard to read */
             OVRDBF FILE(CUSTOMER) TOFILE(QTEMP/CUSTTEMP) OVRSCOPE(*CALLLVL) SHARE(*YES)
```

### Command Groups
Group related commands:

```cl
/*---------------------------------------------------------------------------*/
/* Setup Temporary Environment                                               */
/*---------------------------------------------------------------------------*/

             DLTF       FILE(QTEMP/TEMPFILE)
             MONMSG     MSGID(CPF2105)

             CRTDUPOBJ  OBJ(SOURCEFILE) FROMLIB(SOURCELIB) +
                        OBJTYPE(*FILE) TOLIB(QTEMP) +
                        NEWOBJ(TEMPFILE)

             OVRDBF     FILE(WORKFILE) TOFILE(QTEMP/TEMPFILE) +
                        OVRSCOPE(*CALLLVL)
```

---

## 8. Control Flow Standards

### IF/THEN/ELSE
```cl
/* Simple condition */
             IF         COND(&STATUS *EQ 'A') THEN(DO)
                /* Active processing */
                CALL       PGM(PROCACTIVE) PARM(&CUSTID)
             ENDDO
             ELSE       CMD(DO)
                /* Inactive processing */
                CALL       PGM(PROCINACT) PARM(&CUSTID)
             ENDDO

/* Complex condition */
             IF         COND(&STATUS *EQ 'A' *AND &BALANCE *GT 0) +
                        THEN(DO)
                /* Process active customer with balance */
                CALL       PGM(BILLCUST) PARM(&CUSTID &BALANCE)
             ENDDO
```

### DO WHILE/UNTIL
```cl
/* Process until condition met */
             DOWHILE    COND(&COUNTER *LT &MAXRETRY)
                CALL       PGM(TRYPROCESS) PARM(&STATUS)
                IF         COND(&STATUS *EQ '1') THEN(LEAVE)
                CHGVAR     VAR(&COUNTER) VALUE(&COUNTER + 1)
             ENDDO

/* Process at least once */
             DOUNTIL    COND(&STATUS *EQ '1')
                CALL       PGM(PROCESS) PARM(&STATUS)
             ENDDO
```

### SELECT/WHEN
```cl
/* Multiple conditions */
             SELECT
                WHEN       COND(&STATUS *EQ 'A') THEN(DO)
                   /* Active processing */
                   CALL       PGM(PROCACTIVE)
                ENDDO

                WHEN       COND(&STATUS *EQ 'I') THEN(DO)
                   /* Inactive processing */
                   CALL       PGM(PROCINACT)
                ENDDO

                OTHERWISE  CMD(DO)
                   /* Unknown status */
                   SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                              MSGDTA('Invalid status') +
                              MSGTYPE(*ESCAPE)
                ENDDO
             ENDSELECT
```

---

## 9. File Handling

### Override and Processing
```cl
/*---------------------------------------------------------------------------*/
/* File Override and Processing                                              */
/*---------------------------------------------------------------------------*/

/* Create temporary file */
             CRTDUPOBJ  OBJ(CUSTOMER) FROMLIB(PRODLIB) +
                        OBJTYPE(*FILE) TOLIB(QTEMP) +
                        NEWOBJ(CUSTTEMP)

/* Override file */
             OVRDBF     FILE(CUSTOMER) TOFILE(QTEMP/CUSTTEMP) +
                        OVRSCOPE(*CALLLVL) SHARE(*YES)

/* Process file */
             CALL       PGM(PROCESSCUST)

/* Clean up */
             DLTOVR     FILE(CUSTOMER) LVL(*CALLLVL)
             DLTF       FILE(QTEMP/CUSTTEMP)
```

---

## 10. Message Handling

### Sending Messages
```cl
/* Information message */
             SNDPGMMSG  MSG('Processing customer ' *CAT &CUSTID) +
                        TOPGMQ(*EXT) MSGTYPE(*INFO)

/* Completion message */
             SNDPGMMSG  MSGID(CPF9897) MSGF(QCPFMSG) +
                        MSGDTA('Processing completed successfully') +
                        TOPGMQ(*EXT) MSGTYPE(*COMP)

/* Escape message (error) */
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                        MSGDTA(&ERRMSG) MSGTYPE(*ESCAPE)
```

### Receiving Messages
```cl
/* Receive program message */
             RCVMSG     MSGTYPE(*LAST) RMV(*NO) +
                        MSG(&MSG) MSGID(&MSGID) +
                        MSGDTA(&MSGDTA)

             IF         COND(&MSGID *EQ 'CPF9999') THEN(DO)
                /* Handle specific message */
             ENDDO
```

---

## 11. Performance Best Practices

### Minimize Overrides
```cl
/* Good - Single override scope */
             OVRDBF     FILE(CUSTOMER) TOFILE(QTEMP/CUSTTEMP) +
                        OVRSCOPE(*CALLLVL)
             CALL       PGM(PROCESS1)
             CALL       PGM(PROCESS2)
             DLTOVR     FILE(CUSTOMER) LVL(*CALLLVL)

/* Bad - Multiple override scopes */
             OVRDBF     FILE(CUSTOMER) TOFILE(QTEMP/CUSTTEMP)
             CALL       PGM(PROCESS1)
             DLTOVR     FILE(CUSTOMER)
             OVRDBF     FILE(CUSTOMER) TOFILE(QTEMP/CUSTTEMP)
             CALL       PGM(PROCESS2)
             DLTOVR     FILE(CUSTOMER)
```

### Use QTEMP Efficiently
```cl
/* Create work files in QTEMP */
             CRTDUPOBJ  OBJ(SOURCEFILE) FROMLIB(SOURCELIB) +
                        OBJTYPE(*FILE) TOLIB(QTEMP) +
                        NEWOBJ(WORKFILE)

/* QTEMP is automatically cleaned up at job end */
```

---

## 12. Testing and Debugging

### Debug-Friendly Code
```cl
/* Include meaningful variable names */
             DCL        VAR(&RECORDSPROCESSED) TYPE(*DEC) LEN(7 0) +
                        VALUE(0)
             DCL        VAR(&ERRORCOUNT) TYPE(*DEC) LEN(5 0) VALUE(0)

/* Add debug messages */
             IF         COND(&DEBUGMODE *EQ '1') THEN(DO)
                SNDPGMMSG  MSG('Processing record: ' *CAT +
                           %CHAR(&RECORDID)) TOPGMQ(*EXT) +
                           MSGTYPE(*INFO)
             ENDDO
```

---

## 13. Version Control

### Modification History Format
```cl
/* Modification History:                                                      */
/* v.001 2026.01.15 - Nick Litten - Initial creation                         */
/* v.002 2026.02.20 - Nick Litten - Added error handling                     */
/* v.003 2026.03.10 - Nick Litten - Performance optimization                 */
```

### Copyright Statement
Calculate version from modification count:

```cl
/* 2 modifications = v.002 */
             COPYRIGHT  TEXT('v.002 - Customer Maintenance Program')
```

---

## 14. Code Organization

### Program Structure
1. **PGM statement** with parameters
2. **Header documentation** (/* */)
3. **COPYRIGHT statement**
4. **Variable declarations** (DCL)
5. **Validation logic**
6. **Main processing logic**
7. **Error handling** (ERROR label)
8. **Cleanup and exit** (ENDPGM label)
9. **ENDPGM statement**

### Typical Program Template
```cl
             PGM        PARM(&PARM1 &PARM2)

/*---------------------------------------------------------------------------*/
/* Program documentation here                                                */
/*---------------------------------------------------------------------------*/

             COPYRIGHT  TEXT('v.001 - Description')

/*---------------------------------------------------------------------------*/
/* Variable Declarations                                                     */
/*---------------------------------------------------------------------------*/

             DCL        VAR(&PARM1) TYPE(*CHAR) LEN(10)
             DCL        VAR(&PARM2) TYPE(*DEC) LEN(7 2)

/*---------------------------------------------------------------------------*/
/* Validate Input Parameters                                                 */
/*---------------------------------------------------------------------------*/

             /* Validation logic */

/*---------------------------------------------------------------------------*/
/* Main Processing                                                           */
/*---------------------------------------------------------------------------*/

             /* Processing logic */

             GOTO       CMDLBL(ENDPGM)

/*---------------------------------------------------------------------------*/
/* Error Handling                                                            */
/*---------------------------------------------------------------------------*/

 ERROR:      SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) +
                        MSGDTA(&ERRMSG) MSGTYPE(*ESCAPE)

/*---------------------------------------------------------------------------*/
/* Program Exit                                                              */
/*---------------------------------------------------------------------------*/

 ENDPGM:     ENDPGM
```

---

## 15. Modern CL Features to Use

### Always Use
- Descriptive variable names
- Structured error handling (MONMSG)
- Proper indentation
- Block comments (/* */)
- Continuation characters (+) for readability
- QTEMP for temporary files
- *CALLLVL for override scope

### Avoid
- Single-character variable names
- Unhandled errors
- Deeply nested logic
- Hardcoded values
- Global overrides without scope

---

## Summary Checklist

- [ ] Block comment (/* */) documentation at file level
- [ ] Dash (-) separators only, never equals (=)
- [ ] COPYRIGHT TEXT with version and description
- [ ] Author: Nick Litten
- [ ] Comprehensive modification history
- [ ] Clear section documentation
- [ ] Consistent naming conventions
- [ ] Proper error handling with MONMSG
- [ ] Meaningful variable names
- [ ] Proper indentation
- [ ] Command continuation for readability
- [ ] QTEMP for temporary files
- [ ] Scoped overrides (*CALLLVL)
- [ ] Structured program flow
- [ ] Error exit pattern