     /*-                                                                            +
      * Copyright (c) 2004 Scott C. Klement                                         +
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
      /if defined(IOCTL_H)
      /eof
      /endif
      /define IOCTL_H

      /if defined(USE_QUALIFIED)
      /if not defined(*V5R2M0)
      /undefine USE_QUALIFIED
      /endif
      /endif

      ******************************************************************
      *  The following requests can be made using ioctl():
      ******************************************************************
      *                                         Gen SIGIO signals for
      *                                         async I/O
     D FIOASYNC        C                   131075
      /if defined(*V5R2M0)
      *                                         Get I/O CCSID
     D FIOCCSID        C                   131085
      /endif
      *                                         Set/Clear Non-Blocking I/O
     D FIONBIO         C                   131074
      *                                         Return number of bytes
      *                                         available to read
     D FIONREAD        C                   131073
      *                                         Set PID or GID that is
      *                                         to receive SIGIO/SIGURG
     D FIOSETOWN       C                   131081
      *                                         Add a TCP/IP Route
     D SIOCADDRT       C                   65538
      *                                         Check if at OOB Mark
     D SIOCATMARK      C                   65537
      *                                         Delete a TCP/IP Route
     D SIOCDELRT       C                   65539
      *                                         Get Interface Address
     D SIOCGIFADDR     C                   65541
      *                                         Get Interface Broadcast
      *                                         Address
     D SIOCGIFBRDADDR  C                   65543
      *                                         Get Configured Interfaces
     D SIOCGIFCONF     C                   65549
      *                                         Get Interface flags
     D SIOCGIFFLAGS    C                   65542
      *                                         Get Interface *LIND
     D SIOCGIFLIND     C                   65547
      *                                         Get Interface MTU
     D SIOCGIFMTU      C                   65545
      *                                         Get Interface Netmask
     D SIOCGIFNETMASK  C                   65544
      *                                         Get Interface Reassembly
      *                                         Buffer Size
     D SIOCGIFRBUFS    C                   65546
      *                                         Get Interface Type Of
      *                                         Service
     D SIOCGIFTOS      C                   65548
      *                                         Get PID or GID that is
      *                                         to receive SIGIO/SIGURG
     D SIOCGPGRP       C                   65560
      *                                         Get Configured TCP/IP
      *                                         Routes
     D SIOCGRTCONF     C                   65540
      /if defined(*V5R1M0)
      *                                         Get the Number of Bytes
      *                                         in TCP/IP send queue
      *                                         that have not been acked
     D SIOCSENDQ       C                   65565
      /endif
      *                                         Set PID or GID that is
      *                                         to receive SIGIO/SIGURG
     D SIOCSPGRP       C                   65561
      /if defined(*V4R4M0)
      *                                         Set Telephony Resources
     D SIOCSTELRSC     C                   65562
      /endif


      ******************************************************************
      * Flags for the ifr_flags member of the ifreq structure
      ******************************************************************
      *                                    receive all multicast packets
     D IFF_ALLMULTI    C                   1
      *                                    token-ring routing supported
     D IFF_BRIDGE      C                   2
      *                                    IP broadcast address valid
     D IFF_BROADCAST   C                   4
      *                                    compress PPP address/control
     D IFF_COMPAC      C                   8
      *                                    compress PPP protocol
     D IFF_COMPPROT    C                   16
      *                                    activate interface debugging
     D IFF_DEBUG       C                   32
      *                                    loopback network interface
     D IFF_LOOPBACK    C                   64
      *                                    ARP not supported
     D IFF_NOARP       C                   128
      *                                    do not use trailers
     D IFF_NOTRAILERS  C                   256
      *                                    promiscuous mode
      *                                    (receive all packets)
     D IFF_PROMISC     C                   512
      *                                    interface is p-2-p link
     D IFF_POINTOPOINT...
     D                 C                   1024
      *                                    resources alloced and running
     D IFF_RUNNING     C                   2048
      *                                    extended SAP header
     D IFF_SNAP        C                   4096
      *                                    logical interfaces up/active
     D IFF_UP          C                   8192
      *                                    supports multicast
     D IFF_MULTICAST   C                   16384


      ******************************************************************
      * Flags for the rt_flags field of the rtentry structure:
      ******************************************************************
      *                                      black hole -- silently drop
     D RTF_BLACKHOLE   C                   64
      *                                      created dynamically
     D RTF_DYNAMIC     C                   16
      *                                      destination is a gateway
     D RTF_GATEWAY     C                    2
      *                                      gateway may have problems
     D RTF_GATEWAY_PROBLEMATIC...
     D                 C                   128
      *                                      destination is a host
     D RTF_HOST        C                   4
      *                                      modified dynamically
     D RTF_MODIFIED    C                   32
      *                                      do not rebind to another
      *                                      interface on activate/deactiv
     D RTF_NOREBIND_IFC_ACTV...
     D                 C                   512
      *                                      do not rebind to another
      *                                      interface if interface fails
     D RTF_NOREBIND_IFC_FAIL...
     D                 C                   256
      *                                      route is usable
     D RTF_UP          C                   1


      ******************************************************************
      * Constants for the rt_protocol field of the rtentry structure:
      ******************************************************************
      *                                     route learned, sockets, etc
     D RTP_OTHER       C                   1
      *                                     route learned, configuration
     D RTP_CONFIG      C                   2
      *                                     route learned, SNMP
     D RTP_SNMP        C                   3
      *                                     route learned, ICMP
     D RTP_ICMP        C                   4
      *                                     route learned, EGP
     D RTP_EGP         C                   5
      *                                     route learned, GGP
     D RTP_GGP         C                   6
      *                                     route learned, HELLO
     D RTP_HELLO       C                   7
      *                                     route learned, RIP
     D RTP_RIP         C                   8
      *                                     route learned, IS-IS
     D RTP_ISIS        C                   9
      *                                     route learned, ES-IS
     D RTP_ESIS        C                   10
      *                                     route learned, Cisco IGRP
     D RTP_CIGRP       C                   11
      *                                     route learned, BBN SPF IGRP
     D RTP_BSIGRP      C                   12
      *                                     route learned, OSPF
     D RTP_OSPF        C                   13
      *                                     route learned, BGP
     D RTP_BGP         C                   14


      ******************************************************************
      * Interface Entry Request Structure (ifreq)
      *
      * #define ifr_addr        ifr_ifru.ifru_addr
      * #define ifr_mask        ifr_ifru.ifru_mask
      * #define ifr_broadaddr   ifr_ifru.ifru_broadaddr
      * #define ifr_flags       ifr_ifru.ifru_flags
      * #define ifr_mtu         ifr_ifru.ifru_mtu
      * #define ifr_rbufsize    ifr_ifru.ifru_rbufsize
      * #define ifr_linename    ifr_ifru.ifru_linename
      * #define ifr_TOS         ifr_ifru.ifru_TOS
      *
      * struct ifreq {                        /* interface entry request */
      *   char ifr_name[IFNAMSIZ];            /* interface name         */
      *   union {
      *      struct sockaddr ifru_addr;       /* local IP address       */
      *      struct sockaddr ifru_mask;       /* subnetwork mask        */
      *      struct sockaddr ifru_broadaddr;  /* broadcast address      */
      *      short  ifru_flags;               /* interface flags        */
      *      int    ifru_mtu;                 /* interface MTU size     */
      *      int    ifru_rbufsize;            /* reassembly buffer size */
      *      char   ifru_linename[IFLINSIZ];  /* line description name  */
      *      u_char ifru_TOS;                 /* type-of-service       */
      *   } ifr_ifru;
      * };
      ******************************************************************
     D p_ifreq         s               *
     D ifreq           ds                  based(p_ifreq)
     D                                     align
      /if defined(USE_QUALIFIED)
     D                                     qualified
      /endif
     D   ifr_name                    16A
      /if defined(USE_QUALIFIED)
     D   ifr_addr                          likeds(sockaddr_in)
     D   ifr_mask                          likeds(sockaddr_in)
     D                                     overlay(ifr_addr)
     D   ifr_broadaddr...
     D                                     likeds(sockaddr_in)
     D                                     overlay(ifr_addr)
      /else
     D   ifr_addr                          like(sockaddr_in)
     D   ifr_mask                          like(sockaddr_in)
     D                                     overlay(ifr_addr)
     D   ifr_broadaddr...
     D                                     like(sockaddr_in)
     D                                     overlay(ifr_addr)
      /endif
     D   ifr_flags                    5I 0 overlay(ifr_addr)
     D   ifr_mtu                     10I 0 overlay(ifr_addr)
     D   ifr_rbufsize...
     D                               10I 0 overlay(ifr_addr)
     D   ifr_linename...
     D                               10A   overlay(ifr_addr)
     D   ifr_TOS                      3U 0 overlay(ifr_addr)


      ******************************************************************
      * Interface Configuration List Structure (ifconf)
      *
      * #define ifc_buf         ifc_ifcu.ifcu_buf
      * #define ifc_req         ifc_ifcu.ifcu_req
      *
      * struct ifconf {                 /* interface configuration list*/
      *   int ifc_len;                  /* size of user-supplied buffer*/
      *   int ifc_configured;           /* number of interfaces
      *                                     configured                 */
      *   int ifc_returned;             /* number of interfaces
      *                                     returned                   */
      *   union {
      *      caddr_t      ifcu_buf;     /* user-supplied buffer address*/
      *      struct ifreq *ifcu_req;    /* returned list of interfaces */
      *   } ifc_ifcu;
      * };
      ******************************************************************
     D p_ifconf        s               *
     D ifconf          ds                  based(p_ifconf)
     D                                     align
     D   ifc_len                     10I 0
     D   ifc_configured...
     D                               10I 0
     D   ifc_returned                10I 0
     D   ifc_buf                       *
     D   ifc_req                       *   overlay(ifc_buf)


      ******************************************************************
      * Route Entry Structure (rtentry)
      *
      * struct rtentry {                /* route entry                 */
      *   struct sockaddr rt_dst;       /* route destination
      *                                    net/subnet/host             */
      *   struct sockaddr rt_mask;      /* route mask                  */
      *   struct sockaddr rt_gateway;   /* gateway's IP address        */
      *   int     rt_mtu;               /* MTU for route               */
      *   u_short rt_flags;             /* route flags                 */
      *   u_short rt_refcnt;            /* number held references      */
      *   u_char  rt_protocol;          /* route protocol, how route
      *                                    was learned                 */
      *   u_char  rt_TOS;               /* route type-of-service       */
      *   char    rt_if[IFNAMSIZ];      /* interface used for route    */
      *
      * };
      ***************************************************************
     D p_rtentry       s               *
     D rtentry         ds                  based(p_rtentry)
     D                                     align
      /if defined(USE_QUALIFIED)
     D                                     qualified
     D   rt_dst                            likeds(sockaddr_in)
     D   rt_mask                           likeds(sockaddr_in)
     D   rt_gateway                        likeds(sockaddr_in)
      /else
     D   rt_dst                            like(sockaddr_in)
     D   rt_mask                           like(sockaddr_in)
     D   rt_gateway                        like(sockaddr_in)
      /endif
     D   rt_mtu                      10I 0
     D   rt_flags                     5U 0
     D   rt_refcnt                    5U 0
     D   rt_protocol                  3U 0
     D   rt_TOS                       3U 0
     D   rt_if                       16A


      ***************************************************************
      * Route Configuration List Structure (rtconf)
      *
      * #define rtc_buf    rtc_rtcu.rtcu_buf
      * #define rtc_req    rtc_rtcu.rtcu_req
      *
      * struct rtconf {                /* route configuration list    */
      *   int rtc_len;                 /* size of user-supplied buffer*/
      *   int rtc_configured;          /* number of interfaces
      *                                   configured                  */
      *   int rtc_returned;            /* number of interfaces
      *                                   returned                    */
      *   union {
      *      caddr_t      rtcu_buf;    /* user-supplied buffer address*/
      *      struct rtentry *rtcu_req; /* returned list of interfaces */
      *   } rtc_rtcu;
      * };
      ***************************************************************
     D p_rtconf        s               *
     D rtconf          ds                  based(p_rtconf)
     D                                     align
     D   rtc_len                     10I 0
     D   rtc_configured...
     D                               10I 0
     D   rtc_returned                10I 0
     D   rtc_buf                       *
     D   rtc_req                       *   overlay(rtc_buf)


      * --------------------------------------------------------------------
      *   ioctl()--Perform I/O Control Request
      *
      *   int ioctl(int descriptor, unsigned long request, ...)
      *
      *  returns -1 upon error, 0 when successful
      * --------------------------------------------------------------------
     D ioctl           PR            10I 0 ExtProc('ioctl')
     D   descriptor                  10I 0 value
     D   request                     10U 0 value
     D   arg                           *   value options(*nopass)
