# Coding Standards Migration Plan

## Overview

This document outlines the plan for applying the new coding standards to all existing code in the NICKLITTEN repository.

**Created:** 2026-04-18  
**Status:** Ready for Implementation  
**Estimated Effort:** Phased approach over multiple sessions

---

## Migration Strategy

### Phase 1: Priority Files (Completed ✅)
- [x] Templates created
- [x] Documentation completed
- [x] SAMPLESFL.pgm.sqlrpgle updated as reference example

### Phase 2: Core Examples (Recommended Next - 15 files)

**Hello World Examples (3 files):**
- [ ] `codesamples/hello_world/HELLOWORLD-Simple_HelloWorld.pgm.rpgle`
- [ ] `codesamples/hello_world/HELLOADV-Advanced_HelloWorld.pgm.rpgle`
- [ ] `codesamples/hello_world/HELLOINC-Helloworld_using_copybook.pgm.rpgle`

**Basic SQLRPGLE Examples (3 files):**
- [ ] `codesamples/sqlrpgle_dynamic/SQLREAD-Sample_SQL_RPG_Dynamic_File_read.pgm.sqlrpgle`
- [ ] `codesamples/stored_procs/STOREPRCS-Stored_Procedure_SQLRPG_Employee.pgm.sqlrpgle`
- [ ] `codesamples/stored_procs/STOREPRCR-Stored_Procedure_RPG_Employee.pgm.rpgle`

**Basic CLLE Examples (4 files):**
- [ ] `codesamples/check_subsystem_active/CHKSBSACT-Check_if_subsystem_is_active.pgm.clle`
- [ ] `codesamples/check_subsystem_active/CHKSBSACT1-Example_from_blog.pgm.clle`
- [ ] `codesamples/check_subsystem_active/CHKSBSACT2-Example_from_blog.pgm.clle`
- [ ] `codesamples/email_csv_file/EMLCSVFILE-email_CSV_File.pgm.clle`

**Debug Examples (2 files):**
- [ ] `codesamples/debug/BUGMECL-This_is_a_debugging_example.pgm.clle`
- [ ] `codesamples/debug/BUGMERPG-This_is_a_debugging_example.pgm.rpgle`

**List Libraries (1 file):**
- [ ] `codesamples/list_libraries/LSTLIBSIMP-List_Libraries_Simply.pgm.clle`

**MySQL Control (1 file):**
- [ ] `codesamples/mysql_server/MYSQLCTL-My_SQL_Control.pgm.clle`

**Read Directory (1 file):**
- [ ] `codesamples/read_directory_qshell/READDIR-Read_Directory_with_QSHELL.pgm.clle`

### Phase 3: Subfile Examples (7 files)

**SIMPLE Subfiles:**
- [ ] `codesamples/subfile/SIMPLE-Full_Load_Subfile/SIMPLESFL1-AS400_RPG_subfile_FULL_LOAD.pgm.rpgle`
- [ ] `codesamples/subfile/SIMPLE-Full_Load_Subfile/SIMPLESFL2-IBMi_RPG_subfile_FULL_LOAD.pgm.rpgle`
- [ ] `codesamples/subfile/SIMPLE-Full_Load_Subfile/SIMPLESFL3-IBMi_RPG_subfile_FULL_LOAD_IBMi_BOB_Style.pgm.rpgle`

**NOOB Subfiles:**
- [ ] `codesamples/subfile/NOOB-Full_Load_Subfile_Modernization/NOOBSFL1-Full_load_subfile_example_AS400_STYLE.pgm.rpgle`
- [ ] `codesamples/subfile/NOOB-Full_Load_Subfile_Modernization/NOOBSFL2-Full_load_subfile_example_ISERIES_STYLE.pgm.rpgle`
- [ ] `codesamples/subfile/NOOB-Full_Load_Subfile_Modernization/NOOBSFL3-Full_load_subfile_example_IBMi_STYLE.pgm.rpgle`
- [ ] `codesamples/subfile/NOOB-Full_Load_Subfile_Modernization/NOOBSFL4-Full_load_subfile_example_IBMi_BOB_STYLE.pgm.rpgle`

