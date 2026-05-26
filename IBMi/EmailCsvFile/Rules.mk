# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - EmailCsvFile Module
# -----------------------------------------------------------------------------
# This file defines build targets for the EmailCsvFile utilities.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
EMLCSVFILE.PGM:   EMLCSVFILE-email_CSV_File.pgm.clle
EMLCSVFILE.CMD:   EMLCSVFILE-this_calls_EMLCSVFILE.cmd EMLCSVFILE.PGM