BIN_LIB=NICKLITTEN
APP_BNDDIR=SIMPLEBND
LIBL=$(BIN_LIB)

INCDIR=""
BNDDIR=($(BIN_LIB)/$(APP_BNDDIR))
PREPATH=/QSYS.LIB/$(BIN_LIB).LIB
SHELL=/QOpenSys/usr/bin/qsh

all: .logs .evfevent library $(PREPATH)/SIMPLEBND.BNDDIR $(PREPATH)/CLMODULE.PGM $(PREPATH)/IASPLOOP.PGM $(PREPATH)/CLBNDPGM.PGM $(PREPATH)/IASP.PGM $(PREPATH)/BUGMECL.PGM $(PREPATH)/BUGMERPG.PGM $(PREPATH)/HELLOADV.PGM $(PREPATH)/HELLOINC.PGM $(PREPATH)/HELLOWORLD.PGM $(PREPATH)/STOREPRCR.PGM $(PREPATH)/FREERPG.PGM $(PREPATH)/SQLREAD.PGM $(PREPATH)/STOREPRCS.PGM $(PREPATH)/FREERPG1.PGM $(PREPATH)/FREERPG2.PGM $(PREPATH)/FREERPG3.PGM $(PREPATH)/IFSLEGACY.PGM $(PREPATH)/IFSMODERN.PGM $(PREPATH)/IFSIMPROVE.PGM $(PREPATH)/OLDRPG.PGM $(PREPATH)/OLDTAGRPG2.PGM $(PREPATH)/OLDTAGRPG1.PGM $(PREPATH)/CRUD01RPG.PGM $(PREPATH)/NOOBSFL1.PGM $(PREPATH)/OLDTAGRPG3.PGM $(PREPATH)/NOOBSFL2.PGM $(PREPATH)/NOOBSFL3.PGM $(PREPATH)/SIMPLESFL2.PGM $(PREPATH)/SIMPLESFL1.PGM $(PREPATH)/SORTSFL.PGM $(PREPATH)/SIMPWEBSQL.PGM $(PREPATH)/TEMPLATE.PGM $(PREPATH)/WEBFOOD.PGM

$(PREPATH)/BUGMECL.PGM: $(PREPATH)/BUGMERPG.PGM
$(PREPATH)/SIMPLESRV.SRVPGM: $(PREPATH)/SIMPLEMOD.MODULE
$(PREPATH)/CRUD01RPG.PGM: $(PREPATH)/CRUD01TBL.FILE $(PREPATH)/CRUD01PNL.FILE
$(PREPATH)/NOOBSFL1.PGM: $(PREPATH)/NOOBDSPF.FILE
$(PREPATH)/NOOBSFL2.PGM: $(PREPATH)/NOOBDSPF.FILE
$(PREPATH)/NOOBSFL3.PGM: $(PREPATH)/NOOBDSPF.FILE
$(PREPATH)/SIMPLESFL2.PGM: $(PREPATH)/SIMPLEDSPF.FILE $(PREPATH)/SIMPLEFILE.FILE
$(PREPATH)/SIMPLESFL1.PGM: $(PREPATH)/SIMPLEDSPF.FILE $(PREPATH)/SIMPLEFILE.FILE
$(PREPATH)/SORTSFL.PGM: $(PREPATH)/SORTSFLPF.FILE $(PREPATH)/SORTSFL.FILE
$(PREPATH)/WEBFOOD.PGM: $(PREPATH)/FOODFILE.FILE
$(PREPATH)/SIMPLEBND.BNDDIR: $(PREPATH)/SIMPLESRV.SRVPGM $(PREPATH)/SIMPLEBND.BNDDIR

.logs:
	mkdir .logs
.evfevent:
	mkdir .evfevent
library:
	-system -q "CRTLIB LIB($(BIN_LIB))"


