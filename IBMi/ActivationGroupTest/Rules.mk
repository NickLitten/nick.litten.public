# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - ActivationGroupTest Module
# -----------------------------------------------------------------------------
# Demonstrates activation group behaviour: *CALLER vs named actgrp
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# Shared include (Qp0zLprintf prototype)
QPROTO := QPROTO-Qp0zLprintf_Prototype.rpgleinc

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
ACTGRPTST.PGM:  ACTGRPTST-program_With_Caller_Called_From_Actgrp.pgm.rpgle  $(QPROTO)
ACTGRPTST1.PGM: ACTGRPTST1-program_In_Actgrp_One.pgm.rpgle                  $(QPROTO)
ACTGRPTST2.PGM: ACTGRPTST2-program_In_Actgrp_Two.pgm.rpgle                  $(QPROTO)
