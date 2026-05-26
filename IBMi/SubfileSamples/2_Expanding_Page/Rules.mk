# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - SubfileSamples/2_Expanding_Page
# -----------------------------------------------------------------------------
# This file defines build targets for the Expanding Page subfile examples.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
PERSONSFL.FILE:   PERSONSFL-Person_expanding_page_subfile.dspf
PERSONSFL.PGM:    PERSONSFL-Person_expanding_page_subfile.pgm.sqlrpgle PERSONSFL.FILE