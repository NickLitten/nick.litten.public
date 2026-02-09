%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

PWDEXPMON.CMD: PWDEXPMON-Password_Expiration_Monitor.cmd
PWDEXPMON.PGM: PWDEXPMON-Password_Expiration_Monitor.clle
PWDEXPILE.MODULE: PWDEXPILE-Password_Expiration_Monitor_ILE.sqlrpgle
SCHEDULE.PGM: SCHEDULE-Setup_Password_Monitor_Schedule.clle
EMAILSRV.MODULE: EMAILSRV-Email_Service.sqlrpgle
EMAILSRV.SRVPGM: EMAILSRV.bnd EMAILSRV.MODULE
USRPROFSRV.MODULE: USRPROFSRV-User_Profile_Service.sqlrpgle
USRPROFSRV.SRVPGM: USRPROFSRV.bnd USRPROFSRV.MODULE