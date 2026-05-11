# ------------------------------------------------------------
# Rules.mk - Build rules for Conversion Programs
# ------------------------------------------------------------
# This file defines the build rules for conversion programs.
#
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ------------------------------------------------------------

# Default compilation settings for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# ------------------------------------------------------------
# Object Dependencies
# ------------------------------------------------------------

# Input and output file dependencies
FILEIN.FILE: filein.table
FILEOUT.FILE: fileout.table

# CONVSRV Module - Conversion service program module using CCSID
CONVSRV.MODULE: CONVSRV-Conversion_Service.sqlrpgle

# CONVSRV Binding Directory - Binding directory for conversion services
CONVSRV.BNDDIR: CONVSRV.bnddir

# CONVSRV Service Program - Character conversion service using CCSID
CONVSRV.SRVPGM: CONVSRV.bnd CONVSRV.MODULE

# CONVERT Programs - Various conversion examples
CONVERT1.PGM: CONVERT1-Original.pgm.rpgle
CONVERT2.PGM: CONVERT2-Modernized.pgm.rpgle
CONVERT3.PGM: CONVERT3-Modernized_Improved.pgm.rpgle

# CONVERT4 Program - EBCDIC to ASCII conversion using CONVSRV service program
CONVERT4.PGM: CONVERT4-Convert_EBCDIC_to_ASCII_with_SRVPGM.pgm.rpgle CONVSRV.SRVPGM
