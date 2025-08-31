          // -
          //  Copyright (c) 2002 Scott C. Klement
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
        /if defined(LDAP_H)
        /eof
        /endif
        /define LDAP_H



          //  Default port info

         dcl-c LDAP_PORT CONST(389);
         dcl-c LDAPS_PORT CONST(636);



          //  LDAP error codes

         dcl-c LDAP_SUCCESS CONST(0);
         dcl-c LDAP_NO_SUCH_OBJECT CONST(32);
         dcl-c LDAP_OBJECT_CLASS_VIOLATION CONST(65);
         dcl-c LDAP_TIMEOUT CONST(85);



          //  Scope constants:

         dcl-c LDAP_SCOPE_BASE CONST(0);
         dcl-c LDAP_SCOPE_ONELEVEL CONST(1);
         dcl-c LDAP_SCOPE_SUBTREE CONST(2);



          //  mod_op constants:

         dcl-c LDAP_MOD_ADD CONST(0);
         dcl-c LDAP_MOD_DELETE CONST(1);
         dcl-c LDAP_MOD_REPLACE CONST(2);
         dcl-c LDAP_MOD_BVALUES CONST(128);


          // -----------------------------------------------------------------
          //  Time Value Structure (for the ldap_search_st function, etc)

          //    contrains a structure for specifying a wait time.

          //     tv_sec = seconds.    tv_usec = microseconds
          // -----------------------------------------------------------------
        /IF NOT DEFINED(TIMEVAL_STRUCT)
         dcl-s p_timeval pointer;
         dcl-ds timeval INZ based(p_timeval);
         tv_sec int(10);
         tv_usec int(10);
         end-ds timeval;
        /DEFINE TIMEVAL_STRUCT
        /ENDIF

          // -----------------------------------------------------------------
          //  LDAPMod -- structure to contain info about attributes for
          //      adding or modifying.

          //    typedef struct ldapmod {
          //    	int		mod_op;
          //    	char		*mod_type;
          //    	union {
          //    		char		**modv_strvals;
          //    		struct berval	**modv_bvals;
          //    	} mod_vals;

          // -----------------------------------------------------------------
         dcl-s p_LDAPMOD pointer;
         dcl-ds LdapMod INZ based(p_LdapMod) align;
         mod_op int(10);
         mod_type pointer;
         modv_strvals pointer;
         modv_bvals pointer overlay(modv_strvals);
         end-ds LdapMod;


          // -----------------------------------------------------------------
          //  binary value structure

          //   struct berval {
          //      unsigned long bv_len;
          //      char         *bv_val;
          //   };

          // -----------------------------------------------------------------
         dcl-s p_berval pointer;
         dcl-ds berval INZ based(p_berval) align;
         bv_len uns(10);
         bv_val pointer;
         end-ds berval;

          // -----------------------------------------------------------------
          //  ldap_init() -- Perform an LDAP Initialization Operation

          //  LDAP *ldap_init ( char *defhost, int defport );

          //      defhost = default host(s) to connect to (can be a space
          //                separated list) or *NULL for localhost.
          //      defport = default port number to connect to.
          //                LDAP_PORT can be specified to default to port 389.

          //  Returns a pointer to an LDAP struct, or *NULL if failure
          // -----------------------------------------------------------------
         dcl-pr ldap_init pointer extproc('ldap_init');
         defhost pointer value options(*string);
         defport int(10) value;
         end-pr ldap_init;


          // -----------------------------------------------------------------
          //  ldap_simple_bind_s()--Perform a Simple LDAP Bind Request (Synch)

          //    int ldap_simple_bind_s ( LDAP *ld, char *who, char *passwd );

          //       ld = pointer to struct returned by ldap_init
          //       dn = distinguished name of entry to bind as
          //   passwd = password associated with DN

          //  Returns  LDAP_SUCCESS or an error code
          // -----------------------------------------------------------------
         dcl-pr ldap_simple_bind_s int(10) EXTPROC('ldap_simple_bind_s');
         ld pointer value;
         who pointer value options(*string);
         passwd pointer value options(*string);
         end-pr ldap_simple_bind_s;


          // -----------------------------------------------------------------
          //  ldap_search_st()--Perform an LDAP Search Operation (Timed & Synch)

          //    int ldap_search_st ( LDAP *ld, char *base, int scope,
          //             	char *filter, char **attrs, int attrsonly,
          //              struct timeval *timeout, LDAPMessage **res );

          //         ld = ldap descriptor returned by ldap_init
          //       base = base DN to search
          //      scope = scope of the search.  Can be LDAP_SCOPE_BASE,
          //                LDAP_SCOPE_ONELEVEL or LDAP_SCOPE_SUBTREE
          //     filter = filter of search
          //      attrs = null-terminated array of strings containing
          //              attribute types to return from entries which
          //              match the filter (or NULL for all attribs)
          //  attrsonly = specify 1 if you only want the attribute names,
          //                or 0 to return names & values.
          //    timeout = timeval structure specifying the time-out duration
          //                for this search.
          //        res = result of search.  This result will be passed to
          //                LDAP parsing routines (ldap_first_entry, etc)
          //                When you're done with this, call ldap_msgfree()
          //                to de-allocate the memory its using.

          //   returns LDAP_SUCCESS or an LDAP error code.

          // -----------------------------------------------------------------
         dcl-pr ldap_search_st int(10) ExtProc('ldap_search_st');
         ld pointer value;
         base pointer value options(*string);
         scope int(10) value;
         filter pointer value options(*string);
         attrs pointer value;
         attrsonly int(10) value;
         timeout pointer value;
         res pointer;
         end-pr ldap_search_st;


          // -----------------------------------------------------------------
          //  ldap_first_entry()--Retrieve First LDAP Entry

          //   LDAPMessage *ldap_first_entry(LDAP *ld, LDAPMessage *result);

          //          ld = ldap descriptor
          //      result = result returned by ldap_result or ldap_search_st
          //                  or ldap_search_s, etc.

          //   Returns NULL if error, or next entry if successful
          // -----------------------------------------------------------------
         dcl-pr ldap_first_entry pointer ExtProc('ldap_first_entry');
         ld pointer value;
         result pointer value;
         end-pr ldap_first_entry;


          // -----------------------------------------------------------------
          //  ldap_next_entry()--Retrieve Next LDAP Entry

          //   LDAPMessage *ldap_next_entry(LDAP *ld, LDAPMessage *entry);

          //          ld = ldap descriptor
          //       entry = pointer to entry returned on previous call to
          //                 ldap_first_entry() or ldap_next_entry()

          //   Returns NULL if end of list, or the entry if successful
          // -----------------------------------------------------------------
         dcl-pr ldap_next_entry pointer ExtProc('ldap_next_entry');
         ld pointer value;
         entry pointer value;
         end-pr ldap_next_entry;


          // -----------------------------------------------------------------
          //  ldap_first_attribute()--Retrieve first attribute in an Entry

          //   char *ldap_first_attribute(LDAP *ld, LDAPMessage *entry,
          //                BerElement **berptr);

          //          ld = ldap descriptor
          //       entry = pointer to entry returned on previous call to
          //                 ldap_first_entry() or ldap_next_entry()
          //      berptr = (output) the API uses this to keep track of it's
          //                 internal state.  (don't mess with it)

          //   Returns NULL if error, otherwise a pointer to the attribute
          //         name. You need to call ldap_memfree() to free this
          //         attribute's space when you're done with it.
          // -----------------------------------------------------------------
         dcl-pr ldap_first_attribute pointer ExtProc('ldap_first_attribute');
         ld pointer value;
         entry pointer value;
         berptr pointer;
         end-pr ldap_first_attribute;


          // -----------------------------------------------------------------
          //  ldap_next_attribute()--Retrieve next attribute in an Entry

          //   char *ldap_first_attribute(LDAP *ld, LDAPMessage *entry,
          //                BerElement **berptr);

          //          ld = ldap descriptor
          //       entry = pointer to entry returned on previous call to
          //                 ldap_first_entry() or ldap_next_entry()
          //      berptr = (i/o) the API uses this to keep track of it's
          //                 internal state.  (don't mess with it)

          //   Returns NULL if error, otherwise a pointer to the attribute
          //         name. You need to call ldap_memfree() to free this
          //         attribute's space when you're done with it.
          // -----------------------------------------------------------------
         dcl-pr ldap_next_attribute pointer ExtProc('ldap_next_attribute');
         ld pointer value;
         entry pointer value;
         berptr pointer value;
         end-pr ldap_next_attribute;


          // -----------------------------------------------------------------
          //  ldap_get_values()--Retrieve a set of attribute values from an entry

          //   char **ldap_get_values(LDAP *ld, LDAPMessage *entry,
          //                char *attr);

          //          ld = ldap descriptor
          //       entry = pointer to entry returned on previous call to
          //                 ldap_first_entry() or ldap_next_entry()
          //        attr = attribute whose values are desired

          //   Returns NULL if error, otherwise a null-terminated array of
          //         values for the given entry.   You should call the
          //         ldap_value_free() API to free the memory reserved for this.
          // -----------------------------------------------------------------
         dcl-pr ldap_get_values pointer ExtProc('ldap_get_values');
         ld pointer value;
         entry pointer value;
         attr pointer value options(*string);
         end-pr ldap_get_values;


          // -----------------------------------------------------------------
          //  ldap_get_dn()--Retrieve the Distinguished Name of an Entry

          //   char *ldap_get_dn(LDAP *ld, LDAPMessage *entry);

          //          ld = ldap descriptor
          //       entry = pointer to entry returned on previous call to
          //                 ldap_first_entry() or ldap_next_entry()

          //   Returns NULL if error, otherwise the DN, which should be
          //         released by ldap_memfree().
          // -----------------------------------------------------------------
         dcl-pr ldap_get_dn pointer ExtProc('ldap_get_dn');
         ld pointer value;
         entry pointer value;
         end-pr ldap_get_dn;


          // -----------------------------------------------------------------
          //  ldap_modify_s()--Perform an LDAP Modify Entry Request (Synchronous)

          //   int ldap_modify_s(LDAP *ld, char *dn, LDAPMod *mods[]);

          //          ld = ldap descriptor
          //          dn = distinguished name of entry to modify
          //        mods = NULL terminated array of modifications to make

          //   Returns LDAP_SUCCESS or an LDAP error message
          // -----------------------------------------------------------------
         dcl-pr ldap_modify_s int(10) ExtPRoc('ldap_modify_s');
         ld pointer value;
         dn pointer value options(*string);
         mods pointer value;
         end-pr ldap_modify_s;


          // -----------------------------------------------------------------
          //  ldap_rename_s()--Change the DN of an Entry (Synchronous)

          //   int ldap_rename_s(LDAP *ld, char *dn, char *newrdn,
          //                     char *newparent, int deleteoldrdn,
          //                 LDAPControl **serverctrls, LDAPControl **clientctrls)

          //            ld = ldap descriptor
          //            dn = distinguished name of entry to modify
          //        newrdn = New relative distinguished name to assign
          //     newparent = New parent DN to assign
          //  deleteoldrdn = Delete old RDN?  1=yes, 0=no
          //   serverctrls = server controls or *NULL
          //   clientctrls = client controls or *NULL

          //   Returns LDAP_SUCCESS or an LDAP error message
          // -----------------------------------------------------------------
         dcl-pr ldap_rename_s int(10) ExtPRoc('ldap_rename_s');
         ld pointer value;
         dn pointer value options(*string);
         newrdn pointer value options(*string);
         newparent pointer value options(*string);
         deleteoldrdn int(10) value;
         serverctrls pointer value;
         clientctrls pointer value;
         end-pr ldap_rename_s;


          // -----------------------------------------------------------------
          //  ldap_add_s()--Perform an LDAP Add Operation (Synchronous)

          //   int ldap_add_s(LDAP *ld, char *dn, LDAPMod *attrs[]);

          //          ld = ldap descriptor
          //          dn = distinguished name of entry to modify
          //       attrs = NULL terminated array of attributes to add
          //                (the mod_op field is ignored, except for
          //                checking for LDAP_MOD_BVALUES)

          //   Returns LDAP_SUCCESS or an LDAP error message
          // -----------------------------------------------------------------
         dcl-pr ldap_add_s int(10) ExtProc('ldap_add_s');
         ld pointer value;
         dn pointer value options(*string);
         attrs pointer value;
         end-pr ldap_add_s;


          // -----------------------------------------------------------------
          //  ldap_msgfree()--Free LDAP Result Message

          //   int ldap_msgfree(LDAPMessage *msg);

          //         msg = pointer to message to free

          //   Returns the type of the message freed up, or 0 if msg=NULL
          // -----------------------------------------------------------------
         dcl-pr ldap_msgfree int(10) ExtProc('ldap_msgfree');
         msg pointer value;
         end-pr ldap_msgfree;


          // -----------------------------------------------------------------
          //  ldap_memfree()--Free Memory allocated by LDAP API

          //   void ldap_memfree(char *mem);

          //         mem = pointer to memory to free

          // -----------------------------------------------------------------
         dcl-pr ldap_memfree  ExtProc('ldap_memfree');
         mem pointer value;
         end-pr ldap_memfree;


          // -----------------------------------------------------------------
          //  ldap_value_free()--Free Memory allocated by ldap_get_values()

          //   void ldap_value_free(char **vals);

          //        vals = pointer to memory to free

          // -----------------------------------------------------------------
         dcl-pr ldap_value_free  ExtProc('ldap_value_free');
         mem pointer value;
         end-pr ldap_value_free;


          // -----------------------------------------------------------------
          //  ldap_unbind()--Perform an LDAP Unbind Request (Synch)

          //   Unbind & Terminate an LDAP session.

          //   int ldap_unbind(LDAP *ld);

          //      ld = LDAP descriptor from ldap_init() call

          //   returns LDAP_SUCCES or an LDAP error code.

          //   ldap_unbind() and ldap_unbind_s() are both synch, and do
          //        the exact same thing.
          // -----------------------------------------------------------------
         dcl-pr ldap_unbind  ExtProc('ldap_unbind');
         ld pointer value;
         end-pr ldap_unbind;


          // -----------------------------------------------------------------
          //  ldap_get_errno()--Retrieve error information

          //   int ldap_get_errno(LDAP *ld);

          //      ld = LDAP descriptor from ldap_init() call

          //   returns error number
          // -----------------------------------------------------------------
         dcl-pr ldap_get_errno int(10) ExtProc('ldap_get_errno');
         ld pointer value;
         end-pr ldap_get_errno;


          // -----------------------------------------------------------------
          //  ldap_err2string()--Retrieve LDAP error message string

          //    char *ldap_err2string ( int err );

          //  Returns the English text description for a given error number
          // -----------------------------------------------------------------
         dcl-pr ldap_err2string pointer ExtProc('ldap_err2string');
         error int(10) value;
         end-pr ldap_err2string;
