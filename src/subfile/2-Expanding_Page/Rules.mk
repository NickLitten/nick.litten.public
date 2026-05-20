# ---
# Rules.mk - Expanding Page Subfile Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for expanding page subfile demonstration
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

# PERSONSFL Display File - Person expanding page subfile display file
PERSONSFL.FILE: PERSONSFL-Person_expanding_page_subfile.dspf

# PERSONSFL Program - Person expanding page subfile SQL program
# Note: Depends on PERSONTBL table from database directory
PERSONSFL.PGM: PERSONSFL-Person_expanding_page_subfile.pgm.sqlrpgle PERSONSFL.FILE

# Made with Bob
