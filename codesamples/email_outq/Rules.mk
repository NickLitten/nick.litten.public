# =============================================================================
# Rules.mk - Build rules for EMLOUTQ (Email Output Queue)
# =============================================================================
# This file defines the build rules and dependencies for the email output
# queue functionality, including the command and CL program.
#
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# =============================================================================

# Default compilation settings for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# =============================================================================
# Object Dependencies
# =============================================================================

# EMLOUTQ Command - Email Output Queue command definition
EMLOUTQ.CMD: EMLOUTQ-Email_outq.cmd

# EMLOUTQ Program - Email Output Queue CL processing program
EMLOUTQ.PGM: EMLOUTQ-Email_outq_cpp.pgm.clle