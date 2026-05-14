# ---
# Rules.mk - JSON IFS SQL Example Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for JSON table decode using SQL
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

# JSNIFSSQL Program - JSON table decode using SQL
JSNIFSSQL.PGM: JSNIFSSQL-JSON_TABLE_Decode_JSON_SQL.pgm.sqlrpgle