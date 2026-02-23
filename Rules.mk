# ==============================================================================
# Rules.mk - Root level build configuration for IBM i project
# ==============================================================================
# This file defines subdirectories and common build settings for the project.
# Each subdirectory contains its own Rules.mk with specific object targets.
# ==============================================================================

# Subdirectories to process during build (order matters for dependencies)
SUBDIRS = binders \
          services \
          tables \
          templates \
          codesamples

# ==============================================================================
# Global Build Settings (can be overridden in subdirectory Rules.mk files)
# ==============================================================================

# Default target release for all objects
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.SRVPGM: private TGTRLS := V7R4M0

# Default program settings
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# Default module settings
%.MODULE: private OPTIMIZE := *FULL
%.MODULE: private DBGVIEW := *SOURCE

# Default service program settings
%.SRVPGM: private ACTGRP := *CALLER
%.SRVPGM: private ALWLIBUPD := *NO
%.SRVPGM: private ALWUPD := *YES

# Default file settings
%.FILE:   private OPTION := *EVENTF
%.FILE:   private GENLVL := 10

# Default command settings
%.CMD:    private OPTION := *EVENTF