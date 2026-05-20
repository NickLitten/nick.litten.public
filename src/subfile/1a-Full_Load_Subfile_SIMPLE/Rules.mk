# ---
# Rules.mk - Simple Full Load Subfile Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for simple full load subfile examples
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

# SIMPLEDSPF Display File - Display file for the subfile example
SIMPLEDSPF.FILE: SIMPLEDSPF-Display_file_for_the_subfile_example.dspf

# SIMPLESFL1 Program - AS/400 RPG subfile FULL LOAD
SIMPLESFL1.PGM: SIMPLESFL1-AS400_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE

# SIMPLESFL2 Program - IBM i RPG subfile FULL LOAD
SIMPLESFL2.PGM: SIMPLESFL2-IBMi_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE

# SIMPLESFL3 Program - IBM i RPG subfile FULL LOAD IBM i BOB Style
SIMPLESFL3.PGM: SIMPLESFL3-IBMi_RPG_subfile_FULL_LOAD_IBMi_BOB_Style.pgm.rpgle SIMPLEDSPF.FILE

# Made with Bob
