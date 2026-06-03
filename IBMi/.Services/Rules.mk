# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - Services Module
# -----------------------------------------------------------------------------
# This file defines build targets for the Services (service programs).
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
SIMPLEMOD.MODULE: SIMPLEMOD-Simple_Service_Program.sqlrpgle
SIMPLESRV.SRVPGM: SIMPLESRV-Binder_Source.bnd SIMPLEMOD.MODULE

SMALLMOD.MODULE:   SMALLMOD-Service_Program_for_Lessons.sqlrpgle
SMALLSRV.SRVPGM:   SMALLSRV-Binder_Source.bnd SMALLMOD.MODULE

BIGFATSRV.MODULE: BIGFATSRV-Nicks_Big_Fat_Service_Program.sqlrpgle
BIGFATSRV.SRVPGM: BIGFATSRV-Nicks_Big_Fat_Service_Program.bnd BIGFATMOD.MODULE

BIGBNDDIR.BNDDIR: BIGBNDDIR-Nicks_Big_Fat_Binding_Directory.bnddir SIMPLESRV.SRVPGM SMALLSRV.SRVPGM BIGFATSRV.SRVPGM