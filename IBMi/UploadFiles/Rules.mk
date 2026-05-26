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
TARGETS := CSVFILE-Upload_CSV_File.table FLATFILE-Upload_Flat_File.table SIMPIMPF-Simple_Import_File_Example.pgm.clle SIMPIMPFV2-Simple_Import_File_Example_Enhanced.pgm.clle