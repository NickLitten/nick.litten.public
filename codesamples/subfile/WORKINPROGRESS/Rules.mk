# ------------------------------------------------------------------------------
# Rules.mk - Build rules for Work In Progress Subfile Examples
# ------------------------------------------------------------------------------
# This directory contains subfile examples that are still under development.
# These examples demonstrate advanced subfile techniques that are being refined.
#
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ------------------------------------------------------------------------------

# Subdirectories to process during build
SUBDIRS = CRUD-ChangeReadUpdateDelete-WORKINPROGRESS \
          SORTSFL-Column_Sorting_Subfile

# Default compilation settings for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# Made with Bob
