# ---
# Rules.mk - Root Level Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Define global build settings and subdirectories for IBM i objects
# ---
# This file establishes default compilation parameters for all object types.
# Subdirectories contain their own Rules.mk files with specific dependencies.
# ---

# ---
# Global Build Settings
# ---
# These settings apply to all objects unless overridden in subdirectory Rules.mk
# Use := for immediate assignment to prevent recursive expansion
# Pattern-specific variables use 'private' with := for target-specific settings
# ---

# Target Release - IBM i OS version compatibility
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.SRVPGM: private TGTRLS := V7R4M0

# Program Compilation Settings
%.PGM:    private ENTMOD := *PGM          # Entry module is the program itself
%.PGM:    private ALWRTVSRC := *NO        # Disallow retrieve source (production)
%.PGM:    private OPTIMIZE := *FULL       # Full optimization for performance
%.PGM:    private ACTGRP := NICKLITTEN    # Default activation group
%.PGM:    private DBGVIEW := *SOURCE      # Include source view for debugging

# Module Compilation Settings
%.MODULE: private OPTIMIZE := *FULL       # Full optimization for performance
%.MODULE: private DBGVIEW := *SOURCE      # Include source view for debugging

# Service Program Settings
%.SRVPGM: private ACTGRP := *CALLER       # Use caller's activation group
%.SRVPGM: private ALWLIBUPD := *NO        # Disallow library updates
%.SRVPGM: private ALWUPD := *YES          # Allow service program updates
%.SRVPGM: private DETAIL := *BASIC        # Basic signature detail level

# File and Command Settings
%.FILE:   private OPTION := *EVENTF       # Event file option
%.FILE:   private GENLVL := 10            # Generation level
%.CMD:    private OPTION := *EVENTF       # Event file option for commands

# ---
# Build Order
# ---
# Subdirectories are processed in the order listed
# Dependencies between directories must be respected
# ---

SUBDIRS := IBMi