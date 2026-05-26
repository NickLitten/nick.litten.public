     /*-                                                                            +
      * Copyright (c) 2004 Scott C. Klement                                         +
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
      /if defined(STATVFS_H_DEFINED)
      /eof
      /endif

      /define STATVFS_H_DEFINED

      *---------------------------------------------------------------
      * ds_statvfs - data structure to receive file system info
      *
      *   f_bsize   = file system block size (in bytes)
      *   f_frsize  = fundamental block size in bytes.
      *                if this is zero, f_blocks, f_bfree and f_bavail
      *                are undefined.
      *   f_blocks  = total number of blocks (in f_frsize)
      *   f_bfree   = total free blocks in filesystem (in f_frsize)
      *   f_bavail  = total blocks available to users (in f_frsize)
      *   f_files   = total number of file serial numbers
      *   f_ffree   = total number of unused file serial numbers
      *   f_favail  = number of available file serial numbers to users
      *   f_fsid    = filesystem ID.  This will be 4294967295 if it's
      *                too large for a 10U 0 field. (see f_fsid64)
      *   f_flag    = file system flags (see below)
      *   f_namemax = max filename length.  May be 4294967295 to
      *                indicate that there is no maximum.
      *   f_pathmax = max pathname legnth.  May be 4294967295 to
      *                indicate that there is no maximum.
      *   f_objlinkmax = maximum number of hard-links for objects
      *                other than directories
      *   f_dirlinkmax = maximum number of hard-links for directories
      *   f_fsid64  = filesystem id (in a 64-bit integer)
      *   f_basetype = null-terminated string containing the file
      *                  system type name.  For example, this might
      *                  be "root" or "Network File System (NFS)"
      *
      *  Since f_basetype is null-terminated, you should read it
      *  in ILE RPG with:
      *       myString = %str(%addr(ds_statvfs.f_basetype))
      *---------------------------------------------------------------
     D ds_statvfs      DS                  qualified
     D  f_bsize                      10U 0
     D  f_frsize                     10U 0
     D  f_blocks                     20U 0
     D  f_bfree                      20U 0
     D  f_bavail                     20U 0
     D  f_files                      10U 0
     D  f_ffree                      10U 0
     D  f_favail                     10U 0
     D  f_fsid                       10U 0
     D  f_flag                       10U 0
     D  f_namemax                    10U 0
     D  f_pathmax                    10U 0
     D  f_objlinkmax                 10I 0
     D  f_dirlinkmax                 10I 0
     D  f_reserved1                   4A
     D  f_fsid64                     20U 0
     D  f_basetype                   80A

      *---------------------------------------------------------------
      * flags specified in the f_flags element of the ds_statvfs
      *   data structure.
      *---------------------------------------------------------------
     D ST_RDONLY...
     D                 C                   CONST(1)
     D ST_NOSUID...
     D                 C                   CONST(2)
     D ST_CASE_SENSITITIVE...
     D                 C                   CONST(4)
     D ST_CHOWN_RESTRICTED...
     D                 C                   CONST(8)
     D ST_THREAD_SAFE...
     D                 C                   CONST(16)
     D ST_DYNAMIC_MOUNT...
     D                 C                   CONST(32)
     D ST_NO_MOUNT_OVER...
     D                 C                   CONST(64)
     D ST_NO_EXPORTS...
     D                 C                   CONST(128)
     D ST_SYNCHRONOUS...
     D                 C                   CONST(256)


      *---------------------------------------------------------------
      * statvfs() -- Get file system status
      *
      *    path = (input) pathname of a link ("file") in the IFS.
      *     buf = (output) data structure containing file system info
      *
      * Returns 0 if successful, -1 upon error.
      * (error information is returned via the "errno" variable)
      *---------------------------------------------------------------
     D statvfs         PR            10I 0 ExtProc('statvfs64')
     D   path                          *   value options(*string)
     D   buf                               like(ds_statvfs)
