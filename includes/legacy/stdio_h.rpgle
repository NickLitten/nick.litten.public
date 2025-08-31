     /*-                                                                            +
      * Copyright (c) 2003-2006 Scott C. Klement                                    +
      * All rights reserved.                                                        +
      *                                                                             +
      * Redistribution and use in source and binary forms, with or without          +
      * modification, are permitted provided that the following conditions          +
      * are met:                                                                    +
      * 1. Redistributions of source code must retain the above copyright           +
      *    notice, this list of conditions and the following disclaimer.            +
      * 2. Redistributions in binary form must reproduce the above copyright        +
      *    notice, this list of conditions and the following disclaimer in the      +
      *    documentation and/or other materials provided with the distribution.     +
      *                                                                             +
      * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND      +
      * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE       +
      * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  +
      * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE     +
      * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL  +
      * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS     +
      * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)       +
      * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT  +
      * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY   +
      * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF      +
      * SUCH DAMAGE.                                                                +
      *                                                                             +
      */                                                                            +

      /if defined(STDIO_H)
      /eof
      /endif
      /define STDIO_H

      *-----------------------------------------------------------------
      * Data types
      *-----------------------------------------------------------------
     D pFILE           S               *   based(prototype_only)

     D stdin           s                   like(pFILE)
     D                                     import('_C_IFS_stdin')
     D stdout          s                   like(pFILE)
     D                                     import('_C_IFS_stdout')
     D stderr          s                   like(pFILE)
     D                                     import('_C_IFS_stderr')

      *-----------------------------------------------------------------
      * fopen():  Open File for buffered reading/writing
      *
      *   filename = (input) path to file in the IFS
      *       mode = (input) various open mode flags.  (see manual)
      *
      *  returns *NULL upon error, or a pointer to a FILE structure
      *-----------------------------------------------------------------
     D fopen           PR                  ExtProc('_C_IFS_fopen')
     D                                     like(pFILE)
     D   filename                      *   value options(*string)
     D   mode                          *   value options(*string)


      *-----------------------------------------------------------------
      * fgets(): read a string
      *
      *    string = (output) string read (null-terminated)
      *      size = (input) maximum size that can be stored in string
      *    stream = (input) FILE structure to read data from
      *
      * returns a pointer to the string read from the file
      *      or *NULL upon EOF or error.
      *-----------------------------------------------------------------
     D fgets           PR              *   ExtProc('_C_IFS_fgets')
     D   string                        *   value
     D   size                        10I 0 value
     D   stream                            like(pFILE) value

      *-----------------------------------------------------------------
      * fputs(): Write string
      *
      *    string = (input) string to write to file
      *    stream = (input) FILE structure designating the file to
      *                write to.
      *
      *  returns a non-negative value if successful
      *       or -1 upon error
      *-----------------------------------------------------------------
     D fputs           PR            10I 0 ExtProc('_C_IFS_fputs')
     D   string                        *   value options(*string)
     D   stream                            like(pFILE) value

      *-----------------------------------------------------------------
      * fread(): Read items
      *
      *    data = (input) data items to read
      *    size = (input) size of each data item
      *   count = (input) number of data items
      *  stream = (input) pointer to FILE structure to read from
      *
      * returns the number of full items read, a short count
      *         indicates an error.
      *-----------------------------------------------------------------
     D fread           PR            10U 0 ExtProc('_C_IFS_fread')
     D   data                          *   value
     D   size                        10U 0 value
     D   count                       10U 0 value
     D   stream                            like(pFILE) value

      *-----------------------------------------------------------------
      * fwrite(): Write items
      *
      *    data = (input) data items to write
      *    size = (input) size of each data item
      *   count = (input) number of data items
      *  stream = (input) pointer to FILE structure to write to
      *
      * returns the number of full items written.  A short count
      *         indicates an error.
      *-----------------------------------------------------------------
     D fwrite          PR            10U 0 ExtProc('_C_IFS_fwrite')
     D   data                          *   value
     D   size                        10U 0 value
     D   count                       10U 0 value
     D   stream                            like(pFILE) value

      *-----------------------------------------------------------------
      * fflush():  Flush a stream
      *
      *    stream = (input) pointer to FILE structure to flush
      *
      * returns 0 if successful, -1 otherwise
      *-----------------------------------------------------------------
     D fflush          PR            10U 0 ExtProc('_C_IFS_fflush')
     D   stream                            like(pFILE) value

      *-----------------------------------------------------------------
      * fclose(): Close File
      *
      *    stream = (input) pointer to FILE structure to close
      *-----------------------------------------------------------------
     D fclose          PR            10I 0 ExtProc('_C_IFS_fclose')
     D   stream                            like(pFILE) value

      *-----------------------------------------------------------------
      * fseek(): Reposition a file
      *
      *    stream = (input) pointer to FILE structure to reposition
      *    offset = (input) offset from "whence" in bytes
      *    whence = (input) position to begin offset at, can be
      *                SEEK_SET, SEEK_END or SEEK_CUR
      *
      * returns 0 if successful, -1 otherwise
      *-----------------------------------------------------------------
     D fseek           PR            10I 0 ExtProc('_C_IFS_fseek')
     D   stream                            like(pFILE) value
     D   offset                      10I 0 value
     D   whence                      10I 0 value

      /if not defined(SEEK_WHENCE_VALUES)
     D SEEK_SET        C                   CONST(0)
     D SEEK_CUR        C                   CONST(1)
     D SEEK_END        C                   CONST(2)
      /define SEEK_WHENCE_VALUES
      /endif

      *-----------------------------------------------------------------
      * ftell(): Get Current position
      *
      *    stream = (input) pointer to FILE structure
      *
      * returns the file position, or -1 upon error
      *-----------------------------------------------------------------
     D ftell           PR            10I 0 ExtProc('_C_IFS_ftell')
     D   stream                            like(pFILE) value

      *-----------------------------------------------------------------
      * fdopen():  Upgrade a file descriptor to a buffered stream
      *
      *      fildes = (input) file descriptor to upgrade
      *        mode = (input) mode, equivalent to the mode specified
      *                   on the fopen() API, except that it must be
      *                   compatible with the flags that were used on
      *                   the open() API.
      *
      *  Returns a new pointer to a buffered stream I/O file
      *       or *NULL upon error.
      *-----------------------------------------------------------------
     D fdopen          pr              *   extproc('fdopen')
     D   fildes                      10I 0 value
     D   mode                          *   value options(*string)
