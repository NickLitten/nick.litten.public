# ==============================================================================
# Rules.mk - Build rules for Subfile Examples
# ==============================================================================
# This file defines the build rules for various subfile examples showing
# different styles and techniques.
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

# NOOBDSPF Display File - Full load subfile with incrementing value
NOOBDSPF.FILE: NOOBDSPF-Full_load_sfl_with_incrementing_value.dspf

# NOOBSFL1 Program - Full load subfile AS/400 style
NOOBSFL1.PGM: NOOBSFL1-Full_load_subfile_example_AS400_STYLE.pgm.rpgle NOOBDSPF.FILE

# NOOBSFL2 Program - Full load subfile iSeries style
NOOBSFL2.PGM: NOOBSFL2-Full_load_subfile_example_ISERIES_STYLE.pgm.rpgle NOOBDSPF.FILE

# NOOBSFL3 Program - Full load subfile IBM i style
NOOBSFL3.PGM: NOOBSFL3-Full_load_subfile_example_IBMi_STYLE.pgm.rpgle NOOBDSPF.FILE

# NOOBSFL4 Program - Full load subfile IBM i Bob style
NOOBSFL4.PGM: NOOBSFL4-Full_load_subfile_example_IBMi_BOB_STYLE.pgm.rpgle NOOBDSPF.FILE

# SIMPLEDSPF Display File - Display file for simple subfile example
SIMPLEDSPF.FILE: SIMPLEDSPF-Display_file_for_the_subfile_example.dspf

# SIMPLEFILE Physical File - Simple file with name/address data
SIMPLEFILE.FILE: SIMPLEFILE-Simple_file_with_some_NAME_ADDRESS_data_in_it.pf

# SIMPLESFL1 Program - AS/400 RPG subfile full load
SIMPLESFL1.PGM: SIMPLESFL1-AS400_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE SIMPLEFILE.FILE

# SIMPLESFL2 Program - IBM i RPG subfile full load
SIMPLESFL2.PGM: SIMPLESFL2-IBMi_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE SIMPLEFILE.FILE

# SIMPLESFL3 Program - IBM i RPG subfile full load Bob style
SIMPLESFL3.PGM: SIMPLESFL3-IBMi_RPG_subfile_FULL_LOAD_IBMi_BOB_Style.pgm.rpgle SIMPLEDSPF.FILE SIMPLEFILE.FILE

# PERSONSFL Display File - Person expanding page subfile
PERSONSFL.FILE: PERSONSFL-Person_expanding_page_subfile.dspf

# PERSONSFL Program - Person expanding page subfile program
PERSONSFL.PGM: PERSONSFL-Person_expanding_page_subfile.pgm.sqlrpgle PERSONTBL.FILE PERSONSFL.FILE

# SORTSFLPF Physical File - Sort subfile sample table
SORTSFLPF.FILE: SORTSFLPF-Sort_Subfile_Sample_table.pf

# SORTSFL Display File - Sortable subfile display file
SORTSFL.FILE: SORTSFL-Sortable_Subfile.dspf

# SORTSFL Program - Sortable subfile program
SORTSFL.PGM: SORTSFL-Sortable_Subfile.pgm.sqlrpgle SORTSFLPF.FILE SORTSFL.FILE