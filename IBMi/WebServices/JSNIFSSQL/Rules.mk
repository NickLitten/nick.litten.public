# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - WebServices/JSNIFSSQL
# -----------------------------------------------------------------------------
# This file defines build targets for the JSNIFSSQL webservice examples.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
JSNIFSSQL1.PGM:    JSNIFSSQL1-JSON_TABLE_Decode_JSON_API.pgm.sqlrpgle
#JSNIFSSQL2.PGM:    JSNIFSSQL2-JSON_TABLE_Decode_JSON_SQL.pgm.sqlrpgle