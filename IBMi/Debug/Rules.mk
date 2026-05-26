# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - Debug Module
# -----------------------------------------------------------------------------
# This file defines build targets for the Debug utilities.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
BUGMECL.PGM:      BUGMECL-This_is_a_debugging_example.pgm.clle
BUGMERPG.PGM:     BUGMERPG-This_is_a_debugging_example.pgm.rpgle
BUGME.CMD:        BUGME-This_is_a_debugging_example.cmd BUGMECL.PGM