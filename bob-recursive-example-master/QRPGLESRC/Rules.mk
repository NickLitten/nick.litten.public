ART200.PGM: ART200-Work_with_article.PGM.SQLRPGLE ART201.PGM ARTICLE2.FILE ARTICLE1.FILE ART200D.FILE ARTIINF.FILE
ART201.PGM: ART201-Work_with_article.PGM.RPGLE ARTIPRO1.FILE ART201D.FILE
ART202.PGM: ART202-Function_Article.PGM.RPGLE ARTIPROV.FILE ART202D.FILE
LOG100.PGM: LOG100.PGM.RPGLE PARAMETER.FILE
ORD100.PGM: ORD100.PGM.RPGLE ORDER.FILE DETORD.FILE ORD100D.FILE LASTORDNO.DTAARA
ORD101.PGM: ORD101.PGM.RPGLE ORDER1.FILE DETORD1.FILE ORD101D.FILE
ORD200.PGM: ORD200.PGM.SQLRPGLE ORD101.PGM ORD202.PGM ORD100C.PGM ORDER1.FILE DETORD1.FILE CUSTOME1.FILE ORD200D.FILE ORDERCUS.FILE
ORD201.PGM: ORD201.PGM.SQLRPGLE ORD101.PGM ORD202.PGM ORDER1.FILE CUSTOME1.FILE ARTICLE1.FILE DETORD1.FILE ORD201D.FILE ORDERCUS.FILE
ORD202.PGM: ORD202.PGM.RPGLE CUSTOME1.FILE ARTICLE1.FILE DETORD1.FILE ORDER1.FILE ORD202D.FILE
ORD700.PGM: ORD700.PGM.RPGLE DETORD.FILE DETORD.FILE ARTICLE1.FILE
ORD900.PGM: ORD900.PGM.RPGLE ORDER1.FILE LASTORDNO.DTAARA
ORD901.PGM: ORD901.PGM.SQLRPGLE ORDER.FILE DETORD.FILE CUSTOMER.FILE

ART300.MODULE: ART300-Function_Article.RPGLE ARTICLE1.FILE
ART301.MODULE: ART301.SQLRPGLE ART301D.FILE
ART302.MODULE: ART302.SQLRPGLE ARTIINF.FILE
COU300.MODULE: COU300.RPGLE COUNTRY.FILE
COU301.MODULE: COU301.RPGLE COUNTRY.FILE COUNTR1.FILE COU301D.FILE
CUS300.MODULE: CUS300.RPGLE CUSTOME1.FILE
CUS301.MODULE: CUS301.SQLRPGLE CUS301D.FILE
DAT001.MODULE: DAT001.RPGLE
DAT002.MODULE: DAT002.RPGLE
FAM300.MODULE: FAM300.RPGLE FAMILLY.FILE
FAM301.MODULE: FAM301.RPGLE FAMILLY.FILE FAMILL1.FILE FAM301D.FILE
LOG300.MODULE: LOG300.RPGLE
PAR200.MODULE: PAR200.RPGLE
PAR300.MODULE: PAR300.RPGLE PARAMETER.FILE
PRO200.MODULE: PRO200.RPGLE FCOUNTRY.SRVPGM FPARAMETER.SRVPGM PRO202.MODULE
PRO202.MODULE: PRO202.SQLRPGLE PROVIDE1.FILE PRO202D.FILE ARTICLE.FILE ARTIPROV.FILE
PRO300.MODULE: PRO300.RPGLE PROVIDE1.FILE
XML001.MODULE: XML001.RPGLE QPROTOSRC/XML.RPGLEINC QPROTOSRC/txt.rpgleinc
TXT001.MODULE: TXT001.RPGLE

DAT002.PGM: DAT002.pgm.RPGLE
DAT001.PGM: DAT001.pgm.RPGLE
PAR200.PGM: PAR200.pgm.RPGLE PARAMETER.FILE PAR200D.FILE
PRO200.PGM: PRO200.pgm.RPGLE ART202.PGM PROVIDE1.FILE PRO200D.FILE