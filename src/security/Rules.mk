# ---
# Rules.mk - Security Examples Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for security and password management utilities
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

# PWDEXPMON Command - Password expiration monitor command
PWDEXPMON.CMD: PWDEXPMON-Password_Expiration_Monitor.cmd

# PWDEXPMON Program - Password expiration monitor CL program
PWDEXPMON.PGM: PWDEXPMON-Password_Expiration_Monitor.pgm.clle

# PWDEXPILE Program - Password expiration monitor ILE program
PWDEXPILE.PGM: PWDEXPILE-Password_Expiration_Monitor_ILE.pgm.sqlrpgle

# SCHEDULE Program - Setup password monitor schedule
SCHEDULE.PGM: SCHEDULE-Setup_Password_Monitor_Schedule.pgm.clle
