**FREE

///==============================================================================
/// Program: IFSREAD
/// Description: Classic IFS File Read Example Using Native IBM i APIs
///
/// Purpose:
/// - Demonstrate reading IFS files using native IBM i C runtime APIs
/// - Show proper error handling for IFS operations
/// - Display file contents line by line
/// - Illustrate best practices for IFS file handling
///
/// Features:
/// - Uses open(), read(), and close() APIs from ifsio_h
/// - Proper error checking with errno
/// - Buffer management for file reading
/// - Line-by-line processing of text files
/// - Clean resource management
///
/// Usage:
///   CALL IFSREAD PARM('/path/to/file.txt')
///
/// Parameters:
///   pFilePath - Full IFS path to file to read (up to 256 chars)
///
/// Example:
///   CALL IFSREAD PARM('/home/myuser/test.txt')
///
/// Lesson URL:
///   https://www.nicklitten.com/course/rpgle-example-reading-from-ifs/
///
/// Modification History:
/// Date       Author        Description
/// ---------- ------------- --------------------------------------------------
/// 2021-01-03 Nick Litten   Initial version - Classic IFS read example
///==============================================================================

ctl-opt dftactgrp(*no) actgrp(*caller)
        bnddir('QC2LE')
        copyright('1.0 - Read IFS File Using Native APIs');

// ---
// IFS API Prototypes
// ---
dcl-pr open int(10) extproc('open');
   path pointer value options(*string);
   oflag int(10) value;
   mode uns(10) value options(*nopass);
   codepage uns(10) value options(*nopass);
end-pr;

dcl-pr read int(10) extproc('read');
   fildes int(10) value;
   buf pointer value;
   nbyte uns(10) value;
end-pr;

dcl-pr close int(10) extproc('close');
   fildes int(10) value;
end-pr;

dcl-pr strerror pointer extproc('strerror');
   errnum int(10) value;
end-pr;

// ---
// Constants
// ---
Dcl-C O_RDONLY 1;           // Open for read only
Dcl-C O_TEXTDATA 16777216;  // Text data conversion
Dcl-C BUFFER_SIZE 4096;     // Read buffer size

// ---
// Global Variables
// ---
Dcl-S fd int(10);           // File descriptor
Dcl-S bytesRead int(10);    // Bytes read from file
Dcl-S buffer char(BUFFER_SIZE); // Read buffer
Dcl-S lineBuffer char(256); // Line processing buffer
Dcl-S linePos int(10);      // Position in line buffer
Dcl-S totalLines int(10);   // Total lines read
Dcl-S i int(10);            // Loop counter
Dcl-S errorMsg char(256);   // Error message
Dcl-S errorPtr pointer;     // Pointer to error message

// ---
// Parameters
// ---
Dcl-Pi *n;
   pFilePath char(256) const;
end-pi;

// ---
// Main Processing
// ---

// Initialize
fd = -1;
totalLines = 0;
linePos = 0;
lineBuffer = *blanks;

// Display header
dsply ('IFS File Reader');
dsply ('================');
dsply ('File: ' + %trim(pFilePath));
dsply *blank;

// Open the file
fd = open(%trim(pFilePath): O_RDONLY + O_TEXTDATA);

If (fd < 0);
   errorPtr = strerror(errno);
   errorMsg = %str(errorPtr);
   dsply ('ERROR: Cannot open file');
   dsply ('Reason: ' + %trim(errorMsg));
   *inlr = *on;
   Return;
EndIf;

dsply ('File opened successfully');
dsply ('Reading contents:');
dsply ('---';

// Read file contents
dow (bytesRead >= 0);
  
   // Read chunk from file
   bytesRead = read(fd: %addr(buffer): BUFFER_SIZE);
  
   If (bytesRead < 0);
      errorPtr = strerror(errno);
      errorMsg = %str(errorPtr);
      dsply ('ERROR: Read failed');
      dsply ('Reason: ' + %trim(errorMsg));
      leave;
   EndIf;
  
   If (bytesRead = 0);
      // End of file - process any remaining line
      If (linePos > 0);
         totalLines += 1;
         dsply (%char(totalLines) + ': ' + %subst(lineBuffer:1:linePos));
      EndIf;
      leave;
   EndIf;
  
   // Process buffer character by character
   for i = 1 to bytesRead;
    
      // Check for newline
      If ((%subst(buffer:i:1) = x'15' or  // Newline (EBCDIC)
       %subst(buffer:i:1) = x'25';))    // Line feed
      
         // Display the line
         totalLines += 1;
         If (linePos > 0);
            dsply (%char(totalLines) + ': ' + %subst(lineBuffer:1:linePos));
         Else;
            dsply (%char(totalLines) + ': ');
         EndIf;
      
         // Reset line buffer
         lineBuffer = *blanks;
         linePos = 0;
      
      Else;
         // Add character to line buffer
         If (linePos < %len(lineBuffer));
            linePos += 1;
            %subst(lineBuffer:linePos:1) = %subst(buffer:i:1);
         EndIf;
      EndIf;
    
   endfor;
  
enddo;

// Close the file
If (fd >= 0);
   close(fd);
   dsply ('---';
   dsply ('File closed successfully');
EndIf;

// Display summary
dsply *blank;
dsply ('Total lines read: ' + %char(totalLines));

*inlr = *on;
Return;