     /*-                                                                            +
      * Copyright (c) 1998-2008 Scott C. Klement                                    +
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
      ***********************************************************************
      *  Header file for the Socket API.
      *
      *  To use this, you must /COPY SOCKET_H into the D specs of your
      *  ILE RPG source member.
      *  (or whatever the appropriate source lib/file, member is)
      *
      *   Most of the major socket functions and structures are prototyped
      *   here.  There may be some that I missed (because I havent needed
      *   them) if you need them, you'll have to add them yourself :)
      *                                                   SCK 08/06/1998
      ***********************************************************************

     D/if defined(SOCKET_H)
     D/eof
     D/endif
     D/define SOCKET_H

     ***********************************************************************
     **  C O N S T A N T S
     ***********************************************************************
     D IPVERSION       C                   CONST(4)

      *************************************************
      * Address families.
      *************************************************
     D AF_UNSPEC       C                   CONST(0)
      *                                             Unix domain
     D AF_UNIX         C                   CONST(1)
      *                                             Internet domain (IPv4)
     D AF_INET         C                   CONST(2)
      *                                             Network Services domain
     D AF_NS           C                   CONST(6)
      *                                             IPv6
     D AF_INET6        C                   CONST(24)
      *                                             Unix w/CCSID support
     D AF_UNIX_CCSID   C                   CONST(98)
      *                                             Telephony domain
     D AF_TELEPHONY    C                   CONST(99)


      *************************************************
      * Socket Types:
      *************************************************
     D*                                             stream socket (TCP)
     D SOCK_STREAM     C                   CONST(1)
     D*                                             datagram socket (UDP)
     D SOCK_DGRAM      C                   CONST(2)
     D*                                             raw socket
     D SOCK_RAW        C                   CONST(3)
     D*                                             sequential packet
     D SOCK_SEQPACKET  C                   CONST(5)


      *************************************************
      * Protocol families.
      *************************************************
     D PF_UNSPEC       C                   CONST(0)
      *                                             Unix domain
     D PF_UNIX         C                   CONST(1)
      *                                             Internet domain (IPv4)
     D PF_INET         C                   CONST(2)
      *                                             Network Services domain
     D PF_NS           C                   CONST(6)
      *                                             IPv6
     D PF_INET6        C                   CONST(24)
      *                                             Unix w/CCSID support
     D PF_UNIX_CCSID   C                   CONST(98)
      *                                             Telephony domain
     D PF_TELEPHONY    C                   CONST(99)


      *************************************************
      * Socket-Level options (setsockopt/getsockopt)
      *************************************************
     D*                                          allow broadcast msgs
     D SO_BROADCAST    C                   5
     D*                                          record debug information
     D SO_DEBUG        C                   10
     D*                                          disable routing
     D SO_DONTROUTE    C                   15
     D*                                          error status
     D SO_ERROR        C                   20
     D*                                          keep connections alive
     D SO_KEEPALIVE    C                   25
     D*                                          linger upon close
     D SO_LINGER       C                   30
     D*                                          out-of-band data inline
     D SO_OOBINLINE    C                   35
     D*                                          receive buffer size
     D SO_RCVBUF       C                   40
     D*                                          receive low water mark
     D SO_RCVLOWAT     C                   45
     D*                                          receive timeout value
     D SO_RCVTIMEO     C                   50
     D*                                          re-use local address
     D SO_REUSEADDR    C                   55
     D*                                          send buffer size
     D SO_SNDBUF       C                   60
     D*                                          send low water mark
     D SO_SNDLOWAT     C                   65
     D*                                          send timeout value
     D SO_SNDTIMEO     C                   70
     D*                                          socket type
     D SO_TYPE         C                   75
     D*                                          send loopback
     D SO_USELOOPBACK  C                   80
     D*                                          send loopback
     D SO_ACCEPTCONN   C                   85

      *************************************************
      * flag parameter values (send/sendto/recv/recvfrom)
      *************************************************
     D*                                               dont route
     D MSG_DONTROUTE   C                   CONST(1)
     D*                                               out-of-band data
     D MSG_OOB         C                   CONST(4)
     D*                                               keep data in buffer
     D MSG_PEEK        C                   CONST(8)
     D*                                               data discarded
     D MSG_TRUNC       C                   CONST(16)
     D*                                               control data discard
     D MSG_CTRUNC      C                   CONST(32)
     D*                                               wait for full req
     D MSG_WAITALL     C                   CONST(64)
     D*                                               end of record
     D MSG_EOR         C                   CONST(128)
     D*                                               maximum iovecs
     D MSG_MAXIOVLEN   C                   CONST(16)


     D*                                                socket layer
     D SOL_SOCKET      C                   CONST(-1)
     D*                                                max queued conns
     D SOMAXCONN       C                   CONST(512)


      *************************************************
      * Flag constants for send_file API
      *************************************************
     D SF_CLOSE        C                   1
     D SF_REUSE        C                   2


      *************************************************
      * Flags for shutdown API
      *************************************************
     D SHUT_RD         C                   0
     D SHUT_WR         C                   1
     D SHUT_RDWR       C                   2


      *************************************************
      * Internet Family Protocols
      *************************************************
     D IPPROTO_IP...
     D                 C                   CONST(0)
     D IPPROTO_HOPOPTS...
     D                 C                   CONST(0)
     D IPPROTO_ICMP...
     D                 C                   CONST(1)
     D IPPROTO_TCP...
     D                 C                   CONST(6)
     D IPPROTO_EGP...
     D                 C                   CONST(8)
     D IPPROTO_PUP...
     D                 C                   CONST(12)
     D IPPROTO_UDP...
     D                 C                   CONST(17)
     D IPPROTO_IPV6...
     D                 C                   CONST(41)
     D IPPROTO_ROUTING...
     D                 C                   CONST(43)
     D IPPROTO_FRAGMENT...
     D                 C                   CONST(44)
     D IPPROTO_ESP...
     D                 C                   CONST(50)
     D IPPROTO_AH...
     D                 C                   CONST(51)
     D IPPROTO_ICMPV6...
     D                 C                   CONST(58)
     D IPPROTO_NONE...
     D                 C                   CONST(59)
     D IPPROTO_DSTOPTS...
     D                 C                   CONST(60)
     D IPPROTO_RAW...
     D                 C                   CONST(255)
     D IPPROTO_MAX...
     D                 C                   CONST(256)


     ** IP-Level (IPPROTO_IP) options for setsockopt()/getsockopt()
     D*                                                  ip options
     D IP_OPTIONS...
     D                 C                   CONST(5)
     D IP_TOS...
     D                 C                   CONST(10)
     D IP_TTL...
     D                 C                   CONST(15)
     D IP_MULTICAST_IF...
     D                 C                   CONST(20)
     D IP_MULTICAST_TTL...
     D                 C                   CONST(25)
     D IP_MULTICAST_LOOP...
     D                 C                   CONST(30)
     D IP_ADD_MEMBERSHIP...
     D                 C                   CONST(35)
     D IP_DROP_MEMBERSHIP...
     D                 C                   CONST(40)
     D IP_DONTFRAG...
     D                 C                   CONST(55)
     D IP_RECVLCLIFADDR...
     D                 C                   CONST(99)
     D IPV6_V6ONLY...
     D                 C                   CONST(100)
     D IPV6_RECVHOPLIMIT...
     D                 C                   CONST(101)
     D IPV6_UNICAST_HOPS...
     D                 C                   CONST(15)
     D IPV6_MULTICAST_IF...
     D                 C                   CONST(20)
     D IPV6_MULTICAST_TTL...
     D                 C                   CONST(25)
     D IPV6_MULTICAST_LOOP...
     D                 C                   CONST(30)
     D IPV6_JOIN_GROUP...
     D                 C                   CONST(35)
     D IPV6_LEAVE_GROUP...
     D                 C                   CONST(40)
     D IPV6_CHECKSUM...
     D                 C                   CONST(105)
     D IPV6_HOPLIMIT...
     D                 C                   CONST(115)
     D ICMP6_FILTER...
     D                 C                   CONST(150)


     ** TCP level (IPPROTO_TCP) options for setsockopt()/getsockopt()
     D TCP_MAXSEG      C                   5
     D TCP_NODELAY     C                   10


     ** Types of Service for IP packets
     **  These are indended to be used in the 'ip' data structure
     **  defined below.
     D*                                                  normal
     D IPTOS_NORMAL    C                   CONST(x'00')
     D*                                                  min cost
     D IPTOS_MIN       C                   CONST(x'02')
     D*                                                  reliability
     D IPTOS_RELIABLE  C                   CONST(x'04')
     D*                                                  throughput
     D IPTOS_THRUPUT   C                   CONST(x'08')
     D*                                                  low-delay
     D IPTOS_LOWDELAY  C                   CONST(x'10')


     ** Precedence for Types of Service
     **  These are indended to be used in the 'ip' data structure
     **  defined below.
     D*                                                 net control
     D IPTOS_NET       C                   CONST(x'E0')
     D*                                                 internet control
     D IPTOS_INET      C                   CONST(x'C0')
     D*                                                 critic ecp
     D IPTOS_CRIT      C                   CONST(x'A0')
     D*                                                 flash override
     D IPTOS_FOVR      C                   CONST(x'80')
     D*                                                 flash
     D IPTOS_FLAS      C                   CONST(x'60')
     D*                                                 immediate
     D IPTOS_IMME      C                   CONST(x'40')
     D*                                                 priority
     D IPTOS_PTY       C                   CONST(x'20')
     D*                                                 routine
     D IPTOS_ROUT      C                   CONST(x'10')


     ** "Special" IP Address values
     D INADDR_ANY...
     D                 C                   CONST(0)
     D INADDR_BROADCAST...
     D                 C                   CONST(4294967295)
     D INADDR_LOOPBACK...
     D                 C                   CONST(2130706433)
     D INADDR_NONE...
     D                 C                   CONST(4294967295)
     D INADDR_UNSPEC_GROUP...
     D                 C                   CONST(3758096384)
     D INADDR_ALLHOSTS_GROUP...
     D                 C                   CONST(3758096385)
     D INADDR_MAX_LOCAL_GROUP...
     D                 C                   CONST(3758096639)
     D INET_ADDRSTRLEN...
     D                 s             16a   based(template)
     D INET6_ADDRSTRLEN...
     D                 s             46a   based(template)

     ** ICMP message types
     D*                                                  echo reply
     D ICMP_ECHOREPLY  C                   CONST(x'00')
     D*                                                  unreachable
     D ICMP_UNREACH    C                   CONST(x'03')
     D*                                                  source quench
     D ICMP_SOURCEQUENCH...
     D                 C                   CONST(x'04')
     D*                                                  redirect
     D ICMP_REDIRECT...
     D                 C                   CONST(x'05')
     D*                                                  echo
     D ICMP_ECHO       C                   CONST(x'08')
     D*                                                  time exceeded
     D ICMP_TIMXCEED...
     D                 C                   CONST(x'0B')
     D*                                                  parameter problem
     D ICMP_PARAMPROB  C                   CONST(x'0C')
     D*                                                  timestamp request
     D ICMP_TSTAMP     C                   CONST(x'0D')
     D*                                                  timestamp req reply
     D ICMP_TSTAMPREPLY...
     D                 C                   CONST(x'0E')
     D*                                                  info request
     D ICMP_IREQ       C                   CONST(x'0F')
     D*                                                  info request reply
     D ICMP_IREQREPLY...
     D                 C                   CONST(x'10')
     D*                                                  addr mask request
     D ICMP_MASKREQ    C                   CONST(x'11')
     D*                                                  addr mask req reply
     D ICMP_MASKREPLY  C                   CONST(x'12')

     ** ICMP subtype codes
     D*                                                  network unreachable
     D UNR_NET         C                   CONST(x'00')
     D*                                                  host unreachable
     D UNR_HOST        C                   CONST(x'01')
     D*                                                  protocol unreachble
     D UNR_PROTO       C                   CONST(x'02')
     D*                                                  port unreachable
     D UNR_PORT        C                   CONST(x'03')
     D*                                                  fragmentation needed
     D*                                                  and dont fragment
     D*                                                  flag is set
     D UNR_FRAG        C                   CONST(x'04')
     D*                                                  source route failed
     D UNR_SRCF        C                   CONST(x'05')
     D*                                                  time exceeded in
     D*                                                  transit
     D TIMX_INTRA      C                   CONST(x'00')
     D*                                                  time exceeded in
     D*                                                  frag reassembly
     D TIMX_REASS      C                   CONST(x'01')
     D*                                                  redir for network
     D REDIR_NET       C                   CONST(x'00')
     D*                                                  redir for host
     D REDIR_HOST      C                   CONST(x'01')
     D*                                                  redir for TOS & Net
     D REDIR_TOSN      C                   CONST(x'02')
     D*                                                  redir for TOS & Host
     D REDIR_TOSH      C                   CONST(x'03')

     D/if not defined(FCNTL_CONSTANTS)
     ** fcntl() commands
     D F_DUPFD         C                   CONST(0)
     D F_GETFL         C                   CONST(6)
     D F_SETFL         C                   CONST(7)
     D F_GETOWN        C                   CONST(8)
     D F_SETOWN        C                   CONST(9)

     ** fcntl() flags
     D O_NONBLOCK      C                   CONST(128)
     D O_NDELAY        C                   CONST(128)
     D FNDELAY         C                   CONST(128)
     D FASYNC          C                   CONST(512)
     D/define FCNTL_CONSTANTS
     D/endif


      *************************************************
      *  linger structure
      *
      *     struct linger {
      *          int   l_onoff;    Turns ON/OFF
      *          int   l_linger;   Linger time in secs
      *     };
      *
      *************************************************
     D linger          DS                  BASED(p_linger)
     D   l_onoff                     10I 0
     D   l_linger                    10I 0

      /if defined(XOPEN_SOURCE)
      /if not defined(COMPAT_43)
      /define XOPEN_SOURCE_530
      /endif
      /endif

     D socklen_t       s             10i 0 based(Template)

      **************************************************************
      * Socket Address: This is a basic socket address structure
      *                 for any type of network (pre-IPv6)
      **************************************************************
      /if not defined(XOPEN_SOURCE_520)
     D sa_family_t     s              5u 0 based(Template)
     D sockaddr        ds
     D    sa_family                        like(sa_family_t)
     D    sa_data                    14a
      /else
     D sa_family_t     s              3u 0 based(Template)
     D sa_len_t        s              3u 0 based(Template)
     D sockaddr        ds
     D    sa_len                           like(sa_len_t)
     D    sa_family                        like(sa_family_t)
     D    sa_data                    14a
      /endif


      **************************************************************
      * Socket Storage: Same as preceding structure, but large
      *                 enough for any address, even in IPv6.
      **************************************************************
      /if not defined(XOPEN_SOURCE_520)
     D sockaddr_storage...
     D                 ds           304    based(p_sockaddr_storage)
     D    ss_family                        like(sa_family_t)
      /else
     D sockaddr_storage...
     D                 ds           304    based(p_sockaddr_storage)
     D    ss_len                           like(sa_len_t)
     D    ss_family                        like(sa_family_t)
      /endif


     **  Socket Address (Internet)
     **
     **   struct sockaddr_in {
     **      short           sin_family;
     **      u_short         sin_port;
     **      struct in_addr  sin_addr;
     **      char            sin_zero[8];
     **   };
     **
      /if not defined(XOPEN_SOURCE_520)
     D sockaddr_in     DS                  based(p_sockaddr)
     D   sin_Family                   5u 0
     D   sin_Port                     5U 0
     D   sin_addr                    10U 0
     D   sin_zero                     8A
      /else
     D sockaddr_in     DS                  based(p_sockaddr)
     D   sin_Len                      3u 0
     D   sin_Family                   3u 0
     D   sin_Port                     5U 0
     D   sin_addr                    10U 0
     D   sin_zero                     8A
      /endif


     **  Socket Address (Internet IPv6)
     **
     **   struct sockaddr_in6 {
     **      sa_family_t     sin6_family;    /* AF_INET6                   @A5A*/
     **      in_port_t       sin6_port;      /* transport layer port #     @A5A*/
     **      uint32_t        sin6_flowinfo;  /* IPv6 traffic class & flow  @A5A*/
     **      struct in6_addr sin6_addr;      /* IPv6 address               @A5A*/
     **      uint32_t        sin6_scope_id;  /* set of scope interfaces    @A5A*/
     **   };
     **
      /if not defined(XOPEN_SOURCE_520)
     D sockaddr_in6    DS                  based(Template)
     D  sin6_family                   5u 0
     D  sin6_port                     5U 0
     D  sin6_flowinfo                10u 0
     D  sin6_addr                    16a
     D  sin6_scope_id                10u 0
      /else
     D sockaddr_in6    DS                  based(Template)
     D  sin6_len                      3u 0
     D  sin6_family                   3u 0
     D  sin6_port                     5U 0
     D  sin6_flowinfo                10u 0
     D  sin6_addr                    16a
     D  sin6_scope_id                10u 0
      /endif


     **  Socket Address (Unix domain)
     **
     **   struct sockaddr_un {
     **      short           sun_family;
     **      char            sun_path[126];
     **   };
     **
      /if not defined(XOPEN_SOURCE_520)
     D sockaddr_un     DS                  qualified based(p_sockaddr)
     D   sun_Family                   5I 0
     D   sun_Path                   126A
      /else
     D sockaddr_un     DS                  qualified based(p_sockaddr)
     D   sun_len                      3u 0
     D   sun_family                   3u 0
     D   sun_path                   126a
      /endif


     **
     ** Host Database Entry (for DNS lookups, etc)
     **
     **   (this is a partial implementation... didn't try to
     **    figure out how to deal with all possible addresses
     **    or all possible aliases for a host in RPG)
     **
     **            struct hostent {
     **              char   *h_name;
     **              char   **h_aliases;
     **              int    h_addrtype;
     **              int    h_length;
     **              char   **h_addr_list;
     **            };
     **
     **           #define h_addr   h_addr_list[0]
     **
     D hostent         DS                  Based(p_hostent)
     D   h_name                        *
     D   h_aliases                     *
     D   h_addrtype                   5I 0
     D   h_length                     5I 0
     D   h_addrlist                    *
     D p_h_addr        S               *   Based(h_addrlist)
     D h_addr          S             10U 0 Based(p_h_addr)


     **
     ** Service Database Entry (which service = which port, etc)
     **
     **            struct servent {
     **              char   *s_name;
     **              char   **s_aliases;
     **              int    s_port;
     **              char   *s_proto;
     **            };
     **
     D servent         DS                  Based(p_servent)
     D   s_name                        *
     D   s_aliases                     *
     D   s_port                      10I 0
     D   s_proto                       *


     **
     ** IP structure without any opts (for RAW sockets)
     **
     **   struct ip {
     **       unsigned       ip_v:4;       Version (first 4 bits)
     **       unsigned       ip_hl:4;      Header length (next 4)
     **       u_char         ip_tos;       Type of service
     **       short          ip_len;       Total Length
     **       u_short        ip_id;        Identification
     **       short          ip_off;       Fragment offset field
     **       u_char         ip_ttl;       Time to live
     **       u_char         ip_p;         Protocol
     **       u_short        ip_sum;       Checksum
     **       struct in_addr ip_src;       Source Address
     **       struct in_addr ip_dst;       Destination Address
     **   };
     **
     **  Note:  Since you can't define a variable to be 4 bits long
     **     in RPG, ip_v_hl is a combination of ip_v and ip_hl.
     **     with mult/div/mvr and data structures, it should still
     **     be usable...
     **
     **  Since ip_tos & ip_ttl conflict with the definitions for
     **  setsockopt() & getsockopt(), we add an extra $ to the end...
     D ip              DS                  based(p_ip)
     D                                     qualified
     D   ip_v_hl                      1A
     D   ip_tos                       1A
     D   ip_len                       5I 0
     D   ip_id                        5U 0
     D   ip_off                       5I 0
     D   ip_ttl                       1A
     D   ip_p                         1A
     D   ip_sum                       5U 0
     D   ip_src                      10U 0
     D   ip_dst                      10U 0


     **
     ** UDP Packet Header (for RAW sockets)
     **
     **   struct udphdr {                       /* UDP header             */
     **       u_short     uh_sport;             /* source port            */
     **       u_short     uh_dport;             /* destination port       */
     **       short       uh_ulen;              /* UDP length             */
     **       u_short     uh_sum;               /* UDP checksum           */
     **   };
     **
     d udphdr          DS                  based(p_udphdr)
     D                                     qualified
     D  uh_sport                      5U 0
     D  uh_dport                      5U 0
     D  uh_ulen                       5I 0
     D  uh_sum                        5U 0


     ** Internet Control Message Protocol (ICMP) header
     **   (I THINK I did the unions correctly...  but you might want to
     **    check that out if you're having problems...)
     **
     **   struct icmp {                     /* ICMP header                */
     **       u_char      icmp_type;        /* ICMP message type          */
     **       u_char      icmp_code;        /* type sub code              */
     **       u_short     icmp_cksum;       /* ICMP checksum              */
     **       union {                       /* Message type substructures:*/
     **           u_char ih_pptr;           /*   Parameter problem pointer*/
     **           struct in_addr ih_gwaddr; /*   Redirect gateway address */
     **           struct ih_idseq {         /*   Echo/Timestmp Req/Reply  */
     **               u_short     icd_id;   /*      Indentifier           */
     **               u_short     icd_seq;  /*      Sequence number       */
     **           } ih_idseq;
     **           int ih_void;              /* Unused part of some msgs   */
     **       } icmp_hun;
     **       union {
     **           struct id_ts {            /* Timestamp substructure     */
     **               u_long its_otime;     /*    Originate timestamp     */
     **               u_long its_rtime;     /*    Receive timestamp       */
     **               u_long its_ttime;     /*    Transmit timestamp      */
     **           } id_ts;
     **           struct id_ip  {           /* Imbedded 'original' IP hdr */
     **               struct ip idi_ip;     /* in ICMP error-type msgs.   */
     **                                     /* Includes IP header,IP opts,*/
     **                                     /* and 64 bits of data.       */
     **           } id_ip;
     **           u_long  id_mask;          /* Address mask request/reply */
     **           char    id_data[1];       /* Beginning of echo req data */
     **       } icmp_dun;
     **   };
     D icmp            DS                  based(p_icmp)
     D                                     qualified
     D  icmp_type                     1A
     D  icmp_code                     1A
     D  icmp_cksum                    5U 0
     D  icmp_hun                      4A
     D    ih_gwaddr                  10U 0 OVERLAY(icmp_hun:1)
     D    ih_pptr                     1A   OVERLAY(icmp_hun:1)
     D    ih_idseq                    4A   OVERLAY(icmp_hun:1)
     D      icd_id                    5U 0 OVERLAY(ih_idseq:1)
     D      icd_seq                   5U 0 OVERLAY(ih_idseq:3)
     D    ih_void                     5I 0 OVERLAY(icmp_hun:1)
     D  icmp_dun                     20A
     D    id_ts                      12A   OVERLAY(icmp_dun:1)
     D      its_otime                10U 0 OVERLAY(id_ts:1)
     D      its_rtime                10U 0 OVERLAY(id_ts:5)
     D      its_ttime                10U 0 OVERLAY(id_ts:9)
     D    id_ip                      20A   OVERLAY(icmp_dun:1)
     D      idi_ip                   20A   OVERLAY(id_ip:1)
     D    id_mask                    10U 0 OVERLAY(icmp_dun:1)
     D    id_data                     1A   OVERLAY(icmp_dun:1)


     **
     ** Time Value Structure (for the select() function, etc)
     **
     **      struct timeval {
     **         long  tv_sec;                  /* seconds       */
     **         long  tv_usec;                 /* microseconds  */
     **      };
     **
     **   contrains a structure for specifying a wait time on
     **   a select() function...
     **
     **    tv_sec = seconds.    tv_usec = microseconds
     **
      /if not defined(TIMEVAL_STRUCT)
     D timeval         DS                  based(p_timeval)
     D   tv_sec                      10I 0
     D   tv_usec                     10I 0
      /define TIMEVAL_STRUCT
      /endif

     **
     ** i/o vector.  Can be used to write data from
     ** different buffers without needing to copy the
     ** data all into one place first.
     ** ("scatter/gather" I/O)
     **
      /if not defined(IOVEC_DS_DEFINED)
     D iovec           ds                  based(p_iovec) qualified
     D   iov_base                      *
     D   iov_len                     10u 0
      /define IOVEC_DS_DEFINED
      /endif


     **
     ** msghdr structure for use w/sendmsg() and recvmsg() APIs
     **
      /if not defined(XOPEN_SOURCE_520)
     D msghdr          ds                  based(p_msghdr) qualified
     D                                     align
     D  msg_name                       *
     D  msg_namelen                  10i 0
     D  msg_iov                        *
     D  msg_iovlen                   10i 0
     D  msg_accrights                  *
     D  msg_accrightslen...
     D                               10i 0
      /else
     D msghdr          ds                  based(p_msghdr) qualified
     D                                     align
     D  msg_name                       *
     D  msg_namelen                  10i 0
     D  msg_iov                        *
     D  msg_iovlen                   10i 0
     D  msg_control                    *
     D  msg_controllen...
     D                               10i 0
     D  msg_flags                    10i 0

     D cmsghdr         ds                  based(p_cmsghdr) qualified
     D   cmsg_len                    10i 0
     D   cmsg_level                  10i 0
     D   cmsg_type                   10i 0

     D SCM_RIGHTS      C                   const(1)
     D IP_QOS_CLASSIFICATION_DATA...
     D                 C                   const(x'80000001')
      /endif


     ***********************************************************************
     **  S U B P R O C E D U R E   P R O T O T Y P E S
     ***********************************************************************
     ** --------------------------------------------------------------------
     **
     **    socket--Create Socket
     **
     **    int  socket(int address_family,
     **                int type,
     **                int protocol)
     **
     **
     **     The socket() function is used to create an end point for
     **        communications.  The end point is represented by the
     **        socket descriptor returned by the socket() function.
     **
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D socket          PR            10I 0 ExtProc('socket')
     D   AddrFamily                  10I 0 Value
     D   SocketType                  10I 0 Value
     D   Protocol                    10I 0 Value
      /else
     D socket          PR            10I 0 ExtProc('qso_socket98')
     D   AddrFamily                  10I 0 Value
     D   SocketType                  10I 0 Value
     D   Protocol                    10I 0 Value
      /endif


     ** --------------------------------------------------------------------
     **
     **    setsockopt()--Set Socket Options
     **
     **    int  setsockopt(int socket_descriptor,
     **                    int level,
     **                    int option_name,
     **                    char *option_value
     **                    int option_length)
     **
     **    The setsockopt() function is used to set socket options
     **     (there are many, see the book.)
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D setsockopt      PR            10I 0 ExtProc('setsockopt')
     D   SocketDesc                  10I 0 Value
     D   Opt_Level                   10I 0 Value
     D   Opt_Name                    10I 0 Value
     D   Opt_Value                     *   Value
     D   Opt_Len                     10I 0 Value
      /else
     D setsockopt      PR            10I 0 ExtProc('qso_setsockopt98')
     D   SocketDesc                  10I 0 Value
     D   Opt_Level                   10I 0 Value
     D   Opt_Name                    10I 0 Value
     D   Opt_Value                     *   Value
     D   Opt_Len                     10I 0 Value
      /endif


     ** --------------------------------------------------------------------
     **   getsockopt() -- Retrieve Info about Socket Options
     **
     **   int getsockopt(int socket_descriptor,
     **                  int level,
     **                  int option_name,
     **                  char *option_value,
     **                  int *option_length)
     **
     **   Gets various information about the socket's options.
     **   (there are many, see the book.)
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D getsockopt      PR            10I 0 extproc('getsockopt')
     D   SocketDesc                  10I 0 VALUE
     D   Opt_Level                   10I 0 VALUE
     D   Opt_Name                    10I 0 VALUE
     D   Opt_Value                     *   VALUE
     D   Opt_Length                  10I 0
      /else
     D getsockopt      PR            10I 0 extproc('qso_getsockopt98')
     D   SocketDesc                  10I 0 VALUE
     D   Opt_Level                   10I 0 VALUE
     D   Opt_Name                    10I 0 VALUE
     D   Opt_Value                     *   VALUE
     D   Opt_Length                  10I 0
      /endif


     ** --------------------------------------------------------------------
     **
     **    getsockname()--Get Local Address for Socket
     **
     **    int  getsockname(int socket_descriptor,
     **              struct sockaddr *local_address,
     **              int *address_length)
     **
     **           struct sockaddr {
     **              u_short sa_family;
     **              char    sa_data[14];
     **           };
     **
     **    The getsockname() function is used to retreive the local address
     **      asociated with a socket.
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D getsockname     PR            10I 0 ExtProc('getsockname')
     D   SocketDesc                  10I 0 Value
     D   SockAddr                          like(Sockaddr_storage)
     D                                     options(*varsize)
     D   AddrLength                  10I 0
      /else
     D getsockname     PR            10I 0 ExtProc('qso_getsockname98')
     D   SocketDesc                  10I 0 Value
     D   SockAddr                          like(Sockaddr_storage)
     D                                     options(*varsize)
     D   AddrLength                  10I 0
      /endif


     ** --------------------------------------------------------------------
     **
     **    getpeername()--Retrieve Destination Address of Socket
     **
     **    int  getpeername(int socket_descriptor,
     **                     struct sockaddr *local_address,
     **                     int *address_length)
     **
     **           struct sockaddr {
     **              u_short sa_family;
     **              char    sa_data[14];
     **           };
     **
     **
     **    The getpeername() function is used to retreive the destination
     **      address to which the socket is connected.
     **
     **    Note:  Socket must be connected first.
     **
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D getpeername     PR            10I 0 ExtProc('getpeername')
     D   SocketDesc                  10I 0 Value
     D   p_sockaddr                        like(Sockaddr_storage)
     D                                     options(*varsize)
     D   AddrLength                  10I 0
      /else
     D getpeername     PR            10I 0 ExtProc('qso_getpeername98')
     D   SocketDesc                  10I 0 Value
     D   p_sockaddr                        like(Sockaddr_storage)
     D                                     options(*varsize)
     D   AddrLength                  10I 0
      /endif


     ** --------------------------------------------------------------------
     **    bind()--Bind socket to specified adapter and/or port
     **
     **    int  bind(int socket_descriptor,
     **              struct sockaddr *local_address,
     **              int address_length)
     **
     **           struct sockaddr {
     **              u_short sa_family;
     **              char    sa_data[14];
     **           };
     **
     **
     **    The bind() function is used to associate a local address
     **      and port with a socket.   This allows you to get only
     **      socket requests on a specific network adapter, and to
     **      assign a specific port to your socket.
     **    For example, if you're writing a telnet server, you'd
     **      bind to port 23, because thats the standard port for
     **      telnets to listen on.
     **    If we bind to an address of 0, it will allow requests on
     **      any (TCP/IP enabled) network adapter.
     **
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D bind            PR            10I 0 ExtProc('bind')
     D   Sock_Desc                   10I 0 Value
     D   p_Address                     *   value
     D   AddressLen                  10I 0 Value
      /else
     D bind            PR            10I 0 ExtProc('qso_bind98')
     D   Sock_Desc                   10I 0 Value
     D   p_Address                         like(sockaddr_storage)
     D                                     options(*varsize)
     D   AddressLen                  10I 0 Value
      /endif


     ** --------------------------------------------------------------------
     **    listen()--Invite Incoming Connections Requests
     **
     **    int  listen(int socket_descriptor,
     **                 int back_log)
     **
     **
     **    The listen() function is used to indicate a willingness to accept
     **       incoming connection requests.  if a listen() is not done,
     **       incoming requests are refused.
     **
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D listen          PR            10I 0 ExtProc('listen')
     D   SocketDesc                  10I 0 Value
     D   Back_Log                    10I 0 Value
      /else
     D listen          PR            10I 0 ExtProc('qso_listen98')
     D   SocketDesc                  10I 0 Value
     D   Back_Log                    10I 0 Value
      /endif


     ** --------------------------------------------------------------------
     **    accept()--Wait for Connection Request and Make Connection
     **
     **    int  accept(int socket_descriptor,
     **              struct sockaddr *address,
     **              int *address_length)
     **
     **           struct sockaddr {
     **              u_short sa_family;
     **              char    sa_data[14];
     **           };
     **
     **   The accept() function is used to wait for connection requests.
     **    accept() takes the first connection request on the queue of
     **    pending connection requests and creates a new socket to service
     **    the connection request.
     **
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D accept          PR            10I 0 ExtProc('accept')
     D   Sock_Desc                   10I 0 Value
     D   p_Address                     *   Value
     D   p_AddrLen                   10I 0 options(*omit)
      /else
     D accept          PR            10I 0 ExtProc('accept')
     D   Sock_Desc                   10I 0 Value
     D   p_Address                         like(sockaddr_storage)
     D                                     options(*varsize:*omit)
     D   p_AddrLen                   10I 0 options(*omit)
      /endif


     ** --------------------------------------------------------------------
     **   connect() -- Connect to a host.
     **
     **      int connect(int socket_descriptor,
     **                  struct sockaddr *destination,
     **                  int address_length)
     **
     **      Used to connect to a host.  (Usually used on the client-side)
     **      In TCP applications, this takes an address & port and connects
     **      to a server program thats listening on that port.   In UDP
     **      this simply specifies the address & port to send to.
     **
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D connect         PR            10I 0 ExtProc('connect')
     D   Sock_Desc                   10I 0 VALUE
     D   p_SockAddr                    *   VALUE
     D   AddressLen                  10I 0 VALUE
      /else
     D connect         PR            10I 0 ExtProc('qso_connect98')
     D   Sock_Desc                   10I 0 VALUE
     D   SockAddr                          like(Sockaddr_storage)
     D                                     options(*varsize)
     D   AddressLen                  10I 0 VALUE
      /endif


     ** --------------------------------------------------------------------
     **    send()--Send Data
     **
     **    int  send(int socket_descriptor,
     **              char *buffer,
     **              int  buffer_length,
     **              int  flags)
     **
     **    Sends data in buffer via socket connection to another program.
     **
     **    In the case of text, it should be converted to ASCII and then
     **    CR/LF terminated.
     **
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D Send            PR            10I 0 ExtProc('send')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value
      /else
     D Send            PR            10I 0 ExtProc('qso_send98')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value
      /endif


     ** --------------------------------------------------------------------
     **    sendto()--Send Data
     **
     **   int sendto(int socket_descriptor,
     **              char *buffer,
     **              int buffer_length,
     **              int flags,
     **              struct sockaddr *destination_address,
     **              int address_length)
     **
     **    Sends data in buffer via connected/connectionless sockets
     **
     **    This is more useful for connectionless sockets (such as UDP)
     **    because allows you to specify the destination address.
     **
     **    When used with a connection-oriented sockets (such as TCP)
     **    the destination address should be set to *NULL, and the length
     **    should be zero.
     **
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D SendTo          PR            10I 0 ExtProc('sendto')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value
     D   DestAddr                      *   Value
     D   AddrLen                     10I 0 Value
      /else
     D SendTo          PR            10I 0 ExtProc('qso_sendto98')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value
     D   DestAddr                      *   Value
     D   AddrLen                     10I 0 Value
      /endif


     ** --------------------------------------------------------------------
     **    recv()--Receive Data
     **
     **    int  recv(int socket_descriptor,                 I
     **              char *buffer,                          I
     **              int  buffer_length,                    I
     **              int  flags)
     **
     **
     **   The recv() funcion is used to receive data through a socket.
     **
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D Recv            PR            10I 0 ExtProc('recv')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value
      /else
     D Recv            PR            10I 0 ExtProc('qso_recv98')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value
      /endif


     ** --------------------------------------------------------------------
     **    recvfrom()--Receive Data w/From Address
     **
     **    int  recvfrom(int socket_descriptor,
     **                 char *buffer,
     **                 int buffer_length,
     **                 int flags,
     **                 struct sockaddr *from_address,
     **                 int *address_length)
     **
     **
     **   The recvfrom() function receives data through a connected, or
     **   an unconnected socket.
     **
     **   This is particularly useful for UDP/Connectionless sockets
     **   because it allows you to ascertain who sent the data to you.
     **
     **   The from_address and address_length parms are ignored on
     **   connection-oriented sockets -- or if they are set to *NULL.
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D RecvFrom        PR            10I 0 ExtProc('recvfrom')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value
     D   FromAddr                      *   Value
     D   AddrLength                  10I 0
      /else
     D RecvFrom        PR            10I 0 ExtProc('recvfrom')
     D   Sock_Desc                   10I 0 Value
     D   p_Buffer                      *   Value
     D   BufferLen                   10I 0 Value
     D   Flags                       10I 0 Value
     D   FromAddr                      *   Value
     D   AddrLength                  10I 0
      /endif


     ** --------------------------------------------------------------------
     **    close()--End Socket Connection
     **
     **    int  close(int descriptor)
     **
     **    Ends a socket connection, and deletes the socket descriptor.
     **
     **  Note: Due to conflicts with IFSIO_H, we are only defining
     **        close() if it has not already been defined.
     ** --------------------------------------------------------------------
     D/if not defined(CLOSE_PROTOTYPE)
     D Close           PR            10I 0 ExtProc('close')
     D   Sock_Desc                   10I 0 Value
     D/define CLOSE_PROTOTYPE
     D/endif


     ** --------------------------------------------------------------------
     **    shutdown()-- disable reading/writing on a socket
     **
     **    int  shutdown(int descriptor,
     **                  int how)
     **
     **    Stops all reading and/or writing on a socket.
     **    Difference between this and close() is that with close, you
     **    actually delete the descriptor, and must accept() a new one,
     **    or allocate (socket()) a new one.
     **
     **    The how parameter can be:
     **            0 = no more data can be received
     **            1 = no more data can be sent
     **            2 = no more data can be sent or received
     **
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D shutdown        PR            10I 0 ExtProc('shutdown')
     D   Sock_Desc                   10I 0 Value
     D   How                         10I 0 Value
      /else
     D shutdown        PR            10I 0 ExtProc('qso_shutdown98')
     D   Sock_Desc                   10I 0 Value
     D   How                         10I 0 Value
      /endif


     ** --------------------------------------------------------------------
     **  select() -- wait for events on multiple sockets
     **
     **   int select(int max_descriptor,
     **              fd_set *read_set,
     **              fd_set *write_set,
     **              fd_set *exception_set,
     **              struct timeval *wait_time)
     **
     **   Select is used to wait for i/o on multiple sockets.  This
     **   prevents your job from "blocking" on one socket read, while
     **   there is data to read on another socket.
     **
     **   It also allows you to "poll" for data to be found on a socket
     **   and to set a timeout value to keep your application from
     **   stopping forever on a "dead-end" socket.
     **
     **   ***** To help with managing the descriptor sets, I have
     **   ***** created FD_SET, FD_ISSET, FD_CLR and FD_ZERO functions
     **   ***** in my SOCKUTIL_H/SOCKUTILR4 socket utilities functions!
     **
     **   max_desriptor = The number of descriptors in your sets.
     **                   (take the highest descriptor value you want
     **                   to wait on, and add 1, and put it here)
     **
     **   read_set = A 28-byte character field specifying, on input,
     **                 which descriptors to wait for, and, on output,
     **                 which descriptors have data waiting on them.
     **                 This can be set to *NULL if you do not wish to
     **                 wait for any sockets to be read.
     **
     **  write_set = A 28-byte character field specifying, on input,
     **                 which descriptors to wait for, and, on output,
     **                 which descriptors are ready to be written to.
     **                 This can be set to *NULL if you do not wish to
     **                 wait for any sockets to be written to.
     **
     **  exception_set = A 28-byte character field specifying, on input,
     **                 which descriptors to test, and on output,
     **                 which descriptors have exceptions signalled to them.
     **                 This can be set to *NULL if you do not wish to
     **                 check for any sockets to have exceptions.
     **
     **                 NOTE: An exception is not the same as an error.
     **                       Exceptions are usually out-of-band data!
     **
     **  wait_time = a timeval data structure containing the amoutn of
     **                 time to wait for an event to occur.
     **                 If a wait time of zero is given, select() will
     **                 return immediately.
     **              If *NULL is passed instead of the timeval structure,
     **                 select() will wait indefinitely.
     **
     **  Returns the number of descriptors that met selection criteria
     **           or 0 for timeout
     **           or -1 for error.
     ** --------------------------------------------------------------------
     D Select          PR            10I 0 extproc('select')
     D   max_desc                    10I 0 VALUE
     D   read_set                      *   VALUE
     D   write_set                     *   VALUE
     D   except_set                    *   VALUE
     D   wait_Time                     *   VALUE


     ** --------------------------------------------------------------------
     **   givedescriptor() -- Pass Descriptor Access to Another Job
     **
     **   int givedescriptor(int descriptor,
     **                      char *target_job)
     **
     **   Allows you to pass a descriptor from one OS/400 job to another.
     **   (Very useful if you wanted one job to wait for incoming conn.
     **   then, submit a seperate job to deal with each client connection
     **   while the original keeps waiting for more)
     **
     **   It is the programmer's responsibility to alert the target job
     **   that it needs to take the descriptor, using takedescriptor().
     **
     **   the info for the target job can be obtained by calling a Work
     **   Managment API that supplies an "internal job identifier"
     **   (such as QUSRJOBI)
     **
     **   returns 0 = success, -1 = failure
     ** --------------------------------------------------------------------
     D givedescriptor  PR            10I 0 extproc('givedescriptor')
     D   SockDesc                    10I 0 VALUE
     D   Target_Job                    *   VALUE


     ** --------------------------------------------------------------------
     **   takedescriptor() -- Receive Descriptor Access from Another Job
     **
     **   int takedescriptor(char *source_job)
     **
     **   Allows you to pass a descriptor from one OS/400 job to another.
     **   (Very useful if you wanted one job to wait for incoming conn.
     **   then, submit a seperate job to deal with each client connection
     **   while the original keeps waiting for more)
     **
     **   the info for the source job can be obtained by calling a Work
     **   Managment API that supplies an "internal job identifier"
     **   (such as QUSRJOBI).
     **
     **   You can also specify *NULL pointer for the Source_Job parm if
     **   you want to receive a descriptor from ANY job that gives one
     **   one to you.
     **
     **   If no other jobs has referenced yours with givedescriptor()
     **   then this function will block.
     **
     **   return value is the socket descriptor taken, or -1 for error.
     ** --------------------------------------------------------------------
     D takedescriptor  PR            10I 0 extproc('takedescriptor')
     D   Source_Job                    *   VALUE


     ** --------------------------------------------------------------------
     **   gethostbyname() -- Resolves a domain name to an IP address
     **
     **      struct hostent *gethostbyname(char *host_name)
     **
     **            struct hostent {
     **              char   *h_name;
     **              char   **h_aliases;
     **              int    h_addrtype;
     **              int    h_length;
     **              char   **h_addr_list;
     **            };
     **
     **   Returns a pointer to a host entry structure.  The aliases and
     **   address list items in the structure are pointers to arrays of
     **   pointers, which are null terminated.
     **
     **   Note:  The strings & arrays used in C are often variable length,
     **       null-terminated entities.  Be careful to only use bytes from
     **       the returned pointers (in the hostent data structure) to
     **       the first null (x'00') character.
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D gethostbyname   PR              *   extProc('gethostbyname')
     D  HostName                       *   value options(*string)
      /else
     D gethostbyname   PR              *   extProc('qso_gethostbyname98')
     D  HostName                       *   value options(*string)
      /endif


     ** --------------------------------------------------------------------
     **    getservbyname()--Get Port Number for Service Name
     **
     **    struct servent *getservbyname(char *service_name,
     **                                  char *protocol_name)
     **
     **            struct servent {
     **              char   *s_name;
     **              char   **s_aliases;
     **              int    s_port;
     **              char   *s_proto;
     **            };
     **
     **   This is generally used to look up which port is used for a given
     **   internet service.   i.e. if you want to know the port for
     **   TELNET, you'd do   x = getservbyname('telnet': 'tcp')
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D getservbyname   PR              *   extproc('getservbyname')
     D   service_name                  *   value options(*string)
     D   protocol_nam                  *   value options(*string)
      /else
     D getservbyname   PR              *   extproc('qso_getservbyname98')
     D   service_name                  *   value options(*string)
     D   protocol_nam                  *   value options(*string)
      /endif


     ** --------------------------------------------------------------------
     **    gethostbyaddr()--Get Host Information for IP Address
     **
     **     struct hostent *gethostbyaddr(char *host_address,
     **                                   int address_length,
     **                                   int address_type)
     **         struct hostent {
     **             char   *h_name;
     **             char   **h_aliases;
     **             int    h_addrtype;
     **             int    h_length;
     **             char   **h_addr_list;
     **         };
     **
     **     An IP address (32-bit integer formnat) goes in, and a
     **     hostent structure pops out.   Really, kinda fun, if you
     **     havent already learned to hate the hostent structure, that is.
     **
     **   Note:  The strings & arrays used in C are often variable length,
     **       null-terminated entities.  use caution to only use data from
     **       the returned pointer up until the terminating null (x'00')
     **
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D gethostbyaddr   PR              *   ExtProc('gethostbyaddr')
     D  IP_Address                   10U 0
     D  Addr_Len                     10I 0 VALUE
     D  Addr_Fam                     10I 0 VALUE
      /else
     D gethostbyaddr   PR              *   ExtProc('qso_gethostbyaddr98')
     D  IP_Address                   10U 0
     D  Addr_Len                     10I 0 VALUE
     D  Addr_Fam                     10I 0 VALUE
      /endif


     ** --------------------------------------------------------------------
     **    inet_addr()--Converts an address from dotted-decimal format
     **         to a 32-bit IP address.
     **
     **         unsigned long inet_addr(char *address_string)
     **
     **    Converts an IP address from format 192.168.0.100 to an
     **    unsigned long, such as hex x'C0A80064'.
     **
     **  returns INADDR_NONE on error.
     **
     ** KNOWN BUG: Due to the fact that this can't return a negative value,
     **              it returns x'FFFFFFFF' on error.  However, x'FFFFFFFF'
     **              is also the correct IP for the valid address of
     **              "255.255.255.255".  (which is "worldwide broadcast")
     **              A reasonable workaround is to check for 255.255.255.255
     **              beforehand, and translate it manually rather than
     **              calling inet_addr.
     ** --------------------------------------------------------------------
     D inet_addr       PR            10U 0 ExtProc('inet_addr')
     D  char_addr                      *   value options(*string)


     ** --------------------------------------------------------------------
     **    inet_ntoa()--Converts an address from 32-bit IP address to
     **         dotted-decimal format.
     **
     **         char *inet_ntoa(struct in_addr internet_address)
     **
     **    Converts from 32-bit to dotted decimal, such as, x'C0A80064'
     **    to '192.168.0.100'.  Will return NULL on error
     **
     **   Note:  The strings & arrays used in C are often variable length,
     **       null-terminated entities.  Make sure you only use bytes from
     **       the returned pointer to the first null (x'00') character.
     **
     ** --------------------------------------------------------------------
     D inet_ntoa       PR              *   ExtProc('inet_ntoa')
     D  ulong_addr                   10U 0 VALUE


     ** --------------------------------------------------------------------
     **   fcntl()--Change Descriptor Attributes
     **
     **   int fcntl(int descriptor, int command, ...)
     **
     **   The third parameter (when used with sockets) is also an
     **   integer passed by value.. it specifies an argument for
     **   some of the commands.
     **
     **   commands supported in sockets are:
     **          F_GETFL -- Return the status flags for the descriptor
     **          F_SETFL -- Set status flags for the descriptor
     **                    (Arg =)status flags (ORed) to set.
     ** (the commands below arent terribly useful in RPG)
     **          F_DUPFD -- Duplicate the descriptor
     **                    (Arg =)minimum value that new descriptor can be
     **          F_GETOWN -- Return the process ID or group ID that's
     **                     set to receive SIGIO & SIGURG
     **          F_SETOWN -- Set the process ID or group ID that's
     **                     to receive SIGIO & SIGURG
     **                    (Arg =)process ID (or neg value for group ID)
     **
     **  returns -1 upon error.
     **          successful values are command-specific.
     ** --------------------------------------------------------------------
     D/if not defined(FCNTL_PROTOTYPE)
     D fcntl           PR            10I 0 ExtProc('fcntl')
     D   SocketDesc                  10I 0 Value
     D   Command                     10I 0 Value
     D   Arg                         10I 0 Value Options(*NOPASS)
     D/define FCNTL_PROTOTYPE
     D/endif

     ** --------------------------------------------------------------------
     **   sendmsg() -- send a message over a socket
     **                (allows multiple buffers.  Allows you to send
     **                  descriptor rights if using AF_UNIX )
     **
     **     sock_desc = (input) socket descriptor to use
     **    msg_struct = (input) message to send (see msghdr, above)
     **         flags = (input) flags (like any send/recv API)
     **
     **  Returns number of bytes sent or -1 upon error
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D sendmsg         pr            10i 0 extproc('sendmsg')
     D   sock_desc                   10i 0 value
     D   msg_struct                        like(msghdr)
     D   flags                       10i 0 value
      /else
     D sendmsg         pr            10i 0 extproc('qso_sendmsg98')
     D   sock_desc                   10i 0 value
     D   msg_struct                        like(msghdr)
     D   flags                       10i 0 value
      /endif

     ** --------------------------------------------------------------------
     **   recvmsg() -- receive a message over a socket
     **                (allows multiple buffers.  Allows you to receive
     **                  descriptor rights if using AF_UNIX )
     **
     **     sock_desc = (input) socket descriptor to use
     **    msg_struct = (input) message to receive (see msghdr, above)
     **         flags = (input) flags (like any send/recv API)
     **
     **  Returns number of bytes received or -1 upon error
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D recvmsg         pr            10i 0 extproc('recvmsg')
     D   sock_desc                   10i 0 value
     D   msg_struct                        like(msghdr)
     D   flags                       10i 0 value
      /else
     D recvmsg         pr            10i 0 extproc('qso_recvmsg98')
     D   sock_desc                   10i 0 value
     D   msg_struct                        like(msghdr)
     D   flags                       10i 0 value
      /endif

     ** --------------------------------------------------------------------
     **   socketpair():  Create a pair of connected sockets
     **                  (just like a pipe!)
     **
     **    family = (input) Address family must be AF_UNIX
     **                     or AF_UNIX_CCSID
     **      type = (input) type of socket (datagram or stream)
     **  protocol = (input) protocol (or 0=default)
     **    vector = (output) the two connected sockets
     **
     **  Returns 0 if successful, or -1 otherwise
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D socketpair      PR            10i 0 extproc('socketpair')
     D   family                      10i 0 value
     D   type                        10i 0 value
     D   protocol                    10i 0 value
     D   vector                      10i 0 dim(2)
      /else
     D socketpair      PR            10i 0 extproc('qso_socketpair98')
     D   family                      10i 0 value
     D   type                        10i 0 value
     D   protocol                    10i 0 value
     D   vector                      10i 0 dim(2)
      /endif


     ** --------------------------------------------------------------------
     **   inet_pton(): Convert printable IP address to numeric IP
     **                address.  (Replacement for inet_addr)
     **
     **    family = (input)  Address family must be AF_INET (IPv4)
     **                        or AF_INET6 (IPv6)
     **     paddr = (input)  printable address (human-readable)
     **     naddr = (output) numeric address (binary)
     **
     **  Returns 1 if successful
     **          0 if input is not a valid address
     **         -1 upon error (Check errno)
     ** --------------------------------------------------------------------
      /if defined(*V5R2M0)
     D inet_pton       PR            10i 0 extproc('inet_pton')
     D   family                      10i 0 value
     D   paddr                         *   value options(*string)
     D   naddr                      128a   options(*varsize)


     ** --------------------------------------------------------------------
     **   inet_ntop(): Convert numeric IP address to printable format
     **                (Replacement for inet_ntoa)
     **
     **    family = (input)  Address family must be AF_INET (IPv4)
     **                       or AF_INET6 (IPv6)
     **     naddr = (input)  numeric address (binary)
     **     paddr = (output) printable address (human-readable)
     **                       use like(INET_ADDRSTRLEN or INET6_ADDRSTRLEN)
     **      size = (input)  size of 'paddr' field.  Should be
     **                       Must be >= %size(INET_ADDRSTRLEN) for IPv4
     **                       Must be >= %size(INET6_ADDRSTRLEN) for IPv6
     **
     **  Returns *NULL upon failure.
     **          or a pointer to the text string if successful
     ** --------------------------------------------------------------------
     D inet_ntop       PR              *   extproc('inet_ntop')
     D   family                      10i 0 value
     D   naddr                         *   value
     D   paddr                             like(INET6_ADDRSTRLEN)
     D                                     options(*varsize)
     D   size                              like(socklen_t) value


     ** --------------------------------------------------------------------
     **  getaddrinfo():  Get address information
     **
     **     nodename = (input)  host name or address to look up
     **                          (can be *NULL if looking up a service)
     **     servname = (input)  service name to look up
     **                          (can be *NULL if looking up a node)
     **        hints = (input)  flags/options for controlling how
     **                          this function works.
     **          res = (output) linked list of returned addrinfo_t
     **                          structures.  Must be freed by calling
     **                          freeaddrinfo()
     **
     **  returns 0 if successful, non-zero otherwise.
     **    a non-zero return value is an error code.  Use gai_strerror()
     **    to get a message for that error code.
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D getaddrinfo     PR            10i 0 extproc('getaddrinfo')
     D   nodename                      *   value options(*string)
     D   servname                      *   value options(*string)
     D   hints                             like(addrinfo_t) options(*omit)
     D   res                           *
      /else
     D getaddrinfo     PR            10i 0 extproc('qso_getaddrinfo98')
     D   nodename                      *   value options(*string)
     D   servname                      *   value options(*string)
     D   hints                             like(addrinfo_t) options(*omit)
     D   res                           *
      /endif

     D addrinfo_t      ds                  qualified
     D   ai_flags                    10i 0 inz(0)
     D   ai_family                   10i 0 inz(AF_UNSPEC)
     D   ai_socktype                 10i 0 inz(SOCK_STREAM)
     D   ai_protocol                 10i 0 inz(IPPROTO_IP)
     D   ai_addrlen                        like(socklen_t) inz
     D   ai_canonname                  *   inz(*null)
     D   ai_addr                       *   inz(*null)
     D   ai_next                       *   inz(*null)

      * --------------------------------------------------------------------
      * Flags for getaddrinfo():
      *
      * AI_PASSIVE     = get address to use with bind()
      * AI_CANONNAME   = lookup canonical name, put in ai_canonname
      * AI_NUMERICHOST = prevent DNS resolution (numeric only)
      * AI_NUMERICSERV = prevent service table lookup (port no only)
      * AI_V4MAPPED    = If no IPv6 address found, do IPv4 lookup
      *                   and map to IPv6 format.
      * AI_ALL         = Look up both IPv6 and IPv4 addresses,
      *                   and return any/all addresses found
      *                   (with IPv4 mapped to IPv6 format)
      * AI_ADDRCONFIG  = Lookup is based on the type of IP address(es)
      *                   configured.  IPv6 is used if you have an IPv6
      *                   address configured, IPv4 is used if you have
      *                   an IPv4 address configured. (not incl loopback!)
      * --------------------------------------------------------------------
     D AI_PASSIVE      C                   const(1)
     D AI_CANONNAME    C                   const(2)
     D AI_NUMERICHOST  C                   const(4)
     D AI_NUMERICSERV  C                   const(8)
     D AI_V4MAPPED     C                   const(16)
     D AI_ALL          C                   const(32)
     D AI_ADDRCONFIG   C                   const(64)


     ** --------------------------------------------------------------------
     **  getnameinfo():  Get name information for socket address
     **
     **           sa = (input)  socket address to look up
     **        salen = (input)  length of "sa" parameter.
     **     nodename = (output) returned name of host (can be
     **                          *OMIT if you don't need it.)
     **  nodenamelen = (input)  %size of nodename parameter
     **     servname = (output) returned name of service (can be
     **                          *OMIT if you don't need it.)
     **  servnamelen = (input)  %size of servname parameter
     **        flags = (input)  options to control how getnameinfo
     **                          works.  See NI_xxx flags, below.
     **
     **  returns 0 if successful, non-zero otherwise.
     **    a non-zero return value is an error code.  Use gai_strerror()
     **    to get a message for that error code.
     ** --------------------------------------------------------------------
      /if not defined(XOPEN_SOURCE_520)
     D getnameinfo     PR            10i 0 extproc('getnameinfo')
     D   sa                                like(sockaddr_storage) const
     D   salen                             like(socklen_t) value
     D   nodename                 32767a   options(*varsize:*omit)
     D   nodenamelen                       like(socklen_t) value
     D   servname                 32767a   options(*varsize:*omit)
     D   servnamelen                       like(socklen_t) value
     D   flags                       10i 0 value
      /else
     D getnameinfo     PR            10i 0 extproc('qso_getnameinfo98')
     D   sa                                like(sockaddr_storage) const
     D   salen                             like(socklen_t) value
     D   nodename                 32767a   options(*varsize:*omit)
     D   nodenamelen                       like(socklen_t) value
     D   servname                 32767a   options(*varsize:*omit)
     D   servnamelen                       like(socklen_t) value
     D   flags                       10i 0 value
      /endif


      * --------------------------------------------------------------------
      * Flags for getnameinfo():
      *
      * NI_NOFQDN      = only nodename returned for local hosts
      * NI_NUMERICHOST = only return numeric address, not host name
      * NI_NAMEREQD    = if DNS lookup of name fails, return error.
      *                    (otherwise, numeric address is returned.)
      * NI_NUMERICSERV = always return port number, not service name
      * NI_DGRAM       = return UDP services (by default, returns TCP)
      * --------------------------------------------------------------------
     D NI_NOFQDN       C                   const(1)
     D NI_NUMERICHOST  C                   const(2)
     D NI_NAMEREQD     C                   const(4)
     D NI_NUMERICSERV  C                   const(8)
     D NI_DGRAM        C                   const(32)


     ** --------------------------------------------------------------------
     **   gai_strerror():  Get text message for an error code
     **                    returned by getnameinfo/getaddrinfo
     **
     **       ecode = (input) error code
     **
     ** returns pointer to null-terminated string.
     ** --------------------------------------------------------------------
     D gai_strerror    PR              *   extproc('gai_strerror')
     D   ecode                       10i 0 value


     ** --------------------------------------------------------------------
     **  freeaddrinfo():  Free up address info list memory
     **
     **    list = (input) list of addrinfo_t structures returned
     **                   in the res parm of getaddrinfo()
     ** --------------------------------------------------------------------
     D freeaddrinfo    PR                  extproc('freeaddrinfo')
     D   list                          *   value

      // endif for if defined(*V5R2M0)
      /endif
