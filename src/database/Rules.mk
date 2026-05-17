# ---
# Rules.mk - Database Objects Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Define database file and table object dependencies
# ---
# This directory contains physical files (PF) and SQL table definitions
# Tables must be created before programs that reference them
# ---

# ---
# Compilation Settings
# ---
# Inherit from root Rules.mk, override only if needed
# ---
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# ---
# Object Dependencies
# ---
# SQL Tables - Created via RUNSQLSTM or embedded SQL
# ---

# RECIPIES Table - Baking recipes for CRUD examples
RECIPIES.FILE: RECIPIES-Baking_Recipes.sql

# CRUD01TBL Table - Task management table for CRUD operations
CRUD01TBL.FILE: CRUD01TBL-Task_Management.sql

# FOODFILE Table - Ingredient inventory database
FOODFILE.FILE: FOODFILE-Ingredient_Inventory.sql

# PERSONTBL Table - Person information with name, DOB, address
PERSONTBL.FILE: PERSONTBL-Person_Information.sql

# SAMPLEDB Table - Country names sample database
SAMPLEDB.FILE: SAMPLEDB-Country_Names.sql

# ALLTABLE Table - Comprehensive SQL data types example
ALLTABLE.FILE: ALLTABLE-All_Data_Types.sql

# ---
# DDS Physical Files
# ---

# ALLFILE Physical File - Comprehensive DDS field types example
ALLFILE.FILE: ALLFILE-All_Field_Types.pf