# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - WebServices/WEBFOOD
# -----------------------------------------------------------------------------
# This file defines build targets for the WEBFOOD webservice examples.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
WEBFOOD.PGM:      WEBFOOD-Sample_Webservice_for_FOODFILE.pgm.rpgle
WEBFOODNEW.PGM:   WEBFOODNEW-Sample_Webservice_for_FOODFILE.pgm.rpgle