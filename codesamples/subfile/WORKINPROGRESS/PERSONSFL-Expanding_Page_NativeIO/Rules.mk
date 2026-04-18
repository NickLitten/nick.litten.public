# ------------------------------------------------------------------------------
# Rules.mk - Build rules for Person Expanding Page Subfile Example
# ------------------------------------------------------------------------------
# This directory contains an expanding page subfile example that demonstrates
# loading records as the user pages through data using native I/O.
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

# PERSONTBL Physical File - Person table with name, DOB, and address (DDS version)
PERSONTBL.FILE: PERSONTBL-Person_table_with_name_dob_address.pf

# PERSONTBL Table - Person table with name, DOB, and address (SQL version)
PERSONTBL2.TABLE: PERSONTBL2-Person_table_with_name_dob_address.table

# PERSONSFL Display File - Person expanding page subfile display file
PERSONSFL.FILE: PERSONSFL-Person_expanding_page_subfile.dspf

# PERSONSFL Program - Person expanding page subfile program
# Note: Can use either PERSONTBL.FILE (DDS) or PERSONTBL.TABLE (SQL)
PERSONSFL.PGM: PERSONSFL-Person_expanding_page_subfile.pgm.sqlrpgle PERSONSFL.FILE PERSONTBL.FILE
