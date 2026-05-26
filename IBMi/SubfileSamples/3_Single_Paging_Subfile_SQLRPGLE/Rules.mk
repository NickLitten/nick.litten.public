# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - SubfileSamples/3_Single_Paging_Subfile_SQLRPGLE
# -----------------------------------------------------------------------------
# This file defines build targets for the Single Paging Subfile SQLRPGLE examples.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
SNGPAGSFL.FILE:   SNGPAGSFL-Country_List.dspf
SNGPAGSFL.PGM:    SNGPAGSFL-Country_List.pgm.sqlrpgle SNGPAGSFL.FILE