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
TARGETS := CONVERT1-Original.pgm.rpgle CONVERT2-Modernized.pgm.rpgle CONVERT3-Modernized_Improved.pgm.rpgle CONVERT4-Convert_EBCDIC_to_ASCII_with_SRVPGM.pgm.rpgle CONVSRV.bnd CONVSRV.bnddir CONVSRV-Conversion_Service.sqlrpgle FILEIN-Input_File.table FILEOUT-Output_File.table