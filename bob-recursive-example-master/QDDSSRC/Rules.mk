ARTICLE.FILE: ARTICLE-Article_File.PF SAMREF.FILE
ARTICLE1.FILE: ARTICLE1-Article_File.LF ARTICLE.FILE
ARTICLE2.FILE: ARTICLE2.LF ARTICLE.FILE
ART200D.FILE: ART200D-Work_with_Article.DSPF ARTICLE.FILE VATDEF.FILE
ART301D.FILE: ART301D-Function_Select_an_article.DSPF ARTICLE.FILE
 
CUSTOMER.FILE: CUSTOMER.PF SAMREF.FILE
CUSTOME1.FILE: CUSTOME1.LF CUSTOMER.FILE
CUSTOME2.FILE: CUSTOME2.LF CUSTOMER.FILE
CUS200D.FILE: CUS200D.DSPF CUSTOMER.FILE
CUS301D.FILE: CUS301D.DSPF CUSTOMER.FILE

COUNTRY.FILE: COUNTRY.PF SAMREF.FILE
COUNTR1.FILE: COUNTR1.LF COUNTRY.FILE
COU200D.FILE: COU200D.DSPF COUNTRY.FILE
COU301D.FILE: COU301D.DSPF COUNTRY.FILE

ORDER.FILE: ORDER.PF SAMREF.FILE
ORDER1.FILE: ORDER1.LF ORDER.FILE
ORDER2.FILE: ORDER2.LF ORDER.FILE
ORDER3.FILE: ORDER3.LF ORDER.FILE
DETORD.FILE: DETORD.PF SAMREF.FILE
DETORD1.FILE: DETORD1.LF DETORD.FILE
ORD100D.FILE: ORD100D.DSPF DETORD.FILE ORDER.FILE VATDEF.FILE
ORD101D.FILE: ORD101D.DSPF DETORD.FILE ORDER.FILE VATDEF.FILE
ORD200D.FILE: ORD200D.DSPF ORDER.FILE CUSTOMER.FILE
ORD201D.FILE: ORD201D.DSPF ORDER.FILE CUSTOMER.FILE
ORD202D.FILE: ORD202D.DSPF DETORD.FILE ARTICLE.FILE ORDER.FILE CUSTOMER.FILE
ORD500O.FILE: ORD500O.PRTF ORDER.FILE CUSTOMER.FILE DETORD.FILE ARTICLE.FILE
TMPDETORD.FILE: DETORD.FILE
	cl "CPYF FROMFILE($(OBJLIB)/DETORD) TOFILE($(OBJLIB)/TMPDETORD) CRTFILE(*YES) MBROPT(*ADD)"

FAMILLY.FILE: FAMILLY.PF SAMREF.FILE
FAMILL1.FILE: FAMILL1.LF FAMILLY.FILE
FAM301D.FILE: FAM301D.DSPF FAMILLY.FILE

PROVIDER.FILE: PROVIDER.PF SAMREF.FILE
PROVIDE1.FILE: PROVIDE1.LF PROVIDER.FILE
PRO200D.FILE: PRO200D.DSPF PROVIDER.FILE
PRO201D.FILE: PRO201D.DSPF PROVIDER.FILE

ARTIPROV.FILE: ARTIPROV.PF SAMREF.FILE
ARTIPRO1.FILE: ARTIPRO1.LF ARTIPROV.FILE
ART201D.FILE: ART201D-Work_with_Article.DSPF ARTIPROV.FILE PROVIDER.FILE ARTICLE.FILE
ART202D.FILE: ART202D-Work_with_Article.DSPF ARTIPROV.FILE ARTICLE.FILE PROVIDER.FILE
PRO202D.FILE: PRO202D.DSPF ARTICLE.FILE ARTIPROV.FILE PROVIDER.FILE

PARAMETER.FILE: PARAMETER.PF
PAR200D.FILE: PAR200D.DSPF PARAMETER.FILE
