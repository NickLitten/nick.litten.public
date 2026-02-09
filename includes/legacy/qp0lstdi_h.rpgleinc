      /if defined(QP0LSTDI_H)
      /eof
      /endif
      /define QP0LSTDI_H

     /*-                                                                            +
      * Copyright (c) 2004-2007 Scott C. Klement                                    +
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

      /include QLG_H

     D Qp0lFID_t       s             16A   based(DataTemplate)
     D Qp0l_objtype_t  s             11A   based(DataTemplate)


      ******************************************************************
      *  Qp0lProcessSubtree() API Object types list                     */
      *
      *   typedef struct                        /*                      */
      *   {                                     /*                      */
      *     uint          Number_Of_Objtypes;   /* Number of object     */
      *                                         /*   types in the list  */
      *    /*qp0l_objtype_t  Objtypes[];*/      /*Variable length entry */
      *                                         /*                      */
      *   } Qp0l_Objtypes_List_t;               /*                      */
      ******************************************************************
     D Qp0l_Objtypes_List_t...
     D                 ds                  based(StructureTemplate)
     D                                     qualified
     D  Number_Of_Objtypes...
     D                               10U 0
     D  Objtypes                     11A   dim(128)


      ******************************************************************
      *  Qp0lProcessSubtree() API IN_EXclusion list type
      *
      *   typedef struct
      *   {
      *     uint       IN_EXclusion_t;          /* Inclusion list or  */
      *                                         /*   exclusion list   */
      *                                         /*   type identifier  */
      *     uint       Number_Of_Pointers;      /* Number of path name*/
      *                                         /*   pointers in the  */
      *                                         /*   inclusion or     */
      *                                         /*   exclusion list   */
      *     char       Reserved[8];             /* Must be zero       */
      *                                         /*                    */
      *                                         /*Variable length entry*/
      *    /*Qlg_Path_Name_T    *Path_Name_Ptrs[];*/
      *
      *   } Qp0l_IN_EXclusion_List_t;
      ******************************************************************
     D Qp0l_IN_EXclusion_List_t...
     D                 ds                  based(StructureTemplate)
     D                                     align
     D                                     qualified
     D   IN_EXclusion_t...
     D                               10U 0
     D   Number_Of_Pointers...
     D                               10U 0
     D   Reserved...
     D                                8a
     D   Path_Name_Ptrs...
     D                                 *   dim(128)


      ******************************************************************
      * Qp0LProcessSubtree() API user function
      *   typedef struct
      *   {
      *     uint       Function_Type;           /* Procedure or program */
      *                                         /*   type flag          */
      *     char       Library[10];             /* Program library      */
      *     char       Program[10];             /* Program name         */
      *     char       Mltthdacn[1];            /* Multithread action   */
      *     char       Reserved[7];             /* must be zero         */
      *     Qp0l_ProcSubtree_t  Procedure;      /* Procedure pointer    */
      *
      *   } Qp0l_User_Function_t;
      ******************************************************************
     D Qp0l_User_Function_t...
     D                 ds                  based(StructureTemplate)
     D                                     align
     D                                     qualified
     D  Function_Type                10U 0
     D  Library                      10A
     D  Program                      10A
     D  MltThdAcn                     1A
     D  Reserved                      7A
     D  Procedure                      *   procptr

      *
      *  The Procedure or Program defined in the structure
      *  above should be compatible with the following prototype:
      *
      *  D MyProc          PR
      *  D  SelStatus                    10U 0
      *  D  ErrValue                     10U 0
      *  D  RtnValue                     10U 0
      *  D  ObjName                            likeds(Qlg_Path_Name_T)
      *  D  FuncCtlBlk                     *   value
      *

      ******************************************************************
      *
      *   typedef struct                        /*                      @A5A*/
      *   {                                     /*                      @A5A*/
      *     char          Checked_Out_Flag;     /* Whether or not object@A5A*/
      *                                         /*   is checked out     @A5A*/
      *     char          User_Name[10];        /* Name of user who has @A5A*/
      *                                         /*   it checked out     @A5A*/
      *     char          Reserved[1];          /* Reserved field.      @A5A*/
      *     uint          Checked_Out_Time;     /* Time, in seconds     @A5A*/
      *                                         /*   since Epoch, when  @A5A*/
      *                                         /*   checked out        @A5A*/
      *   } Qp0l_Checkout_t;                    /*                      @A5A*/
      ******************************************************************
     D Qp0l_Checkout_t...
     D                 ds                  based(StructureTemplate)
     D                                     qualified
     D                                     align
     D  Checked_Out_Flag...
     D                                3U 0
     D  User_Name...
     D                               10A
     D  Reserved...
     D                                1A
     D  Checked_Out_Time...
     D                               10U 0


      ******************************************************************
      * Qp0lGetAttr() API format for general authority information.
      *
      *   typedef struct                        /*                      @A5A*/
      *   {                                     /*                      @A5A*/
      *     char          Object_owner[10];     /* Object owner         @A5A*/
      *     char          Primary_group[10];    /* Primary group        @A5A*/
      *     char          Auth_list_name[10];   /* Authorization list   @A5A*/
      *                                         /* name                 @A5A*/
      *     char          Reserved1[10];        /* (must be zero)       @A5A*/
      *     uint          UserArray_Offset;     /* Offset to Array of   @A5A*/
      *                                         /* users                @A5A*/
      *     uint          Number_of_users;      /* Number of users      @A5A*/
      *     uint          UserEntry_size;       /* Size of user entry   @A5A*/
      *                                         /*   field entry        @A5A*/
      *     char          Reserved2[12];        /* (must be zero)       @A5A*/
      *    /*char        Array_of_Users[];*/    /*Variable length entry @A5A*/
      *                                         /*                      @A5A*/
      *   } Qp0l_Authority_General_t;
      ******************************************************************
     D Qp0l_Authority_General_t...
     D                 ds                  based(StructureTemplate)
     D                                     qualified
     D                                     align
     D   Object_owner...
     D                               10A
     D   Primary_group...
     D                               10A
     D   Auth_list_name...
     D                               10A
     D   Reserved1...
     D                               10A
     D   UserArray_Offset...
     D                               10U 0
     D   Number_of_users...
     D                               10U 0
     D   UserEntry_size...
     D                               10U 0
     D   Reserved2...
     D                               12A
     D   Array_of_Users_Base...
     D                                1A


      ******************************************************************
      *  Qp0lCvtPathToQSYSObjName() API struct for info
      *  returned about the QSYS object name.
      *
      *   typedef struct {                      /*                      @A6A*/
      *       uint Bytes_Returned;              /* # bytes actually     @A6A*/
      *                                         /*   returned to caller @A6A*/
      *       uint Bytes_Available;             /* # bytes total        @A6A*/
      *                                         /*   available          @A6A*/
      *       uint CCSID_Out;                   /* CCSID that names and @A6A*/
      *                                         /*   types returned in  @A6A*/
      *       char Lib_Name[28];                /* Name of library      @A6A*/
      *       char Lib_Type[20];                /* Type of library      @A6A*/
      *       char Obj_Name[28];                /* Name of object       @A6A*/
      *       char Obj_Type[20];                /* Type of object       @A6A*/
      *       char Mbr_Name[28];                /* Name of member       @A6A*/
      *       char Mbr_Type[20];                /* Type of member       @A6A*/
      *       char Asp_Name[28];                /* Name of ASP          @C4A*/
      *   } Qp0l_QSYS_Info_t;                   /*                      @A6A*/
      ******************************************************************
     D Qp0l_QSYS_Info_t...
     D                 DS                  based(StructureTemplate)
     D                                     qualified
     D                                     align
     D  Bytes_Returned...
     D                               10U 0
     D  Bytes_Available...
     D                               10U 0
     D  CCSID_Out...
     D                               10U 0
     D  Lib_Name                     28A
     D  Lib_Type                     20A
     D  Obj_Name                     28A
     D  Obj_Type                     20A
     D  Mbr_Name                     28A
     D  Mbr_Type                     20A
     D  Asp_Name                     28A


      ******************************************************************
      *  Qp0lGetAttr() API format for information returned for users
      *
      *   typedef struct                        /*                      @A5A*/
      *   {                                     /*                      @A5A*/
      *     char          User_name[10];        /* User name            @A5A*/
      *     char          User_data_auth[10];   /* User data authority  @A5A*/
      *     char          OBJMGT_rights[1];     /* Object management    @A5A*/
      *     char          OBJEXIST_rights[1];   /* Object existence auth@A5A*/
      *     char          OBJALTER_rights[1];   /* Object alter         @A5A*/
      *     char          OBJREF_rights[1];     /* Object reference     @A5A*/
      *     char          Reserved1[10];        /* (must be zero)       @A5A*/
      *     char          OBJOPR_DataRights[1]; /* Object operational   @A5A*/
      *     char          READ_DataRights[1];   /* Read                 @A5A*/
      *     char          ADD_DataRights[1];    /* Add                  @A5A*/
      *     char          UPDATE_DataRights[1]; /* Update               @A5A*/
      *     char          DELETE_DataRights[1]; /* Delete               @A5A*/
      *     char          EXECUTE_DataRights[1];/* Execute              @A5A*/
      *     char          EXCLUDE_DataRights[1];/* Exclude              @A5A*/
      *     char          Reserved2[7];         /* (must be zero)       @A5A*/
      *
      *   } Qp0l_Authority_Users_t;             /*                      @A5A*/
      ******************************************************************
     D Qp0l_Authority_Users_t...
     D                 ds                  based(StructureTemplate)
     D                                     qualified
     D                                     align
     D   User_Name...
     D                               10A
     D   User_data_auth...
     D                               10A
     D   OBJMGT_rights...
     D                                1A
     D   OBJEXIST_rights...
     D                                1A
     D   OBJALTER_rights...
     D                                1A
     D   OBJREF_rights...
     D                                1A
     D   Reserved1...
     D                               10A
     D   OBJOPR_DataRights...
     D                                1A
     D   READ_DataRights...
     D                                1A
     D   ADD_DataRights...
     D                                1A
     D   UPDATE_DataRights...
     D                                1A
     D   DELETE_DataRights...
     D                                1A
     D   EXECUTE_DataRights...
     D                                1A
     D   EXCLUDE_DataRights...
     D                                1A
     D   Reserved2...
     D                                7A


      ******************************************************************
      * Qp0lSaveStgFree() API pathnames for Exit programs
      *
      *    typedef struct                        /*                     @A7A*/
      *    {                                     /*                     @A7A*/
      *      uint       Number_Of_Names;         /* Number of path name @A7A*/
      *                                          /*   pointers in the   @A7A*/
      *      char       Reserved[12];            /* (must be zero)      @A7A*/
      *     /*Qlg_Path_Name_T  *Names_Ptrs[];*/  /* Variable length     @A7A*/
      *                                          /*   entry             @A7A*/
      *
      *    } Qp0l_Pathnames_t;                   /*                     @A7A*/
      ******************************************************************
     D Qp0l_Pathnames_t...
     D                 ds                  based(StructureTemplate)
     D                                     qualified
     D                                     align
     D   Number_of_Names...
     D                               10U 0
     D   Reserved...
     D                               12A
     D   Names_Ptrs...
     D                                 *   dim(100)


      ******************************************************************
      *  Qp0lSaveStgFree() API user function
      *
      *   typedef struct                         /*                     @A7A*/
      *   {                                      /*                     @A7A*/
      *     uint                Function_Type;   /* Procedure or        @A7A*/
      *                                          /*   program type      @A7A*/
      *     char                Library[10];     /* Program library     @A7A*/
      *     char                Program[10];     /* Program name        @A7A*/
      *     char                Mltthdacn[1];    /* Multithread action  @B5A*/
      *     char                Reserved[7];     /* must be zero        @B5C*/
      *     Qp0l_SaveStgFree_t  Procedure;       /* Procedure pointer   @A7A*/
      *
      *   } Qp0l_StgFree_Function_t;             /*                     @A7A*/
      ******************************************************************
     D Qp0l_StgFree_Function_t...
     D                 ds                  based(StructureTemplate)
     D                                     qualified
     D                                     align
     D   Function_Type...
     D                               10U 0
     D   Library...
     D                               10A
     D   Program...
     D                               10A
     D   Mltthdacn...
     D                                1A
     D   Reserved...
     D                                7A
     D   Procedure...
     D                                 *   procptr


      ******************************************************************
      * Qp0lGetAttr() API usage information
      *
      *   typedef struct                        /*                      @B2A*/
      *   {                                     /*                      @B2A*/
      *     uint            Reset_date;         /* Date, in seconds     @B2A*/
      *                                         /*  since Epoch, that   @B2A*/
      *                                         /*  the Days_used_count @B2A*/
      *                                         /*  was reset.          @B2A*/
      *     uint            Last_used_date;     /* Date, in seconds     @B2A*/
      *                                         /*  since Epoch, that   @B2A*/
      *                                         /*  the object was most @B2A*/
      *                                         /*  recently used.      @B2A*/
      *     unsigned short  Days_used_count;    /* Count, incremented   @B2A*/
      *                                         /*  once each day, when @B2A*/
      *                                         /*  an object is used.  @B2A*/
      *     char            Reserved[4];        /* (must be zero)       @A5A*/
      *   } Qp0l_Usage_t;                       /*                      @B2A*/
      ******************************************************************
     D Qp0l_Usage_t    ds                  based(StructureTemplate)
     D                                     qualified
     D                                     align
     D   Reset_date...
     D                               10U 0
     D   Last_used_date...
     D                               10U 0
     D   Days_used_count...
     D                                5U 0
     D   Reserved...
     D                                4A


      ******************************************************************
      *  Qp0lGetAttr() API journal information
      *
      *   typedef struct                        /*                      @B6A*/
      *   {                                     /*                      @B6A*/
      *     char          Status;               /* Current journaling   @B6A*/
      *                                         /*  status              @B6A*/
      *     char          Options;              /* Current Options      @B6A*/
      *     char          Journal_Identifier[10]; /*   JID              @B6A*/
      *     char          Journal_Name[10];     /* Current or last      @B6A*/
      *                                         /*  journal name.       @B6A*/
      *     char          Journal_Library[10];  /* Current or last      @B6A*/
      *                                         /*  journal library     @B6A*/
      *                                         /*  name.               @B6A*/
      *     uint          Time_Last_Started;    /* Date and time, in    @B6A*/
      *                                         /*  seconds since Epoch,@B6A*/
      *                                         /*  that journaling was @B6A*/
      *                                         /*  last started on the @B6A*/
      *                                         /*  object.             @B6A*/
      *   } Qp0l_Journal_Info_t;                /*                      @B6A*/
      ******************************************************************
     d Qp0l_Journal_Info_T...
     D                 ds                  based(StructureTemplate)
     D                                     qualified
     D                                     align
     D   Status...
     D                                3U 0
     D   Options...
     D                                3U 0
     D   Journal_Identifier...
     D                               10A
     D   Journal_Name...
     D                               10A
     D   Journal_Library...
     D                               10A
     D   Time_Last_Started...
     D                               10U 0


      ******************************************************************
      *  Format of the "Buffer" parm for Qp0lSetAttr/Qp0lGetAttr APIs.
      *
      *  Note: The size of this structure can vary, and more than one
      *        of these can be returned.  That means you must use
      *        the "Next_Attr_Offset" with pointer logic to read them
      *        all.  I know... YUCK!  Well, welcome to the Qp0l APIs!
      ******************************************************************
     D Qp0l_Attr_Header_t...
     D                 ds                  based(StructureTemplate)
     D                                     align
     D                                     qualified
     D  Next_Attr_Offset...
     D                               10U 0
     D  Attr_ID                      10U 0
     D  Attr_Size                    10I 0
     D  Reserved                      4A
     D  IntData                      10I 0
     D  UnsData                      10U 0 overlay(IntData:1)
     D  CharData                      1A   overlay(IntData:1)


      ******************************************************************
      *  Requested attribute types structure (used by Qp0lGetAttr API)
      ******************************************************************
     D Qp0l_AttrTypes_List_t...
     D                 ds                  based(StructureTemplate)
     D                                     align
     D                                     qualified
     D   Number_Of_ReqAttrs...
     D                               10U 0
     D   AttrTypes...
     D                               10U 0 dim(256)


      ******************************************************************
      *  Attributes:
      ******************************************************************
     D QP0L_ATTR_OBJTYPE...
     D                 C                   0
     D QP0L_ATTR_DATA_SIZE...
     D                 C                   1
     D QP0L_ATTR_ALLOC_SIZE...
     D                 C                   2
     D QP0L_ATTR_EXTENDED_ATTR_SIZE...
     D                 C                   3
     D QP0L_ATTR_CREATE_TIME...
     D                 C                   4
     D QP0L_ATTR_ACCESS_TIME...
     D                 C                   5
     D QP0L_ATTR_CHANGE_TIME...
     D                 C                   6
     D QP0L_ATTR_MODIFY_TIME...
     D                 C                   7
     D QP0L_ATTR_STG_FREE...
     D                 C                   8
     D QP0L_ATTR_CHECKED_OUT...
     D                 C                   9
     D QP0L_ATTR_LOCAL_REMOTE...
     D                 C                   10
     D QP0L_ATTR_AUTH...
     D                 C                   11
     D QP0L_ATTR_FILE_ID...
     D                 C                   12
     D QP0L_ATTR_ASP...
     D                 C                   13
     D QP0L_ATTR_DATA_SIZE_64...
     D                 C                   14
     D QP0L_ATTR_ALLOC_SIZE_64...
     D                 C                   15
     D QP0L_ATTR_USAGE_INFORMATION...
     D                 C                   16
     D QP0L_ATTR_PC_READ_ONLY...
     D                 C                   17
     D QP0L_ATTR_PC_HIDDEN...
     D                 C                   18
     D QP0L_ATTR_PC_SYSTEM...
     D                 C                   19
     D QP0L_ATTR_PC_ARCHIVE...
     D                 C                   20
     D QP0L_ATTR_SYSTEM_ARCHIVE...
     D                 C                   21
     D QP0L_ATTR_CODEPAGE...
     D                 C                   22
     D QP0L_ATTR_FILE_FORMAT...
     D                 C                   23
     D QP0L_ATTR_UDFS_DEFAULT_FORMAT...
     D                 C                   24
     D QP0L_ATTR_JOURNAL_INFORMATION...
     D                 C                   25
     D QP0L_ATTR_ALWCKPWRT...
     D                 C                   26
     D QP0L_ATTR_CCSID...
     D                 C                   27
     D QP0L_ATTR_SIGNED...
     D                 C                   28
     D QP0L_ATTR_SYS_SIGNED...
     D                 C                   29
     D QP0L_ATTR_MULT_SIGS...
     D                 C                   30
     D QP0L_ATTR_DISK_STG_OPT...
     D                 C                   31
     D QP0L_ATTR_MAIN_STG_OPT...
     D                 C                   32
     D QP0L_ATTR_DIR_FORMAT...
     D                 C                   33
     D QP0L_ATTR_AUDIT...
     D                 C                   34
     D QP0L_ATTR_CRTOBJSCAN...
     D                 C                   35
     D QP0L_ATTR_SCAN...
     D                 C                   36
     D QP0L_ATTR_SCAN_INFO...
     D                 C                   37
     D QP0L_ATTR_ALWSAV...
     D                 C                   38
     D QP0L_ATTR_RSTRNMUNL...
     D                 C                   39
     D QP0L_ATTR_JOURNAL_EXTENDED_INFORMATION...
     D                 C                   40
     D QP0L_ATTR_CRTOBJAUD...
     D                 C                   41
     D QP0L_ATTR_SYSTEM_USE...
     D                 C                   42
     D QP0L_ATTR_RESET_DATE...
     D                 C                   200
     D QP0L_ATTR_SUID...
     D                 C                   300
     D QP0L_ATTR_SGID...
     D                 C                   301

      ******************************************************************
      *  flags for "follow_symlink" API parameters:
      ******************************************************************
     D QP0L_DONOT_FOLLOW_SYMLNK...
     D                 C                   0
     D QP0L_FOLLOW_SYMLNK...
     D                 C                   1

      ******************************************************************
      *  Flags for generic "yes/no" parameters
      ******************************************************************
     D QP0L_NO...
     D                 C                   0
     D QP0L_YES...
     D                 C                   1

      ******************************************************************
      * flags for particular attributes:
      ******************************************************************
     D QP0L_SYS_NOT_STG_FREE...
     D                 C                   x'00'
     D QP0L_SYS_STG_FREE...
     D                 C                   x'01'

     D QP0L_PC_NOT_READONLY...
     D                 C                   x'00'
     D QP0L_PC_READONLY...
     D                 C                   x'01'

     D QP0L_PC_NOT_HIDDEN...
     D                 C                   x'00'
     D QP0L_PC_HIDDEN...
     D                 C                   x'01'

     D QP0L_PC_NOT_SYSTEM...
     D                 C                   x'00'
     D QP0L_PC_SYSTEM...
     D                 C                   x'01'

     D QP0L_PC_NOT_CHANGED...
     D                 C                   x'00'
     D QP0L_PC_CHANGED...
     D                 C                   x'01'

     D QP0L_SYSTEM_NOT_CHANGED...
     D                 C                   x'00'
     D QP0L_SYSTEM_CHANGED...
     D                 C                   x'01'

     D QP0L_NOT_ALWCKPWRT...
     D                 C                   x'00'
     D QP0L_ALWCKPWRT...
     D                 C                   x'01'

     D QP0L_STG_NORMAL...
     D                 C                   x'00'
     D QP0L_STG_MINIMIZE...
     D                 C                   x'01'
     D QP0L_STG_DYNAMIC...
     D                 C                   x'02'

     D QP0L_SUID_ON...
     D                 C                   x'00'
     D QP0L_SUID_OFF...
     D                 C                   x'01'

     D QP0L_SGID_ON...
     D                 C                   x'00'
     D QP0L_SGID_OFF...
     D                 C                   x'01'

     D QP0L_NOT_CHECKED_OUT...
     D                 C                   x'00'
     D QP0L_CHECKED_OUT...
     D                 C                   x'01'

     D QP0L_FILE_FORMAT_TYPE1...
     D                 C                   x'00'
     D QP0L_FILE_FORMAT_TYPE2...
     D                 C                   x'01'
     D QP0L_UDFS_DEFAULT_TYPE1...
     D                 C                   x'00'
     D QP0L_UDFS_DEFAULT_TYPE2...
     D                 C                   x'01'

     D QP0L_NOT_SIGNED...
     D                 C                   x'00'
     D QP0L_SIGNED...
     D                 C                   x'01'

     D QP0L_SYSTEM_SIGNED_NO...
     D                 C                   x'00'
     D QP0L_SYSTEM_SIGNED_YES...
     D                 C                   x'01'

     D QP0L_MULT_SIGS_NO...
     D                 C                   x'00'
     D QP0L_MULT_SIGS_YES...
     D                 C                   x'01'

     D QP0L_DIR_FORMAT_TYPE1...
     D                 C                   x'00'
     D QP0L_DIR_FORMAT_TYPE2...
     D                 C                   x'01'

     D QP0L_MLTTHDACN_SYSVAL...
     D                 C                   x'00'
     D QP0L_MLTTHDACN_NOMSG...
     D                 C                   x'01'
     D QP0L_MLTTHDACN_MSG...
     D                 C                   x'02'
     D QP0L_MLTTHDACN_NO...
     D                 C                   x'03'

     D QP0L_NOT_JOURNALED...
     D                 C                   x'00'
     D QP0L_JOURNALED...
     D                 C                   x'00'

     D QP0L_JOURNAL_SUBTREE...
     D                 C                   x'80'
     D QP0L_JOURNAL_BEFORE_IMAGES...
     D                 C                   x'40'
     D QP0L_JOURNAL_AFTER_IMAGES...
     D                 C                   x'20'
     D QP0L_JOURNAL_OPTIONAL_ENTRIES...
     D                 C                   x'08'

     D QP0L_SCAN_NO...
     D                 C                   x'00'
     D QP0L_SCAN_YES...
     D                 C                   x'01'

     D QP0L_SCANNING_NO...
     D                 C                   x'00'
     D QP0L_SCANNING_YES...
     D                 C                   x'01'
     D QP0L_SCANNING_CHGONLY...
     D                 C                   x'02'

     D QP0L_ALWSAV_NO...
     D                 C                   x'00'
     D QP0L_ALWSAV_YES...
     D                 C                   x'01'

     D QP0L_RSTDRNMUNL_OFF...
     D                 C                   x'00'
     D QP0L_RSTDRNMUNL_ON...
     D                 C                   x'01'


      ******************************************************************
      * flags for Qp0lProcessSubtree API:
      ******************************************************************
     D QP0L_USER_FUNCTION_PTR...
     D                 c                   0
     D QP0L_USER_FUNCTION_PGM...
     D                 c                   1

     D QP0L_INCLUSION_TYPE...
     D                 c                   0
     D QP0L_EXCLUSION_TYPE...
     D                 c                   1

     D QP0L_SUBTREE_YES...
     D                 c                   0
     D QP0L_SUBTREE_NO...
     D                 c                   1

     D QP0L_LOCAL_REMOTE_OBJ...
     D                 C                   x'00'
     D QP0L_LOCAL_OBJ...
     D                 C                   x'01'
     D QP0L_REMOTE_OBJ...
     D                 C                   x'02'

     D QP0L_PASS_WITH_ERRORID...
     D                 C                   0
     D QP0L_BYPASS_NO_ERRORID...
     D                 C                   1
     D QP0L_JOBLOG_NO_ERRORID...
     D                 C                   2
     D QP0L_NULLNAME_ERRORID...
     D                 C                   3
     D QP0L_END_PROCESS_SUBTREE...
     D                 C                   4

     D QP0L_SELECT_OK...
     D                 C                   0
     D QP0L_SELECT_DONE...
     D                 C                   1
     D QP0L_SELECT_NOT_OK...
     D                 C                   2
     D QP0L_SELECT_FAILED...
     D                 C                   3

     D QP0L_ALLDIR     C                   CONST('*ALLDIR')
     D QP0L_ALLQSYS    C                   CONST('*ALLQSYS')
     D QP0L_ALLSTMF    C                   CONST('*ALLSTMF')
     D QP0L_MBR        C                   CONST('*MBR')
     D QP0L_NOQSYS     C                   CONST('*NOQSYS')


      ******************************************************************
      *  Qp0lSetAttr():  Set IFS file attributes
      *
      *    int Qp0lSetAttr(Qlg_Path_Name_T *,
      *                      char *,
      *                      uint,
      *                      uint, ...);
      ******************************************************************
     D Qp0lSetAttr     PR            10I 0 ExtProc('Qp0lSetAttr')
     D  Path_Name                          likeds(Qlg_Path_Name_t) const
     D  Buffer                    32767A   options(*varsize)
     D  Buffer_Size                  10U 0 value
     D  Follow_Symlnk                10U 0 value
     D  WhatsThisFor                  1A   options(*nopass)


      ******************************************************************
      * Qp0lGetAttr():  Get IFS File attributes
      *
      *   int Qp0lGetAttr(Qlg_Path_Name_T *,
      *                      Qp0l_AttrTypes_List_t *,
      *                      char *,
      *                      uint,
      *                      uint *,
      *                      uint *,
      *                      uint, ...);
      ******************************************************************
     D Qp0lGetAttr     PR            10I 0 ExtProc('Qp0lGetAttr')
     D  Path_Name                          likeds(Qlg_Path_Name_t) const
     D  Attr_Array                         likeds(Qp0l_AttrTypes_List_t)
     D  Buffer                         *   value
     D  Buffer_Size                  10U 0 value
     D  Buf_Size_Need                10U 0
     D  Bytes_Returnd                10U 0
     D  Follow_Symlnk                10U 0 value
     D  WhatsThisFor                  1A   options(*nopass)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * Rename File, Unlink new file if it already exists.
      *
      *   int Qp0lRenameUnlink(const char *, const char *);
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Qp0lRenameUnlink...
     D                 PR            10I 0 extproc('Qp0lRenameUnlink')
     D   old                           *   value options(*string)
     D   new                           *   value options(*string)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *  Rename File. If another file with new name exists, keep the
      *    original names and return an error.
      *
      *  int Qp0lRenameKeep(const char *, const char *);
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Qp0lRenameKeep...
     D                 PR            10I 0 extproc('Qp0lRenameKeep')
     D   old                           *   value options(*string)
     D   new                           *   value options(*string)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *  Get IFS path from File ID
      *
      *   char *Qp0lGetPathFromFileID(char *, size_t, Qp0lFID_t)            ;
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Qp0lGetPathFromFileID...
     D                 pr              *   extproc('Qp0lGetPathFromFileID')
     D   buf                      32767A   options(*varsize)
     D   size                        10U 0 value
     D   fileid                            like(Qp0lFID_t) const


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *  Call back for all objects in a subtree below a given pathname
      *
      *  int Qp0lProcessSubtree(Qlg_Path_Name_T *,
      *                   uint,
      *                   Qp0l_Objtypes_List_t *,
      *                   uint,
      *                   Qp0l_IN_EXclusion_List_t *,
      *                   uint,
      *                   Qp0l_User_Function_t *,
      *                   void *, ...);
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Qp0lProcessSubtree...
     D                 PR            10I 0 ExtProc('Qp0lProcessSubtree')
     D   Path_Name                         likeds(Qlg_Path_Name_t)
     D                                     options(*omit)
     D   Subtree_lvl                 10U 0 value
     D   ObjTypes                          likeds(Qp0l_ObjTypes_List_t)
     D                                     options(*omit)
     D   Local_remote                10U 0 value
     D   IN_EX_List                        likeds(Qp0l_IN_EXclusion_List_t)
     D                                     options(*omit)
     D   Err_action                  10U 0 value
     D   User_Funct                        likeds(Qp0l_User_Function_t)
     D   User_CtlBlk                   *   value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *  Convert IFS path to QSYS object name
      *
      *    void Qp0lCvtPathToQSYSObjName(
      *                      Qlg_Path_Name_T *,
      *                      void *,
      *                      char [8],
      *                      uint,
      *                      uint,
      *                      void *);
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Qp0lCvtPathToQSYSObjName...
     D                 PR                  extproc('Qp0lCvtPathToQSYSObjName')
     D   path_name                         likeds(Qlg_Path_Name_t)
     D   qsys_info                32767A   options(*varsize)
     D   format_name                  8A   const
     D   bytes_prov                  10U 0 value
     D   CCSID                       10U 0 value
     D   error_code                8192A   options(*varsize)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *  Save Storage Free
      *
      *    int Qp0lSaveStgFree(Qlg_Path_Name_T *,
      *                             Qp0l_StgFree_Function_t *,
      *                             void *);
      *
      *  This calls a user-defined function which is intended to be
      *  user to save the storage for a stream file to an off-line
      *  location.  It then deletes the data portion of the stream
      *  file, but keeps pathnames, attributes, etc intact.
      *
      *  When a user requests access to this stream file again, the
      *  system will call a program at the QIBM_QTA_STOR_EX400 exit
      *  point to restore the data.
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Qp0lSaveStgFree...
     D                 PR            10I 0 extproc('Qp0lSaveStgFree')
     D   path_name                         likeds(Qlg_Path_Name_t)
     D   UserFunction                  *   value procptr
     D   User_CtlBlk                   *   value procptr


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *  int Qp0lOpen(Qlg_Path_Name_T *, int, ...);
      *
      *   This is the same as open() as defined in IFSIO_H, except
      *   that it uses the Qlg_Path_Name_t structure for the pathname
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Qp0lOpen        PR            10I 0 ExtProc('Qp0lOpen')
     D  pathname                           likeds(Qlg_Path_Name_t)
     D  openflags                    10I 0 value
     D  mode                         10U 0 value options(*nopass)
     D  codepage                     10U 0 value options(*nopass)
     D/if defined(*V5R2M0)
     D  txtcreatid                   10U 0 value options(*nopass)
     D/endif


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *  int Qp0lUnlink(Qlg_Path_Name_T *);
      *
      *   This is the same as unlink() as defined in IFSIO_H, except
      *   that it uses the Qlg_Path_Name_t structure for the pathname
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Qp0lUnlink      PR            10I 0 ExtProc('Qp0lUnlink')
     D  pathname                           likeds(Qlg_Path_Name_t)
