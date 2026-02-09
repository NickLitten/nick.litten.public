      /if defined(USRSPC_H_DEFINED)
      /eof
      /endif
      /define USRSPC_H_DEFINED

      *
      *  USRSPC_H is the /COPY member containing definitions for use
      *  with user spaces.
      *

      *---------------------------------------------------------------
      * QUSCRTUS(): Create User Space
      *
      *      usrspc = (input) qualified user space name
      *                         pos  1-10 = object name
      *                             11-20 = library name
      *     extattr = (input) attribute displayed in WRKOBJ panels
      *        size = (input) initial size of user space
      *       value = (input) initial value of bytes in user space
      *                          (use x'00' for best performance)
      *  publicAuth = (input) authority that *PUBLIC gets to space
      *        Text = (input) Text description of user space
      * -- optional group 1 --
      *     Replace = (input/optional) Replace if exists? (*YES/*NO)
      *   ErrorCode = (i/o) standard API error code
      * -- optional group 2 --
      *      Domain = (input/optional) Domain (*DEFAULT/*SYSTEM/*USER)
      * -- optional group 3 --
      * XferSizeReq = (input/optional) number of pages of storage to
      *                         transfer on each request
      *                         0 = use the default value
      *                      1-32 = number of pages
      * OptSpcAlign = (input/optional) Use optimimum space alignment?
      *                         0 = do not choose optimum (default)
      *                         1 = choose optimum alignment
      *---------------------------------------------------------------
     D QUSCRTUS        PR                  ExtPgm('QUSCRTUS')
     D   usrspc                      20A   const
     D   extattr                     10A   const
     D   size                        10i 0 const
     D   value                        1A   const
     D   publicAuth                  10A   const
     D   Text                        50A   const
     D   Replace                     10A   const options(*nopass)
     D   ErrorCode                32767A   options(*varsize:*nopass)
     D   Domain                      10A   const options(*nopass)
     D   XferSizeReq                 10I 0 const options(*nopass)
     D   OptSpcAlign                  1A   const options(*nopass)

      *---------------------------------------------------------------
      * QUSPTRUS(): Retrieve Pointer to User Space
      *
      *      usrspc = (input) qualified user space name
      *                         pos  1-10 = object name
      *                             11-20 = library name
      *      pointer = (output) pointer retrieved
      * -- optional group 1 --
      *   ErrorCode = (i/o) standard API error code
      *---------------------------------------------------------------
     D QUSPTRUS        PR                  ExtPgm('QUSPTRUS')
     D   usrspc                      20A   const
     D   pointer                       *
     D   ErrorCode                32767A   options(*varsize:*nopass)

      *---------------------------------------------------------------
      * QUSDLTUS(): Delete User Space
      *
      *      usrspc = (input) qualified user space name
      *                         pos  1-10 = object name
      *                             11-20 = library name
      * -- optional group 1 --
      *   ErrorCode = (i/o) standard API error code
      *---------------------------------------------------------------
     D QUSDLTUS        PR                  ExtPgm('QUSDLTUS')
     D   usrspc                      20A   const
     D   ErrorCode                32767A   options(*varsize)

      *---------------------------------------------------------------
      * QUSCHGUS(): Change User Space Contents
      *
      *    NOTE: This is only included for completeness. For best
      *          performance, and simplest coding, please use pointer
      *          access to change a user space.
      *
      *      usrspc = (input) qualified user space name
      *                         pos  1-10 = object name
      *                             11-20 = library name
      *       start = (input) starting position within space
      *         len = (input) length of data to change
      *        data = (input) new data to assign
      *    ForceAux = (input/optional) force changes to aux storage
      *                       (i.e. make data write to disk immediately
      *                             instead of caching in memory)
      *                       0 = do not force (best performance)
      *                       1 = force asynch (medium performance)
      *                       2 = force synch  (worst performance)
      * -- optional group 1 --
      *   ErrorCode = (i/o) standard API error code
      *---------------------------------------------------------------
     D QUSCHGUS        PR                  ExtPgm('QUSCHGUS')
     D   usrspc                      20A   const
     D   Start                       10I 0 const
     D   Len                         10I 0 const
     D   Data                     65535A   const options(*varsize)
     D   ForceAux                     1A   const
     D   ErrorCode                32767A   options(*varsize:*nopass)

      *---------------------------------------------------------------
      * QUSCHGUS(): Retrieve User Space Contents
      *
      *    NOTE: This is only included for completeness. For best
      *          performance and simplest coding, please use pointer
      *          access to read a user space.
      *
      *      usrspc = (input) qualified user space name
      *       start = (input) starting position in the user space
      *         len = (input) length of data to read
      *      RcvVar = (output) variable to receive data
      * -- optional group 1 --
      *   ErrorCode = (i/o) standard API error code
      *---------------------------------------------------------------
     D QUSRTVUS        PR                  ExtPgm('QUSRTVUS')
     D   usrspc                      20A   const
     D   Start                       10I 0 const
     D   Len                         10I 0 const
     D   RcvVar                   32767A   options(*varsize)
     D   ErrorCode                32767A   options(*varsize:*nopass)

      *---------------------------------------------------------------
      * QUSCUSAT(): Change user space attributes ("cuss at")
      *
      *    rtnlib = (output) annoying "returned library" parameter
      *                Note: I recommend that you do not use this.
      *                      Use QUSRUSAT to get the library, if needed,
      *                      so I have this defined as CONST so you dont
      *                      have to always create an unused temporary
      *                      variable every time you call this API.
      *                      You can disable this behavior with
      *                      /define NO_RTNLIB_HACK if you like.
      *    usrspc = (input) qualified user space name
      *      attr = (input) attribute list (see Qus_UsrSpc_Attr_LIst_t)
      *                      to change in user space
      * ErrorCode = (i/o) standard API error code
      *---------------------------------------------------------------
     D QUSCUSAT        PR                  ExtPgm('QUSCUSAT')
     D   rtnlib                      10A
      /if not defined(NO_RTNLIB_HACK)
     D                                     const
      /endif
     D   usrspc                      20A   const
     D   attr                       480A   const options(*varsize)
     D   ErrorCode                32767A   options(*varsize)

      *
      * Possible key values for QUSCUSAT:
      *
     D QUS_ATTR_SPACE_SIZE...
     D                 C                   1
     D QUS_ATTR_INITIAL_VALUE...
     D                 C                   2
     D QUS_ATTR_AUTO_EXTEND...
     D                 C                   3
     D QUS_ATTR_XFER_SIZE_REQ...
     D                 C                   4

      *
      * RPG doesn't support nested data structures or
      * arrays of them in V5R1 or earlier
      *
      /if not defined(*V5R2M0)
      /undefine USE_NESTED_STRUCTURES
      /endif

      *
      * The "proper" way to call the QUSCUSAT API is to set all of
      * the needed attributes in an array of data structures. However
      * this requires V5R2, and even in later releases is more awkward
      * than using flat DS.  Granted, with the flat DS you have to
      * call the API repeatedly (once for each key) but in my experience
      * it's unusual to need to change more than one attribute anyway.
      *
      * Consequently, if you want the "proper" approach (with a nested
      * array) you can define USE_NESTED_STRUCTURES.  But, by default
      * I have the "flat" version defined.
      *
      /if defined(USE_NESTED_STRUCTURES)

     D Qus_UsrSpc_Attr_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   Key                         10I 0
     D   Length                      10I 0
     D   Value
     D     IntValue                  10I 0 overlay(Value)
     D     CharValue                  1A   overlay(Value)

     D Qus_UsrSpc_Attr_List_t...
     D                 ds                  qualified
     D                                     based(Template)
     D    NbrRec                     10I 0
     D    Rec                              likeds(Qus_UsrSpc_Attr_t)
     D                                     dim(4)

      /else

     D Qus_UsrSpc_Attr_List_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   NbrKeys                     10I 0
     D   Key                         10I 0
     D   Length                      10I 0
     D   Value
     D     IntValue                  10I 0 overlay(Value)
     D     CharValue                  1A   overlay(Value)

      /endif

      *
      * This is a "short cut" to save me time.  99% of the time that
      * I use QUSCAT, I use it for "auto-extend" so I've predefined
      * the auto-extend values in their own DS.
      *
     D Qus_Auto_Extend...
     D                 ds                  qualified
     D   NbrKeys                     10I 0 inz(1)
     D   Key                         10I 0 inz(QUS_ATTR_AUTO_EXTEND)
     D   Length                      10I 0 inz(%size(Qus_Auto_Extend.Value))
     D   Value                        1A   inz('1')

      *---------------------------------------------------------------
      * QUSRUSAT(): Retrieve User Space Attributes
      *
      *    RcvVar = (output) attributes retrieved (data structure thats
      *                           in SPCA0100 format... see the
      *                           Qus_SPCA0100_t ds, below)
      * RcvVarLen = (input) size of receiver variable
      *    format = (input) format of attributes (SPCA0100)
      *    usrspc = (input) user space to retrieve the attributes of
      * ErrorCode = (i/o) standard API error code
      *---------------------------------------------------------------
     D QUSRUSAT        PR                  ExtPgm('QUSCUSAT')
     D   RcvVar                            like(Qus_SPCA0100_t)
     D   RcvVarLen                   10i 0 const
     D   format                       8A   const
     D   usrspc                      20A   const
     D   ErrorCode                32767A   options(*varsize)

      *
      *  Data structure to contain the returned definitions
      *
     D Qus_SPCA0100_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   BytesRtn                    10I 0
     D   BytesAvail                  10I 0
     D   Size                        10I 0
     D   AutoExtend                   1A
     D   InitValue                    1A
     D   Library                     10A

      *---------------------------------------------------------------
      * Qus_Generic_Header_0100_t: Structure of the generic header
      *                            used by the i5/OS list APIs.
      *
      *  99% of the time, I only use the Offset, Count & Size fields
      *      so I have these defined with simple, short names to
      *      simplify coding
      *---------------------------------------------------------------
     D Qus_Generic_Header_0100_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   User_Area                   64A
     D   GenHdrSize                  10I 0
     D   Release                      4A
     D   Format                       8A
     D   API_Used                    10A
     D   TimeCreated                 13A
     D   InfoStatus                   1A
     D   SpaceSize                   10i 0
     D   InputOffset                 10i 0
     D   InputSize                   10i 0
     D   HeaderOffset                10i 0
     D   HeaderSize                  10i 0
     D   ListOffset                  10i 0
     D     Offset                    10i 0 overlay(ListOffset)
     D   ListSize                    10i 0
     D   EntryCount                  10i 0
     D     Count                     10i 0 overlay(EntryCount)
     D   EntrySize                   10i 0
     D     Size                      10i 0 overlay(EntrySize)
     D   EntryCCSID                  10i 0
     D   CountryID                    2A
     D   LanguageID                   3A
     D   Subset                       1A
     D                               42A

      *---------------------------------------------------------------
      * Qus_Generic_Header_0300_t: Same as Qus_Generic_Header_0100_t
      *                            except for 1 additional field
      *                            typically used with ILE versions
      *                            of the list APIs.
      *---------------------------------------------------------------
     D Qus_Generic_Header_0300_t...
     D                 ds                  qualified
     D                                     based(Template)
     D   User_Area                   64A
     D   GenHdrSize                  10I 0
     D   Release                      4A
     D   Format                       8A
     D   API_Used                    10A
     D   TimeCreated                 13A
     D   InfoStatus                   1A
     D   SpaceSize                   10i 0
     D   InputOffset                 10i 0
     D   InputSize                   10i 0
     D   HeaderOffset                10i 0
     D   HeaderSize                  10i 0
     D   ListOffset                  10i 0
     D     Offset                    10i 0 overlay(ListOffset)
     D   ListSize                    10i 0
     D   EntryCount                  10i 0
     D     Count                     10i 0 overlay(EntryCount)
     D   EntrySize                   10i 0
     D     Size                      10i 0 overlay(EntrySize)
     D   EntryCCSID                  10i 0
     D   CountryID                    2A
     D   LanguageID                   3A
     D   Subset                       1A
     D                               42A
     D   Entry_Point                256A
     D                              128A
