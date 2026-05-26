# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - EmailOutq Module
# -----------------------------------------------------------------------------
# This file defines build targets for the EmailOutq utilities.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
EMLOUTQ.PGM:      EMLOUTQ-Email_outq_cpp.pgm.clle
EMLOUTQ.CMD:      EMLOUTQ-Email_outq.cmd EMLOUTQ.PGM