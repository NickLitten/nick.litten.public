# ==============================================================================
# Rules.mk - Build rules for Update IASP Job Descriptions
# ==============================================================================
# This file defines the build rules for updating IASP job descriptions.
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

# UPDIASP Program - Update IASP Job Descriptions (CL version)
UPDIASP.PGM: UPDIASP-Update_IASP_Job_Descriptions.pgm.clle

# UPDIASPSQL Program - Update IASP Job Descriptions (SQLRPGLE version)
UPDIASPSQL.PGM: UPDIASPSQL-Update_IASP_Job_Descriptions.pgm.sqlrpgle