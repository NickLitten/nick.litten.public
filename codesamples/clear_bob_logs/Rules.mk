# ==============================================================================
# Rules.mk - Build rules for CLRBOBLOG (Clear Bob Logs)
# ==============================================================================
# This file defines the build rules for the CLRBOBLOG program which lists
# and deletes specific log files from a specified home directory.
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

# CLRBOBLOG Command - Clear Bob Logs command definition
CLRBOBLOG.CMD: CLRBOBLOG-Clear_Bob_Logs.cmd

# CLRBOBLOG Program - CL program to list and delete log files
CLRBOBLOG.PGM: CLRBOBLOG-Clear_Bob_Logs.pgm.clle