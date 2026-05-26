# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - SubfileSamples/1a_Full_Load_Subfile_SIMPLE
# -----------------------------------------------------------------------------
# This file defines build targets for the Full Load Subfile SIMPLE examples.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
SIMPLEDSPF.FILE:  SIMPLEDSPF-Display_file_for_the_subfile_example.dspf
SIMPLESFL1.PGM:   SIMPLESFL1-AS400_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE
SIMPLESFL2.PGM:   SIMPLESFL2-IBMi_RPG_subfile_FULL_LOAD.pgm.rpgle SIMPLEDSPF.FILE
SIMPLESFL3.PGM:   SIMPLESFL3-IBMi_RPG_subfile_FULL_LOAD_IBMi_BOB_Style.pgm.rpgle SIMPLEDSPF.FILE