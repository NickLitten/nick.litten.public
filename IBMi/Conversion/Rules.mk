# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - Conversion Module
# -----------------------------------------------------------------------------
# This file defines build targets for the Conversion utilities.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
FILEIN.FILE:      filein.table
FILEOUT.FILE:     fileout.table
CONVSRV.MODULE:   CONVSRV-Conversion_Service.sqlrpgle
CONVSRV.SRVPGM:   CONVSRV.bnd CONVSRV.MODULE
CONVSRV.BNDDIR:   CONVSRV.bnddir CONVSRV.SRVPGM
CONVERT3.PGM:     CONVERT3-Modernized_Improved.pgm.rpgle
CONVERT4.PGM:     CONVERT4-Convert_EBCDIC_to_ASCII_with_SRVPGM.pgm.rpgle CONVSRV.SRVPGM