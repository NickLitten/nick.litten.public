# ==============================================================================
# Rules.mk - Build rules for CRUD Examples
# ==============================================================================
# This file defines the build rules for Create, Read, Update, Delete examples.
#
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ==============================================================================

# Default compilation settings for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# ==============================================================================
# Object Dependencies
# ==============================================================================

# RECIPCRUD Display File - Recipe CRUD example display file
RECIPCRUD.FILE: RECIPCRUD-crud_rpgle_recipe_example.dspf

# RECIPCRUD Program - Recipe CRUD example program
RECIPCRUD.PGM: RECIPCRUD-crud_rpgle_recipe_example.pgm.rpgle RECIPES.FILE RECIPCRUD.FILE

# CRUD01PNL Display File - Change/Read/Update/Delete example display file
CRUD01PNL.FILE: CRUD01PNL-Change_Read_Update_Delete_Example.dspf

# CRUD01RPG Program - Change/Read/Update/Delete example program
CRUD01RPG.PGM: CRUD01RPG-Change_Read_Update_Delete_Example.pgm.sqlrpgle CRUD01PNL.FILE