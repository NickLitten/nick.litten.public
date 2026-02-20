%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

LSTLIB.FILE: LSTLIB-Library_List_workfile.table
LISTLIBS.PGM: LISTLIBS-List_Libraries_and_Call_QLIRLIBD.pgm.clle
LISTLIBS2.PGM: LISTLIBS2-Enhanced_Library_List_with_API.pgm.clle
LSTLIBSIMP.PGM: LSTLIBSIMP-List_Libraries_Simply.pgm.clle