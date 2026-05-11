# ------------------------------------------------------------------------------
# Rules.mk - Build rules for Simple Full Load Subfile Examples
# ------------------------------------------------------------------------------
# This directory contains three versions of a full load subfile example,
# showing the evolution from AS/400 style to modern IBM i style.
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

# SIMPLEFILE Physical File - Sample data file with NAME/ADDRESS data
SIMPLEFILE.FILE: SIMPLEFILE-Simple_file_with_some_NAME_ADDRESS_data_in_it.pf

# SIMPLEDSPF Display File - Display file for subfile example
SIMPLEDSPF.FILE: SIMPLEDSPF-Display_file_for_the_subfile_example.dspf

# SIMPLESFL1 Program - AS/400 style full load subfile
SIMPLESFL1.PGM: SIMPLESFL1-AS400_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE SIMPLEFILE.FILE

# SIMPLESFL2 Program - IBM i style full load subfile
SIMPLESFL2.PGM: SIMPLESFL2-IBMi_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE SIMPLEFILE.FILE

# SIMPLESFL3 Program - IBM i Bob style full load subfile
SIMPLESFL3.PGM: SIMPLESFL3-IBMi_RPG_subfile_FULL_LOAD_IBMi_BOB_Style.pgm.rpgle SIMPLEDSPF.FILE SIMPLEFILE.FILE

# Made with Bob
