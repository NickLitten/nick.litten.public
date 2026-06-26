# 2026-06-04 | BIGFATSRV | LogMessage - Fixed SND-MSG *COMP/*DIAG limitation

## Problem
`LogMessage` in `BIGFATSRV` had a long-standing TODO comment asking why
`SND-MSG *COMP message` and `SND-MSG *DIAG message` did not work.

## Root Cause
The RPG `SND-MSG` opcode only supports `*INFO` when sending ad-hoc character
data (immediate text). The types `*COMP`, `*DIAG`, `*ESCAPE`, `*NOTIFY`,
`*STATUS` require a pre-defined message ID in a message file. Attempting to
use `SND-MSG *COMP charVar` results in runtime error status 126.

## Fix
Replaced `SND-MSG` with a direct call to the `QMHSNDPM` (Send Program Message)
system API. QMHSNDPM accepts all message types for immediate text by passing a
blank message ID and blank message file, with the text in the message data
parameter. The call stack entry is `'*'` at level `1` (one frame up = the
caller of `LogMessage`).

## Files Changed
- `IBMi/.Services/BIGFATSRV-Nicks_Big_Fat_Service_Program.sqlrpgle`
  - Removed old commented-out SND-MSG attempts and TODO
  - Added `QMHSNDPM` prototype inline in the procedure
  - Updated procedure doc header to `///` triple-slash format
