# ==============================================================================
# Rules.mk - Build rules for Trigger Examples
# ==============================================================================
# This file defines the build rules for database trigger examples.
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

# SKELTRIG Program - Skeleton trigger program example
SKELTRIG.PGM: SKELTRIG-Skeleton_Trigger_Program.pgm.rpgle