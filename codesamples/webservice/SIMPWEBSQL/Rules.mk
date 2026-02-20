# ==============================================================================
# Rules.mk - Build rules for Simple Web Service SQL Example
# ==============================================================================
# This file defines the build rules for consuming web service responses.
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

# SIMPWEBSQL Program - Consume a web service response
SIMPWEBSQL.PGM: SIMPWEBSQL-Consume_a_webservice_response.pgm.sqlrpgle