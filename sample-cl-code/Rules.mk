%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

IASP.PGM: IASP-Question_and_Answer_CL_Example.pgm.clle
IASPLOOP.PGM: IASPLOOP-DOU_Question_and_Answer_CL_Example.pgm.clle

CLMODULE.MODULE: CLMODULE-Simple_CL_Module.CLLE

CLBNDPGM.PGM: CLBNDPGM-Simple_Bound_CL_Program.PGM.CLLE