### Phase 4: Service Programs & Security (6 files)

**Service Programs:**
- [ ] `codesamples/services/SIMPLEMOD-Simple_Service_Program.sqlrpgle`
- [ ] `codesamples/conversion/CONVSRV-Conversion_Service.sqlrpgle`

**Security Programs:**
- [ ] `codesamples/security/EMAILSRV-Email_Service.sqlrpgle`
- [ ] `codesamples/security/USRPROFSRV-User_Profile_Service.sqlrpgle`
- [ ] `codesamples/security/PWDEXPILE-Password_Expiration_Monitor_ILE.sqlrpgle`
- [ ] `codesamples/security/PWDEXPMON-Password_Expiration_Monitor.clle`
- [ ] `codesamples/security/SCHEDULE-Setup_Password_Monitor_Schedule.clle`

### Phase 5: Modernization & Conversion Examples (19 files)

**RPG Modernization:**
- [ ] `codesamples/rpg_modernization/FREERPG-Nicks_Version.pgm.rpgle`
- [ ] `codesamples/rpg_modernization/FREERPG1-RPGLE_Free.pgm.rpgle`
- [ ] `codesamples/rpg_modernization/FREERPG2-ARCAD_Converter.pgm.rpgle`
- [ ] `codesamples/rpg_modernization/FREERPG3-Cozzi_Converter.pgm.rpgle`
- [ ] `codesamples/rpg_modernization/FREERPG4-Modernized-by-BOB.pgm.rpgle`
- [ ] `codesamples/rpg_modernization/FREERPG5-Modernized-by-BOB-SQL.pgm.sqlrpgle`
- [ ] `codesamples/rpg_modernization/IFSIMPROVE-IFS_Sample_Modernised_and_Improved.pgm.rpgle`
- [ ] `codesamples/rpg_modernization/IFSLEGACY-IFS_Sample_legacy_RPG_Column_Based.pgm.rpgle`
- [ ] `codesamples/rpg_modernization/IFSMODERN-IFS_Sample_modernised_RPG_Free.pgm.rpgle`
- [ ] `codesamples/rpg_modernization/OLDRPG-old_rpg400_code.pgm.rpgle`
- [ ] `codesamples/rpg_modernization/OLDTAGRPG1-old_rpg400_with_goto_tag_subroutine.pgm.rpgle`
- [ ] `codesamples/rpg_modernization/OLDTAGRPG2-old_rpg400_lightly_neater.pgm.rpgle`
- [ ] `codesamples/rpg_modernization/OLDTAGRPG3-old_rpg400_modernised.pgm.rpgle`

**Conversion Programs:**
- [ ] `codesamples/conversion/CONVERSION-Modernized_Improved.pgm.rpgle`
- [ ] `codesamples/conversion/CONVERSION-Modernized.pgm.rpgle`
- [ ] `codesamples/conversion/CONVERT-Convert_EBCDIC_to_ASCII_with_SRVPGM.pgm.rpgle`
- [ ] `codesamples/conversion/CONVERTBAS-Convert_EBCDIC_to_ASCII_BASIC.pgm.rpgle`

### Phase 6: Web Services & Specialized (10 files)

**Web Services:**
- [ ] `codesamples/webservice/JSNIFSSQL/JSNIFSSQL-JSON_TABLE_Decode_JSON_SQL.pgm.sqlrpgle`
- [ ] `codesamples/webservice/SIMPWEBSQL/SIMPWEBSQL-Consume_a_webservice_response.pgm.sqlrpgle`
- [ ] `codesamples/webservice/WEBFOOD/WEBFOOD-Sample_Webservice_for_FOODFILE.pgm.rpgle`
- [ ] `codesamples/webservice/WEBFOOD/WEBFOODNEW-Sample_Webservice_for_FOODFILE.pgm.rpgle`

