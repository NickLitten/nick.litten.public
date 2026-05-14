# ---
# Rules.mk - Upload Files Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for file import and upload utilities
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

# FLATFILE Table - Flat file format definition
FLATFILE.FILE: flatfile.table

# CSVFILE Table - CSV file format definition
CSVFILE.FILE: csvfile.table

# SIMPIMPF Program - Simple import file example
SIMPIMPF.PGM: SIMPIMPF-Simple_Import_File_Example.pgm.clle

# SIMPIMPFV2 Program - Enhanced import file example
SIMPIMPFV2.PGM: SIMPIMPFV2-Simple_Import_File_Example_Enhanced.pgm.clle