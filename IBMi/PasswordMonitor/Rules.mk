# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - PasswordMonitor Module
# -----------------------------------------------------------------------------
# This file defines build targets for the Password Expiration Monitor utility.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
#
# Build Order:
#   1. Main SQLRPGLE program (PWDEXPILE.PGM)
#   2. CL wrapper program (PWDEXPMON.PGM)
#   3. Command object (PWDEXPMON.CMD)
#   4. Schedule setup program (SCHEDULE.PGM)
#
# Dependencies:
#   - Service programs: USRPRFSRV.SRVPGM, EMAILSRV.SRVPGM
#   - Binding directory: BIGBNDDIR.BNDDIR
#
# Usage: make -f Rules.mk [target]
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
# Main password expiration monitor (SQLRPGLE with service program dependencies)
PWDEXPILE.PGM:    PWDEXPILE-Password_Expiration_Monitor.pgm.sqlrpgle

# CL wrapper program (depends on main program)
PWDEXPMON.PGM:    PWDEXPMON-Password_Expiration_Monitor.pgm.clle PWDEXPILE.PGM

# Command object (depends on CL wrapper)
PWDEXPMON.CMD:    PWDEXPMON-Password_Expiration_Monitor.cmd PWDEXPMON.PGM

# Schedule setup utility
SCHEDULE.PGM:     SCHEDULE-Setup_Password_Monitor_Schedule.pgm.clle