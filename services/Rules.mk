# ------------------------------------------------------------------------------
# Rules.mk - Build rules for Service Programs
# ------------------------------------------------------------------------------
# This file defines the build rules for service programs.
#
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ------------------------------------------------------------------------------

# Default compilation settings for all modules and programs
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0

# Program compilation settings (inherits TGTRLS and ACTGRP from root Rules.mk)
# These settings are already defined in root Rules.mk but explicitly declared here
# for clarity and to allow service-specific overrides if needed in the future
%.PGM:    private ENTMOD := *PGM        # Entry module is the program itself
%.PGM:    private ALWRTVSRC := *NO      # Disallow retrieve source (production setting)
%.PGM:    private OPTIMIZE := *FULL     # Full optimization for performance
%.PGM:    private DBGVIEW := *SOURCE    # Include source view for debugging
%.PGM:    private ACTGRP := NICKLITTEN

# ------------------------------------------------------------------------------
# Object Dependencies
# ------------------------------------------------------------------------------

# SIMPLEMOD Module - Simple service program module
SIMPLEMOD.MODULE: SIMPLEMOD-Simple_Service_Program.sqlrpgle

# SIMPLESRV Service Program - Simple service program
SIMPLESRV.SRVPGM: SIMPLESRV-Binder_Source.bnd SIMPLEMOD.MODULE

# SIMPLEMOD Module - Simple service program module
NICKMOD.MODULE: NICKMOD-Service_Program_for_Lessons.sqlrpgle

# SIMPLESRV Service Program - Simple service program
NICKSRV.SRVPGM: NICKSRV-Binder_Source.bnd NICKMOD.MODULE