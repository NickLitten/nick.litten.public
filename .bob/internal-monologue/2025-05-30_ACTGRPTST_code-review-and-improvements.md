# 2025-05-30 ACTGRPTST - Code Review and Improvements

## Task
User requested improvements to ACTGRPTST for readability, performance, and best practices.

## Changes Made

### ACTGRPTST-program_With_Caller_Called_From_Actgrp.pgm.rpgle
- Added `**FREE` directive (was missing, used legacy indentation)
- Added full `///` doc header with version, author, purpose, parameters, history
- Updated `copyright()` to versioned format `'1.0 - ...'`
- Added `bnddir('QC2LE')` per project rules
- Fixed PR/PI name casing mismatch (`EntryPList`/`EntryPlist` → both `ACTGRPTST`)
- Changed `count` from `zoned(10)` to `int(10) static` — binary arithmetic, persists across calls within same actgrp
- Renamed `joblogData1`/`joblogData2` → `logTitle`/`logBody` (cleaner)
- Removed misleading `inz('Title')`/`inz('Body')` (values immediately overwritten)
- Removed leading `|` from logBody message (was `|ACTGRP is (...)`, now `ACTGRP is (...)`)
- Replaced inline Qp0zLprintf prototype with `/copy` of shared include
- Standardised `%trim` casing (was `%trim`/`%Trim` mixed)

### ACTGRPTST1-program_In_Actgrp_One.pgm.rpgle
### ACTGRPTST2-program_In_Actgrp_Two.pgm.rpgle
- Same structural changes: `**FREE`, doc header, `bnddir`, shared `/copy`
- Renamed `parameter` → `actgrpName` for clarity
- Removed misleading variable initialisations

### QPROTO-Qp0zLprintf_Prototype.rpgleinc (NEW)
- Extracted `Qp0zLprintf` prototype into a shared include
- Eliminates three-way duplication

### Rules.mk
- Added `QPROTO` variable for the shared include
- All three PGM targets now depend on `$(QPROTO)` for correct rebuild triggers
