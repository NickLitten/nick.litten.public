# ==============================================================================
# Rules.mk - Build rules for Upload Files
# ==============================================================================
# This file defines the build rules for uploading files to the IBM-i system.
# It specifies the target release, activation group, and compilation settings 
# for the modules and programs involved in the upload process.
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

FLATFILE.FILE: CSVFILE-This_is_an_example_CSV_file.table
CSVFILE.FILE: CSVFILE-This_is_an_example_CSV_file.table

SIMPIMPF.PGM: SIMPIMPF-Simple_Import_File_Example.pgm.clle
SIMPIMPFV2.PGM: SIMPIMPFV2-Simple_Import_File_Example_Enhanced.pgm.clle