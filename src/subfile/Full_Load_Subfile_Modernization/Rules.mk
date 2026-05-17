# ---
# Rules.mk - Full Load Subfile Modernization Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for full load subfile modernization examples
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

# NOOBDSPF Display File - Full load subfile with incrementing value
NOOBDSPF.FILE: NOOBDSPF-Full_load_sfl_with_incrementing_value.dspf

# NOOBSFL1 Program - AS/400 style full load subfile example
NOOBSFL1.PGM: NOOBSFL1-Full_load_subfile_example_AS400_STYLE.pgm.rpgle NOOBDSPF.FILE

# NOOBSFL2 Program - iSeries style full load subfile example
NOOBSFL2.PGM: NOOBSFL2-Full_load_subfile_example_ISERIES_STYLE.pgm.rpgle NOOBDSPF.FILE

# NOOBSFL3 Program - IBM i style full load subfile example
NOOBSFL3.PGM: NOOBSFL3-Full_load_subfile_example_IBMi_STYLE.pgm.rpgle NOOBDSPF.FILE

# NOOBSFL4 Program - IBM i BOB style full load subfile example
NOOBSFL4.PGM: NOOBSFL4-Full_load_subfile_example_IBMi_BOB_STYLE.pgm.rpgle NOOBDSPF.FILE

# Made with Bob
