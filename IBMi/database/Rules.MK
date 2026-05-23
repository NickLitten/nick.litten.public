# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules
# -----------------------------------------------------------------------------
# This file defines build targets and subdirectories for the MAKEi build system.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
#
# Variables:
#   TARGETS  - Source files to compile in this directory
#   SUBDIRS  - Subdirectories to process recursively
#
# Usage:
#   make          - Build all targets in this directory
#   make clean    - Remove all built objects
#   make install  - Deploy objects to IBM i system
# -----------------------------------------------------------------------------
TARGETS := ALLFILE-All_Field_Types.pf ALLTABLE-All_Data_Types.sql CRUD01TBL-Task_Management.sql FOODFILE-Ingredient_Inventory.sql PERSONTBL-Person_Information.sql PERSONTBLX-Person_Table_Old_DDS.pf RECIPIES-Baking_Recipes.sql SAMPLEDB-Country_Names.sql SIMPLEFILE-Super_Simple_file_with_NAME_ADDRESS.pf SIMPLEFILE-Super_Simple_file_with_NAME_ADDRESS.sql