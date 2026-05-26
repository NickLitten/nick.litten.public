# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - ClearBobLogs Module
# -----------------------------------------------------------------------------
# This file defines build targets for the ClearBobLogs utility.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
#
# Build Order:
#   1. Main program (CLRBOBLOG.PGM)
#   2. Command object (CLRBOBLOG.CMD)
#
# Usage: make -f Rules.mk [target]
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
CLRBOBLOG.PGM:    CLRBOBLOG-Clear_Bob_Logs.pgm.clle
CLRBOBLOG.CMD:    CLRBOBLOG-Clear_Bob_Logs.cmd CLRBOBLOG.PGM