     /*-                                                                            +
      * Copyright (c) 2002 Scott C. Klement                                         +
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
      /if defined(LDAP_H)
      /eof
      /endif
      /define LDAP_H


      *
      * Default port info
      *
     D LDAP_PORT       C                   CONST(389)
     D LDAPS_PORT      C                   CONST(636)


      *
      * LDAP error codes
      *
     D LDAP_SUCCESS    C                   CONST(0)
     D LDAP_NO_SUCH_OBJECT...
     D                 C                   CONST(32)
     D LDAP_OBJECT_CLASS_VIOLATION...
     D                 C                   CONST(65)
     D LDAP_TIMEOUT    C                   CONST(85)


      *
      * Scope constants:
      *
     D LDAP_SCOPE_BASE...
     D                 C                   CONST(0)
     D LDAP_SCOPE_ONELEVEL...
     D                 C                   CONST(1)
     D LDAP_SCOPE_SUBTREE...
     D                 C                   CONST(2)


      *
      * mod_op constants:
      *
     D LDAP_MOD_ADD    C                   CONST(0)
     D LDAP_MOD_DELETE...
     D                 C                   CONST(1)
     D LDAP_MOD_REPLACE...
     D                 C                   CONST(2)
     D LDAP_MOD_BVALUES...
     D                 C                   CONST(128)


      *-----------------------------------------------------------------
      * Time Value Structure (for the ldap_search_st function, etc)
      *
      *   contrains a structure for specifying a wait time.
      *
      *    tv_sec = seconds.    tv_usec = microseconds
      *-----------------------------------------------------------------
      /IF NOT DEFINED(TIMEVAL_STRUCT)
     D p_timeval       S               *
     D timeval         DS                  based(p_timeval)
     D   tv_sec                      10I 0
     D   tv_usec                     10I 0
      /DEFINE TIMEVAL_STRUCT
      /ENDIF

      *-----------------------------------------------------------------
      * LDAPMod -- structure to contain info about attributes for
      *     adding or modifying.
      *
      *   typedef struct ldapmod {
      *   	int		mod_op;
      *   	char		*mod_type;
      *   	union {
      *   		char		**modv_strvals;
      *   		struct berval	**modv_bvals;
      *   	} mod_vals;
      *
      *-----------------------------------------------------------------
     D p_LDAPMOD       S               *
     D LdapMod         DS                  based(p_LdapMod) align
     D   mod_op                      10I 0
     D   mod_type                      *
     D   modv_strvals                  *
     D   modv_bvals                    *   overlay(modv_strvals)


      *-----------------------------------------------------------------
      * binary value structure
      *
      *  struct berval {
      *     unsigned long bv_len;
      *     char         *bv_val;
      *  };
      *
      *-----------------------------------------------------------------
     D p_berval        S               *
     D berval          DS                  based(p_berval) align
     D   bv_len                      10U 0
     D   bv_val                        *

      *-----------------------------------------------------------------
      * ldap_init() -- Perform an LDAP Initialization Operation
      *
      * LDAP *ldap_init ( char *defhost, int defport );
      *
      *     defhost = default host(s) to connect to (can be a space
      *               separated list) or *NULL for localhost.
      *     defport = default port number to connect to.
      *               LDAP_PORT can be specified to default to port 389.
      *
      * Returns a pointer to an LDAP struct, or *NULL if failure
      *-----------------------------------------------------------------
     D ldap_init       PR              *   extproc('ldap_init')
     D   defhost                       *   value options(*string)
     D   defport                     10I 0 value


      *-----------------------------------------------------------------
      * ldap_simple_bind_s()--Perform a Simple LDAP Bind Request (Synch)
      *
      *   int ldap_simple_bind_s ( LDAP *ld, char *who, char *passwd );
      *
      *      ld = pointer to struct returned by ldap_init
      *      dn = distinguished name of entry to bind as
      *  passwd = password associated with DN
      *
      * Returns  LDAP_SUCCESS or an error code
      *-----------------------------------------------------------------
     D ldap_simple_bind_s...
     D                 PR            10I 0 EXTPROC('ldap_simple_bind_s')
     D   ld                            *   value
     D   who                           *   value options(*string)
     D   passwd                        *   value options(*string)


      *-----------------------------------------------------------------
      * ldap_search_st()--Perform an LDAP Search Operation (Timed & Synch)
      *
      *   int ldap_search_st ( LDAP *ld, char *base, int scope,
      *            	char *filter, char **attrs, int attrsonly,
      *             struct timeval *timeout, LDAPMessage **res );
      *
      *        ld = ldap descriptor returned by ldap_init
      *      base = base DN to search
      *     scope = scope of the search.  Can be LDAP_SCOPE_BASE,
      *               LDAP_SCOPE_ONELEVEL or LDAP_SCOPE_SUBTREE
      *    filter = filter of search
      *     attrs = null-terminated array of strings containing
      *             attribute types to return from entries which
      *             match the filter (or NULL for all attribs)
      * attrsonly = specify 1 if you only want the attribute names,
      *               or 0 to return names & values.
      *   timeout = timeval structure specifying the time-out duration
      *               for this search.
      *       res = result of search.  This result will be passed to
      *               LDAP parsing routines (ldap_first_entry, etc)
      *               When you're done with this, call ldap_msgfree()
      *               to de-allocate the memory its using.
      *
      *  returns LDAP_SUCCESS or an LDAP error code.
      *
      *-----------------------------------------------------------------
     D ldap_search_st  PR            10I 0 ExtProc('ldap_search_st')
     D   ld                            *   value
     D   base                          *   value options(*string)
     D   scope                       10I 0 value
     D   filter                        *   value options(*string)
     D   attrs                         *   value
     D   attrsonly                   10I 0 value
     D   timeout                       *   value
     D   res                           *


      *-----------------------------------------------------------------
      * ldap_first_entry()--Retrieve First LDAP Entry
      *
      *  LDAPMessage *ldap_first_entry(LDAP *ld, LDAPMessage *result);
      *
      *         ld = ldap descriptor
      *     result = result returned by ldap_result or ldap_search_st
      *                 or ldap_search_s, etc.
      *
      *  Returns NULL if error, or next entry if successful
      *-----------------------------------------------------------------
     D ldap_first_entry...
     D                 PR              *   ExtProc('ldap_first_entry')
     D   ld                            *   value
     D   result                        *   value


      *-----------------------------------------------------------------
      * ldap_next_entry()--Retrieve Next LDAP Entry
      *
      *  LDAPMessage *ldap_next_entry(LDAP *ld, LDAPMessage *entry);
      *
      *         ld = ldap descriptor
      *      entry = pointer to entry returned on previous call to
      *                ldap_first_entry() or ldap_next_entry()
      *
      *  Returns NULL if end of list, or the entry if successful
      *-----------------------------------------------------------------
     D ldap_next_entry...
     D                 PR              *   ExtProc('ldap_next_entry')
     D   ld                            *   value
     D   entry                         *   value


      *-----------------------------------------------------------------
      * ldap_first_attribute()--Retrieve first attribute in an Entry
      *
      *  char *ldap_first_attribute(LDAP *ld, LDAPMessage *entry,
      *               BerElement **berptr);
      *
      *         ld = ldap descriptor
      *      entry = pointer to entry returned on previous call to
      *                ldap_first_entry() or ldap_next_entry()
      *     berptr = (output) the API uses this to keep track of it's
      *                internal state.  (don't mess with it)
      *
      *  Returns NULL if error, otherwise a pointer to the attribute
      *        name. You need to call ldap_memfree() to free this
      *        attribute's space when you're done with it.
      *-----------------------------------------------------------------
     D ldap_first_attribute...
     D                 PR              *   ExtProc('ldap_first_attribute')
     D   ld                            *   value
     D   entry                         *   value
     D   berptr                        *


      *-----------------------------------------------------------------
      * ldap_next_attribute()--Retrieve next attribute in an Entry
      *
      *  char *ldap_first_attribute(LDAP *ld, LDAPMessage *entry,
      *               BerElement **berptr);
      *
      *         ld = ldap descriptor
      *      entry = pointer to entry returned on previous call to
      *                ldap_first_entry() or ldap_next_entry()
      *     berptr = (i/o) the API uses this to keep track of it's
      *                internal state.  (don't mess with it)
      *
      *  Returns NULL if error, otherwise a pointer to the attribute
      *        name. You need to call ldap_memfree() to free this
      *        attribute's space when you're done with it.
      *-----------------------------------------------------------------
     D ldap_next_attribute...
     D                 PR              *   ExtProc('ldap_next_attribute')
     D   ld                            *   value
     D   entry                         *   value
     D   berptr                        *   value


      *-----------------------------------------------------------------
      * ldap_get_values()--Retrieve a set of attribute values from an entry
      *
      *  char **ldap_get_values(LDAP *ld, LDAPMessage *entry,
      *               char *attr);
      *
      *         ld = ldap descriptor
      *      entry = pointer to entry returned on previous call to
      *                ldap_first_entry() or ldap_next_entry()
      *       attr = attribute whose values are desired
      *
      *  Returns NULL if error, otherwise a null-terminated array of
      *        values for the given entry.   You should call the
      *        ldap_value_free() API to free the memory reserved for this.
      *-----------------------------------------------------------------
     D ldap_get_values...
     D                 PR              *   ExtProc('ldap_get_values')
     D   ld                            *   value
     D   entry                         *   value
     D   attr                          *   value options(*string)


      *-----------------------------------------------------------------
      * ldap_get_dn()--Retrieve the Distinguished Name of an Entry
      *
      *  char *ldap_get_dn(LDAP *ld, LDAPMessage *entry);
      *
      *         ld = ldap descriptor
      *      entry = pointer to entry returned on previous call to
      *                ldap_first_entry() or ldap_next_entry()
      *
      *  Returns NULL if error, otherwise the DN, which should be
      *        released by ldap_memfree().
      *-----------------------------------------------------------------
     D ldap_get_dn     PR              *   ExtProc('ldap_get_dn')
     D   ld                            *   value
     D   entry                         *   value


      *-----------------------------------------------------------------
      * ldap_modify_s()--Perform an LDAP Modify Entry Request (Synchronous)
      *
      *  int ldap_modify_s(LDAP *ld, char *dn, LDAPMod *mods[]);
      *
      *         ld = ldap descriptor
      *         dn = distinguished name of entry to modify
      *       mods = NULL terminated array of modifications to make
      *
      *  Returns LDAP_SUCCESS or an LDAP error message
      *-----------------------------------------------------------------
     D ldap_modify_s   PR            10I 0 ExtPRoc('ldap_modify_s')
     D   ld                            *   value
     D   dn                            *   value options(*string)
     D   mods                          *   value


      *-----------------------------------------------------------------
      * ldap_rename_s()--Change the DN of an Entry (Synchronous)
      *
      *  int ldap_rename_s(LDAP *ld, char *dn, char *newrdn,
      *                    char *newparent, int deleteoldrdn,
      *                LDAPControl **serverctrls, LDAPControl **clientctrls)
      *
      *           ld = ldap descriptor
      *           dn = distinguished name of entry to modify
      *       newrdn = New relative distinguished name to assign
      *    newparent = New parent DN to assign
      * deleteoldrdn = Delete old RDN?  1=yes, 0=no
      *  serverctrls = server controls or *NULL
      *  clientctrls = client controls or *NULL
      *
      *  Returns LDAP_SUCCESS or an LDAP error message
      *-----------------------------------------------------------------
     D ldap_rename_s   PR            10I 0 ExtPRoc('ldap_rename_s')
     D   ld                            *   value
     D   dn                            *   value options(*string)
     D   newrdn                        *   value options(*string)
     D   newparent                     *   value options(*string)
     D   deleteoldrdn                10I 0 value
     D   serverctrls                   *   value
     D   clientctrls                   *   value


      *-----------------------------------------------------------------
      * ldap_add_s()--Perform an LDAP Add Operation (Synchronous)
      *
      *  int ldap_add_s(LDAP *ld, char *dn, LDAPMod *attrs[]);
      *
      *         ld = ldap descriptor
      *         dn = distinguished name of entry to modify
      *      attrs = NULL terminated array of attributes to add
      *               (the mod_op field is ignored, except for
      *               checking for LDAP_MOD_BVALUES)
      *
      *  Returns LDAP_SUCCESS or an LDAP error message
      *-----------------------------------------------------------------
     D ldap_add_s      PR            10I 0 ExtProc('ldap_add_s')
     D   ld                            *   value
     D   dn                            *   value options(*string)
     D   attrs                         *   value


      *-----------------------------------------------------------------
      * ldap_msgfree()--Free LDAP Result Message
      *
      *  int ldap_msgfree(LDAPMessage *msg);
      *
      *        msg = pointer to message to free
      *
      *  Returns the type of the message freed up, or 0 if msg=NULL
      *-----------------------------------------------------------------
     D ldap_msgfree    PR            10I 0 ExtProc('ldap_msgfree')
     D   msg                           *   value


      *-----------------------------------------------------------------
      * ldap_memfree()--Free Memory allocated by LDAP API
      *
      *  void ldap_memfree(char *mem);
      *
      *        mem = pointer to memory to free
      *
      *-----------------------------------------------------------------
     D ldap_memfree    PR                  ExtProc('ldap_memfree')
     D   mem                           *   value


      *-----------------------------------------------------------------
      * ldap_value_free()--Free Memory allocated by ldap_get_values()
      *
      *  void ldap_value_free(char **vals);
      *
      *       vals = pointer to memory to free
      *
      *-----------------------------------------------------------------
     D ldap_value_free...
     D                 PR                  ExtProc('ldap_value_free')
     D   mem                           *   value


      *-----------------------------------------------------------------
      * ldap_unbind()--Perform an LDAP Unbind Request (Synch)
      *
      *  Unbind & Terminate an LDAP session.
      *
      *  int ldap_unbind(LDAP *ld);
      *
      *     ld = LDAP descriptor from ldap_init() call
      *
      *  returns LDAP_SUCCES or an LDAP error code.
      *
      *  ldap_unbind() and ldap_unbind_s() are both synch, and do
      *       the exact same thing.
      *-----------------------------------------------------------------
     D ldap_unbind     PR                  ExtProc('ldap_unbind')
     D   ld                            *   value


      *-----------------------------------------------------------------
      * ldap_get_errno()--Retrieve error information
      *
      *  int ldap_get_errno(LDAP *ld);
      *
      *     ld = LDAP descriptor from ldap_init() call
      *
      *  returns error number
      *-----------------------------------------------------------------
     D ldap_get_errno  PR            10I 0 ExtProc('ldap_get_errno')
     D   ld                            *   value


      *-----------------------------------------------------------------
      * ldap_err2string()--Retrieve LDAP error message string
      *
      *   char *ldap_err2string ( int err );
      *
      * Returns the English text description for a given error number
      *-----------------------------------------------------------------
     D ldap_err2string...
     D                 PR              *   ExtProc('ldap_err2string')
     D   error                       10I 0 value
