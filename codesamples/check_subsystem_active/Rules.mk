%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

CHKSBSACT.CMD: CHKSBSACT-Check_if_subsystem_is_active.cmd
CHKSBSACT.PGM: CHKSBSACT-Check_if_subsystem_is_active.pgm.clle
BLOG1.PGM: BLOG1-Example_from_blog.pgm.clle
BLOG2.PGM: BLOG2-Example_from_blog.pgm.clle