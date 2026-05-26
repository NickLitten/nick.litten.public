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

NICKSRV.MODULE:   NICKSRV-Service_Program_for_Lessons.sqlrpgle
NICKSRV.SRVPGM:   NICKSRV-Binder_Source.bnd NICKSRV.MODULE

EMAILSRV.MODULE:  EMAILSRV-Email_Service.sqlrpgle
EMAILSRV.SRVPGM:  EMAILSRV-Email_Service.bnd EMAILSRV.MODULE

USRPRFSRV.MODULE: USRPRFSRV-User_Profile_Service.sqlrpgle
USRPRFSRV.SRVPGM: USRPRFSRV-User_Profile_Service.bnd USRPRFSRV.MODULE

BIGBNDDIR.BNDDIR: BIGBNDDIR-Nicks_Sample_Binding_Directory.bnddir SIMPLESRV.SRVPGM NICKSRV.SRVPGM EMAILSRV.SRVPGM USRPRFSRV.SRVPGM