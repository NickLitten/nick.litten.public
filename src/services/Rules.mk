# ---
# Rules.mk - Service Programs Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for reusable service programs and modules
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
%.PGM:    private DBGVIEW := *SOURCE
%.PGM:    private ACTGRP := NICKLITTEN

# ---
# Object Dependencies
# ---

# SIMPLEMOD Module - Simple service program module
SIMPLEMOD.MODULE: SIMPLEMOD-Simple_Service_Program.sqlrpgle

# SIMPLESRV Service Program - Simple service program
SIMPLESRV.SRVPGM: SIMPLESRV-Binder_Source.bnd SIMPLEMOD.MODULE

# NICKSRV Module - Service program for lessons
NICKSRV.MODULE: NICKSRV-Service_Program_for_Lessons.sqlrpgle

# NICKSRV Service Program - Service program for lessons
NICKSRV.SRVPGM: NICKSRV-Binder_Source.bnd NICKSRV.MODULE

# EMAILSRV Module - Email service module
EMAILSRV.MODULE: EMAILSRV-Email_Service.sqlrpgle

# EMAILSRV Service Program - Email service program
EMAILSRV.SRVPGM: EMAILSRV-Email_Service.bnd EMAILSRV.MODULE

# USRPRFSRV Module - User profile service module
USRPRFSRV.MODULE: USRPRFSRV-User_Profile_Service.sqlrpgle

# USRPRFSRV Service Program - User profile service program
USRPRFSRV.SRVPGM: USRPRFSRV-User_Profile_Service.bnd USRPRFSRV.MODULE

# BIGBNDDIR Binding Directory - Sample binding directory for examples
BIGBNDDIR.BNDDIR: BIGBNDDIR-Nicks_Sample_Binding_Directory.bnddir

# PWDMON Binding Directory - Password monitor service program bindings
PWDMON.BNDDIR: PWDMON-Password_Monitor_Binding_Directory.bnddir