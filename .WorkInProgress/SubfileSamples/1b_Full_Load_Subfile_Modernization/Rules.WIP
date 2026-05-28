# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - SubfileSamples/1b_Full_Load_Subfile_Modernization
# -----------------------------------------------------------------------------
# This file defines build targets for the Full Load Subfile Modernization examples.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
NOOBDSPF.FILE:    NOOBDSPF-Full_load_sfl_with_incrementing_value.dspf
NOOBSFL1.PGM:     NOOBSFL1-Full_load_subfile_example_AS400_STYLE.pgm.rpgle NOOBDSPF.FILE
NOOBSFL2.PGM:     NOOBSFL2-Full_load_subfile_example_ISERIES_STYLE.pgm.rpgle NOOBDSPF.FILE
NOOBSFL3.PGM:     NOOBSFL3-Full_load_subfile_example_IBMi_STYLE.pgm.rpgle NOOBDSPF.FILE
NOOBSFL4.PGM:     NOOBSFL4-Full_load_subfile_example_IBMi_BOB_STYLE.pgm.rpgle NOOBDSPF.FILE