# ---
# Rules.mk - Single Page Subfile SQL Example Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for single page subfile SQL demonstration
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

# SNGPAGSFL Display File - Country list subfile display file
SNGPAGSFL.FILE: SNGPAGSFL-Country_List_Subfile_SQL_SINGLEPAGE.dspf

# SNGPAGSFL Program - Country list subfile SQL program
# Note: Depends on SAMPLEDB table from database directory
SNGPAGSFL.PGM: SNGPAGSFL-Country_List_Subfile_SQL_SINGLEPAGE.pgm.sqlrpgle SNGPAGSFL.FILE