$(PREPATH)/BUGMERPG.PGM: codesamples/debug/BUGMERPG-This_is_a_debugging_example.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/BUGMERPG) SRCSTMF('codesamples/debug/BUGMERPG-This_is_a_debugging_example.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/bugmerpg.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/BUGMERPG.MBR') TOSTMF('.evfevent/bugmerpg.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/HELLOADV.PGM: codesamples/rpg_code/HELLOADV-Advanced_HelloWorld.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/HELLOADV) SRCSTMF('codesamples/rpg_code/HELLOADV-Advanced_HelloWorld.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/helloadv.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/HELLOADV.MBR') TOSTMF('.evfevent/helloadv.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/HELLOINC.PGM: codesamples/rpg_code/HELLOINC-Helloworld_using_copybook.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/HELLOINC) SRCSTMF('codesamples/rpg_code/HELLOINC-Helloworld_using_copybook.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/helloinc.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/HELLOINC.MBR') TOSTMF('.evfevent/helloinc.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/HELLOWORLD.PGM: codesamples/rpg_code/HELLOWORLD-Simple_HelloWorld.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/HELLOWORLD) SRCSTMF('codesamples/rpg_code/HELLOWORLD-Simple_HelloWorld.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/helloworld.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/HELLOWORLD.MBR') TOSTMF('.evfevent/helloworld.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/STOREPRCR.PGM: codesamples/rpg_code/STOREPRCR-Stored_Procedure_RPG_Employee.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/STOREPRCR) SRCSTMF('codesamples/rpg_code/STOREPRCR-Stored_Procedure_RPG_Employee.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/storeprcr.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/STOREPRCR.MBR') TOSTMF('.evfevent/storeprcr.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/FREERPG.PGM: codesamples/rpg_modernization/FREERPG-Nicks_Version.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/FREERPG) SRCSTMF('codesamples/rpg_modernization/FREERPG-Nicks_Version.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/freerpg.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/FREERPG.MBR') TOSTMF('.evfevent/freerpg.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/FREERPG1.PGM: codesamples/rpg_modernization/FREERPG1-RPGLE_Free.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/FREERPG1) SRCSTMF('codesamples/rpg_modernization/FREERPG1-RPGLE_Free.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/freerpg1.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/FREERPG1.MBR') TOSTMF('.evfevent/freerpg1.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/FREERPG2.PGM: codesamples/rpg_modernization/FREERPG2-ARCAD_Converter.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/FREERPG2) SRCSTMF('codesamples/rpg_modernization/FREERPG2-ARCAD_Converter.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/freerpg2.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/FREERPG2.MBR') TOSTMF('.evfevent/freerpg2.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/FREERPG3.PGM: codesamples/rpg_modernization/FREERPG3-Cozzi_Converter.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/FREERPG3) SRCSTMF('codesamples/rpg_modernization/FREERPG3-Cozzi_Converter.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/freerpg3.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/FREERPG3.MBR') TOSTMF('.evfevent/freerpg3.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/IFSIMPROVE.PGM: codesamples/rpg_modernization/IFSIMPROVE-IFS_Sample_Modernised_and_Improved.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/IFSIMPROVE) SRCSTMF('codesamples/rpg_modernization/IFSIMPROVE-IFS_Sample_Modernised_and_Improved.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/ifsimprove.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/IFSIMPROVE.MBR') TOSTMF('.evfevent/ifsimprove.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/IFSLEGACY.PGM: codesamples/rpg_modernization/IFSLEGACY-IFS_Sample_legacy_RPG_Column_Based.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/IFSLEGACY) SRCSTMF('codesamples/rpg_modernization/IFSLEGACY-IFS_Sample_legacy_RPG_Column_Based.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/ifslegacy.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/IFSLEGACY.MBR') TOSTMF('.evfevent/ifslegacy.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/IFSMODERN.PGM: codesamples/rpg_modernization/IFSMODERN-IFS_Sample_modernised_RPG_Free.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/IFSMODERN) SRCSTMF('codesamples/rpg_modernization/IFSMODERN-IFS_Sample_modernised_RPG_Free.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/ifsmodern.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/IFSMODERN.MBR') TOSTMF('.evfevent/ifsmodern.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/OLDRPG.PGM: codesamples/rpg_modernization/OLDRPG-old_rpg400_code.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/OLDRPG) SRCSTMF('codesamples/rpg_modernization/OLDRPG-old_rpg400_code.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/oldrpg.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/OLDRPG.MBR') TOSTMF('.evfevent/oldrpg.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/OLDTAGRPG1.PGM: codesamples/rpg_modernization/OLDTAGRPG1-old_rpg400_with_goto_tag_subroutine.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/OLDTAGRPG1) SRCSTMF('codesamples/rpg_modernization/OLDTAGRPG1-old_rpg400_with_goto_tag_subroutine.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/oldtagrpg1.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/OLDTAGRPG1.MBR') TOSTMF('.evfevent/oldtagrpg1.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/OLDTAGRPG2.PGM: codesamples/rpg_modernization/OLDTAGRPG2-old_rpg400_lightly_neater.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/OLDTAGRPG2) SRCSTMF('codesamples/rpg_modernization/OLDTAGRPG2-old_rpg400_lightly_neater.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/oldtagrpg2.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/OLDTAGRPG2.MBR') TOSTMF('.evfevent/oldtagrpg2.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/OLDTAGRPG3.PGM: codesamples/rpg_modernization/OLDTAGRPG3-old_rpg400_modernised.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/OLDTAGRPG3) SRCSTMF('codesamples/rpg_modernization/OLDTAGRPG3-old_rpg400_modernised.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/oldtagrpg3.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/OLDTAGRPG3.MBR') TOSTMF('.evfevent/oldtagrpg3.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/NOOBSFL1.PGM: codesamples/subfile/NOOBSFL1-Full_load_subfile_example_AS400_STYLE.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/NOOBSFL1) SRCSTMF('codesamples/subfile/NOOBSFL1-Full_load_subfile_example_AS400_STYLE.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/noobsfl1.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/NOOBSFL1.MBR') TOSTMF('.evfevent/noobsfl1.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/NOOBSFL2.PGM: codesamples/subfile/NOOBSFL2-Full_load_subfile_example_ISERIES_STYLE.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/NOOBSFL2) SRCSTMF('codesamples/subfile/NOOBSFL2-Full_load_subfile_example_ISERIES_STYLE.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/noobsfl2.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/NOOBSFL2.MBR') TOSTMF('.evfevent/noobsfl2.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/NOOBSFL3.PGM: codesamples/subfile/NOOBSFL3-Full_load_subfile_example_IBMi_STYLE.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/NOOBSFL3) SRCSTMF('codesamples/subfile/NOOBSFL3-Full_load_subfile_example_IBMi_STYLE.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/noobsfl3.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/NOOBSFL3.MBR') TOSTMF('.evfevent/noobsfl3.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/SIMPLESFL1.PGM: codesamples/subfile/SIMPLESFL1-AS400_RPG_subfile_FULL_LOAD.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/SIMPLESFL1) SRCSTMF('codesamples/subfile/SIMPLESFL1-AS400_RPG_subfile_FULL_LOAD.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/simplesfl1.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/SIMPLESFL1.MBR') TOSTMF('.evfevent/simplesfl1.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/SIMPLESFL2.PGM: codesamples/subfile/SIMPLESFL2-IBMi_RPG_subfile_FULL_LOAD.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/SIMPLESFL2) SRCSTMF('codesamples/subfile/SIMPLESFL2-IBMi_RPG_subfile_FULL_LOAD.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/simplesfl2.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/SIMPLESFL2.MBR') TOSTMF('.evfevent/simplesfl2.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/WEBFOOD.PGM: codesamples/webservice/WEBFOOD/WEBFOOD-Sample_Webservice_for_FOODFILE.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/WEBFOOD) SRCSTMF('codesamples/webservice/WEBFOOD/WEBFOOD-Sample_Webservice_for_FOODFILE.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/webfood.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/WEBFOOD.MBR') TOSTMF('.evfevent/webfood.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')

$(PREPATH)/SQLREAD.PGM: codesamples/rpg_code/SQLREAD-Sample_SQL_RPG_Dynamic_File_read.pgm.sqlrpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/SQLREAD) SRCSTMF('codesamples/rpg_code/SQLREAD-Sample_SQL_RPG_Dynamic_File_read.pgm.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) OPTION(*EVENTF) RPGPPOPT(*LVL2) COMPILEOPT('TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*no)')" > .logs/sqlread.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/SQLREAD.MBR') TOSTMF('.evfevent/sqlread.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/STOREPRCS.PGM: codesamples/rpg_code/STOREPRCS-Stored_Procedure_SQLRPG_Employee.pgm.sqlrpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/STOREPRCS) SRCSTMF('codesamples/rpg_code/STOREPRCS-Stored_Procedure_SQLRPG_Employee.pgm.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) OPTION(*EVENTF) RPGPPOPT(*LVL2) COMPILEOPT('TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*no)')" > .logs/storeprcs.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/STOREPRCS.MBR') TOSTMF('.evfevent/storeprcs.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/CRUD01RPG.PGM: codesamples/subfile/CRUD01RPG-Change_Read_Update_Delete_Example.pgm.sqlrpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/CRUD01RPG) SRCSTMF('codesamples/subfile/CRUD01RPG-Change_Read_Update_Delete_Example.pgm.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) OPTION(*EVENTF) RPGPPOPT(*LVL2) COMPILEOPT('TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*no)')" > .logs/crud01rpg.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/CRUD01RPG.MBR') TOSTMF('.evfevent/crud01rpg.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/SORTSFL.PGM: codesamples/subfile/SORTSFL-Sortable_Subfile.pgm.sqlrpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/SORTSFL) SRCSTMF('codesamples/subfile/SORTSFL-Sortable_Subfile.pgm.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) OPTION(*EVENTF) RPGPPOPT(*LVL2) COMPILEOPT('TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*no)')" > .logs/sortsfl.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/SORTSFL.MBR') TOSTMF('.evfevent/sortsfl.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/SIMPWEBSQL.PGM: codesamples/webservice/SIMPWEBSQL/SIMPWEBSQL-Consume_a_webservice_response_from_nicklitten_dot_com.pgm.sqlrpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/SIMPWEBSQL) SRCSTMF('codesamples/webservice/SIMPWEBSQL/SIMPWEBSQL-Consume_a_webservice_response_from_nicklitten_dot_com.pgm.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) OPTION(*EVENTF) RPGPPOPT(*LVL2) COMPILEOPT('TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*no)')" > .logs/simpwebsql.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/SIMPWEBSQL.MBR') TOSTMF('.evfevent/simpwebsql.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')


