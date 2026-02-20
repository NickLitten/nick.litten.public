# ==============================================================================
# Rules.mk - Build rules for Debug Examples
# ==============================================================================
# This file defines the build rules for debugging examples.
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

# BUGME Command - Debugging example command
BUGME.CMD: BUGME-This_is_a_debugging_example.cmd

# BUGMECL Program - Debugging example CL program
BUGMECL.PGM: BUGMECL-This_is_a_debugging_example.pgm.clle

# BUGMERPG Program - Debugging example RPG program
BUGMERPG.PGM: BUGMERPG-This_is_a_debugging_example.pgm.rpgle