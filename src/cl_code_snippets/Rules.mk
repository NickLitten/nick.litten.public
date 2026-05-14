# ---
# Rules.mk - CL Code Snippets Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for CL programming examples and snippets
# ---
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ---

# ---
# Compilation Settings
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

# CLBNDPGM Program - Simple bound CL program example
CLBNDPGM.PGM: CLBNDPGM-Simple_Bound_CL_Program.pgm.clle

# CLMODULE Module - Simple CL module example
CLMODULE.MODULE: CLMODULE-Simple_CL_Module.pgm.clle

# IASP Program - Question and answer CL example
IASP.PGM: IASP-Question_and_Answer_CL_Example.pgm.clle

# IASPLOOP Program - DOU question and answer CL example
IASPLOOP.PGM: IASPLOOP-DOU_Question_and_Answer_CL_Example.pgm.clle