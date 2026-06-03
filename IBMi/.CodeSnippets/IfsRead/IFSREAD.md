# IFSREAD - IFS File Reader Using Native IBM i APIs

## Overview

IFSREAD is a classic example of reading IFS (Integrated File System) files using native IBM i C runtime APIs. This program demonstrates low-level file I/O operations without relying on SQL or higher-level abstractions.

## Purpose

This example teaches fundamental concepts for IFS file handling on IBM i:

- **Native API Usage**: Direct use of C runtime functions (open, read, close)
- **Error Handling**: Proper checking of return codes and errno values
- **Buffer Management**: Efficient reading with chunked I/O
- **Character Processing**: Line-by-line text file parsing
- **Resource Management**: Proper file descriptor lifecycle

## Features

### Core Functionality
- Opens IFS files in read-only text mode
- Reads file contents in 4KB chunks for efficiency
- Processes files character-by-character to detect line boundaries
- Displays each line with line numbers
- Handles EBCDIC newline characters (x'15' and x'25')
- Provides detailed error messages using strerror()

### Technical Highlights
- **API Integration**: Uses open(), read(), close() from C runtime
- **Error Detection**: Checks file descriptor and read return values
- **Text Conversion**: O_TEXTDATA flag for automatic CCSID conversion
- **Buffer Strategy**: 4KB read buffer with 256-byte line buffer
- **Clean Shutdown**: Ensures file closure even on errors

## Usage

### Basic Call
```
CALL IFSREAD PARM('/path/to/file.txt')
```

### Examples
```
CALL IFSREAD PARM('/home/myuser/test.txt')
CALL IFSREAD PARM('/tmp/logfile.log')
CALL IFSREAD PARM('/www/myapp/config.json')
```

## Parameters

| Parameter | Type | Length | Description |
|-----------|------|--------|-------------|
| pFilePath | CHAR | 256 | Full IFS path to file to read |

## Output

The program displays:
1. Header with file path
2. File contents line-by-line with line numbers
3. Summary with total lines read
4. Error messages if file cannot be opened or read

### Sample Output
```
IFS File Reader
================
File: /home/myuser/test.txt

File opened successfully
Reading contents:
---
1: This is line one
2: This is line two
3: This is line three
---
File closed successfully

Total lines read: 3
```

## API Reference

### open()
Opens an IFS file and returns a file descriptor.

**Prototype:**
```rpgle
dcl-pr open int(10) extproc('open');
  path pointer value options(*string);
  oflag int(10) value;
  mode uns(10) value options(*nopass);
  codepage uns(10) value options(*nopass);
end-pr;
```

**Flags Used:**
- `O_RDONLY (1)`: Open for reading only
- `O_TEXTDATA (16777216)`: Enable text data conversion

**Returns:** File descriptor (>=0) on success, -1 on error

### read()
Reads data from an open file descriptor into a buffer.

**Prototype:**
```rpgle
dcl-pr read int(10) extproc('read');
  fildes int(10) value;
  buf pointer value;
  nbyte uns(10) value;
end-pr;
```

**Returns:** Number of bytes read, 0 at EOF, -1 on error

### close()
Closes an open file descriptor.

**Prototype:**
```rpgle
dcl-pr close int(10) extproc('close');
  fildes int(10) value;
end-pr;
```

**Returns:** 0 on success, -1 on error

### strerror()
Converts errno value to human-readable error message.

**Prototype:**
```rpgle
dcl-pr strerror pointer extproc('strerror');
  errnum int(10) value;
end-pr;
```

**Returns:** Pointer to null-terminated error message string

## Error Handling

The program handles errors at multiple levels:

### File Open Errors
- Invalid path
- Permission denied
- File not found
- Path too long

### Read Errors
- I/O error during read
- File descriptor closed unexpectedly
- Device errors

### Error Message Display
All errors display:
1. Error type (open/read failure)
2. System error message from strerror()
3. Graceful program termination

## Technical Details

### Buffer Management
- **Read Buffer**: 4096 bytes for efficient I/O
- **Line Buffer**: 256 bytes for display
- **Processing**: Character-by-character to detect newlines
- **Overflow**: Lines longer than 256 chars are truncated

### Character Encoding
- Uses O_TEXTDATA for automatic CCSID conversion
- Handles EBCDIC newline characters:
  - x'15': Newline (NL)
  - x'25': Line Feed (LF)
- Converts IFS file encoding to job CCSID

### Performance Considerations
- Reads in 4KB chunks to minimize I/O operations
- Single-pass processing without file rewinding
- Minimal memory footprint
- Suitable for files of any size

## Compilation

### Using MAKEi/TOBi
```
gmake IFSREAD.PGM
```

### Manual Compilation
```
CRTRPGMOD MODULE(MYLIB/IFSREAD) 
          SRCSTMF('/path/to/IFSREAD-Read_IFS_File_Using_Native_APIs.pgm.rpgle')
          DBGVIEW(*SOURCE)

CRTPGM PGM(MYLIB/IFSREAD)
       MODULE(MYLIB/IFSREAD)
       BNDSRVPGM(QC2LE)
       ACTGRP(*CALLER)
```

## Dependencies

- **Binding Directory**: QC2LE (C runtime library)
- **Activation Group**: *CALLER
- **Authority**: *USE on IFS file and parent directories

## Limitations

- Line buffer limited to 256 characters
- Text files only (binary files not supported)
- No write capability (read-only)
- Single file at a time
- No directory traversal

## Best Practices Demonstrated

1. **Resource Management**: Always close file descriptors
2. **Error Checking**: Validate all API return values
3. **Error Messages**: Use strerror() for meaningful errors
4. **Buffer Sizing**: Balance memory vs. I/O efficiency
5. **Text Mode**: Use O_TEXTDATA for text files
6. **Activation Groups**: Use *CALLER for utility programs
7. **Documentation**: Comprehensive inline comments

## Related Examples

- **IFSWRITE**: Writing to IFS files
- **IFSDIR**: Directory listing and traversal
- **IFSSTAT**: File information and attributes
- **IFSAPI**: Complete IFS API wrapper service program

## References

- IBM i IFS APIs: https://www.ibm.com/docs/en/i/7.5?topic=functions-ifs
- C Runtime Functions: https://www.ibm.com/docs/en/i/7.5?topic=extensions-ile-c-runtime-functions
- IFS Programming: https://www.ibm.com/docs/en/i/7.5?topic=system-integrated-file

## Version History

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 1.0 | 2026-06-03 | Nick Litten | Initial version - Classic IFS read example |

## License

This code is provided as an educational example for IBM i developers.

## Author

Nick Litten - IBM i Developer and Educator