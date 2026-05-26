# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - UploadFiles Module
# -----------------------------------------------------------------------------
# This file defines build targets for the UploadFiles utilities.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
CSVFILE.FILE:     CSVFILE-CSV_Import_Work_File_Ingredient_Data.table
FLATFILE.FILE:    FLATFILE-Flat_File_Import_Work_File_Generic_Data.table
SIMPIMPF.PGM:     SIMPIMPF-Simple_Import_File_Example.pgm.clle FLATFILE.FILE
SIMPIMPFV2.PGM:   SIMPIMPFV2-Simple_Import_File_Example_Enhanced.pgm.clle CSVFILE.FILE