**SQL Encryption:**
- [ ] `codesamples/sql_encryption/GETENC-Get_Encryption_Data.pgm.sqlrpgle`

**CRUD Examples:**
- [ ] `codesamples/crud/CRUD01RPG-Change_Read_Update_Delete_Example.pgm.sqlrpgle`
- [ ] `codesamples/crud/RECIPCRUD-crud_rpgle_recipe_example.pgm.rpgle`

**Utility Programs:**
- [ ] `codesamples/update_iasp/UPDIASP-Update_IASP_Job_Descriptions.pgm.clle`
- [ ] `codesamples/update_iasp/UPDIASPSQL-Update_IASP_Job_Descriptions.pgm.sqlrpgle`
- [ ] `codesamples/upload_files/SIMPIMPF-Simple_Import_File_Example.pgm.clle`
- [ ] `codesamples/upload_files/SIMPIMPFV2-Simple_Import_File_Example_Enhanced.pgm.clle`
- [ ] `codesamples/email_outq/EMLOUTQ-Email_outq_cpp.pgm.clle`
- [ ] `codesamples/clear_pfrdata/CLRPFRDATA-Clear_Performance_Data_and_Report.pgm.clle`
- [ ] `codesamples/clear_bob_logs/CLRBOBLOG-Clear_Bob_Logs.pgm.clle`

**CL Code Snippets:**
- [ ] `codesamples/cl_code_snippets/CLBNDPGM-Simple_Bound_CL_Program.pgm.clle`
- [ ] `codesamples/cl_code_snippets/CLMODULE-Simple_CL_Module.pgm.clle`
- [ ] `codesamples/cl_code_snippets/IASP-Question_and_Answer_CL_Example.pgm.clle`
- [ ] `codesamples/cl_code_snippets/IASPLOOP-DOU_Question_and_Answer_CL_Example.pgm.clle`

### Phase 7: Work in Progress (3 files - Lower Priority)

**WORKINPROGRESS Subfiles:**
- [ ] `codesamples/subfile/WORKINPROGRESS/CRUD-ChangeReadUpdateDelete/CRUD01RPG-Change_Read_Update_Delete_Example.pgm.sqlrpgle`
- [ ] `codesamples/subfile/WORKINPROGRESS/PERSONSFL-Expanding_Page_NativeIO/PERSONSFL-Person_expanding_page_subfile.pgm.sqlrpgle`
- [ ] `codesamples/subfile/WORKINPROGRESS/SORTSFL-Column_Sorting_Subfile/SORTSFL-Sortable_Subfile.pgm.sqlrpgle`

### Phase 8: RPG Code Directory (Duplicates - Review Only)
Note: These appear to be duplicates of files in other directories
- `codesamples/rpg_code/` - Review for duplicates before updating

---

## Standards to Apply

### For All RPGLE/SQLRPGLE Files:

1. **Add Triple-Slash Header:**
```rpgle
///
/// Program: PROGNAME - Brief Title
///
/// Description: Comprehensive explanation
///
/// Purpose: Demonstrating:
///   - Concept 1
///   - Concept 2
///
/// Features:
///   - Feature 1
///   - Feature 2
///
/// Modification History:
///   V.000 YYYY-MM-DD | Author | Initial creation
///
```

2. **Update Section Separators:**
   - Change `// ------` to `// ==============`

3. **Update Copyright:**
   - Format: `copyright('PROGNAME | V.XXX | Description')`
   - Calculate version from modification history

4. **Add Procedure Documentation:**
```rpgle
// ==============================================================================
// Procedure: ProcedureName
// Description: What it does
// Parameters:
//   - parm1: Description
// ==============================================================================
```

### For All CLLE Files:

1. **Add Block Comment Header:**
```clle
/* Program: PROGNAME - Brief Title                                         */
/*                                                                          */
/* Description: Comprehensive explanation                                  */
/*                                                                          */
/* Modification History:                                                    */
/* V.000 YYYY-MM-DD | Author | Initial creation                            */
```