$(PREPATH)/SIMPLEMOD.MODULE: codesamples/services/SIMPLEMOD-Simple_Service_Program.sqlrpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/SIMPLEMOD) SRCSTMF('codesamples/services/SIMPLEMOD-Simple_Service_Program.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) COMPILEOPT('TGTCCSID(*JOB)') RPGPPOPT(*LVL2) OPTION(*EVENTF) OBJTYPE(*MODULE) PRIVATE TGTRLS(V7R4M0)" > .logs/simplemod.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/SIMPLEMOD.MBR') TOSTMF('.evfevent/simplemod.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')

$(PREPATH)/CLBNDPGM.PGM: codesamples/cl_code/CLBNDPGM-Simple_Bound_CL_Program.pgm.clle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDCL PGM($(BIN_LIB)/CLBNDPGM) SRCSTMF('codesamples/cl_code/CLBNDPGM-Simple_Bound_CL_Program.pgm.clle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) DFTACTGRP(*NO)" > .logs/clbndpgm.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/CLBNDPGM.MBR') TOSTMF('.evfevent/clbndpgm.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/CLMODULE.PGM: codesamples/cl_code/CLMODULE-Simple_CL_Module.pgm.clle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDCL PGM($(BIN_LIB)/CLMODULE) SRCSTMF('codesamples/cl_code/CLMODULE-Simple_CL_Module.pgm.clle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) DFTACTGRP(*NO)" > .logs/clmodule.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/CLMODULE.MBR') TOSTMF('.evfevent/clmodule.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/IASP.PGM: codesamples/cl_code/IASP-Question_and_Answer_CL_Example.pgm.clle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDCL PGM($(BIN_LIB)/IASP) SRCSTMF('codesamples/cl_code/IASP-Question_and_Answer_CL_Example.pgm.clle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) DFTACTGRP(*NO)" > .logs/iasp.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/IASP.MBR') TOSTMF('.evfevent/iasp.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/IASPLOOP.PGM: codesamples/cl_code/IASPLOOP-DOU_Question_and_Answer_CL_Example.pgm.clle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDCL PGM($(BIN_LIB)/IASPLOOP) SRCSTMF('codesamples/cl_code/IASPLOOP-DOU_Question_and_Answer_CL_Example.pgm.clle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) DFTACTGRP(*NO)" > .logs/iasploop.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/IASPLOOP.MBR') TOSTMF('.evfevent/iasploop.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/BUGMECL.PGM: codesamples/debug/BUGMECL-This_is_a_debugging_example.pgm.clle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDCL PGM($(BIN_LIB)/BUGMECL) SRCSTMF('codesamples/debug/BUGMECL-This_is_a_debugging_example.pgm.clle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) DFTACTGRP(*NO)" > .logs/bugmecl.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/BUGMECL.MBR') TOSTMF('.evfevent/bugmecl.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/TEMPLATE.PGM: templates/TEMPLATE-CL_Program_Starter_Template.pgm.clle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDCL PGM($(BIN_LIB)/TEMPLATE) SRCSTMF('templates/TEMPLATE-CL_Program_Starter_Template.pgm.clle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) DFTACTGRP(*NO)" > .logs/template.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/TEMPLATE.MBR') TOSTMF('.evfevent/template.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')

