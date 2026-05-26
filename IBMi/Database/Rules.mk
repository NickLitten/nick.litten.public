# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - Database Module
# -----------------------------------------------------------------------------
# This file defines build targets for the Database files and tables.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
ALLFILE.FILE:     ALLFILE-All_Field_Types.pf
ALLTABLE.FILE:    ALLTABLE-All_Data_Types.sql
CRUD01TBL.FILE:   crud01tbl.table
FOODFILE.FILE:    FOODFILE-Ingredient_Inventory.table
PERSONTBL.FILE:   PERSONTBL-Person_Information.sql
PERSONTBLX.FILE:  PERSONTBLX-Person_Table_Old_DDS.pf
RECIPIES.FILE:    RECIPIES-Baking_Recipes.table
SAMPLEDB.FILE:    SAMPLEDB-Country_Names.sql
SIMPLEFILE.FILE:  SIMPLEFILE-Super_Simple_file_with_NAME_ADDRESS.pf