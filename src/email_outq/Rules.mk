# ---
# Rules.mk - Email Output Queue Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for output queue email utilities
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

# EMLOUTQ Command - Email Output Queue command definition
EMLOUTQ.CMD: EMLOUTQ-Email_outq.cmd

# EMLOUTQ Program - Email Output Queue CL processing program
EMLOUTQ.PGM: EMLOUTQ-Email_outq_cpp.pgm.clle