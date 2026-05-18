# ---
# Rules.mk - SQL Encryption Examples Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for SQL encryption demonstration programs
# ---
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ---

# ---
# Compilation Settings
# ---
# Override global settings for encryption examples
# Use := for immediate assignment (TOBi standard)
# ---
%.MODULE: private TGTRLS := V7R4M0
%.MODULE: private OPTIMIZE := *FULL
%.MODULE: private DBGVIEW := *SOURCE

%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN
%.PGM:    private DBGVIEW := *SOURCE

# ---
# Object Dependencies
# ---
# Format: TARGET: SOURCE_FILE [ADDITIONAL_DEPENDENCIES]
# Modules must be built before programs that bind them
# ---

# GETENC Module - Get encryption data example
GETENC.MODULE: GETENC-Get_Encryption_Data.sqlrpgle

# GETENC Program - Single module bound program
GETENC.PGM: GETENC.MODULE

# ---
# Additional Targets
# ---
# Add custom targets for testing or deployment here
# Example: test-encryption: GETENC.PGM
# ---

.PHONY: clean-encryption
clean-encryption:
	@echo "Cleaning SQL encryption objects..."
	# Add cleanup commands if needed