# ------------------------------------------------------------------------------
# Rules.mk - Build rules for Subfile Examples
# ------------------------------------------------------------------------------
# This file defines the build rules for various subfile examples showing
# different styles and techniques.
#
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ------------------------------------------------------------------------------

# Subdirectories to process during build
SUBDIRS = NOOB-Full_Load_Subfile_Modernization \
          PERSONSFL-Expanding_Page_NativeIO \
          SAMPLESFL-Single_Page_Subfile_SQL \
          SIMPLE-Full_Load_Subfile \
          WORKINPROGRESS

# Default compilation settings for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

