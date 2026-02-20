# ==============================================================================
# Rules.mk - Build rules for RPG Modernization Examples
# ==============================================================================
# This file defines the build rules for RPG modernization examples showing
# the evolution from legacy RPG/400 to modern free-format RPGLE.
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

# OLDRPG Program - Old RPG/400 code example
OLDRPG.PGM: OLDRPG-old_rpg400_code.pgm.rpgle

# OLDTAGRPG1 Program - Old RPG/400 with GOTO/TAG/subroutine
OLDTAGRPG1.PGM: OLDTAGRPG1-old_rpg400_with_goto_tag_subroutine.pgm.rpgle

# OLDTAGRPG2 Program - Old RPG/400 lightly neater version
OLDTAGRPG2.PGM: OLDTAGRPG2-old_rpg400_lightly_neater.pgm.rpgle

# OLDTAGRPG3 Program - Old RPG/400 modernized version
OLDTAGRPG3.PGM: OLDTAGRPG3-old_rpg400_modernised.pgm.rpgle

# FREERPG Program - Nick's version of free-format RPG
FREERPG.PGM: FREERPG-Nicks_Version.pgm.rpgle

# FREERPG1 Program - RPGLE free-format example
FREERPG1.PGM: FREERPG1-RPGLE_Free.pgm.rpgle

# FREERPG2 Program - ARCAD converter output
FREERPG2.PGM: FREERPG2-ARCAD_Converter.pgm.rpgle

# FREERPG3 Program - Cozzi converter output
FREERPG3.PGM: FREERPG3-Cozzi_Converter.pgm.rpgle

# IFSLEGACY Program - IFS sample legacy RPG column-based
IFSLEGACY.PGM: IFSLEGACY-IFS_Sample_legacy_RPG_Column_Based.pgm.rpgle

# IFSMODERN Program - IFS sample modernized RPG free-format
IFSMODERN.PGM: IFSMODERN-IFS_Sample_modernised_RPG_Free.pgm.rpgle

# IFSIMPROVE Program - IFS sample modernized and improved
IFSIMPROVE.PGM: IFSIMPROVE-IFS_Sample_Modernised_and_Improved.pgm.rpgle