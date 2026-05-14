# ---
# Rules.mk - Web Service Examples Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for web service demonstration programs
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
# Build Order
# ---
SUBDIRS := JSNIFSSQL SIMPWEBSQL WEBFOOD