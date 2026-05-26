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
TARGETS := CHKSBSACT1-Example_from_blog.pgm.clle CHKSBSACT2-Example_from_blog.pgm.clle CHKSBSACT-Check_if_subsystem_is_active.cmd CHKSBSACT-Check_if_subsystem_is_active.pgm.clle