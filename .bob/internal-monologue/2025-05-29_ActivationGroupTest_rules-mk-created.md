# 2025-05-29 - ActivationGroupTest - Rules.mk Created

## Action
Created `IBMi/ActivationGroupTest/Rules.mk` following the TOBi/MAKEi pattern
from `IBMi/HelloWorld/Rules.mk`.

## Files in scope
| Source file | Target |
|---|---|
| `ACTGRPTST-program_With_Caller_Called_From_Actgrp.pgm.rpgle` | `ACTGRPTST.PGM` |
| `ACTGRPTST1.program_In_Actgrp_One.pgm.rpgle` | `ACTGRPTST1.PGM` |
| `ACTGRPTST2-program_In_Actgrp_Two.pgm.rpgle` | `ACTGRPTST2.PGM` |

## Notes
- `ACTGRPTST1` source uses a dot separator instead of a dash (non-standard);
  the Rules.mk reflects the actual filename exactly.
- `ActivationGroupTest` was already listed in the parent `IBMi/Rules.mk` SUBDIRS,
  so no change to the parent was required.
