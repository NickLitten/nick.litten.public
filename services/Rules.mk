# ==============================================================================
# Rules.mk - Build rules for Service Programs
# ==============================================================================
# This file defines the build rules for service programs.
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

# SIMPLEMOD Module - Simple service program module
SIMPLEMOD.MODULE: SIMPLEMOD-Simple_Service_Program.sqlrpgle

# SIMPLESRV Service Program - Simple service program
SIMPLESRV.SRVPGM: SIMPLESRV.bnd SIMPLEMOD.MODULE