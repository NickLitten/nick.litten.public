# ---
# Rules.mk - SQL RPGLE Dynamic Examples Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for dynamic SQL RPGLE demonstration programs
# ---
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ---

# ---
# Compilation Settings
# ---
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# ---
# Object Dependencies
# ---

# SQLREAD Program - Sample SQL RPG dynamic file read
SQLREAD.PGM: SQLREAD-Sample_SQL_RPG_Dynamic_File_read.pgm.sqlrpgle