2. **Update COPYRIGHT:**
   - Format: `COPYRIGHT TEXT('PROGNAME Ver:XXX Description')`

---

## Migration Checklist Per File

For each file being updated:

- [ ] Read current file content
- [ ] Identify existing documentation
- [ ] Count modification history entries for version
- [ ] Create comprehensive triple-slash header
- [ ] Update section separators
- [ ] Update copyright statement
- [ ] Add procedure documentation
- [ ] Add modification history entry
- [ ] Verify file compiles (if possible)
- [ ] Commit changes with descriptive message

---

## Automated vs Manual Approach

### Automated (Recommended for Bulk Updates):
- Use helper scripts for version calculation
- Use helper scripts for copyright updates
- BOB can batch process similar files

### Manual (Recommended for Complex Files):
- Files with unique structures
- Files requiring significant refactoring
- Files with complex documentation needs

---

## Quality Assurance

After each file update:

1. **Verify Standards Compliance:**
   - Triple-slash header present
   - Section separators correct
   - Copyright format correct
   - Version matches history

2. **Verify Functionality:**
   - Code logic unchanged
   - No syntax errors introduced
   - Comments accurate

3. **Documentation Review:**
   - Description is comprehensive
   - Purpose clearly stated
   - Features accurately listed
   - Modification history complete

---

## Implementation Commands

### For BOB AI Assistant:

To update a specific file:
```
Apply coding standards to [filename]
```

To update a group of files:
```
Apply coding standards to all files in [directory]
```

To review a file for standards compliance:
```
Review [filename] for coding standards compliance
```

### Using Helper Scripts:

Calculate version:
```bash
node .bob/scripts/calculate-version.js path/to/file.rpgle
```

Update copyright:
```bash
node .bob/scripts/update-copyright.js path/to/file.rpgle V.042 "Description"
```

---

## Progress Tracking

### Files Updated: 1 / ~100+

**Completed:**
- ✅ SAMPLESFL-Country_List_Subfile_SQL_SINGLEPAGE.pgm.sqlrpgle

**In Progress:**
- (None currently)

**Pending:**
- All other files in codesamples/

---

## Rollback Plan

If issues are discovered:

1. **Git Revert:** Use git to revert specific commits
2. **Backup:** Keep original files in a backup branch
3. **Incremental:** Update files in small batches for easier rollback

---

## Communication

### Team Notification:
- Announce migration plan
- Share this document
- Request feedback on priorities
- Schedule review sessions

### Documentation Updates:
- Update README files as needed
- Add migration notes to relevant docs
- Update blog posts if applicable

---

## Success Criteria

Migration is complete when:

- ✅ All production code files have triple-slash headers
- ✅ All section separators use `// ======` format
- ✅ All copyright statements are correct
- ✅ All modification histories are accurate
- ✅ All procedure documentation is complete
- ✅ No compilation errors introduced
- ✅ All files pass standards validation

---

## Estimated Timeline

**Phase 1:** Complete ✅  
**Phase 2:** 2-3 hours (10-15 files)  
**Phase 3:** 3-4 hours (15-20 files)  
**Phase 4:** 2-3 hours (10 files)  
**Phase 5:** 4-5 hours (20-30 files)  
**Phase 6:** 2-3 hours (10-15 files)  

**Total Estimated:** 15-20 hours of focused work

---

## Next Steps

1. **Review this plan** with project stakeholders
2. **Prioritize phases** based on business needs
3. **Begin Phase 2** with core example files
4. **Track progress** in this document
5. **Review and adjust** as needed

---

## Notes

- Some files in `code_snippets_NOCOMPILE/` may not need updates
- Legacy examples may be intentionally left in old format
- Work in progress files can be updated last
- Consider creating a `standards-migration` branch for safety

---

**Document Version:** 1.0  
**Last Updated:** 2026-04-18  
**Maintained By:** BOB AI Assistant / Nick Litten