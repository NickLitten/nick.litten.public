# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - CheckSubsystemActive Module
# -----------------------------------------------------------------------------
# This file defines build targets for the CheckSubsystemActive utilities.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
#
# Build Order:
#   1. Main program (CHKSBSACT.PGM)
#   2. Command object (CHKSBSACT.CMD)
#   3. Example programs (CHKSBSACT1.PGM, CHKSBSACT2.PGM)
#
# Usage: make -f Rules.mk [target]
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
CHKSBSACT.PGM:    CHKSBSACT-Check_if_subsystem_is_active.pgm.clle
CHKSBSACT.CMD:    CHKSBSACT-Check_if_subsystem_is_active.cmd CHKSBSACT.PGM
CHKSBSACT1.PGM:   CHKSBSACT1-Example_from_blog.pgm.clle CHKSBSACT.PGM
CHKSBSACT2.PGM:   CHKSBSACT2-Example_from_blog.pgm.clle CHKSBSACT.PGM