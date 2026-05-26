     /*-                                                                            +
      * Copyright (c) 2001-2010 Scott C. Klement                                    +
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
      /if defined(RECIO_H)
      /eof
      /endif
      /define RECIO_H

      **-------------------------------------------------------
      *  Constants:
      **-------------------------------------------------------
     D EOF             C                   -1
     D FILENAME_MAX    C                   39
     D ROPEN_MAX       C                   32767
     D r_RRN_EQ        C                   134218496
     D r_KEY_EQ        C                   184549632
     D r_KEY_GT        C                   218104064
     D r_KEY_LT        C                   150995200
     D r_KEY_LE        C                   167772416
     D r_KEY_GE        C                   201326848
     D r_KEY_NEXTUNQ   C                   83886336
     D r_KEY_PREVUNQ   C                   100663552
     D r_KEY_NEXTEQ    C                   234881280
     D r_KEY_PREVEQ    C                   251658496

     D r_FIRST         C                   16777984
     D r_LAST          C                   33555200
     D r_NEXT          C                   50332416
     D r_PREVIOUS      C                   67109632

     D r_START_FRC     C                   50331652
     D r_START         C                   16777220
     D r_END_FRC       C                   67108868
     D r_END           C                   33554436

     D r_DFT           C                   184549632
     D r_NO_LOCK       C                   1
     D r_NO_POSITION   C                   1048576
     D r_PRIOR         C                   4096
     D r_DATA_ONLY     C                   2
     D r_NULL_KEY_MAP  C                   8

     D r_READ_NEXT     C                   3
     D r_READ_PREV     C                   4

     D NOT_NULL_VALUE  C                   '0'
     D NULL_VALUE      C                   '1'
     D MAPPING_ERROR   C                   '2'

     D DK_YES          C                   1
     D DK_NO           C                   0

      **-------------------------------------------------------
      *  "Record" file handle data type
      **-------------------------------------------------------
     D RFILE_T         DS                  qualified based(Template)
     D                               16A
     D   in_buf                        *
     D   out_buf                       *
     D                               48A
     D   riofb                             likeds(RIOFB_T)
     D                               32A
     D   buf_length                  10U 0
     D                               28A
     D   in_null_map                   *
     D   out_null_map                  *
     D   null_key_map                  *
     D                               48A
     D   min_length                  10I 0
     D   null_map_len                 5I 0
     D   null_key_map_len...
     D                                5I 0
     D                                8A

      **-------------------------------------------------------
      *  I/O Feedback Structure  (returned by most Rreadx calls)
      *
      *  typedef struct {
      *    unsigned char               *key;
      *    _Sys_Struct_T               *sysparm;
      *    unsigned long                rrn;
      *    long                         num_bytes;
      *    short                        blk_count;
      *    char                         blk_filled_by;
      *    int                          dup_key   : 1;
      *    int                          icf_locate: 1;
      *    int                          reserved1 : 6;
      *    char                         reserved2[20];
      *  } _RIOFB_T;
      **-------------------------------------------------------
     D RIOFB_T         DS                  based(Template)
     D                                     align
     D                                     qualified
     D  key                            *
     D  sysparm                        *
     D  rrn                          10U 0
     D  num_bytes...
     D                               10I 0
     D  blk_count...
     D                                5I 0
     D  blk_filled_by...
     D                                1A
     D  flags...
     D                                1A
     D                               20A

     **-------------------------------------------------------
     ** Open Feedback Information:
     **
     **   typedef _Packed struct _XXDEV_LST_T {
     **      char        pgm_dev_name[10];                 10
     **      char        reserved1[50];                    60
     **      char        dev_desc_name[10];                70
     **      char        dev_class;                        71
     **      char        dev_type;                         72
     **      short       num_rows;                         74
     **      short       num_columns;                      76
     **
     **      /* BIT FLAGS...               */
     **
     **      int         blink_capability_flag    : 1;
     **      int         dev_location_flag        : 1;
     **      int         acquire_status_flag      : 1;
     **      int         invite_status_flag       : 1;
     **      int         data_avail_status_flag   : 1;
     **      int         transaction_status_flag  : 1;
     **      int         requester_dev_flag       : 1;
     **      int         DBCS_dev_flag            : 1;    77
     **      int                                  : 2;    /* reserved   */
     **      int         DBCS_keyboard_flag       : 1;
     **      int                                  : 5;    78
     **
     **      char        synch_level;                     79
     **      char        conversation_type;               80
     **      char        reserved2[50];                  130
     **   } _XXDEV_LST_T;                            (130 bytes long)
     **
     **   typedef _Packed struct _XXOPFB_T {
     **       char        odp_type[2];
     **       char        file_name[10];
     **       char        library_name[10];
     **       char        spool_file_name[10];
     **       char        spool_lib_name[10];
     **       short       spool_file_num;
     **       short       pgm_record_len;
     **       char        reserved1[2];
     **       char        member_name[10];
     **       char        reserved2[8];
     **       short       file_type;
     **       char        reserved3[3];
     **       short       rows;
     **       short       columns;
     **       int         num_records;
     **       char        access_type[2];
     **       char        dup_key_indic;
     **       char        src_file_indic;
     **       char        reserved4[10];
     **       char        reserved5[10];
     **       short       vol_label_offset;
     **       short       max_blocked_recs;
     **       short       overflow_line_num;
     **       short       blocked_rec_incr;
     **       char        reserved6[4];
     **
     **       /* MISCELLANEOUS FLAGS...     */
     **
     **       int                                  : 1;    /* reserved   */
     **       int         file_sharable_flag       : 1;
     **       int         commit_control_flag      : 1;
     **       int         commit_lock_level_flag   : 1;
     **       int         mbr_type_flag            : 1;
     **       int         field_level_file_flag    : 1;
     **       int         DBCS_capable_flag        : 1;
     **       int         EOF_delay_flag           : 1;
     **
     **       char        requester_dev_name[10];
     **       short       file_open_count;
     **       char        reserved7[2];
     **       short       num_based_pf_mbrs;
     **
     **       int         mult_mbr_process_flag    : 1;
     **       int         join_logical_file_flag   : 1;
     **       int         local_remote_data_flag   : 1;
     **       int         remote_AS400_S38_flag    : 1;
     **       int         sep_indic_area_flag      : 1;
     **       int         user_buffers_flag        : 1;
     **       int                                  : 2;      /* reserved   */
     **       char        reserved8[2];
     **       short       max_rcd_length;
     **       unsigned short  ccsid;
     **       int         null_capable             : 1;
     **       int         varlen_fields_file       : 1;
     **       int         varlen_record_file       : 1;
     **       int         ccsid_sub_char           : 1;
     **       int         reserved9                : 4;
     **       char        reserved10[4];
     **       short       max_pgm_devices;
     **       short       num_pgm_devices;
     **       _XXDEV_LST_T dev_list_array[250];
     **   } _XXOPFB_T;
     **-------------------------------------------------------
     D XXDEV_LST_T     ds           130    based(Template)
     D                                     qualified
     D                                     align
     D  pgm_dev_name...
     D                               10A
     D                               50A
     D  dev_desc_name...
     D                               10A
     D  dev_class...
     D                                1A
     D  dev_type...
     D                                1A
     D  num_rows...
     D                                5I 0
     D  num_columns...
     D                                5I 0
     D  bit_flags_1...
     D                                1A
     D  bit_flags_2...
     D                                1A
     D  sync_level...
     D                                1A
     D  conversation_type...
     D                                1A

     D xxopfb_t        ds                  based(Template)
     D                                     qualified
     D  odp_type                      2A
     D  file_name                    10A
     D  library_name                 10A
     D  spool_file_name...
     D                               10A
     D  spool_lib_name...
     D                               10A
     D  spool_file_num...
     D                                5I 0
     D  pgm_Record_len...
     D                                5I 0
     D                                2A
     D  member_name                  10A
     D                                8A
     D  file_type                     5I 0
     D                                3A
     D  rows                          5I 0
     D  columns                       5I 0
     D  num_records                  10I 0
     D  access_type                   2A
     D  dup_key_indic                 1A
     D  src_file_indic...
     D                                1A
     D                               10A
     D                               10A
     D  vol_label_offset...
     D                                5I 0
     D  max_blocked_recs...
     D                                5I 0
     D  overlow_line_num...
     D                                5I 0
     D  blocked_rec_incr...
     D                                5I 0
     D                                4A
     D  misc_flags                    1A
     D  requester_dev_name...
     D                               10A
     D  file_open_count...
     D                                5I 0
     D                                2A
     D  num_based_pf_mbrs...
     D                                5I 0
     D  oth_flags                     1A
     D                                2A
     D  max_rcd_length...
     D                                5I 0
     D  ccsid                         5U 0
     D  moreflags                     1A
     D                                4A
     D  max_pgm_devices...
     D                                5I 0
     D  num_pgm_devices...
     D                                5I 0
     D  dev_list_array...
     D                                     likeds(XXDEV_LST_T) dim(250)

     **-------------------------------------------------------
     **  Common I-O Feedback Area
     **
     **        typedef _Packed struct _XXIOFB_T {
     **            short       file_dep_fb_offset;
     **            int         write_count;
     **            int         read_count;
     **            int         write_read_count;
     **            int         other_io_count;
     **            char        reserved1;
     **            char        cur_operation;
     **            char        rec_format[10];
     **            char        dev_class[2];
     **            char        dev_name[10];
     **            int         last_io_rec_len;
     **            char        reserved2[80];
     **            short       num_recs_retrieved;
     **            short       last_io_rec_len2;
     **            char        reserved3[2];
     **            int         cur_blk_count;
     **            char        reserved4[8];
     **        } _XXIOFB_T;
     **-------------------------------------------------------
     D XXIOFB_T        ds                  qualified based(Template)
     D   file_dep_fd_offset...
     D                                5i 0
     D   write_count...
     D                               10i 0
     D   read_count...
     D                               10i 0
     D   write_read_count...
     D                               10i 0
     D   other_io_count...
     d                               10i 0
     D   reserved1...
     D                                1a
     D   cur_operation...
     D                                1a
     D   rec_format...
     D                               10a
     D   dev_class...
     D                                2a
     D   dev_name...
     D                               10a
     D   last_io_rec_len...
     D                               10i 0
     D   reserved2...
     D                               80a
     D   num_recs_retrieved...
     D                                5i 0
     D   last_io_rec_len2...
     D                                5i 0
     D   reserved3...
     D                                2a
     D   cur_blk_count...
     D                               10i 0
     D   reserved4...
     D                                8a

      **-------------------------------------------------------
      *  _Rclose -- close an open record file
      *
      *   int _Rclose(_RFILE *fp);
      **-------------------------------------------------------
     D Rclose          PR            10I 0 ExtProc('_Rclose')
     D   fp                                likeds(RFILE_T)


      **-------------------------------------------------------
      *  _Riofbk -- retrieve I/O feedback
      *
      *   _XXIOFB_T *_Riofbk(_RFILE *fp);
      **-------------------------------------------------------
     D Riofbk          PR              *   ExtProc('_Riofbk')
     D   fp                                likeds(RFILE_T)


      **-------------------------------------------------------
      *  _Rdelete -- delete a record from file
      *
      *   _RIOFB_T *_Rdelete(_RFILE *fp);
      **-------------------------------------------------------
     D Rdelete         PR              *   ExtProc('_Rdelete')
     D   fp                                likeds(RFILE_T)


      **-------------------------------------------------------
      * _Rfeod -- Force End Of Data
      *
      * int _Rfeod(_RFILE *fp);
      *
      **-------------------------------------------------------
     D Rfeod           PR            10I 0 ExtProc('_Rfeod')
     D   fp                                likeds(RFILE_T)


      **-------------------------------------------------------
      * _Rlocate -- Position to a record
      *
      * _RIOFB_T *_Rlocate(_RFILE *fp, void *key, int klen_rrn,
      *                    int opts);
      *
      **-------------------------------------------------------
     D Rlocate         PR              *   ExtProc('_Rlocate')
     D   fp                                likeds(RFILE_T)
     D   key                           *   value
     D   klen_rrn                    10I 0 value
     D   opts                        10I 0 value


      **-------------------------------------------------------
      *  _Ropen -- open a record file for processing:
      *
      * _RFILE *_Ropen(const char * filename, const char * mode, ...);
      **-------------------------------------------------------
     D Ropen           PR              *   ExtProc('_Ropen')
     D   filename                      *   value options(*string)
     D   mode                          *   value options(*string)


      **-------------------------------------------------------
      ** _Ropnfbk -- get open feedback information:
      **
      ** _XXOPFB_T *_Ropnfbk(_RFILE *fp);
      **
      **-------------------------------------------------------
     D Ropnfbk         PR              *   ExtProc('_Ropnfbk')
     D   fp                                likeds(RFILE_T)


      **-------------------------------------------------------
      * _Rrlslck -- Release record lock
      *
      * int _Rrlslck(_RFILE *fp);
      *
      **-------------------------------------------------------
     D Rrlslck         PR            10I 0 ExtProc('_Rrlslck')
     D   fp                                likeds(RFILE_T)


      **-------------------------------------------------------
      *  _Rreadk -- read next record in file by key
      *
      *  _RIOFB_T *_Rreadk(_RFILE *fp, void *buf, size_t size,
      *                    int opts, void *key,
      *                    unsigned int keylen);
      **-------------------------------------------------------
     D Rreadk          PR              *   ExtProc('_Rreadk')
     D   fp                                likeds(RFILE_T)
     D   buf                      32767A   options(*varsize: *omit)
     D   buf_size                    10U 0 value
     D   opts                        10I 0 value
     D   key                      32767A   options(*varsize)
     D   keylen                      10U 0 value


      **-------------------------------------------------------
      *  _Rreadn -- read next record in file
      *
      *   _RIOFB_T *_Rreadn (_RFILE *fp, void *buf, size_t size,
      *                      int opts);
      **-------------------------------------------------------
     D Rreadn          PR              *   ExtProc('_Rreadn')
     D   fp                                likeds(RFILE_T)
     D   buf                      32767A   options(*varsize: *omit)
     D   buf_size                    10U 0 value
     D   opts                        10I 0 value


      **-------------------------------------------------------
      *  _Rreadp -- read previous record in file
      *
      *   _RIOFB_T *_Rreadp(_RFILE *fp, void *buf, size_t size,
      *                     int opts);
      **-------------------------------------------------------
     D Rreadp          PR              *   ExtProc('_Rreadp')
     D   fp                                likeds(RFILE_T)
     D   buf                      32767A   options(*varsize: *omit)
     D   buf_size                    10U 0 value
     D   opts                        10I 0 value


      **-------------------------------------------------------
      * _Rupdate -- update record
      *
      * _RIOFB_T *_Rupdate(_RFILE *fp, void *buf, size_t size);
      *
      **-------------------------------------------------------
     D Rupdate         PR              *   ExtProc('_Rupdate')
     D   fp                                likeds(RFILE_T)
     D   buf                      32767A   options(*varsize: *omit)
     D   size                        10U 0 value


      **-------------------------------------------------------
      * _Rwrite -- add new record
      *
      * _RIOFB_T *_Rwrite(_RFILE *fp, void *buf, size_t size);
      *
      **-------------------------------------------------------
     D Rwrite          PR              *   ExtProc('_Rwrite')
     D   fp                                likeds(RFILE_T)
     D   buf                      32767A   options(*varsize: *omit)
     D                                     const
     D   size                        10U 0 value
