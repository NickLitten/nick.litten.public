%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

CHOOSEIASP.PGM: CHOOSEIASP-Question_and_Answer_CL_Example.pgm.clle

CLMODULE.MODULE: CLMODULE.CLLE

CLBNDPGM.PGM: CLBNDPGM-Simple_Bound_CL_Program.PGM.CLLE

NICKSTRUP.MODULE: NICKSTRUP-Multisystem_Startup_Program.clle
NICKSTRUPA.MODULE: NICKSTRUPA-Multisystem_System_A.clle
NICKSTRUPB.MODULE: NICKSTRUPB-Multisystem_System_B.clle
NICKSTRUPC.MODULE: NICKSTRUPC-Multisystem_System_C.clle