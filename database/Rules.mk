# ------------------------------------------------------------------------------
# Rules.mk - Build rules for Database Examples
# ------------------------------------------------------------------------------
# This file defines the build rules for database examples demonstrating
# all DDS Physical File and SQL Table data types.
#
# Target Release: V7R4M0
# ------------------------------------------------------------------------------

# Default compilation settings for all database objects
%.FILE:   private TGTRLS := V7R4M0

# ------------------------------------------------------------------------------
# Object Dependencies
# ------------------------------------------------------------------------------

# ALLFILE Physical File - Comprehensive DDS field types example
ALLFILE.FILE: ALLFILE-All_Field_Types_in_1_File.pf

# ALLTABLE SQL Table - Comprehensive SQL data types example
# Note: SQL tables are created via RUNSQLSTM or similar, not compiled like PF
# This entry documents the table definition file
ALLTABLE.TABLE: ALLTABLE-All_Data_Types_in_1_Table.table