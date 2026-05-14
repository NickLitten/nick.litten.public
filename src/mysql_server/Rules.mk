# ---
# Rules.mk - MySQL Server Control Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for MySQL server management utilities
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

# MYSQLCTL Command - MySQL server control command
MYSQLCTL.CMD: MYSQLCTL-My_SQL_Control.cmd

# MYSQLCTL Program - MySQL server control CL program
MYSQLCTL.PGM: MYSQLCTL-My_SQL_Control.pgm.clle