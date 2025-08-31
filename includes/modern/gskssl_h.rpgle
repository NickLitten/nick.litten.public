          // -
          //  Copyright (c) 2001,2004 Scott C. Klement
          //  All rights reserved.

          //  Redistribution and use in source and binary forms, with or without
          //  modification, are permitted provided that the following conditions
          //  are met:
          //  1. Redistributions of source code must retain the above copyright
          //     notice, this list of conditions and the following disclaimer.
          //  2. Redistributions in binary form must reproduce the above copyright
          //     notice, this list of conditions and the following disclaimer in the
          //     documentation and/or other materials provided with the distribution.

          //  THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
          //  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
          //  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPO
          //  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
          //  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTI
          //  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
          //  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
          //  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRI
          //  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WA
          //  OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
          //  SUCH DAMAGE.

          // /

          // * This is a /copy file containing the constants, prototypes
          // * and structures needed to call IBM's Global Secure Toolkit


          // ***************************************************************
          //   These errors may be returned by any of the GSKit functions:

          //   (exception: _INVALID_HANDLE & _INVALID_STATE are never
          //               returned by the 'open' function)
          // ***************************************************************
         dcl-c GSK_OK CONST(0) ;
         dcl-c GSK_INVALID_HA  CONST(1) ;
         dcl-c GSK_API_NOT_AV  CONST(2) ;
         dcl-c GSK_INTERNAL_E  CONST(3) ;
         dcl-c GSK_INSUFFICIE  CONST(4) ;
         dcl-c GSK_INVALID_ST  CONST(5) ;
         dcl-c GSK_KEY_LABEL_  CONST(6) ;
         dcl-c GSK_CERTIFICAT  EXTFLD CONST(7) ;
         dcl-c GSK_ERROR_CERT  CONST(8);
         dcl-c GSK_ERROR_CRYP CONST(9) ;
         dcl-c GSK_ERROR_ASN zoned(0:C) NST(10) ;
         dcl-c GSK_ERROR_LDAP  ONST(11) ;
         dcl-c GSK_ERROR_UNKN  CONST(12);


          // ***************************************************************
          //  These errors may be returned by any of the '_open' functions
          // ***************************************************************
         dcl-c GSK_OPEN_CIPHE  CONST(101) ;
         dcl-c GSK_KEYFILE_IO  CONST(102) ;
         dcl-c GSK_KEYFILE_IN  CONST(103) ;
         dcl-c GSK_KEYFILE_DU  CONST(104) ;
         dcl-c GSK_KEYFILE_DU  CONST(105) ;
         dcl-c GSK_BAD_FORMAT  CONST(106) ;
         dcl-c GSK_KEYFILE_CE  CONST(107) ;
         dcl-c GSK_ERROR_LOAD  CONST(108);


          // ***************************************************************
          //   These may be returned by the gsk_enviornment_init function:
          // ***************************************************************
         dcl-c GSK_NO_KEYFILE  CONST(201) ;
         dcl-c GSK_KEYRING_OP  EXTFLD CONST(202) ;
         dcl-c GSK_RSA_TEMP_K  EXTFLD CONST(203);


          // ***************************************************************
          //   These may be returned by all '_close' functions:
          // ***************************************************************
         dcl-c GSK_CLOSE_FAIL CONST(301);


          // ***************************************************************
          //   These may be returned by the 'gsk_secure_soc_init' function:
          // ***************************************************************
         dcl-c GSK_ERROR_BAD_  CONST(401) ;
         dcl-c GSK_ERROR_NO_C  CONST(402) ;
         dcl-c GSK_ERROR_NO_C  EXTFLD CONST(403) ;
         dcl-c GSK_ERROR_BAD_  CONST(404) ;
         dcl-c GSK_ERROR_UNSU  PE C                   CONST(405) ;
         dcl-c GSK_ERROR_IO C zoned(0:CO) ST(406) ;
         dcl-c GSK_ERROR_BAD_  CONST(407) ;
         dcl-c GSK_ERROR_BAD_  CONST(408) ;
         dcl-c GSK_ERROR_BAD_  CONST(409) ;
         dcl-c GSK_ERROR_BAD_  CONST(410);
         dcl-c GSK_ERROR_BAD_ CONST(411) ;
         dcl-c GSK_ERROR_UNSU  CONST(412) ;
         dcl-c GSK_ERROR_BAD_  CONST(413) ;
         dcl-c GSK_ERROR_BAD_  CONST(414) ;
         dcl-c GSK_ERROR_BAD_  CONST(415) ;
         dcl-c GSK_ERROR_PERM  CONST(416) ;
         dcl-c GSK_ERROR_SELF  CONST(417) ;
         dcl-c GSK_ERROR_NO_R  EXTFLD CONST(418) ;
         dcl-c GSK_ERROR_NO_W  CONST(419) ;
         dcl-c GSK_ERROR_SOCK  EXTFLD CONST(420) ;
         dcl-c GSK_ERROR_BAD_  CONST(421) ;
         dcl-c GSK_ERROR_BAD_  CONST(422) ;
         dcl-c GSK_ERROR_BAD_  CONST(423) ;
         dcl-c GSK_ERROR_BAD_ OBJECT  CONST(424) ;
         dcl-c GSK_ERROR_HAND  CONST(425) ;
         dcl-c GSK_ERROR_INIT USC2(0) CONST(426) ;
         dcl-c GSK_ERROR_LDAP  CONST(427) ;
         dcl-c GSK_ERROR_NO_P  CONST(428);


          // ***************************************************************
          //   These may be returned by the read and write functions:
          // ***************************************************************
         dcl-c GSK_INVALID_BU  CONST(501);
         dcl-c GSK_WOULD_BLOC CONST(502);


          // ***************************************************************
          //   These may be returned by the gsk_secure_soc_misc function:
          // ***************************************************************
         dcl-c GSK_ERROR_NOT_  CONST(601) ;
         dcl-c GSK_MISC_INVAL  CONST(602);


          // ***************************************************************
          //   These may be returned by the gsk_attribute_set_ functions:
          // ***************************************************************
         dcl-c GSK_ATTRIBUTE_  CONST(701) ;
         dcl-c GSK_ATTRIBUTE_  CONST(702) ;
         dcl-c GSK_ATTRIBUTE_ ind CONST(703) ;
         dcl-c GSK_ATTRIBUTE_ USC2(0) CONST(704) ;
         dcl-c GSK_ATTRIBUTE_  C                   CONST(705);


          // ***************************************************************
          //   These may be returned by the cert prompt callback routine:
          // ***************************************************************
         dcl-c GSK_SC_OK C ind 1501) ;
         dcl-c GSK_SC_CANCEL zoned(0:C) NST(1502);


          // ***************************************************************
          //   Reserve ranges for return values & enumerated types on a
          //    per-platform basis:
          // ***************************************************************
         dcl-c GSK_AS400_BASE  ONST(6000) ;
         dcl-c GSK_AS400_BASE  CONST(6999) ;
         dcl-c GSK_OS390_BASE  ONST(7000) ;
         dcl-c GSK_OS390_BASE  CONST(7999);


          // ***************************************************************
          //   AS/400 specific errors:
          // ***************************************************************
         dcl-c GSK_AS400_ERRO  CONST(6000) ;
         dcl-c GSK_AS400_ERRO  CONST(6001) ;
         dcl-c GSK_AS400_ERRO  CONST(6002) ;
         dcl-c GSK_AS400_ERRO  CONST(6003) ;
         dcl-c GSK_AS400_ERRO  CONST(6004) ;
         dcl-c GSK_AS400_ERRO uns(0) RITIES C                   CONST(6005 ;
         dcl-c GSK_AS400_ERRO  CONST(6007) ;
         dcl-c GSK_AS400_ERRO  CONST(6008) ;
         dcl-c GSK_AS400_ERRO  CONST(6009) ;
         dcl-c GSK_AS400_ERRO USC2(0) CONST(6010) ;
         dcl-c GSK_AS400_ERRO  CONST(6011) ;
         dcl-c GSK_AS400_ASYN  CONST(6012) ;
         dcl-c GSK_AS400_ASYN  CONST(6013) ;
         dcl-c GSK_AS400_ERRO  _T C                   CONST(6014) ;
         dcl-c GSK_AS400_ERRO time(*ISO) PORT C                   CONST(6015) ;
         dcl-c GSK_AS400_ERRO int(0) R C                   CONST(6016) ;
         dcl-c GSK_AS400_4BYT  EXTFLD CONST(70000);


          // ***************************************************************

          // ***************************************************************
         dcl-s gsk_handle pointer;


          // ***************************************************************
          //    typedef enum GSK_MISC_ID_T
          //    {
          //      GSK_RESET_CIPHER = 100,  /* Rerun handshake */
          //      GSK_RESET_SESSION = 101, /* Reset SID entry */
          //                   /* Force enum size to 4 bytes - do not use this value *
          //      GSK_AS400_MISC_FINAL = GSK_AS400_4BYTE_VALUE

          //    } GSK_MISC_ID;
          // ***************************************************************
         dcl-s GSK_MISC_ID int(10);
         dcl-c GSK_RESET_CIPH CONST(100) ;
         dcl-c GSK_RESET_SESS  CONST(101);


          // ***************************************************************
          //    typedef enum GSK_BUF_ID_T
          //    {
          //      GSK_USER_DATA = 200,
          //      GSK_KEYRING_FILE = 201,
          //      GSK_KEYRING_PW = 202,
          //      GSK_KEYRING_LABEL = 203,
          //      GSK_KEYRING_STASH_FILE = 204,
          //      GSK_V2_CIPHER_SPECS = 205,
          //      GSK_V3_CIPHER_SPECS = 206,
          //      GSK_CONNECT_CIPHER_SPEC = 207,
          //      GSK_CONNECT_SEC_TYPE = 208,
          //      GSK_LDAP_SERVER = 209,
          //      GSK_LDAP_USER = 210,
          //      GSK_LDAP_USER_PW = 211,
          //      GSK_SID_VALUE = 212,
          //      GSK_PKCS11_DRIVER_PATH = 213,
          //      GSK_OS400_APPLICATION_ID = 6999,
          //                   /* Force enum size to 4 bytes - do not use this value *
          //      GSK_AS400_BUF_FINAL = GSK_AS400_4BYTE_VALUE

          //    } GSK_BUF_ID;
          // ***************************************************************
         dcl-s GSK_BUF_ID int(10) ;
         dcl-c GSK_USER_DATA zoned(0:C) NST(200);
         dcl-c GSK_KEYRING_FI CONST(201) ;
         dcl-c GSK_KEYRING_PW  ONST(202) ;
         dcl-c GSK_KEYRING_LA  CONST(203) ;
         dcl-c GSK_KEYRING_ST  CONST(204) ;
         dcl-c GSK_V2_CIPHER_  CONST(205) ;
         dcl-c GSK_V3_CIPHER_  CONST(206) ;
         dcl-c GSK_CONNECT_CI  CONST(207) ;
         dcl-c GSK_CONNECT_SE  CONST(208);
         dcl-c GSK_LDAP_SERVE CONST(209) ;
         dcl-c GSK_LDAP_USER zoned(0:C) NST(210);
         dcl-c GSK_LDAP_USER_ CONST(211) ;
         dcl-c GSK_SID_VALUE zoned(0:C) NST(212) ;
         dcl-c GSK_PKCS11_DRI  CONST(213) ;
         dcl-c GSK_OS400_APPL  CONST(6999);


          // ***************************************************************
          //    typedef enum GSK_NUM_ID_T
          //    {
          //      GSK_FD = 300,
          //      GSK_V2_SESSION_TIMEOUT = 301,
          //      GSK_V3_SESSION_TIMEOUT = 302,
          //      GSK_LDAP_SERVER_PORT = 303,
          //      GSK_V2_SIDCACHE_SIZE = 304,
          //      GSK_V3_SIDCACHE_SIZE = 305,
          //      GSK_CERTIFICATE_VALIDATION_CODE = 6996,
          //      GSK_HANDSHAKE_TIMEOUT = 6998,
          //                   /* Force enum size to 4 bytes - do not use this value *
          //      GSK_AS400_NUM_FINAL = GSK_AS400_4BYTE_VALUE

          //    } GSK_NUM_ID;
          // ***************************************************************
         dcl-s GSK_NUM_ID int(10) ;
         dcl-c GSK_FD C zoned(0:30) ) ;
         dcl-c GSK_V2_SESSION  CONST(301) ;
         dcl-c GSK_V3_SESSION  CONST(302) ;
         dcl-c GSK_LDAP_SERVE  CONST(303) ;
         dcl-c GSK_V2_SIDCACH  EXTFLD CONST(304) ;
         dcl-c GSK_V3_SIDCACH  EXTFLD CONST(305) ;
         dcl-c GSK_CERTIFICAT USC2(0) EXTFLD CONST(6996) ;
         dcl-c GSK_HANDSHAKE_  CONST(6998);


          // ***************************************************************
          //    typedef enum GSK_ENUM_ID_T
          //    {
          //      GSK_CLIENT_AUTH_TYPE = 401,
          //      GSK_SESSION_TYPE = 402,
          //      GSK_PROTOCOL_SSLV2 = 403,
          //      GSK_PROTOCOL_SSLV3 = 404,
          //      GSK_PROTOCOL_USED = 405,
          //      GSK_SID_FIRST = 406,
          //      GSK_PROTOCOL_TLSV1 = 407,
          //                   /* Force enum size to 4 bytes - do not use this value *
          //      GSK_AS400_ENUM_FINAL = GSK_AS400_4BYTE_VALUE

          //    } GSK_ENUM_ID ;
          // ***************************************************************
         dcl-s GSK_ENUM_ID int(10) ;
         dcl-c GSK_CLIENT_AUT  CONST(401);
         dcl-c GSK_SESSION_TY CONST(402) ;
         dcl-c GSK_PROTOCOL_S  CONST(403) ;
         dcl-c GSK_PROTOCOL_S  CONST(404) ;
         dcl-c GSK_PROTOCOL_U  CONST(405) ;
         dcl-c GSK_SID_FIRST zoned(0:C) NST(406) ;
         dcl-c GSK_PROTOCOL_T  CONST(407) ;
         dcl-c GSK_SERVER_AUT  CONST(410);


          // ***************************************************************

          //    typedef enum GSK_ENUM_VALUE_T
          //    {
          //      GSK_NULL = 500,                         /* Use for initial value   *
          //      GSK_CLIENT_AUTH_FULL = 503,             /* GSK_CLIENT_AUTH_TYPE    *
          //      GSK_CLIENT_AUTH_PASSTHRU = 505,         /* GSK_CLIENT_AUTH_TYPE    *
          //      GSK_CLIENT_SESSION = 507,               /* GSK_SESSION_TYPE        *
          //      GSK_SERVER_SESSION = 508,               /* GSK_SESSION_TYPE        *
          //      GSK_SERVER_SESSION_WITH_CL_AUTH = 509,  /* GSK_SESSION_TYPE        *
          //      GSK_PROTOCOL_SSLV2_ON = 510,            /* GSK_PROTOCOL_SSLV2      *
          //      GSK_PROTOCOL_SSLV2_OFF = 511,           /* GSK_PROTOCOL_SSLV2      *
          //      GSK_PROTOCOL_SSLV3_ON = 512,            /* GSK_PROTOCOL_SSLV3      *
          //      GSK_PROTOCOL_SSLV3_OFF = 513,           /* GSK_PROTOCOL_SSLV3      *
          //      GSK_PROTOCOL_USED_SSLV2 = 514,          /* GSK_PROTOCOL_USED       *
          //      GSK_PROTOCOL_USED_SSLV3 = 515,          /* GSK_PROTOCOL_USED       *
          //      GSK_SID_IS_FIRST = 516,                 /* GSK_SID_FIRST           *
          //      GSK_SID_NOT_FIRST = 517,                /* GSK_SID_FIRST           *
          //      GSK_PROTOCOL_TLSV1_ON = 518,            /* GSK_PROTOCOL_TLSV1      *
          //      GSK_PROTOCOL_TLSV1_OFF = 519,           /* GSK_PROTOCOL_TLSV1      *
          //      GSK_PROTOCOL_USED_TLSV1 = 520,          /* GSK_PROTOCOL_USED (get) *
          //      GSK_OS400_CLIENT_AUTH_REQUIRED = 6995,  /* GSK_CLIENT_AUTH_TYPE    *
          //                   /* Force enum size to 4 bytes - do not use this value *
          //      GSK_AS400_ENUM_VALUE_FINAL = GSK_AS400_4BYTE_VALUE

          //    } GSK_ENUM_VALUE ;
          // ***************************************************************
         dcl-s GSK_ENUM_VALUE int(10) ;
         dcl-c GSK_NULL C zoned(0:T() 00) ;
         dcl-c GSK_CLIENT_AUT  CONST(503) ;
         dcl-c GSK_CLIENT_AUT  CONST(505) ;
         dcl-c GSK_CLIENT_SES  CONST(507) ;
         dcl-c GSK_SERVER_SES  CONST(508) ;
         dcl-c GSK_SERVER_SES USC2(0) CONST(509) ;
         dcl-c GSK_PROTOCOL_S  CONST(510) ;
         dcl-c GSK_PROTOCOL_S  CONST(511) ;
         dcl-c GSK_PROTOCOL_S  CONST(512) ;
         dcl-c GSK_PROTOCOL_S  CONST(513) ;
         dcl-c GSK_PROTOCOL_U  CONST(514) ;
         dcl-c GSK_PROTOCOL_U  CONST(515);
         dcl-c GSK_SID_IS_FIR CONST(516) ;
         dcl-c GSK_SID_NOT_FI  CONST(517) ;
         dcl-c GSK_PROTOCOL_T  CONST(518) ;
         dcl-c GSK_PROTOCOL_T  CONST(519) ;
         dcl-c GSK_PROTOCOL_U  CONST(520) ;
         dcl-c GSK_SERVER_AUT  CONST(534) ;
         dcl-c GSK_SERVER_AUT  CONST(535) ;
         dcl-c GSK_OS400_CLIE  CONST(6995);

          // ***************************************************************
          //    /* The following enumerated type is the identifier for the data type
          //       of the elements of the array of information in the gsk_cert_data
          //       structure. Note that depending on the specific certificate, some
          //       data types may not be present. */
          //    typedef enum GSK_CERT_DATA_ID_T
          //    {
          //      CERT_BODY_DER = 600,     /* complete certificate body, der format */
          //      CERT_BODY_BASE64 = 601,  /* complete certificate body, base 64    */
          //      CERT_SERIAL_NUMBER = 602,
          //      CERT_COMMON_NAME = 610,
          //      CERT_LOCALITY = 611,
          //      CERT_STATE_OR_PROVINCE = 612,
          //      CERT_COUNTRY = 613,
          //      CERT_ORG = 614,
          //      CERT_ORG_UNIT = 615,
          //      CERT_DN_PRINTABLE = 616,
          //      CERT_DN_DER = 617,
          //      CERT_POSTAL_CODE = 618,
          //      CERT_EMAIL = 619,
          //      CERT_ISSUER_COMMON_NAME = 650,
          //      CERT_ISSUER_LOCALITY = 651,
          //      CERT_ISSUER_STATE_OR_PROVINCE = 652,
          //      CERT_ISSUER_COUNTRY = 653,
          //      CERT_ISSUER_ORG = 654,
          //      CERT_ISSUER_ORG_UNIT = 655,
          //      CERT_ISSUER_DN_PRINTABLE = 656,
          //      CERT_ISSUER_DN_DER = 657,
          //      CERT_ISSUER_POSTAL_CODE = 658,
          //      CERT_ISSUER_EMAIL = 659,
          //                   /* Force enum size to 4 bytes - do not use this value *
          //      GSK_AS400_CERT_DATA_FINAL = GSK_AS400_4BYTE_VALUE


          //    } GSK_CERT_DATA_ID;
          // ***************************************************************
         dcl-s GSK_CERT_DATA_ char(1);
         dcl-c CERT_BODY_DER zoned(0:C) NST(600);
         dcl-c CERT_BODY_BASE CONST(601);
         dcl-c CERT_SERIAL_NU  CONST(602);
         dcl-c CERT_COMMON_NA CONST(610);
         dcl-c CERT_LOCALITY zoned(0:C) NST(611);
         dcl-c CERT_STATE_OR_  CONST(612);
         dcl-c CERT_COUNTRY C zoned(0:CO) ST(613);
         dcl-c CERT_ORG C zoned(0:T() 14);
         dcl-c CERT_ORG_UNIT zoned(0:C) NST(615);
         dcl-c CERT_DN_PRINTA  CONST(616);
         dcl-c CERT_DN_DER C USC2(0) T(617);
         dcl-c CERT_POSTAL_CO CONST(618);
         dcl-c CERT_EMAIL C OBJECT  (619);
         dcl-c CERT_ISSUER_CO  CONST(650);
         dcl-c CERT_ISSUER_LO  CONST(651);
         dcl-c CERT_ISSUER_ST  CONST(652);
         dcl-c CERT_ISSUER_CO  CONST(653);
         dcl-c CERT_ISSUER_OR CONST(654);
         dcl-c CERT_ISSUER_OR  CONST(655);
         dcl-c CERT_ISSUER_DN  CONST(656);
         dcl-c CERT_ISSUER_DN  CONST(657);
         dcl-c CERT_ISSUER_PO  CONST(658);
         dcl-c CERT_ISSUER_EM  CONST(659);
         dcl-c CERT_VERSION C zoned(0:CO) ST(660);
         dcl-c CERT_SIGNATURE  CONST(661);
         dcl-c CERT_VALID_FRO CONST(662);
         dcl-c CERT_VALID_TO zoned(0:C) NST(663);

          // ***************************************************************
          //    typedef struct gsk_cert_data_elem_t
          //    {
          //      GSK_CERT_DATA_ID cert_data_id;  /* identifer of each data type */
          //      char *cert_data_p;  /* pointer to data */
          //      int cert_data_l;  /* length of data (not including trailing null) */

          //    } gsk_cert_data_elem;
          // ***************************************************************
         dcl-c p_gsk_cert_datpointer;
         dcl-c GSK_cert_data_  EXTFLD ALIGN BASED(p_gsk_cert_data_elem);
         dcl-c cert_data_id  like(GSK_CERT_DATA_ID);
         dcl-c cert_data_p pointer;
         dcl-c cert_data_l int(10);
         dcl-c cert_padding char(12);

          // ***************************************************************
          //    typedef enum GSK_CERT_ID_T
          //    {
          //      GSK_PARTNER_CERT_INFO = 700,
          //      GSK_LOCAL_CERT_INFO = 701,
          //                   /* Force enum size to 4 bytes - do not use this value *
          //      GSK_AS400_CERT_FINAL = GSK_AS400_4BYTE_VALUE

          //    } GSK_CERT_ID ;
          // ***************************************************************
         dcl-s GSK_CERT_ID int(10) ;
         dcl-c GSK_PARTNER_CE  CONST(700) ;
         dcl-c GSK_LOCAL_CERT  CONST(701);


          // *---------------------------------------------------------------------
          // *  int gsk_environment_open(gsk_handle *my_env_handle)
          // *
          // *     creates a new GSKit Enviorment.  (This is the first API
          // *     you need to call)
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_environmen int(10) extproc('gsk_environment_open');
         my_env_handle  like(gsk_handle);
         end-pr;


          // *---------------------------------------------------------------------
          // *
          // *  int gsk_environment_init(gsk_handle my_env_handle)
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_environmen int(10) extproc('gsk_environment_init');
         my_env_handle  like(gsk_handle) value;
        end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_environment_close(gsk_handle *my_env_handle)
          // *
          // *---------------------------------------------------------------------
         
         
         dcl-pr gsk_environmen int(10) extproc('gsk_environment_close');
         my_env_handle  like(gsk_handle);
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *   int gsk_attribute_get_buffer(gsk_handle my_gsk_handle,
          // *                            GSK_BUF_ID bufID,
          // *                            const char **buffer,
          // *                            int *bufSize);
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_attribute_ int(10) extproc('gsk_attribute_get_buffer');
         my_gsk_handle  like(gsk_handle) value;
         bufID  like(GSK_BUF_ID) value;
         buffer pointer value;
         bufSize int(10);
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *   int gsk_attribute_set_buffer(gsk_handle my_gsk_handle,
          // *                            GSK_BUF_ID bufID,
          // *                            const char *buffer,
          // *                            int bufSize);
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_attribute_ int(10) extproc('gsk_attribute_set_buffer');
         my_gsk_handle  like(gsk_handle) value;
         bufID  like(GSK_BUF_ID) value;
         buffer pointer value options(*string);
         bufSize int(10) value;
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_attribute_get_cert_info(gsk_handle my_gsk_handle,
          // *                  GSK_CERT_ID certID,
          // *                  const gsk_cert_data_elem **certDataElem,
          // *                  int *certDataElemCount);
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_attribute_ int(10) extproc('gsk_attribute_get_cert_info');
         my_gsk_handle  like(gsk_handle) value;
         certID  like(GSK_CERT_ID) value;
         certDataElem pointer;
         certDataElemC;
        end-pr;
        
          // *---------------------------------------------------------------------
          // *
          // *   int gsk_attribute_get_enum(gsk_handle my_gsk_handle,
          // *                          GSK_ENUM_ID enumID,
          // *                          GSK_ENUM_VALUE *enumValue);
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_attribute_ int(10) extproc('gsk_attribute_get_enum');
         my_gsk_handle  like(gsk_handle) value;
         enumID  like(GSK_ENUM_ID) value;
         enumValue  like(GSK_ENUM_VALUE);
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *    int gsk_attribute_get_numeric_value(gsk_handle my_gsk_handle,
          // *                                   GSK_NUM_ID numID,
          // *                                   int *numValue);
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_attribute_ int(10) extproc('gsk_attribute_get_numeric_value');
         my_gsk_handle  like(gsk_handle) value;
         numID  like(GSK_NUM_ID) value;
         numValue int(10);
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_attribute_set_enum(gsk_handle my_gsk_handle,
          // *                          GSK_ENUM_ID enumID,
          // *                          GSK_ENUM_VALUE enumValue);
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_attribute_ int(10) extproc('gsk_attribute_set_enum');
         my_gsk_handle  like(gsk_handle) value;
         enumID  like(GSK_ENUM_ID) value;
         enumValue  like(GSK_ENUM_VALUE) value;
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_attribute_set_numeric_value(gsk_handle my_gsk_handle,
          // *                                    GSK_NUM_ID numID,
          // *                                    int numValue);
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_attribute_ int(10) extproc('gsk_attribute_set_numeric_value');
         my_gsk_handle  like(gsk_handle) value;
         numID  like(GSK_NUM_ID) value;
         numValue int(10) value;
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_secure_soc_open(gsk_handle my_env_handle,
          // *                        gsk_handle *my_session_handle);
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_secure_soc int(10) extproc('gsk_secure_soc_open');
         my_env_handle  like(gsk_handle) value;
         my_ssn_handle  like(gsk_handle);
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_secure_soc_init(gsk_handle my_session_handle);
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_secure_soc int(10) extproc('gsk_secure_soc_init');
         my_ssn_handle  like(gsk_handle) value;
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_secure_soc_misc(gsk_handle my_session_handle,
          // *                          GSK_MISC_ID miscID);
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_secure_soc int(10) extproc('gsk_secure_soc_misc');
         my_ssn_handle  like(gsk_handle) value;
         miscID  like(GSK_MISC_ID) value;
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_secure_soc_read(gsk_handle my_session_handle,
          // *                        char *readBuffer,
          // *                        int readBufSize,
          // *                        int *amtRead);
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_secure_soc int(10) extproc('gsk_secure_soc_read');
         my_ssn_handle  like(gsk_handle) value;
         readBuffer pointer value;
         readBufSize int(10) value;
         amtRead int(10);
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_secure_soc_write(gsk_handle my_session_handle,
          // *                        char *writeBuffer,
          // *                        int writeBufSize,
          // *                        int *amtWritten);
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_secure_soc int(10) extproc('gsk_secure_soc_write');
         my_ssn_handle  like(gsk_handle) value;
         writeBuffer pointer value;
         writeBufSize int(10) value;
         amtWritten int(10);
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_secure_soc_close(gsk_handle *my_session_handle);
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_secure_soc int(10) extproc('gsk_secure_soc_close');
         my_ssn_handle  like(gsk_handle);
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_secure_soc_startRecv (gsk_handle my_session_handle,
          // *              int IOCompletionPort,
          // *              Qso_OverlappedIO_t *communicationsArea)
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_secure_soc int(10) extproc('gsk_secure_soc_startRecv');
         my_ssn_handle  like(gsk_handle) value;
         IOComplPort int(10) value;
         communArea pointer value;
         end-pr;

          // *---------------------------------------------------------------------
          // *
          // *  int gsk_secure_soc_startSend (gsk_handle my_session_handle,
          // *              int IOCompletionPort,
          // *              Qso_OverlappedIO_t *communicationsArea)
          // *
          // *---------------------------------------------------------------------
         
         dcl-pr gsk_secure_soc int(10) extproc('gsk_secure_soc_startSend');
         my_ssn_handle  like(gsk_handle) value;
         IOComplPort int(10) value;
         communArea pointer value;
         end-pr;

        /if not defined(V4R5_GSKIT)
          // *---------------------------------------------------------------------
          // *
          // *  const char *gsk_strerror(int gsk_return_value);
          // *
          // *  This does not exist in V4R5.
          // *---------------------------------------------------------------------
         dcl-pr gsk_strerror pointer extproc('gsk_strerror');
         gsk_ret_value int(10) value;
         end-pr gsk_strerror;
        /endif
