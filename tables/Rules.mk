%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

NOOBDSPF.FILE: NOOBDSPF-Full_load_sfl_with_incrementing_value.dspf
NOOBSFL2.PGM: NOOBSFL2-Full_load_subfile_example_ISERIES_STYLE.pgm.rpgle NOOBDSPF.FILE
NOOBSFL1.PGM: NOOBSFL1-Full_load_subfile_example_AS400_STYLE.pgm.rpgle NOOBDSPF.FILE
NOOBSFL3.PGM: NOOBSFL3-Full_load_subfile_example_IBMi_STYLE.pgm.rpgle NOOBDSPF.FILE

SIMPLEDSPF.FILE: SIMPLEDSPF-Display_file_for_the_subfile_example.dspf
SIMPLEFILE.FILE: SIMPLEFILE-Simple_file_with_some_NAME_ADDRESS_data_in_it.pf
SIMPLESFL1.PGM: SIMPLESFL1-AS400_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE SIMPLEFILE.FILE
SIMPLESFL2.PGM: SIMPLESFL2-IBMi_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE SIMPLEFILE.FILE

CRUD01TBL.FILE: CRUD01TBL-Change_Read_Update_Sample_Table.table
CRUD01PNL.FILE: CRUD01PNL-Change_Read_Update_Delete_Example.dspf
CRUD01RPG.MODULE: CRUD01RPG-Change_Read_Update_Delete_Example.sqlrpgle
CRUD01RPG.PGM: CRUD01RPG-Change_Read_Update_Delete_Example.pgm.sqlrpgle CRUD01TBL.FILE CRUD01PNL.FILE