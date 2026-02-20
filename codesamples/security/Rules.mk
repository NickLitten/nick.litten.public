# ==============================================================================
# Rules.mk - Build rules for Security Examples
# ==============================================================================
# This file defines the build rules for security-related programs including
# password expiration monitoring and user profile services.
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

# PWDEXPMON Command - Password expiration monitor command
PWDEXPMON.CMD: PWDEXPMON-Password_Expiration_Monitor.cmd

# PWDEXPMON Program - Password expiration monitor CL program
PWDEXPMON.PGM: PWDEXPMON-Password_Expiration_Monitor.clle

# PWDEXPILE Module - Password expiration monitor ILE module
PWDEXPILE.MODULE: PWDEXPILE-Password_Expiration_Monitor_ILE.sqlrpgle

# SCHEDULE Program - Setup password monitor schedule
SCHEDULE.PGM: SCHEDULE-Setup_Password_Monitor_Schedule.clle

# EMAILSRV Module - Email service module
EMAILSRV.MODULE: EMAILSRV-Email_Service.sqlrpgle

# EMAILSRV Service Program - Email service program
EMAILSRV.SRVPGM: EMAILSRV.bnd EMAILSRV.MODULE

# USRPROFSRV Module - User profile service module
USRPROFSRV.MODULE: USRPROFSRV-User_Profile_Service.sqlrpgle

# USRPROFSRV Service Program - User profile service program
USRPROFSRV.SRVPGM: USRPROFSRV.bnd USRPROFSRV.MODULE