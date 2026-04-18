# ------------------------------------------------------------------------------
# Rules.mk - Build rules for CRUD Subfile Example (Work In Progress)
# ------------------------------------------------------------------------------
# This directory contains a CRUD (Change, Read, Update, Delete) subfile example
# that is currently under development and refinement.
#
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ------------------------------------------------------------------------------

# Default compilation settings for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# ------------------------------------------------------------------------------
# Object Dependencies
# ------------------------------------------------------------------------------

# CRUD01PNL Display File - Change/Read/Update/Delete example display file
CRUD01PNL.FILE: CRUD01PNL-Change_Read_Update_Delete_Example.dspf

# CRUD01RPG Program - Change/Read/Update/Delete example program
# Note: Depends on CRUD01TBL table from database directory
CRUD01RPG.PGM: CRUD01RPG-Change_Read_Update_Delete_Example.pgm.sqlrpgle CRUD01PNL.FILE

# Made with Bob
