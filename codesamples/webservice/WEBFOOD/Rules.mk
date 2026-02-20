# ==============================================================================
# Rules.mk - Build rules for Web Food Example
# ==============================================================================
# This file defines the build rules for the web food service example.
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

# WEBFOOD Program - Sample web service for food file
WEBFOOD.PGM: WEBFOOD-Sample_Webservice_for_FOODFILE.pgm.rpgle FOODFILE.FILE