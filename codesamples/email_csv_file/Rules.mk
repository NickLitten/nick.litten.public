# ==============================================================================
# Rules.mk - Build rules for Email CSV File
# ==============================================================================
# This file defines the build rules for emailing CSV files.
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

# EMLCSVFILE Command - Email CSV file command
EMLCSVFILE.CMD: EMLCSVFILE-this_calls_EMLCSVFILE.cmd

# EMLCSVFILE Program - Email CSV file CL program
EMLCSVFILE.PGM: EMLCSVFILE-email_CSV_File.pgm.clle