$(PREPATH)/CRUD01PNL.FILE: codesamples/subfile/CRUD01PNL-Change_Read_Update_Delete_Example.dspf
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QTMPSRC) RCDLEN(112) CCSID(*JOB)"
	system "CPYFRMSTMF FROMSTMF('codesamples/subfile/CRUD01PNL-Change_Read_Update_Delete_Example.dspf') TOMBR('$(PREPATH)/QTMPSRC.FILE/CRUD01PNL.MBR') MBROPT(*REPLACE)"
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTDSPF FILE($(BIN_LIB)/CRUD01PNL) SRCFILE($(BIN_LIB)/QTMPSRC) SRCMBR(CRUD01PNL) OPTION(*EVENTF)" > .logs/crud01pnl.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/CRUD01PNL.MBR') TOSTMF('.evfevent/crud01pnl.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/NOOBDSPF.FILE: codesamples/subfile/NOOBDSPF-Full_load_sfl_with_incrementing_value.dspf
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QTMPSRC) RCDLEN(112) CCSID(*JOB)"
	system "CPYFRMSTMF FROMSTMF('codesamples/subfile/NOOBDSPF-Full_load_sfl_with_incrementing_value.dspf') TOMBR('$(PREPATH)/QTMPSRC.FILE/NOOBDSPF.MBR') MBROPT(*REPLACE)"
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTDSPF FILE($(BIN_LIB)/NOOBDSPF) SRCFILE($(BIN_LIB)/QTMPSRC) SRCMBR(NOOBDSPF) OPTION(*EVENTF)" > .logs/noobdspf.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/NOOBDSPF.MBR') TOSTMF('.evfevent/noobdspf.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/SIMPLEDSPF.FILE: codesamples/subfile/SIMPLEDSPF-Display_file_for_the_subfile_example.dspf
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QTMPSRC) RCDLEN(112) CCSID(*JOB)"
	system "CPYFRMSTMF FROMSTMF('codesamples/subfile/SIMPLEDSPF-Display_file_for_the_subfile_example.dspf') TOMBR('$(PREPATH)/QTMPSRC.FILE/SIMPLEDSPF.MBR') MBROPT(*REPLACE)"
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTDSPF FILE($(BIN_LIB)/SIMPLEDSPF) SRCFILE($(BIN_LIB)/QTMPSRC) SRCMBR(SIMPLEDSPF) OPTION(*EVENTF)" > .logs/simpledspf.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/SIMPLEDSPF.MBR') TOSTMF('.evfevent/simpledspf.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/SORTSFL.FILE: codesamples/subfile/SORTSFL-Sortable_Subfile.dspf
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QTMPSRC) RCDLEN(112) CCSID(*JOB)"
	system "CPYFRMSTMF FROMSTMF('codesamples/subfile/SORTSFL-Sortable_Subfile.dspf') TOMBR('$(PREPATH)/QTMPSRC.FILE/SORTSFL.MBR') MBROPT(*REPLACE)"
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTDSPF FILE($(BIN_LIB)/SORTSFL) SRCFILE($(BIN_LIB)/QTMPSRC) SRCMBR(SORTSFL) OPTION(*EVENTF)" > .logs/sortsfl.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/SORTSFL.MBR') TOSTMF('.evfevent/sortsfl.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')


