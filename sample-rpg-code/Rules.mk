%.MODULE: private TGTRLS := V7R4M0

%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

HELLOINC.PGM: HELLOINC-Helloworld_using_copybook.pgm.rpgle
HELLOWORLD.PGM: HELLOWORLD-Simple_HelloWorld.pgm.rpgle
HELLOADV.PGM: HELLOADV-Advanced_HelloWorld.pgm.rpgle