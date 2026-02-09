%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

EMLCSVFILE.CMD: EMLCSVFILE-this_calls_EMLCSVFILE.cmd
EMLCSVFILE.PGM: EMLCSVFILE-email_CSV_File.pgm.clle