# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - ListLibraries Module
# -----------------------------------------------------------------------------
# This file defines build targets for the ListLibraries utilities.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
LSTLIB.FILE:      LSTLIB-Library_List_workfile.table
LSTLIBSIMP.PGM:   LSTLIBSIMP-List_Libraries_Simply.pgm.clle LSTLIB.FILE