# ==============================================================================
# Rules.mk - Build rules for Web Service Examples
# ==============================================================================
# This file defines the subdirectories for web service examples.
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
# Subdirectories
# ==============================================================================

SUBDIRS = JSNIFSSQL SIMPWEBSQL WEBFOOD