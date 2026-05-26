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
TARGETS := SIMPLEDSPF-Display_file_for_the_subfile_example.dspf SIMPLESFL1-AS400_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLESFL2-IBMi_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLESFL3-IBMi_RPG_subfile_FULL_LOAD_IBMi_BOB_Style.pgm.rpgle