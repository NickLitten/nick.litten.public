%.MODULE: private TGTRLS := V7R4M0

%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

FOODFILE.FILE: FOODFILE-Food_Sample_file.table
WEBFOOD.PGM: WEBFOOD-Sample_Webservice_for_FOODFILE.pgm.rpgle