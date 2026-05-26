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
TARGETS := NOOBDSPF-Full_load_sfl_with_incrementing_value.dspf NOOBSFL1-Full_load_subfile_example_AS400_STYLE.pgm.rpgle NOOBSFL2-Full_load_subfile_example_ISERIES_STYLE.pgm.rpgle NOOBSFL3-Full_load_subfile_example_IBMi_STYLE.pgm.rpgle NOOBSFL4-Full_load_subfile_example_IBMi_BOB_STYLE.pgm.rpgle