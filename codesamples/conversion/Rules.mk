# ------------------------------------------------------------
# Rules.mk - Build rules for Conversion Programs
# ------------------------------------------------------------
# This file defines the build rules for conversion programs.
#
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ------------------------------------------------------------

# Default compilation settings for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# ------------------------------------------------------------
# Object Dependencies
# ------------------------------------------------------------

# CONVSRV Module - Conversion service program module using CCSID
CONVSRV.MODULE: CONVSRV-Conversion_Service.sqlrpgle

# CONVSRV Service Program - Character conversion service using CCSID
CONVSRV.SRVPGM: CONVSRV.bnd CONVSRV.MODULE

# CONVERT Program - EBCDIC to ASCII conversion using CONVSRV service program
CONVERT.PGM: CONVERT-Convert_EBCDIC_to_ASCII.pgm.rpgle CONVSRV.SRVPGM

# CONVERTBAS Program - Basic EBCDIC to ASCII conversion (legacy version)
CONVERTBAS.PGM: CONVERTBAS-Convert_EBCDIC_to_ASCII_BASIC_VERSION.pgm.rpgle