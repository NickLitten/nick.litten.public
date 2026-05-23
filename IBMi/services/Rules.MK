# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules
# -----------------------------------------------------------------------------
# This file defines build targets and subdirectories for the MAKEi build system.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
#
# Variables:
#   TARGETS  - Source files to compile in this directory
#   SUBDIRS  - Subdirectories to process recursively
#
# Usage:
#   make          - Build all targets in this directory
#   make clean    - Remove all built objects
#   make install  - Deploy objects to IBM i system
# -----------------------------------------------------------------------------
TARGETS := BIGBNDDIR-Nicks_Sample_Binding_Directory.bnddir EMAILSRV-Email_Service.bnd EMAILSRV-Email_Service.sqlrpgle NICKSRV-Binder_Source.bnd NICKSRV-Service_Program_for_Lessons.sqlrpgle SIMPLEMOD-Simple_Service_Program.sqlrpgle SIMPLESRV-Binder_Source.bnd USRPRFSRV-User_Profile_Service.bnd USRPRFSRV-User_Profile_Service.sqlrpgle