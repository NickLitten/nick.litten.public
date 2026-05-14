# ---
# Rules.mk - Check Subsystem Active Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for subsystem status checking utilities
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

# Command-specific settings
%.CMD:    private ALLOW := *IPGM *BPGM

# ---
# Object Dependencies
# ---

# CHKSBSACT Command - Check if subsystem is active
CHKSBSACT.CMD: CHKSBSACT-Check_if_subsystem_is_active.cmd

# CHKSBSACT Program - Check subsystem active CL program
CHKSBSACT.PGM: CHKSBSACT-Check_if_subsystem_is_active.pgm.clle

# CHKSBSACT1 Program - Blog example 1
CHKSBSACT1.PGM: CHKSBSACT1-Example_from_blog.pgm.clle