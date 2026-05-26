# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - MySqlServer Module
# -----------------------------------------------------------------------------
# This file defines build targets for the MySqlServer utilities.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
MYSQLCTL.PGM:     MYSQLCTL-My_SQL_Control.pgm.clle
MYSQLCTL.CMD:     MYSQLCTL-My_SQL_Control.cmd MYSQLCTL.PGM