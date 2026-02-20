# ==============================================================================
# Rules.mk - Build rules for Stored Procedure Examples
# ==============================================================================
# This file defines the build rules for stored procedure examples.
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

# STOREPRCR Program - Stored procedure RPG employee example
STOREPRCR.PGM: STOREPRCR-Stored_Procedure_RPG_Employee.pgm.rpgle

# STOREPRCS Program - Stored procedure SQL RPG employee example
STOREPRCS.PGM: STOREPRCS-Stored_Procedure_SQLRPG_Employee.pgm.sqlrpgle