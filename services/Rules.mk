%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

SIMPLEMOD.MODULE: SIMPLEMOD-Simple_Service_Program.sqlrpgle

SIMPLESRV.SRVPGM: SIMPLESRV.bnd SIMPLEMOD.MODULE