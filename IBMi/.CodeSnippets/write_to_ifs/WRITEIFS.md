# WRITEIFS - Write Data to IFS using SQL

## Overview
WRITEIFS demonstrates how to write database records to an IFS (Integrated File System) file using IBM i's SQL `IFS_WRITE` stored procedure. This program reads data from a database table via SQL cursor and writes each record as a line to a text file in the IFS.

## Purpose
- Demonstrate SQL cursor processing with IFS file operations
- Show proper use of `QSYS2.IFS_WRITE` stored procedure
- Illustrate REPLACE vs APPEND file writing strategies
- Example of SQL error handling with SQLCODE checking

## Key Features
- **SQL Cursor Processing**: Reads database records sequentially
- **IFS File Writing**: Uses `QSYS2.IFS_WRITE` stored procedure
- **Smart Overwrite Logic**: First write uses REPLACE to clear file, subsequent writes use APPEND
- **UTF-8 Output**: Writes with CCSID 1208 (UTF-8) encoding
- **CRLF Line Endings**: Compatible with Windows text editors
- **Comprehensive Error Handling**: SQL error checking and monitor/on-error blocks
- **Modern SQLRPGLE**: Fully free-format with embedded SQL

## Technical Details

### File Operations
- **First Write**: Uses `REPLACE` to create/clear the file
- **Subsequent Writes**: Uses `APPEND` to add new lines
- **Encoding**: UTF-8 (CCSID 1208)
- **Line Endings**: CRLF (Windows-style)

### SQL Configuration
```rpgle
set option naming = *sys,
           commit = *none,
           usrprf = *user,
           dynusrprf = *user,
           datfmt = *iso,
           closqlcsr = *endmod;
```

### Error Handling
- SQLCODE = 0: Success, continue processing
- SQLCODE = 100: End of data (no more records)
- SQLCODE > 0: Warning condition
- SQLCODE < 0: Error condition
- Monitor/on-error: Catches runtime exceptions

## Usage

### Basic Execution
```
CALL WRITEIFS
```

### Prerequisites
1. Source table `MYFILE` must exist with column `MYDATA`
2. IFS directory `/home/nicklitten/` must exist and be writable
3. User must have authority to the source table and IFS directory

### Customization
Modify these variables in the source code:
```rpgle
Dcl-S ifsFile varchar(255) inz('/home/nicklitten/myfile.txt');  // Output file path
```

Update the SQL cursor to read from your table:
```rpgle
exec sql
     declare c1 cursor for
     select MYDATA
     from MYFILE;
```

## Compilation

### Using CRTSQLRPGI
```
CRTSQLRPGI OBJ(NICKLITTEN/WRITEIFS) +
  SRCSTMF('/home/nicklitten/source/writeifs.sqlrpgle') +
  COMMIT(*NONE) OBJTYPE(*PGM) DBGVIEW(*SOURCE)
```

### Using GNU Make (TOBi/MAKEI)
```bash
make WRITEIFS
```

## Example Output
If `MYFILE` contains:
```
Record 1
Record 2
Record 3
```

The IFS file `/home/nicklitten/myfile.txt` will contain:
```
Record 1
Record 2
Record 3
```

## Common Use Cases
- **Data Export**: Export database records to text files for external processing
- **Report Generation**: Create formatted text reports in the IFS
- **Integration**: Generate files for consumption by other systems
- **Logging**: Write application logs to IFS files
- **Backup**: Create text-based backups of database content

## Best Practices Demonstrated
1. **SQL Cursor Management**: Proper open/fetch/close pattern
2. **Error Handling**: Comprehensive SQLCODE checking
3. **Resource Cleanup**: Cursor closed in all scenarios
4. **Modern RPG**: Fully free-format with clear variable names
5. **IFS Integration**: Using SQL services instead of C APIs
6. **UTF-8 Encoding**: Modern character encoding for portability

## Related Examples
- **Read from IFS**: See examples using `IFS_READ` or C file APIs
- **SQL Cursors**: Other cursor processing examples
- **IFS Operations**: Directory listing, file management examples

## Notes
- The program uses `QSYS2.IFS_WRITE` which is available on IBM i 7.2+
- For older releases, consider using C file APIs (open/write/close)
- The `REPLACE` option will overwrite existing files without warning
- UTF-8 encoding ensures compatibility with modern text editors
- CRLF line endings make files readable in Windows environments

## Troubleshooting

### File Not Created
- Check IFS directory exists and is writable
- Verify user has authority to create files in target directory
- Check for SQL errors in job log

### Empty File
- Verify source table contains data
- Check SQL cursor SELECT statement
- Review SQLCODE values in debug

### Encoding Issues
- Ensure CCSID 1208 (UTF-8) is appropriate for your data
- Consider using CCSID 37 (EBCDIC) for IBM i-only files
- Check for special characters in source data

## Author
Nick Litten

## Version History
- **V1.0** (2020-06-31): Initial creation

## License
This code is provided as an educational example for IBM i developers.