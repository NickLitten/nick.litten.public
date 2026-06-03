# WRITEIFS2 - Write Data to IFS using Traditional C APIs (Pure RPGLE)

## Overview
WRITEIFS2 demonstrates how to write database records to an IFS (Integrated File System) file using traditional IBM i C APIs (`open()`, `write()`, `close()`) with pure RPGLE. This program provides a lower-level alternative to the SQL `IFS_WRITE` approach shown in WRITEIFS, using native RPG file I/O instead of SQL cursors.

## Purpose
- Demonstrate IFS file operations using C APIs (open/write/close)
- Show proper file descriptor management
- Illustrate file creation with permissions and CCSID
- Example of error handling with errno checking
- Pure RPGLE approach without any SQL

## Key Features
- **Pure RPGLE**: No SQL - uses native RPG file I/O operations
- **C API File Operations**: Direct use of `open()`, `write()`, `close()` APIs
- **File Descriptor Management**: Proper opening, using, and closing of file descriptors
- **Permission Control**: Explicit file permissions (0644 - rw-r--r--)
- **UTF-8 Output**: Creates files with CCSID 1208 (UTF-8) encoding
- **CRLF Line Endings**: Compatible with Windows text editors
- **Error Handling**: errno checking for C API failures
- **Resource Cleanup**: Ensures file descriptor is closed even on errors
- **Modern RPGLE**: Fully free-format with native file I/O

## Technical Details

### File Operations
- **open()**: Creates/truncates file with specified permissions and CCSID
- **write()**: Writes data directly to file descriptor
- **close()**: Releases file descriptor
- **Flags Used**:
  - `O_WRONLY`: Write-only access
  - `O_CREAT`: Create file if it doesn't exist
  - `O_TRUNC`: Truncate existing file to zero length
  - `O_CCSID`: Use CCSID parameter for encoding

### Database File Access
```rpgle
Dcl-F MYFILE disk(*ext) usage(*input) keyed;

read MYFILE;
dow not %eof(MYFILE);
   // Process record
   read MYFILE;
enddo;
```

### File Permissions
```rpgle
mode = S_IRUSR + S_IWUSR + S_IRGRP + S_IROTH;  // 0644 octal
```
- Owner: Read + Write
- Group: Read
- Public: Read

### Error Handling
- File descriptor < 0: open() failed
- bytesWritten < 0: write() failed
- errno: Contains system error code
- %eof(): End of file indicator for database
- Monitor/on-error: Catches runtime exceptions with cleanup

## Usage

### Basic Execution
```
CALL WRITEIFS2
```

### Prerequisites
1. Physical file `MYFILE` must exist with field `MYDATA`
2. IFS directory `/home/nicklitten/` must exist and be writable
3. User must have authority to the physical file and IFS directory
4. Program must be bound to `QC2LE` binding directory for C APIs

### Customization
Modify these variables in the source code:
```rpgle
Dcl-S ifsFile varchar(255) inz('/home/nicklitten/myfile2.txt');  // Output file path
```

Update the file declaration to read from your file:
```rpgle
Dcl-F MYFILE disk(*ext) usage(*input) keyed;
```

Change file permissions if needed:
```rpgle
// Current: 0644 (rw-r--r--)
mode = S_IRUSR + S_IWUSR + S_IRGRP + S_IROTH;

// Example: 0600 (rw-------)
mode = S_IRUSR + S_IWUSR;

// Example: 0755 (rwxr-xr-x)
mode = S_IRUSR + S_IWUSR + S_IXUSR + S_IRGRP + S_IXGRP + S_IROTH + S_IXOTH;
```

## Compilation

### Using CRTBNDRPG
```
CRTBNDRPG PGM(NICKLITTEN/WRITEIFS2) +
  SRCSTMF('/home/nicklitten/source/writeifs2.rpgle') +
  DBGVIEW(*SOURCE)
```

### Using GNU Make (TOBi/MAKEI)
```bash
make WRITEIFS2
```

## Example Output
If `MYFILE` contains:
```
Record 1
Record 2
Record 3
```

The IFS file `/home/nicklitten/myfile2.txt` will contain:
```
Record 1
Record 2
Record 3
```

Console output:
```
DSPLY  Wrote 3 records
```

## Comparison: WRITEIFS vs WRITEIFS2

### WRITEIFS (SQL Approach)
**Advantages:**
- Simpler code - single SQL CALL statement
- Automatic line ending handling
- No need for file descriptor management
- Built-in REPLACE/APPEND logic
- Less error handling code
- Can query any SQL table/view