$(PREPATH)/BUGME.CMD: codesamples/debug/BUGME-This_is_a_debugging_example.cmd
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QTMPSRC) RCDLEN(112) CCSID(*JOB)"
	system "CPYFRMSTMF FROMSTMF('codesamples/debug/BUGME-This_is_a_debugging_example.cmd') TOMBR('$(PREPATH)/QTMPSRC.FILE/BUGME.MBR') MBROPT(*REPLACE)"
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTCMD CMD($(BIN_LIB)/BUGME) PGM($(BIN_LIB)/BUGME) SRCFILE($(BIN_LIB)/QTMPSRC) OPTION(*EVENTF) SRCMBR(BUGME)" > .logs/bugme.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/BUGME.MBR') TOSTMF('.evfevent/bugme.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')

$(PREPATH)/IBM.FILE: codesamples/webservice/SIMPWEBSQL/ibm-i-webservice-consumption-sql-example-simple.sql
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "RUNSQLSTM SRCSTMF('codesamples/webservice/SIMPWEBSQL/ibm-i-webservice-consumption-sql-example-simple.sql') COMMIT(*NONE)" > .logs/ibm.splf


$(PREPATH)/FOODFILE.FILE: codesamples/webservice/WEBFOOD/foodfile.table
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "RUNSQLSTM SRCSTMF('codesamples/webservice/WEBFOOD/foodfile.table') COMMIT(*NONE)" > .logs/foodfile.splf
$(PREPATH)/CRUD01TBL.FILE: tables/crud01tbl.table
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "RUNSQLSTM SRCSTMF('tables/crud01tbl.table') COMMIT(*NONE)" > .logs/crud01tbl.splf


