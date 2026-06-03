# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - Update IASP Module
# -----------------------------------------------------------------------------
# This file defines build targets for the IASP job description update utilities.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
#
# Build Order:
#   1. CLLE version (UPDIASP.PGM)
#   2. SQLRPGLE version (UPDIASPSQL.PGM)
#
# Usage: make -f Rules.mk [target]
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
UPDIASP.PGM:      UPDIASP-Update_IASP_Job_Descriptions.pgm.clle
UPDIASPSQL.PGM:   UPDIASPSQL-Update_IASP_Job_Descriptions.pgm.sqlrpgle
