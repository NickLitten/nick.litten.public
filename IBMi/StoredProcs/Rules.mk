# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - StoredProcs Module
# -----------------------------------------------------------------------------
# This file defines build targets for the StoredProcs examples.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
STOREPRCR.PGM:    STOREPRCR-Stored_Procedure_RPG_Employee.pgm.rpgle
STOREPRCS.PGM:    STOREPRCS-Stored_Procedure_SQLRPG_Employee.pgm.sqlrpgle