%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

NOOBDSPF.FILE: NOOBDSPF-Full_load_sfl_with_incrementing_value.dspf
NOOBSFL1.PGM: NOOBSFL1-Full_load_subfile_example_AS400_STYLE.pgm.rpgle NOOBDSPF.FILE
NOOBSFL2.PGM: NOOBSFL2-Full_load_subfile_example_ISERIES_STYLE.pgm.rpgle NOOBDSPF.FILE
NOOBSFL3.PGM: NOOBSFL3-Full_load_subfile_example_IBMi_STYLE.pgm.rpgle NOOBDSPF.FILE
NOOBSFL4.PGM: NOOBSFL4-Full_load_subfile_example_IBMi_BOB_STYLE.pgm.rpgle NOOBDSPF.FILE

SIMPLEDSPF.FILE: SIMPLEDSPF-Display_file_for_the_subfile_example.dspf
SIMPLEFILE.FILE: SIMPLEFILE-Simple_file_with_some_NAME_ADDRESS_data_in_it.pf
SIMPLESFL1.PGM: SIMPLESFL1-AS400_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE SIMPLEFILE.FILE
SIMPLESFL2.PGM: SIMPLESFL2-IBMi_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE SIMPLEFILE.FILE
SIMPLESFL3.PGM: SIMPLESFL3-IBMi_RPG_subfile_FULL_LOAD_IBMi_BOB_Style.pgm.rpgle SIMPLEDSPF.FILE SIMPLEFILE.FILE


PERSONSFL.FILE: PERSONSFL-Person_expanding_page_subfile.dspf
PERSONSFL.PGM: PERSONSFL-Person_expanding_page_subfile.pgm.sqlrpgle PERSONTBL.FILE PERSONSFL.FILE

SORTSFLPF.FILE: SORTSFLPF-Sort_Subfile_Sample_table.pf
SORTSFL.FILE: SORTSFL-Sortable_Subfile.dspf
SORTSFL.PGM: SORTSFL-Sortable_Subfile.pgm.sqlrpgle SORTSFLPF.FILE SORTSFL.FILE