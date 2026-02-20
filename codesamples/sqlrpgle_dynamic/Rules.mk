# ==============================================================================
# Rules.mk - Build rules for SQL RPGLE Dynamic Examples
# ==============================================================================
# This file defines the build rules for dynamic SQL RPGLE examples.
#
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ==============================================================================

# Default compilation settings for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# ==============================================================================
# Object Dependencies
# ==============================================================================

# SQLREAD Program - Sample SQL RPG dynamic file read
SQLREAD.PGM: SQLREAD-Sample_SQL_RPG_Dynamic_File_read.pgm.sqlrpgle