#==============================================================================
# Rules.mk - Build rules for Read Directory QSHELL sample
#==============================================================================
# This file defines the build rules for VS Code for IBM i
# It specifies compilation parameters and dependencies for the READDIR program
#==============================================================================

# Default compilation parameters for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

#==============================================================================
# Build Rules
#==============================================================================

# READDIR Command - Command definition for listing IFS directories
READDIR.CMD: READDIR-Read_Directory_with_QSHELL.cmd

# READDIR Program - CL program that processes IFS directory listings
READDIR.PGM: READDIR-Read_Directory_with_QSHELL.pgm.clle READDIR.CMD