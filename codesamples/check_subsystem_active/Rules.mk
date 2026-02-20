# ==============================================================================
# Rules.mk - Build rules for Check Subsystem Active
# ==============================================================================
# This file defines the build rules for checking if a subsystem is active.
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

# CHKSBSACT Command - Check if subsystem is active
CHKSBSACT.CMD: CHKSBSACT-Check_if_subsystem_is_active.cmd

# CHKSBSACT Program - Check subsystem active CL program
CHKSBSACT.PGM: CHKSBSACT-Check_if_subsystem_is_active.pgm.clle

# BLOG1 Program - Blog example 1
BLOG1.PGM: BLOG1-Example_from_blog.pgm.clle

# BLOG2 Program - Blog example 2
BLOG2.PGM: BLOG2-Example_from_blog.pgm.clle