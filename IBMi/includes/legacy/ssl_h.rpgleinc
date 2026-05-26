     /*-                                                                            +
      * Copyright (c) 2001 Scott C. Klement                                         +
      * All rights reserved.                                                        +
      *                                                                             +
      * Redistribution and use in source and binary forms, with or without          +
      * modification, are permitted provided that the following conditions          +
      * are met:                                                                    +
      * 1. Redistributions of source code must retain the above copyright           +
      *    notice, this list of conditions and the following disclaimer.            +
      * 2. Redistributions in binary form must reproduce the above copyright        +
      *    notice, this list of conditions and the following disclaimer in the      +
      *    documentation and/or other materials provided with the distribution.     +
      *                                                                             +
      * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND      +
      * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE       +
      * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  +
      * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE     +
      * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL  +
      * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS     +
      * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)       +
      * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT  +
      * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY   +
      * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF      +
      * SUCH DAMAGE.                                                                +
      *                                                                             +
      */                                                                            +
  
      /if defined(SSL_H)
      /eof
      /endif

      /define SSL_H

      ****************************************************************
      * The SSL Init Structure.  (All fields are for input to API)
      *
      *  struct SSLInitStr {
      *     char *               keyringFileName;
      *     char *               keyringPassword;
      *     unsigned short int * cipherSuiteList;
      *     unsigned int         cipherSuiteListLen;
      *  };
      *  typedef struct SSLInitStr SSLInit;
      *
      *  keyringFileName = null-terminated path to keyring file in IFS
      *  keyringPassword = null-terminated password for keyring file
      *  cipherSuiteList = pointer to cypher spec list to use during
      *         SSL handshake protocol.  You can pass *NULL if you
      *         want to use the previous SSL_Init's values.  If no
      *         no previous call, pass *NULL to use the system default.
      *  cipherSuiteListLen = number of suite entries in prev param.
      *
      *  note that the cipherSuiteList element is a pointer to an
      *  array of unsigned shorts (i.e. 5U 0)
      ****************************************************************
     D p_SSLInitStr    S               *
     D SSLInitStr      DS                  based(p_SSLInit) align
     D  SSLInit_keyringFileName...
     D                                 *
     D  SSLInit_keyringPassword...
     D                                 *
     D  SSLInit_cipherSuiteList...
     D                                 *
     D  SSLInit_cipherSuiteListLen...
     D                               10U 0

      ****************************************************************
      *  struct SSLInitAppStr {
      *        char         *applicationID;
      *        unsigned int  applicationIDLen;
      *        char         *localCertificate;
      *        unsigned int  localCertificateLen;
      *        unsigned short int *cipherSuiteList;
      *        unsigned int  cipherSuiteListLen;
      *        char          reserved[28];
      *   };
      *   typedef struct SSLInitAppStr SSLInitApp;
      *
      *   applicationID (input) ptr to null-terminated string
      *       identifying the application id value that was used
      *       to register the application for certificate use
      *       (the QSYRGAP or QsyRegisterAppForCertUse API)
      *
      *   applicationIDLen (input) Length of string (above)
      *
      *   localCertificate (i/o) area of memory to place the registered
      *       local certificate.  (must be allocated by the calling
      *       app, and the size of the area given in localCertificateLen)
      *       Most certs are less than 2k in len.  If cert is not to be
      *       returned, *NULL can be passed.
      *
      *   localCertificateLen (i/o) length of area of memory allocated
      *       to localCertificate on input, and length of actual
      *       certificate on output.  If no cert is to be returned,
      *       this should be set to 0.
      *
      *   cipherSuiteList & cipherSuiteListLen are the same as they
      *      are in the SSLInitStr struct above, except that if you
      *      pass NULL, the system will use the values from SSL_Init.
      *
      *   reserved1 must be all x'00'
      ****************************************************************
     D SSLInitAppStr   DS                  based(p_SSLInitApp) align
     D   SSLInitApp_applicationID...
     D                                 *
     D   SSLInitApp_applicationIDLen...
     D                               10U 0
     D   SSLInitApp_localCertificate...
     D                                 *
     D   SSLInitApp_localCertificateLen...
     D                               10U 0
     D   SSLInitApp_cipherSuiteList...
     D                                 *
     D   SSLInitApp_cipherSuiteListLen...
     D                               10U 0
     D   SSLInitApp_reserved...
     D                               28A

      ****************************************************************
      *  The SSLHandle structure is returned by the SSL_Create API
      *
      *  struct SSLHandleStr {
      *     int            fd;
      *     int            createFlags;
      *     unsigned       protocol;
      *     unsigned       timeout;
      *     unsigned char  cipherKind[3];
      *     unsigned short int cipherSuite;
      *     unsigned short int* cipherSuiteList;
      *     unsigned int        cipherSuiteListLen;
      *     unsigned char* peerCert;
      *     unsigned       peerCertLen;
      *     int            peerCertValidateRc;
      *     int            (*exitPgm)(struct SSLHandleStr* sslh);
      *  };
      ****************************************************************
     D p_SSLHandle     S               *
     D SSLHandleStr    DS                  based(p_SSLHandle)
     D   SSLHandle_fd...
     D                               10I 0
     D   SSLHandle_createFlags...
     D                               10I 0
     D   SSLHandle_protocol...
     D                               10U 0
     D   SSLHandle_timeout...
     D                               10U 0
     D   SSLHandle_cipherKind...
     D                                3A
     D   SSLHandle_cipherSuite...
     D                                5U 0
     D   SSLHandle_cipherSuiteList...
     D                                 *
     D   SSLHandle_cipherSuiteListLen...
     D                               10U 0
     D   SSLHandle_peerCert...
     D                                 *
     D   SSLHandle_peerCertLen...
     D                               10U 0
     D   SSLHandle_peerCertValidateRc...
     D                               10I 0
     D   SSLHandle_exitPgm...
     D                                 *   procptr

      ****************************************************************
      * Flags for the SSL_Create() proc
      ****************************************************************
     D SSL_ENCRYPT     C                   1
     D SSL_DONT_ENCRYPT...
     D                 C                   0

      ****************************************************************
      * Error numbers that can be returned by the SSL_xxxx procs.
      *   (Note that some of these, such as SSL_ERROR_IO, merely
      *    mean that you need to check errno)
      ****************************************************************
     D SSL_ERROR_NO_CIPHERS...
     D                 C                   -1
     D SSL_ERROR_NO_CERTIFICATE...
     D                 C                   -2
     D SSL_ERROR_BAD_CERTIFICATE...
     D                 C                   -4
     D SSL_ERROR_UNSUPPORTED_CERTIFICATE_TYPE...
     D                 C                   -6
     D SSL_ERROR_IO...
     D                 C                   -10
     D SSL_ERROR_BAD_MESSAGE...
     D                 C                   -11
     D SSL_ERROR_BAD_MAC...
     D                 C                   -12
     D SSL_ERROR_UNSUPPORTED...
     D                 C                   -13
     D SSL_ERROR_BAD_CERT_SIG...
     D                 C                   -14
     D SSL_ERROR_BAD_CERT...
     D                 C                   -15
     D SSL_ERROR_BAD_PEER...
     D                 C                   -16
     D SSL_ERROR_PERMISSION_DENIED...
     D                 C                   -17
     D SSL_ERROR_SELF_SIGNED...
     D                 C                   -18
     D SSL_ERROR_BAD_MALLOC...
     D                 C                   -20
     D SSL_ERROR_BAD_STATE...
     D                 C                   -21
     D SSL_ERROR_SOCKET_CLOSED...
     D                 C                   -22
     D SSL_ERROR_NOT_TRUSTED_ROOT...
     D                 C                   -23
     D SSL_ERROR_CERT_EXPIRED...
     D                 C                   -24
     D SSL_ERROR_BAD_DATE...
     D                 C                   -25
     D SSL_ERROR_BAD_KEY_LEN_FOR_EXPORT...
     D                 C                   -26
     D SSL_ERROR_NOT_KEYRING...
     D                 C                   -90
     D SSL_ERROR_KEYPASSWORD_EXPIRED...
     D                 C                   -91
     D SSL_ERROR_CERTIFICATE_REJECTED...
     D                 C                   -92
     D SSL_ERROR_SSL_NOT_AVAILABLE...
     D                 C                   -93
     D SSL_ERROR_NO_INIT...
     D                 C                   -94
     D SSL_ERROR_NO_KEYRING...
     D                 C                   -95
     D SSL_ERROR_NOT_ENABLED...
     D                 C                   -96
     D SSL_ERROR_BAD_CIPHER_SUITE...
     D                 C                   -97
     D SSL_ERROR_CLOSED...
     D                 C                   -98
     D SSL_ERROR_UNKNOWN...
     D                 C                   -99
     D SSL_ERROR_NOT_REGISTERED...
     D                 C                   -1009

      ****************************************************************
      *  The following cipher suites work when using a version 3.0
      *  to version 3.0 SSL implementation
      ****************************************************************
     D SSL_RSA_WITH_NULL_MD5...
     D                 C                   1
     D SSL_RSA_WITH_NULL_SHA...
     D                 C                   2
     D SSL_RSA_WITH_RC4_128_SHA...
     D                 C                   5
     D SSL_RSA_WITH_DES_CBC_SHA...
     D                 C                   9
     D SSL_RSA_WITH_3DES_EDE_CBC_SHA...
     D                 C                   10

      ****************************************************************
      *  The following cipher suites work when using a version 2.0
      *  to version 2.0 SSL implementation as well as version 3.0
      *  to version 3.0...
      ****************************************************************
     D SSL_RSA_EXPORT_WITH_RC4_40_MD5...
     D                 C                   3
     D SSL_RSA_WITH_RC4_128_MD5...
     D                 C                   4
     D SSL_RSA_EXPORT_WITH_RC2_CBC_40_MD5...
     D                 C                   6

      ****************************************************************
      *  The following cipher suites work when using a version 2.0
      *  to version 2.0 SSL implementation
      ****************************************************************
     D SSL_RSA_WITH_RC2_CBC_128_MD5...
     D                 C                   65281
     D SSL_RSA_WITH_DES_CBC_MD5...
     D                 C                   65282
     D SSL_RSA_WITH_3DES_EDE_CBC_MD5...
     D                 C                   65283

      ****************************************************************
      *  values for "how" parm of SSL_Handshake
      ****************************************************************
     D SSL_HANDSHAKE_AS_CLIENT...
     D                 C                   0
     D SSL_HANDSHAKE_AS_SERVER...
     D                 C                   1
     D SSL_HANDSHAKE_AS_SERVER_WITH_CLIENT_AUTH...
     D                 C                   2
     D SSL_HANDSHAKE_AS_SERVER_WITH_OPTIONAL_CLIENT_AUTH...
     D                 C                   3

      ****************************************************************
      *  Initialize the current job for SSL
      *
      *  int SSL_Init(SSLInit *init);
      *
      *  The SSL_Init function is used to establish the SSL security
      *  information to be used for all SSL sessions for the current
      *  job.
      ****************************************************************
     D SSL_Init        PR            10I 0 ExtProc('SSL_Init')
     D   init                          *   value

      ****************************************************************
      *  Initialize the Current Job for SSL processing Based on the
      *   Application Identifier
      *
      * int SSL_Init_Application(SSLInitApp *init_app);
      *
      * Uses the application identifier to determine and then
      * establish the certificate for use by the SSL handshake
      * protocol processing.
      ****************************************************************
     D SSL_Init_Application...
     D                 PR            10I 0 ExtProc('SSL_Init_Application')
     D   init_app                      *   value

      ****************************************************************
      * SSL_Create() -- enable SSL support on a given socket descr.
      *
      *   SSLHandle *SSL_Create(int socket_descriptor, int flags);
      *
      ****************************************************************
     D SSL_Create      PR              *   ExtProc('SSL_Create')
     D   sock_desc                   10I 0 value
     D   flags                       10I 0 value

      ****************************************************************
      * Initiate the SSL Handshake protool
      *
      *  int SSL_Handshake(SSLHandle *handle, int how);
      *
      *  The SSL_Handshake() function is used by a program to initiate
      *  the SSL handshake protocol.  Both the client and the server
      *  program must call the SSL_Handshake verb in order to initiate
      *  handshake processing.
      ****************************************************************
     D SSL_Handshake   PR            10I 0 ExtProc('SSL_Handshake')
     D   handle                        *   value
     D   how                         10I 0 value

      ****************************************************************
      * Read data from SSL-enabled socket
      *
      *  int SSL_Read(SSLHandle *handle, void *buffer, int buflen);
      *
      *  handle = handle returned by SSL_Create
      *  buffer = place where the data is :)
      *  buflen = size of buffer (max size to read at once)
      *
      * returns length of data read, or an error upon failure
      ****************************************************************
     D SSL_Read        PR            10I 0 ExtProc('SSL_Read')
     D   handle                        *   value
     D   buffer                        *   value
     D   buflen                      10I 0 value

      ****************************************************************
      * Write data to SSL-enabled socket
      *
      *  int SSL_Write(SSLHandle *handle, void *buffer, int buflen);
      *
      *  handle = handle returned by SSL_Create
      *  buffer = place where the data is :)
      *  buflen = size of buffer (amount of data to write)
      *
      * returns length of data written, or an error upon failure
      ****************************************************************
     D SSL_Write       PR            10I 0 ExtProc('SSL_Write')
     D   handle                        *   value
     D   buffer                        *   value
     D   buflen                      10I 0 value

      ****************************************************************
      *  End SSL support for a given SSL-enabled socket.
      *
      *   handle = SSL session to end.
      ****************************************************************
     D SSL_Destroy     PR                  ExtProc('SSL_Destroy')
     D   handle                        *   value
