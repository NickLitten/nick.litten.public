# ==============================================================================
# Rules.mk - Build rules for List Libraries
# ==============================================================================
# This file defines the build rules for listing library examples.
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

# LSTLIB File - Library list workfile
LSTLIB.FILE: LSTLIB-Library_List_workfile.table

# LSTLIBSIMP Program - Simple library list example
LSTLIBSIMP.PGM: LSTLIBSIMP-List_Libraries_Simply.pgm.clle