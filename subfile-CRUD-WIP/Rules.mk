%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

CRUD01TBL.FILE: crud01.sql
CRUD01PNL.FILE: crud01pnl.dspf
CRUD01RPG.MODULE: crud01rpg.sqlrpgle CRUD01TBL.FILE CRUD01PNL.FILE