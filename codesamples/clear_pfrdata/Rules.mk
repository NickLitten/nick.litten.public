# ==============================================================================
# Rules.mk - Build rules for Clear Performance Data
# ==============================================================================
# This file defines the build rules for clearing performance data and reporting.
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

# CLRPFRDATA Program - Clear performance data and generate report
CLRPFRDATA.PGM: CLRPFRDATA-Clear_Performance_Data_and_Report.pgm.clle