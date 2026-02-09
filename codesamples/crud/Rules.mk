%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

RECIPCRUD.FILE: RECIPCRUD-crud_rpgle_recipe_example.dspf
RECIPCRUD.PGM: RECIPCRUD-crud_rpgle_recipe_example.pgm.rpgle RECIPES.FILE RECIPCRUD.FILE

CRUD01PNL.FILE: CRUD01PNL-Change_Read_Update_Delete_Example.dspf
CRUD01RPG.PGM: CRUD01RPG-Change_Read_Update_Delete_Example.pgm.sqlrpgle CRUD01PNL.FILE