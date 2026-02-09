%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

STOREPRCR.PGM: STOREPRCR-Stored_Procedure_RPG_Employee.pgm.rpgle
STOREPRCS.PGM: STOREPRCS-Stored_Procedure_SQLRPG_Employee.pgm.sqlrpgle