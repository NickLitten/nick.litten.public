# ------------------------------------------------------------------------------
# Rules.mk - Build rules for NOOB Full Load Subfile Modernization Examples
# ------------------------------------------------------------------------------
# This directory contains four versions of a full load subfile example,
# demonstrating the evolution from AS/400 style through to modern IBM i Bob style.
# Perfect for learning subfile modernization techniques.
#
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ------------------------------------------------------------------------------

# Default compilation settings for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# ------------------------------------------------------------------------------
# Object Dependencies
# ------------------------------------------------------------------------------

# NOOBDSPF Display File - Display file with incrementing value subfile
NOOBDSPF.FILE: NOOBDSPF-Full_load_sfl_with_incrementing_value.dspf

# NOOBSFL1 Program - AS/400 style full load subfile
NOOBSFL1.PGM: NOOBSFL1-Full_load_subfile_example_AS400_STYLE.pgm.rpgle NOOBDSPF.FILE

# NOOBSFL2 Program - iSeries style full load subfile
NOOBSFL2.PGM: NOOBSFL2-Full_load_subfile_example_ISERIES_STYLE.pgm.rpgle NOOBDSPF.FILE

# NOOBSFL3 Program - IBM i style full load subfile
NOOBSFL3.PGM: NOOBSFL3-Full_load_subfile_example_IBMi_STYLE.pgm.rpgle NOOBDSPF.FILE

# NOOBSFL4 Program - IBM i Bob style full load subfile
NOOBSFL4.PGM: NOOBSFL4-Full_load_subfile_example_IBMi_BOB_STYLE.pgm.rpgle NOOBDSPF.FILE

# Made with Bob
