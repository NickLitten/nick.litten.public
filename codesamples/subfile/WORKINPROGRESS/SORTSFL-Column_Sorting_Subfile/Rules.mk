# ------------------------------------------------------------------------------
# Rules.mk - Build rules for Sortable Subfile Example (Work In Progress)
# ------------------------------------------------------------------------------
# This directory contains a sortable subfile example that demonstrates
# column sorting functionality. Currently under development.
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

# SORTSFLPF Physical File - Sort subfile sample table
SORTSFLPF.FILE: SORTSFLPF-Sort_Subfile_Sample_table.pf

# SORTSFL Display File - Sortable subfile display file
SORTSFL.FILE: SORTSFL-Sortable_Subfile.dspf

# SORTSFL Program - Sortable subfile program
SORTSFL.PGM: SORTSFL-Sortable_Subfile.pgm.sqlrpgle SORTSFL.FILE SORTSFLPF.FILE

# Made with Bob
