**free

/// Program: SKELTRIG - Skeleton Trigger Program
///
/// Description: Template trigger program demonstrating the standard structure
///              and data handling for database triggers on IBM i. Provides a
///              foundation for implementing custom trigger logic for Insert,
///              Delete, Update, and Read operations with before/after record
///              images and commit lock level handling.
///
/// Purpose: Educational example demonstrating:
///   - Standard trigger program structure and parameter interface
///   - Trigger buffer data structure definition and usage
///   - Before and after record image pointer handling
///   - Event type detection (Insert, Delete, Update, Read)
///   - Trigger timing (Before/After) and commit level handling
///
/// Features:
///   - Complete trigger buffer structure with all standard fields
///   - Pointer-based access to before/after record images
///   - Event type constants for clear code logic
///   - Timing constants (Before/After trigger execution)
///   - Commit lock level constants for transaction control
///   - Based data structures for type-safe record access
///   - Template logic structure for all trigger events
///
/// Usage: ADDPFTRG FILE(library/filename) TRGTIME(*AFTER/*BEFORE)
///                 TRGEVENT(*INSERT/*UPDATE/*DELETE) PGM(library/SKELTRIG)
///        Example: ADDPFTRG FILE(MYLIB/SAMPLEDB) TRGTIME(*AFTER)
///                          TRGEVENT(*UPDATE) PGM(MYLIB/SKELTRIG)
///
/// Parameters:
///   - Trgbuffer: likeds(trigger) - Trigger buffer containing event information
///   - Trgbufferlen: int(10) - Length of trigger buffer
///
/// Dependencies:
///   - Physical file SAMPLEDB (or modify EXTNAME references)
///   - File must exist in library list for compilation
///
/// Control Options:
///   - debug: Enables debugging with source statement view
///   - option(*nodebugio): Disables debug I/O for performance
///   - option(*srcstmt): Shows source statements in debug
///   - datfmt(*iso-): ISO date format with dash separator
///   - timfmt(*iso.): ISO time format with period separator
///   - indent('| '): Custom indentation for readability
///
/// Modification History:
/// 1.0 2017-04-19 | Nick Litten | Initial skeleton creation
/// 1.1 2026-04-02 | Bob AI | Added comprehensive triple-slash documentation

ctl-opt
   copyright('| SKELTRIG V001 2017.04.19')
   debug option(*nodebugio: *srcstmt)
   datfmt(*iso-) timfmt(*iso.)
   indent('| ');

dcl-pi *n;
   Trgbuffer likeds(trigger);
   Trgbufferlen int(10);
end-pi;

// Possible values for Event
dcl-c Insert '1';
dcl-c Delete '2';
dcl-c Update '3';
dcl-c Read '4';

// Possible values for Time
dcl-c After '1';
dcl-c Before '2';

// Possible values for Commitlocklev
dcl-c Cmtnone '0';
dcl-c Cmtchange '1';
dcl-c Cmtcs '2';
dcl-c Cmtall '3';

// Trigger buffer information
dcl-ds trigger qualified;
   File char(10);
   Library char(10);
   Member char(10);
   Event char(1);
   Time char(1);
   Commitlocklev char(1);
   *n char(3);
   Ccsid int(10);
   Rrn int(10);
   *n char(4);
   Befrecoffset int(10);
   Befreclen int(10);
   Befnulloffset int(10);
   Befnulllen int(10);
   Aftrecoffset int(10);
   Aftreclen int(10);
   Aftnulloffset int(10);
   Aftnulllen int(10);
end-ds;

// "Before" record image
dcl-s Befrecptr pointer;
dcl-ds Old extname('SAMPLEDB') based(befrecptr) qualified end-ds;

//  "After" record image
dcl-s Aftrecptr pointer;
dcl-ds New extname('SAMPLEDB') based(aftrecptr) qualified end-ds;

// Map trigger buffer into data structures
Befrecptr = %ADDR(Trgbuffer) + Trgbuffer.Befrecoffset;
Aftrecptr = %ADDR(Trgbuffer) + Trgbuffer.Aftrecoffset;

// Trigger processing goes here
// Refer to  Old field names with "old." qualification
// Refer to new field names with "new." qualification
 select;
  when trgbuffer.event = Insert;
  // add some logic here for Insert processing
  // for example, something like this:
  if old.address <> new.address;
     // write some audit report detailing customers changed of address
  endif;

  when trgbuffer.event = Delete;
   // add some logic here for Delete processing
 
  when trgbuffer.event = Update;
   // add some logic here for Update processing
 
  when trgbuffer.event = Read;
   // add some logic here for Read processing
 
 endsl;

Return;
