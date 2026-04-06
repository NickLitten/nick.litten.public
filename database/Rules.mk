%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

RECIPIES.FILE: RECIPIES-Simple_Recipies_for_CRUD_Examples.table
CRUD01TBL.FILE: CRUD01TBL-Task_Table.table
FOODFILE.FILE: FOODFILE-Food_Tastes_Yummy.table
PERSONTBL.FILE: PERSONTBL-Person_table_with_name_dob_address.table
SAMPLEDB.FILE: SAMPLEDB-Sample_table_country_names.table

# ALLFILE Physical File - Comprehensive DDS field types example
ALLFILE.FILE: ALLFILE-All_Field_Types_in_1_File.pf

# ALLTABLE SQL Table - Comprehensive SQL data types example
# Note: SQL tables are created via RUNSQLSTM or similar, not compiled like PF
# This entry documents the table definition file
ALLTABLE.TABLE: ALLTABLE-All_Data_Types_in_1_Table.table