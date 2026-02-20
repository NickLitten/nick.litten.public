# ==============================================================================
# Rules.mk - Build rules for SQL Encryption Examples
# ==============================================================================
# This file defines the build rules for SQL encryption examples.
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

# GETENC Program - Get encryption data example
GETENC.PGM: GETENC-Get_Encryption_Data.pgm.sqlrpgle