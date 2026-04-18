# ------------------------------------------------------------------------------
# Rules.mk - Build rules for Single Page Subfile SQL Example
# ------------------------------------------------------------------------------
# This directory contains a single page subfile example using SQL to display
# European country information from the SAMPLEDB table.
#
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ------------------------------------------------------------------------------

# Default compilation settings for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# ------------------------------------------------------------------------------
# Object Dependencies
# ------------------------------------------------------------------------------

# SAMPLESFL Display File - Country list subfile display file
SAMPLESFL.FILE: SAMPLESFL-Country_List_Subfile_SQL_SINGLEPAGE.dspf

# SAMPLESFL Program - Country list subfile SQL program
# Note: Depends on SAMPLEDB table from database directory
SAMPLESFL.PGM: SAMPLESFL-Country_List_Subfile_SQL_SINGLEPAGE.pgm.sqlrpgle SAMPLESFL.FILE

# Made with Bob