**Disadvantages:**
- Requires SQL precompiler
- Less control over file operations
- Limited to SQL capabilities
- Requires IBM i 7.2+
- Cannot set file permissions explicitly

### WRITEIFS2 (Pure RPGLE with C APIs)
**Advantages:**
- No SQL dependency - pure RPGLE
- Full control over file operations
- Can set explicit file permissions
- Works on all IBM i releases
- More flexible for complex operations
- Can use advanced file flags
- Better for binary data
- Faster compilation (no SQL precompiler)

**Disadvantages:**
- More complex code
- Manual file descriptor management
- More error handling required
- Need to manage line endings manually
- Must bind to QC2LE
- Requires physical file (not SQL tables)

## Common Use Cases
- **Legacy Systems**: Working with existing physical files
- **No SQL Dependency**: When SQL precompiler is not available
- **Fine-Grained Control**: When you need specific file permissions or flags
- **Binary Files**: Writing non-text data to IFS
- **Performance**: Direct API calls can be faster for large files
- **Advanced Operations**: Using features not available in SQL services

## Best Practices Demonstrated
1. **Resource Management**: File descriptor closed in all scenarios
2. **Error Checking**: Both errno and %eof() validation
3. **Modern RPG**: Fully free-format with clear variable names
4. **Include Files**: Using modern copybooks for API prototypes
5. **UTF-8 Encoding**: Modern character encoding for portability
6. **Proper Cleanup**: on-error block ensures resources are released
7. **Record Counting**: Tracks number of records processed

## API Reference

### open()
```rpgle
fd = open(path: flags: mode: ccsid);
```
- Returns: File descriptor (>=0) or -1 on error
- Check errno on failure

### write()
```rpgle
bytesWritten = write(fd: buffer: bytes);
```
- Returns: Number of bytes written or -1 on error
- Check errno on failure

### close()
```rpgle
rc = close(fd);
```
- Returns: 0 on success, -1 on error
- Always call to release file descriptor

## Common errno Values
- `EACCES (13)`: Permission denied
- `EEXIST (17)`: File exists (with O_EXCL)
- `ENOENT (2)`: Directory doesn't exist
- `ENOSPC (28)`: No space left on device
- `EROFS (30)`: Read-only file system

## Troubleshooting

### File Not Created
- Check IFS directory exists and is writable
- Verify user has authority to create files in target directory
- Check errno value in job log
- Ensure binding directory QC2LE is available

### Permission Denied
- Verify directory permissions
- Check user profile authorities
- Review file ownership if file already exists
- Consider using different mode value

### Write Failures
- Check available disk space
- Verify file descriptor is valid (>= 0)
- Ensure data length is correct
- Review errno for specific error

### Database File Errors
- Verify MYFILE exists in library list
- Check file has MYDATA field
- Ensure user has read authority to file
- Verify file is not locked

### Encoding Issues
- Ensure CCSID 1208 (UTF-8) is appropriate for your data
- Consider using CP_CURJOB (0) for job CCSID
- Check for special characters in source data
- Verify line ending format (CRLF vs LF)

## Related Examples
- **WRITEIFS**: SQL-based IFS writing (simpler approach)
- **Read from IFS**: Examples using `read()` API
- **Directory Operations**: `opendir()`, `readdir()`, `closedir()`
- **File Information**: `stat()` and `fstat()` examples

## Notes
- The C APIs are available on all IBM i releases
- File descriptor must be closed to flush data and release resources
- UTF-8 encoding ensures compatibility with modern text editors
- CRLF line endings make files readable in Windows environments
- Always check return values from C APIs
- errno is thread-local and should be checked immediately after API failure
- Native RPG file I/O is faster than SQL for simple sequential reads

## Performance Considerations
- C APIs are generally faster than SQL services for large files
- Native RPG file I/O is very efficient for sequential reads
- write() can be called multiple times without reopening file
- Consider buffering for very small writes
- Use O_SYNC flag if immediate disk write is required
- For large files, consider using larger buffer sizes

## Security Considerations
- File permissions are set at creation time
- Default umask may affect final permissions
- Consider using O_EXCL to prevent overwriting existing files
- Validate file paths to prevent directory traversal attacks
- Be cautious with user-supplied file names
- Ensure database file access is properly secured

## Author
Nick Litten

## Version History
- **V1.0** (2026-06-03): Initial creation

## License
This code is provided as an educational example for IBM i developers.