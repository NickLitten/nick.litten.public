# ---
# Rules.mk - List Libraries Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for library list management utilities
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

# LSTLIB File - Library list workfile
LSTLIB.FILE: LSTLIB-Library_List_workfile.table

# LSTLIBSIMP Program - Simple library list example
LSTLIBSIMP.PGM: LSTLIBSIMP-List_Libraries_Simply.pgm.clle