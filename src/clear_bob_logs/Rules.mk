# ---
# Rules.mk - Clear Bob Logs Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for Bob log file management utilities
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

# CLRBOBLOG Command - Clear Bob Logs command definition
CLRBOBLOG.CMD: CLRBOBLOG-Clear_Bob_Logs.cmd

# CLRBOBLOG Program - CL program to list and delete log files
CLRBOBLOG.PGM: CLRBOBLOG-Clear_Bob_Logs.pgm.clle