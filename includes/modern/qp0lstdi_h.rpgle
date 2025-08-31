        /if defined(QP0LSTDI_H)
        /eof
        /endif
        /define QP0LSTDI_H

          // -
          //  Copyright (c) 2004-2007 Scott C. Klement
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

        /include QLG_H

         dcl-s Qp0lFID_t char(16)  based(DataTemplate);
         dcl-s Qp0l_objtype_t char(11)  based(DataTemplate);


          // *****************************************************************
          //   Qp0lProcessSubtree() API Object types list                     */

          //    typedef struct                        /*                      */
          //    {                                     /*                      */
          //      uint          Number_Of_Objtypes;   /* Number of object     */
          //                                          /*   types in the list  */
          //     /*qp0l_objtype_t  Objtypes[];*/      /*Variable length entry */
          //                                          /*                      */
          //    } Qp0l_Objtypes_List_t;               /*                      */
          // *****************************************************************
         dcl-ds Qp0l_Objtypes_List_t INZ based(StructureTemplate) qualified;
         Number_Of_ObjtypesObjtypes uns(10) dim(128);
         end-ds Qp0l_Objtypes_List_t;


          // *****************************************************************
          //   Qp0lProcessSubtree() API IN_EXclusion list type

          //    typedef struct
          //    {
          //      uint       IN_EXclusion_t;          /* Inclusion list or  */
          //                                          /*   exclusion list   */
          //                                          /*   type identifier  */
          //      uint       Number_Of_Pointers;      /* Number of path name*/
          //                                          /*   pointers in the  */
          //                                          /*   inclusion or     */
          //                                          /*   exclusion list   */
          //      char       Reserved[8];             /* Must be zero       */
          //                                          /*                    */
          //                                          /*Variable length entry*/
          //     /*Qlg_Path_Name_T    *Path_Name_Ptrs[];*/

          //    } Qp0l_IN_EXclusion_List_t;
          // *****************************************************************
         dcl-ds Qp0l_IN_EXclusion_List_t INZ based(StructureTemplate) align
           qualified;
         IN_EXclusion_tNumber_Of_PointersReservedPath_Name_Ptrs uns(10) dim(128
           );
         end-ds Qp0l_IN_EXclusion_List_t;


          // *****************************************************************
          //  Qp0LProcessSubtree() API user function
          //    typedef struct
          //    {
          //      uint       Function_Type;           /* Procedure or program */
          //                                          /*   type flag          */
          //      char       Library[10];             /* Program library      */
          //      char       Program[10];             /* Program name         */
          //      char       Mltthdacn[1];            /* Multithread action   */
          //      char       Reserved[7];             /* must be zero         */
          //      Qp0l_ProcSubtree_t  Procedure;      /* Procedure pointer    */

          //    } Qp0l_User_Function_t;
          // *****************************************************************
         dcl-ds Qp0l_User_Function_t INZ based(StructureTemplate) align
           qualified;
         Function_Type uns(10);
         Library char(10);
         Program char(10);
         MltThdAcn char(1);
         Reserved char(7);
         Procedure pointer procptr;
         end-ds Qp0l_User_Function_t;


          //   The Procedure or Program defined in the structure
          //   above should be compatible with the following prototype:

          //   D MyProc          PR
          //   D  SelStatus                    10U 0
          //   D  ErrValue                     10U 0
          //   D  RtnValue                     10U 0
          //   D  ObjName                            likeds(Qlg_Path_Name_T)
          //   D  FuncCtlBlk                     *   value


          // *****************************************************************

          //    typedef struct                        /*                      @A5A*/
          //    {                                     /*                      @A5A*/
          //      char          Checked_Out_Flag;     /* Whether or not object@A5A*/
          //                                          /*   is checked out     @A5A*/
          //      char          User_Name[10];        /* Name of user who has @A5A*/
          //                                          /*   it checked out     @A5A*/
          //      char          Reserved[1];          /* Reserved field.      @A5A*/
          //      uint          Checked_Out_Time;     /* Time, in seconds     @A5A*/
          //                                          /*   since Epoch, when  @A5A*/
          //                                          /*   checked out        @A5A*/
          //    } Qp0l_Checkout_t;                    /*                      @A5A*/
          // *****************************************************************
         dcl-ds Qp0l_Checkout_t INZ based(StructureTemplate) qualified align;
         Checked_Out_FlagUser_NameReservedChecked_Out_Time uns(3);
         end-ds Qp0l_Checkout_t;


          // *****************************************************************
          //  Qp0lGetAttr() API format for general authority information.

          //    typedef struct                        /*                      @A5A*/
          //    {                                     /*                      @A5A*/
          //      char          Object_owner[10];     /* Object owner         @A5A*/
          //      char          Primary_group[10];    /* Primary group        @A5A*/
          //      char          Auth_list_name[10];   /* Authorization list   @A5A*/
          //                                          /* name                 @A5A*/
          //      char          Reserved1[10];        /* (must be zero)       @A5A*/
          //      uint          UserArray_Offset;     /* Offset to Array of   @A5A*/
          //                                          /* users                @A5A*/
          //      uint          Number_of_users;      /* Number of users      @A5A*/
          //      uint          UserEntry_size;       /* Size of user entry   @A5A*/
          //                                          /*   field entry        @A5A*/
          //      char          Reserved2[12];        /* (must be zero)       @A5A*/
          //     /*char        Array_of_Users[];*/    /*Variable length entry @A5A*/
          //                                          /*                      @A5A*/
          //    } Qp0l_Authority_General_t;
          // *****************************************************************
         dcl-ds Qp0l_Authority_General_t INZ based(StructureTemplate) qualified
           align;
         Object_ownerPrimary_groupAuth_list_nameReserved1UserArray_Offs...
         end-ds Qp0l_Authority_General_t;
           etNumber_of_usersUserEntry_sizeReserved2Array_of_Users_Basechar(10);


          // *****************************************************************
          //   Qp0lCvtPathToQSYSObjName() API struct for info
          //   returned about the QSYS object name.

          //    typedef struct {                      /*                      @A6A*/
          //        uint Bytes_Returned;              /* # bytes actually     @A6A*/
          //                                          /*   returned to caller @A6A*/
          //        uint Bytes_Available;             /* # bytes total        @A6A*/
          //                                          /*   available          @A6A*/
          //        uint CCSID_Out;                   /* CCSID that names and @A6A*/
          //                                          /*   types returned in  @A6A*/
          //        char Lib_Name[28];                /* Name of library      @A6A*/
          //        char Lib_Type[20];                /* Type of library      @A6A*/
          //        char Obj_Name[28];                /* Name of object       @A6A*/
          //        char Obj_Type[20];                /* Type of object       @A6A*/
          //        char Mbr_Name[28];                /* Name of member       @A6A*/
          //        char Mbr_Type[20];                /* Type of member       @A6A*/
          //        char Asp_Name[28];                /* Name of ASP          @C4A*/
          //    } Qp0l_QSYS_Info_t;                   /*                      @A6A*/
          // *****************************************************************
         dcl-ds Qp0l_QSYS_Info_t INZ based(StructureTemplate) qualified align;
         Bytes_ReturnedBytes_AvailableCCSID_OutLib_Name uns(10);
         Lib_Type char(20);
         Obj_Name char(28);
         Obj_Type char(20);
         Mbr_Name char(28);
         Mbr_Type char(20);
         Asp_Name char(28);
         end-ds Qp0l_QSYS_Info_t;


          // *****************************************************************
          //   Qp0lGetAttr() API format for information returned for users

          //    typedef struct                        /*                      @A5A*/
          //    {                                     /*                      @A5A*/
          //      char          User_name[10];        /* User name            @A5A*/
          //      char          User_data_auth[10];   /* User data authority  @A5A*/
          //      char          OBJMGT_rights[1];     /* Object management    @A5A*/
          //      char          OBJEXIST_rights[1];   /* Object existence auth@A5A*/
          //      char          OBJALTER_rights[1];   /* Object alter         @A5A*/
          //      char          OBJREF_rights[1];     /* Object reference     @A5A*/
          //      char          Reserved1[10];        /* (must be zero)       @A5A*/
          //      char          OBJOPR_DataRights[1]; /* Object operational   @A5A*/
          //      char          READ_DataRights[1];   /* Read                 @A5A*/
          //      char          ADD_DataRights[1];    /* Add                  @A5A*/
          //      char          UPDATE_DataRights[1]; /* Update               @A5A*/
          //      char          DELETE_DataRights[1]; /* Delete               @A5A*/
          //      char          EXECUTE_DataRights[1];/* Execute              @A5A*/
          //      char          EXCLUDE_DataRights[1];/* Exclude              @A5A*/
          //      char          Reserved2[7];         /* (must be zero)       @A5A*/

          //    } Qp0l_Authority_Users_t;             /*                      @A5A*/
          // *****************************************************************
         dcl-ds Qp0l_Authority_Users_t INZ based(StructureTemplate) qualified
           align;
         User_NameUser_data_authOBJMGT_rightsOBJEXIST_rightsOBJALTER_ri...
           ghtsOBJREF_rightsReserved1OBJOPR_DataRightsREAD_DataRightsADD_...
           DataRightsUPDATE_DataRightsDELETE_DataRightsEXECUTE_DataRights...
         end-ds Qp0l_Authority_Users_t;
           EXCLUDE_DataRightsReserved2char(10);


          // *****************************************************************
          //  Qp0lSaveStgFree() API pathnames for Exit programs

          //     typedef struct                        /*                     @A7A*/
          //     {                                     /*                     @A7A*/
          //       uint       Number_Of_Names;         /* Number of path name @A7A*/
          //                                           /*   pointers in the   @A7A*/
          //       char       Reserved[12];            /* (must be zero)      @A7A*/
          //      /*Qlg_Path_Name_T  *Names_Ptrs[];*/  /* Variable length     @A7A*/
          //                                           /*   entry             @A7A*/

          //     } Qp0l_Pathnames_t;                   /*                     @A7A*/
          // *****************************************************************
         dcl-ds Qp0l_Pathnames_t INZ based(StructureTemplate) qualified align;
         Number_of_NamesReservedNames_Ptrs uns(10) dim(100);
         end-ds Qp0l_Pathnames_t;


          // *****************************************************************
          //   Qp0lSaveStgFree() API user function

          //    typedef struct                         /*                     @A7A*/
          //    {                                      /*                     @A7A*/
          //      uint                Function_Type;   /* Procedure or        @A7A*/
          //                                           /*   program type      @A7A*/
          //      char                Library[10];     /* Program library     @A7A*/
          //      char                Program[10];     /* Program name        @A7A*/
          //      char                Mltthdacn[1];    /* Multithread action  @B5A*/
          //      char                Reserved[7];     /* must be zero        @B5C*/
          //      Qp0l_SaveStgFree_t  Procedure;       /* Procedure pointer   @A7A*/

          //    } Qp0l_StgFree_Function_t;             /*                     @A7A*/
          // *****************************************************************
         dcl-ds Qp0l_StgFree_Function_t INZ based(StructureTemplate) qualified
           align;
         Function_TypeLibraryProgramMltthdacnReservedProcedure uns(10) procptr;
         end-ds Qp0l_StgFree_Function_t;


          // *****************************************************************
          //  Qp0lGetAttr() API usage information

          //    typedef struct                        /*                      @B2A*/
          //    {                                     /*                      @B2A*/
          //      uint            Reset_date;         /* Date, in seconds     @B2A*/
          //                                          /*  since Epoch, that   @B2A*/
          //                                          /*  the Days_used_count @B2A*/
          //                                          /*  was reset.          @B2A*/
          //      uint            Last_used_date;     /* Date, in seconds     @B2A*/
          //                                          /*  since Epoch, that   @B2A*/
          //                                          /*  the object was most @B2A*/
          //                                          /*  recently used.      @B2A*/
          //      unsigned short  Days_used_count;    /* Count, incremented   @B2A*/
          //                                          /*  once each day, when @B2A*/
          //                                          /*  an object is used.  @B2A*/
          //      char            Reserved[4];        /* (must be zero)       @A5A*/
          //    } Qp0l_Usage_t;                       /*                      @B2A*/
          // *****************************************************************
         dcl-ds Qp0l_Usage_t INZ based(StructureTemplate) qualified align;
         Reset_dateLast_used_dateDays_used_countReserved uns(10);
         end-ds Qp0l_Usage_t;


          // *****************************************************************
          //   Qp0lGetAttr() API journal information

          //    typedef struct                        /*                      @B6A*/
          //    {                                     /*                      @B6A*/
          //      char          Status;               /* Current journaling   @B6A*/
          //                                          /*  status              @B6A*/
          //      char          Options;              /* Current Options      @B6A*/
          //      char          Journal_Identifier[10]; /*   JID              @B6A*/
          //      char          Journal_Name[10];     /* Current or last      @B6A*/
          //                                          /*  journal name.       @B6A*/
          //      char          Journal_Library[10];  /* Current or last      @B6A*/
          //                                          /*  journal library     @B6A*/
          //                                          /*  name.               @B6A*/
          //      uint          Time_Last_Started;    /* Date and time, in    @B6A*/
          //                                          /*  seconds since Epoch,@B6A*/
          //                                          /*  that journaling was @B6A*/
          //                                          /*  last started on the @B6A*/
          //                                          /*  object.             @B6A*/
          //    } Qp0l_Journal_Info_t;                /*                      @B6A*/
          // *****************************************************************
         dcl-ds Qp0l_Journal_Info_T INZ based(StructureTemplate) qualified
           align;
         StatusOptionsJournal_IdentifierJournal_NameJournal_LibraryTime...
         end-ds Qp0l_Journal_Info_T;
           _Last_Starteduns(3);


          // *****************************************************************
          //   Format of the "Buffer" parm for Qp0lSetAttr/Qp0lGetAttr APIs.

          //   Note: The size of this structure can vary, and more than one
          //         of these can be returned.  That means you must use
          //         the "Next_Attr_Offset" with pointer logic to read them
          //         all.  I know... YUCK!  Well, welcome to the Qp0l APIs!
          // *****************************************************************
         dcl-ds Qp0l_Attr_Header_t INZ based(StructureTemplate) align qualified
           ;
         Next_Attr_OffsetAttr_ID uns(10);
         Attr_Size int(10);
         Reserved char(4);
         IntData int(10);
         UnsData uns(10) overlay(IntData:1);
         CharData char(1) overlay(IntData:1);
         end-ds Qp0l_Attr_Header_t;


          // *****************************************************************
          //   Requested attribute types structure (used by Qp0lGetAttr API)
          // *****************************************************************
         dcl-ds Qp0l_AttrTypes_List_t INZ based(StructureTemplate) align
           qualified;
         Number_Of_ReqAttrsAttrTypes uns(10) dim(256);
         end-ds Qp0l_AttrTypes_List_t;


          // *****************************************************************
          //   Attributes:
          // *****************************************************************
         dcl-c QP0L_ATTR_OBJTYPE 0;
         dcl-c QP0L_ATTR_DATA_SIZE 1;
         dcl-c QP0L_ATTR_ALLOC_SIZE 2;
         dcl-c QP0L_ATTR_EXTENDED_ATTR_SIZE 3;
         dcl-c QP0L_ATTR_CREATE_TIME 4;
         dcl-c QP0L_ATTR_ACCESS_TIME 5;
         dcl-c QP0L_ATTR_CHANGE_TIME 6;
         dcl-c QP0L_ATTR_MODIFY_TIME 7;
         dcl-c QP0L_ATTR_STG_FREE 8;
         dcl-c QP0L_ATTR_CHECKED_OUT 9;
         dcl-c QP0L_ATTR_LOCAL_REMOTE 10;
         dcl-c QP0L_ATTR_AUTH 11;
         dcl-c QP0L_ATTR_FILE_ID 12;
         dcl-c QP0L_ATTR_ASP 13;
         dcl-c QP0L_ATTR_DATA_SIZE_64 14;
         dcl-c QP0L_ATTR_ALLOC_SIZE_64 15;
         dcl-c QP0L_ATTR_USAGE_INFORMATION 16;
         dcl-c QP0L_ATTR_PC_READ_ONLY 17;
         dcl-c QP0L_ATTR_PC_HIDDEN 18;
         dcl-c QP0L_ATTR_PC_SYSTEM 19;
         dcl-c QP0L_ATTR_PC_ARCHIVE 20;
         dcl-c QP0L_ATTR_SYSTEM_ARCHIVE 21;
         dcl-c QP0L_ATTR_CODEPAGE 22;
         dcl-c QP0L_ATTR_FILE_FORMAT 23;
         dcl-c QP0L_ATTR_UDFS_DEFAULT_FORMAT 24;
         dcl-c QP0L_ATTR_JOURNAL_INFORMATION 25;
         dcl-c QP0L_ATTR_ALWCKPWRT 26;
         dcl-c QP0L_ATTR_CCSID 27;
         dcl-c QP0L_ATTR_SIGNED 28;
         dcl-c QP0L_ATTR_SYS_SIGNED 29;
         dcl-c QP0L_ATTR_MULT_SIGS 30;
         dcl-c QP0L_ATTR_DISK_STG_OPT 31;
         dcl-c QP0L_ATTR_MAIN_STG_OPT 32;
         dcl-c QP0L_ATTR_DIR_FORMAT 33;
         dcl-c QP0L_ATTR_AUDIT 34;
         dcl-c QP0L_ATTR_CRTOBJSCAN 35;
         dcl-c QP0L_ATTR_SCAN 36;
         dcl-c QP0L_ATTR_SCAN_INFO 37;
         dcl-c QP0L_ATTR_ALWSAV 38;
         dcl-c QP0L_ATTR_RSTRNMUNL 39;
         dcl-c QP0L_ATTR_JOURNAL_EXTENDED_INFORMATION 40;
         dcl-c QP0L_ATTR_CRTOBJAUD 41;
         dcl-c QP0L_ATTR_SYSTEM_USE 42;
         dcl-c QP0L_ATTR_RESET_DATE 200;
         dcl-c QP0L_ATTR_SUID 300;
         dcl-c QP0L_ATTR_SGID 301;

          // *****************************************************************
          //   flags for "follow_symlink" API parameters:
          // *****************************************************************
         dcl-c QP0L_DONOT_FOLLOW_SYMLNK 0;
         dcl-c QP0L_FOLLOW_SYMLNK 1;

          // *****************************************************************
          //   Flags for generic "yes/no" parameters
          // *****************************************************************
         dcl-c QP0L_NO 0;
         dcl-c QP0L_YES 1;

          // *****************************************************************
          //  flags for particular attributes:
          // *****************************************************************
         dcl-c QP0L_SYS_NOT_STG_FREE x'00';
         dcl-c QP0L_SYS_STG_FREE x'01';

         dcl-c QP0L_PC_NOT_READONLY x'00';
         dcl-c QP0L_PC_READONLY x'01';

         dcl-c QP0L_PC_NOT_HIDDEN x'00';
         dcl-c QP0L_PC_HIDDEN x'01';

         dcl-c QP0L_PC_NOT_SYSTEM x'00';
         dcl-c QP0L_PC_SYSTEM x'01';

         dcl-c QP0L_PC_NOT_CHANGED x'00';
         dcl-c QP0L_PC_CHANGED x'01';

         dcl-c QP0L_SYSTEM_NOT_CHANGED x'00';
         dcl-c QP0L_SYSTEM_CHANGED x'01';

         dcl-c QP0L_NOT_ALWCKPWRT x'00';
         dcl-c QP0L_ALWCKPWRT x'01';

         dcl-c QP0L_STG_NORMAL x'00';
         dcl-c QP0L_STG_MINIMIZE x'01';
         dcl-c QP0L_STG_DYNAMIC x'02';

         dcl-c QP0L_SUID_ON x'00';
         dcl-c QP0L_SUID_OFF x'01';

         dcl-c QP0L_SGID_ON x'00';
         dcl-c QP0L_SGID_OFF x'01';

         dcl-c QP0L_NOT_CHECKED_OUT x'00';
         dcl-c QP0L_CHECKED_OUT x'01';

         dcl-c QP0L_FILE_FORMAT_TYPE1 x'00';
         dcl-c QP0L_FILE_FORMAT_TYPE2 x'01';
         dcl-c QP0L_UDFS_DEFAULT_TYPE1 x'00';
         dcl-c QP0L_UDFS_DEFAULT_TYPE2 x'01';

         dcl-c QP0L_NOT_SIGNED x'00';
         dcl-c QP0L_SIGNED x'01';

         dcl-c QP0L_SYSTEM_SIGNED_NO x'00';
         dcl-c QP0L_SYSTEM_SIGNED_YES x'01';

         dcl-c QP0L_MULT_SIGS_NO x'00';
         dcl-c QP0L_MULT_SIGS_YES x'01';

         dcl-c QP0L_DIR_FORMAT_TYPE1 x'00';
         dcl-c QP0L_DIR_FORMAT_TYPE2 x'01';

         dcl-c QP0L_MLTTHDACN_SYSVAL x'00';
         dcl-c QP0L_MLTTHDACN_NOMSG x'01';
         dcl-c QP0L_MLTTHDACN_MSG x'02';
         dcl-c QP0L_MLTTHDACN_NO x'03';

         dcl-c QP0L_NOT_JOURNALED x'00';
         dcl-c QP0L_JOURNALED x'00';

         dcl-c QP0L_JOURNAL_SUBTREE x'80';
         dcl-c QP0L_JOURNAL_BEFORE_IMAGES x'40';
         dcl-c QP0L_JOURNAL_AFTER_IMAGES x'20';
         dcl-c QP0L_JOURNAL_OPTIONAL_ENTRIES x'08';

         dcl-c QP0L_SCAN_NO x'00';
         dcl-c QP0L_SCAN_YES x'01';

         dcl-c QP0L_SCANNING_NO x'00';
         dcl-c QP0L_SCANNING_YES x'01';
         dcl-c QP0L_SCANNING_CHGONLY x'02';

         dcl-c QP0L_ALWSAV_NO x'00';
         dcl-c QP0L_ALWSAV_YES x'01';

         dcl-c QP0L_RSTDRNMUNL_OFF x'00';
         dcl-c QP0L_RSTDRNMUNL_ON x'01';


          // *****************************************************************
          //  flags for Qp0lProcessSubtree API:
          // *****************************************************************
         dcl-c QP0L_USER_FUNCTION_PTR 0;
         dcl-c QP0L_USER_FUNCTION_PGM 1;

         dcl-c QP0L_INCLUSION_TYPE 0;
         dcl-c QP0L_EXCLUSION_TYPE 1;

         dcl-c QP0L_SUBTREE_YES 0;
         dcl-c QP0L_SUBTREE_NO 1;

         dcl-c QP0L_LOCAL_REMOTE_OBJ x'00';
         dcl-c QP0L_LOCAL_OBJ x'01';
         dcl-c QP0L_REMOTE_OBJ x'02';

         dcl-c QP0L_PASS_WITH_ERRORID 0;
         dcl-c QP0L_BYPASS_NO_ERRORID 1;
         dcl-c QP0L_JOBLOG_NO_ERRORID 2;
         dcl-c QP0L_NULLNAME_ERRORID 3;
         dcl-c QP0L_END_PROCESS_SUBTREE 4;

         dcl-c QP0L_SELECT_OK 0;
         dcl-c QP0L_SELECT_DONE 1;
         dcl-c QP0L_SELECT_NOT_OK 2;
         dcl-c QP0L_SELECT_FAILED 3;

         dcl-c QP0L_ALLDIR CONST('*ALLDIR');
         dcl-c QP0L_ALLQSYS CONST('*ALLQSYS');
         dcl-c QP0L_ALLSTMF CONST('*ALLSTMF');
         dcl-c QP0L_MBR CONST('*MBR');
         dcl-c QP0L_NOQSYS CONST('*NOQSYS');


          // *****************************************************************
          //   Qp0lSetAttr():  Set IFS file attributes

          //     int Qp0lSetAttr(Qlg_Path_Name_T *,
          //                       char *,
          //                       uint,
          //                       uint, ...);
          // *****************************************************************
         dcl-pr Qp0lSetAttr int(10) ExtProc('Qp0lSetAttr');
         Path_Name  likeds(Qlg_Path_Name_t) const;
         Buffer char(32767) options(*varsize);
         Buffer_Size uns(10) value;
         Follow_Symlnk uns(10) value;
         WhatsThisFor char(1) options(*nopass);
         end-pr Qp0lSetAttr;


          // *****************************************************************
          //  Qp0lGetAttr():  Get IFS File attributes

          //    int Qp0lGetAttr(Qlg_Path_Name_T *,
          //                       Qp0l_AttrTypes_List_t *,
          //                       char *,
          //                       uint,
          //                       uint *,
          //                       uint *,
          //                       uint, ...);
          // *****************************************************************
         dcl-pr Qp0lGetAttr int(10) ExtProc('Qp0lGetAttr');
         Path_Name  likeds(Qlg_Path_Name_t) const;
         Attr_Array  likeds(Qp0l_AttrTypes_List_t);
         Buffer pointer value;
         Buffer_Size uns(10) value;
         Buf_Size_Need uns(10);
         Bytes_Returnd uns(10);
         Follow_Symlnk uns(10) value;
         WhatsThisFor char(1) options(*nopass);
         end-pr Qp0lGetAttr;

          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //  Rename File, Unlink new file if it already exists.

          //    int Qp0lRenameUnlink(const char *, const char *);
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr Qp0lRenameUnlink int(10) extproc('Qp0lRenameUnlink');
         old pointer value options(*string);
         new pointer value options(*string);
         end-pr Qp0lRenameUnlink;

          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //   Rename File. If another file with new name exists, keep the
          //     original names and return an error.

          //   int Qp0lRenameKeep(const char *, const char *);
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr Qp0lRenameKeep int(10) extproc('Qp0lRenameKeep');
         old pointer value options(*string);
         new pointer value options(*string);
         end-pr Qp0lRenameKeep;

          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //   Get IFS path from File ID

          //    char *Qp0lGetPathFromFileID(char *, size_t, Qp0lFID_t)            ;
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr Qp0lGetPathFromFileID pointer extproc(
           'Qp0lGetPathFromFileID');
         buf char(32767) options(*varsize);
         size uns(10) value;
         fileid  like(Qp0lFID_t) const;
         end-pr Qp0lGetPathFromFileID;


          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //   Call back for all objects in a subtree below a given pathname

          //   int Qp0lProcessSubtree(Qlg_Path_Name_T *,
          //                    uint,
          //                    Qp0l_Objtypes_List_t *,
          //                    uint,
          //                    Qp0l_IN_EXclusion_List_t *,
          //                    uint,
          //                    Qp0l_User_Function_t *,
          //                    void *, ...);
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr Qp0lProcessSubtree int(10) ExtProc('Qp0lProcessSubtree');
         Path_Name  likeds(Qlg_Path_Name_t) options(*omit);
         Subtree_lvl uns(10) value;
         ObjTypes  likeds(Qp0l_ObjTypes_List_t) options(*omit);
         Local_remote uns(10) value;
         IN_EX_List  likeds(Qp0l_IN_EXclusion_List_t) options(*omit);
         Err_action uns(10) value;
         User_Funct  likeds(Qp0l_User_Function_t);
         User_CtlBlk pointer value;
         end-pr Qp0lProcessSubtree;


          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //   Convert IFS path to QSYS object name

          //     void Qp0lCvtPathToQSYSObjName(
          //                       Qlg_Path_Name_T *,
          //                       void *,
          //                       char [8],
          //                       uint,
          //                       uint,
          //                       void *);
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr Qp0lCvtPathToQSYSObjName  extproc('Qp0lCvtPathToQSYSObjName');
         path_name  likeds(Qlg_Path_Name_t);
         qsys_info char(32767) options(*varsize);
         format_name char(8) const;
         bytes_prov uns(10) value;
         CCSID uns(10) value;
         error_code char(8192) options(*varsize);
         end-pr Qp0lCvtPathToQSYSObjName;

          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //   Save Storage Free

          //     int Qp0lSaveStgFree(Qlg_Path_Name_T *,
          //                              Qp0l_StgFree_Function_t *,
          //                              void *);

          //   This calls a user-defined function which is intended to be
          //   user to save the storage for a stream file to an off-line
          //   location.  It then deletes the data portion of the stream
          //   file, but keeps pathnames, attributes, etc intact.

          //   When a user requests access to this stream file again, the
          //   system will call a program at the QIBM_QTA_STOR_EX400 exit
          //   point to restore the data.
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr Qp0lSaveStgFree int(10) extproc('Qp0lSaveStgFree');
         path_name  likeds(Qlg_Path_Name_t);
         UserFunction pointer value procptr;
         User_CtlBlk pointer value procptr;
         end-pr Qp0lSaveStgFree;


          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //   int Qp0lOpen(Qlg_Path_Name_T *, int, ...);

          //    This is the same as open() as defined in IFSIO_H, except
          //    that it uses the Qlg_Path_Name_t structure for the pathname
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr Qp0lOpen int(10) ExtProc('Qp0lOpen');
         pathname  likeds(Qlg_Path_Name_t);
         openflags int(10) value;
         mode uns(10) value options(*nopass);
         codepage uns(10) value options(*nopass);
         end-pr Qp0lOpen;
        /if defined(*V5R2M0)
         txtcreatid uns(10) value options(*nopass);
        /endif


          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          //   int Qp0lUnlink(Qlg_Path_Name_T *);

          //    This is the same as unlink() as defined in IFSIO_H, except
          //    that it uses the Qlg_Path_Name_t structure for the pathname
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         dcl-pr Qp0lUnlink int(10) ExtProc('Qp0lUnlink');
         pathname  likeds(Qlg_Path_Name_t);
         end-pr Qp0lUnlink;