$(PREPATH)/SIMPLESRV.SRVPGM: codesamples/services/SIMPLESRV.bnd
	-system -q "CRTBNDDIR BNDDIR($(BIN_LIB)/$(APP_BNDDIR))"
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTSRVPGM SRVPGM($(BIN_LIB)/SIMPLESRV) MODULE(SIMPLEMOD) SRCSTMF('codesamples/services/SIMPLESRV.bnd') BNDDIR($(BNDDIR)) REPLACE(*YES) PRIVATE TGTRLS(V7R4M0)" > .logs/simplesrv.splf
	-system -q "ADDBNDDIRE BNDDIR($(BIN_LIB)/$(APP_BNDDIR)) OBJ((*LIBL/SIMPLESRV *SRVPGM *IMMED))"





$(PREPATH)/SIMPLEFILE.FILE: codesamples/subfile/SIMPLEFILE-Simple_file_with_some_NAME_ADDRESS_data_in_it.pf
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QTMPSRC) RCDLEN(112) CCSID(*JOB)"
	system "CPYFRMSTMF FROMSTMF('codesamples/subfile/SIMPLEFILE-Simple_file_with_some_NAME_ADDRESS_data_in_it.pf') TOMBR('$(PREPATH)/QTMPSRC.FILE/SIMPLEFILE.MBR') MBROPT(*REPLACE)"
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTPF FILE($(BIN_LIB)/SIMPLEFILE) SRCFILE($(BIN_LIB)/QTMPSRC) OPTION(*EVENTF) SRCMBR(SIMPLEFILE)" > .logs/simplefile.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/SIMPLEFILE.MBR') TOSTMF('.evfevent/simplefile.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')
$(PREPATH)/SORTSFLPF.FILE: codesamples/subfile/SORTSFLPF-Sort_Subfile_Sample_table.pf
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QTMPSRC) RCDLEN(112) CCSID(*JOB)"
	system "CPYFRMSTMF FROMSTMF('codesamples/subfile/SORTSFLPF-Sort_Subfile_Sample_table.pf') TOMBR('$(PREPATH)/QTMPSRC.FILE/SORTSFLPF.MBR') MBROPT(*REPLACE)"
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTPF FILE($(BIN_LIB)/SORTSFLPF) SRCFILE($(BIN_LIB)/QTMPSRC) OPTION(*EVENTF) SRCMBR(SORTSFLPF)" > .logs/sortsflpf.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/SORTSFLPF.MBR') TOSTMF('.evfevent/sortsflpf.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')

