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

# LISTLIBS Program - List libraries and call QLIRLIBD API
LISTLIBS.PGM: LISTLIBS-List_Libraries_and_Call_QLIRLIBD.pgm.clle

# LISTLIBS2 Program - Enhanced library list with API
LISTLIBS2.PGM: LISTLIBS2-Enhanced_Library_List_with_API.pgm.clle

# LSTLIBSIMP Program - Simple library list example
LSTLIBSIMP.PGM: LSTLIBSIMP-List_Libraries_Simply.pgm.clle