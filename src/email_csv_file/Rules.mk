# ---
# Rules.mk - Email CSV File Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for CSV file email utilities
# ---
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ---

# ---
# Compilation Settings
# ---
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# ---
# Object Dependencies
# ---

# EMLCSVFILE Command - Email CSV file command
EMLCSVFILE.CMD: EMLCSVFILE-this_calls_EMLCSVFILE.cmd

# EMLCSVFILE Program - Email CSV file CL program
EMLCSVFILE.PGM: EMLCSVFILE-email_CSV_File.pgm.clle