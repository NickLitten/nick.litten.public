-- ----------------------------------------------------------------------------
-- SORTSFLPF-Insert_Test_Rows.sql - Insert 100 Test Rows into SORTSFLPF
-- ----------------------------------------------------------------------------
-- Description: Standalone SQL script to populate SORTSFLPF with realistic
--              test data for demonstrating column sorting functionality.
--
-- How to run:
--   Option 1 - ACS Run SQL Scripts:
--              Open this file in IBM ACS Run SQL Scripts, set the default
--              schema/library that SORTSFLPF lives in, then run (F5).
--
--   Option 2 - RUNSQLSTM command on IBM i:
--              RUNSQLSTM SRCSTMF('/path/to/SORTSFLPF-Insert_Test_Rows.sql.sql')
--                        COMMIT(*NONE) NAMING(*SQL)
--
-- Column reference (from SORTSFLPF.pf):
--   SORTDATE   10S 0  Date in CYYMMDD format  (C=1 for 2000s, e.g. 1240315)
--   SORTTIME   10S 0  Time in HHMMSS format   (e.g. 083045 = 08:30:45)
--   SORTUSER   10A    User ID, padded to 10 chars
--   SORTTEXT   40A    Audit text, padded to 40 chars
--   SORTSTATUS  1A    '0'=Active  '2'=Inactive
--
-- Note: Data covers Jan-Dec 2025 across multiple departments so every column
--       produces a visually different sort order when clicked.
-- ----------------------------------------------------------------------------
set schema NICKLITTEN;


-- Clear existing data
delete from SORTSFLPF;


-- Insert 100 rows of varied test data
insert into SORTSFLPF (
      SORTDATE,
      SORTTIME,
      SORTUSER,
      SORTTEXT,
      SORTSTATUS
    )
  values
    (
      1231215,
      083045,
      'JSMITH    ',
      'User login successful                   ',
      '0'
    ),
    (
      1231215,
      091230,
      'MJONES    ',
      'Password changed by administrator        ',
      '0'
    ),
    (
      1231215,
      102145,
      'RBROWN    ',
      'File access denied - insufficient rights ',
      '2'
    ),
    (
      1231215,
      113520,
      'SJOHNSON  ',
      'Report generated successfully            ',
      '0'
    ),
    (
      1231215,
      124835,
      'KWILLIAMS ',
      'Database backup initiated                ',
      '0'
    ),
    (
      1231216,
      073015,
      'TDAVIS    ',
      'System startup completed                 ',
      '0'
    ),
    (
      1231216,
      084520,
      'LMILLER   ',
      'User account created                     ',
      '0'
    ),
    (
      1231216,
      095735,
      'CWILSON   ',
      'Email notification sent                  ',
      '0'
    ),
    (
      1231216,
      101245,
      'AMOORE    ',
      'Batch job submitted to queue             ',
      '0'
    ),
    (
      1231216,
      112550,
      'DTAYLOR   ',
      'Security audit log reviewed              ',
      '0'
    ),
    (
      1231217,
      080130,
      'BANDERSON ',
      'User session timeout                     ',
      '2'
    ),
    (
      1231217,
      091445,
      'JTHOMAS   ',
      'Print job completed                      ',
      '0'
    ),
    (
      1231217,
      103250,
      'MJACKSON  ',
      'Data export to CSV successful            ',
      '0'
    ),
    (
      1231217,
      114505,
      'RWHITE    ',
      'System maintenance scheduled             ',
      '0'
    ),
    (
      1231217,
      125820,
      'SHARRIS   ',
      'User privileges updated                  ',
      '0'
    ),
    (
      1231218,
      072535,
      'KMARTIN   ',
      'Database connection established          ',
      '0'
    ),
    (
      1231218,
      083840,
      'TTHOMPSON ',
      'Invalid login attempt detected           ',
      '2'
    ),
    (
      1231218,
      095145,
      'LGARCIA   ',
      'File upload completed                    ',
      '0'
    ),
    (
      1231218,
      110450,
      'CMARTINEZ ',
      'System backup verified                   ',
      '0'
    ),
    (
      1231218,
      121755,
      'AROBINSON ',
      'User account locked                      ',
      '2'
    ),
    (
      1231219,
      081200,
      'DCLARK    ',
      'Application server restarted             ',
      '0'
    ),
    (
      1231219,
      092505,
      'BRODRIGUZ ',
      'Data synchronization complete            ',
      '0'
    ),
    (
      1231219,
      103810,
      'JLEWIS    ',
      'Report distribution initiated            ',
      '0'
    ),
    (
      1231219,
      115115,
      'MLEE      ',
      'User profile modified                    ',
      '0'
    ),
    (
      1231219,
      130420,
      'RWALKER   ',
      'System performance check completed       ',
      '0'
    ),
    (
      1231220,
      074725,
      'SHALL     ',
      'Database index rebuilt                   ',
      '0'
    ),
    (
      1231220,
      090030,
      'KALLEN    ',
      'User logout recorded                     ',
      '0'
    ),
    (
      1231220,
      101335,
      'TYOUNG    ',
      'Security policy updated                  ',
      '0'
    ),
    (
      1231220,
      112640,
      'LHERNANDEZ',
      'Batch process completed successfully     ',
      '0'
    ),
    (
      1231220,
      123945,
      'CKING     ',
      'System alert acknowledged                ',
      '0'
    ),
    (
      1231221,
      082250,
      'AWRIGHT   ',
      'File transfer initiated                  ',
      '0'
    ),
    (
      1231221,
      093555,
      'DLOPEZ    ',
      'User session established                 ',
      '0'
    ),
    (
      1231221,
      104900,
      'BHILL     ',
      'Database query executed                  ',
      '0'
    ),
    (
      1231221,
      120205,
      'JSCOTT    ',
      'System configuration changed             ',
      '0'
    ),
    (
      1231221,
      131510,
      'MGREEN    ',
      'User access revoked                      ',
      '2'
    ),
    (
      1231222,
      075815,
      'RADAMS    ',
      'Application update installed             ',
      '0'
    ),
    (
      1231222,
      091120,
      'SBAKER    ',
      'Data validation completed                ',
      '0'
    ),
    (
      1231222,
      102425,
      'KGONZALEZ ',
      'User password reset                      ',
      '0'
    ),
    (
      1231222,
      113730,
      'TNELSON   ',
      'System log archived                      ',
      '0'
    ),
    (
      1231222,
      125035,
      'LCARTER   ',
      'File deletion recorded                   ',
      '0'
    ),
    (
      1231223,
      081340,
      'CMITCHELL ',
      'Database backup completed                ',
      '0'
    ),
    (
      1231223,
      092645,
      'APEREZ    ',
      'User login failed - invalid password     ',
      '2'
    ),
    (
      1231223,
      103950,
      'DROBERTS  ',
      'Report generation started                ',
      '0'
    ),
    (
      1231223,
      115255,
      'BTURNER   ',
      'System maintenance completed             ',
      '0'
    ),
    (
      1231223,
      130600,
      'JPHILLIPS ',
      'User account activated                   ',
      '0'
    ),
    (
      1231224,
      074905,
      'MCAMPBELL ',
      'Email server connection established      ',
      '0'
    ),
    (
      1231224,
      090210,
      'RPARKER   ',
      'Data import successful                   ',
      '0'
    ),
    (
      1231224,
      101515,
      'SEVANS    ',
      'User session terminated                  ',
      '0'
    ),
    (
      1231224,
      112820,
      'KEDWARDS  ',
      'System resource check completed          ',
      '0'
    ),
    (
      1231224,
      124125,
      'TCOLLINS  ',
      'File access granted                      ',
      '0'
    ),
    (
      1231225,
      082430,
      'LSTEWART  ',
      'Database connection closed               ',
      '0'
    ),
    (
      1231225,
      093735,
      'CSANCHEZ  ',
      'User profile created                     ',
      '0'
    ),
    (
      1231225,
      105040,
      'AMORRIS   ',
      'System alert generated                   ',
      '2'
    ),
    (
      1231225,
      120345,
      'DMORGAN   ',
      'Batch job completed                      ',
      '0'
    ),
    (
      1231225,
      131650,
      'BBELL     ',
      'User privileges reviewed                 ',
      '0'
    ),
    (
      1231226,
      075955,
      'JMURPHY   ',
      'Application startup successful           ',
      '0'
    ),
    (
      1231226,
      091300,
      'MRIVERA   ',
      'Data export initiated                    ',
      '0'
    ),
    (
      1231226,
      102605,
      'RCOOK     ',
      'User account suspended                   ',
      '2'
    ),
    (
      1231226,
      113910,
      'SROGERS   ',
      'System configuration validated           ',
      '0'
    ),
    (
      1231226,
      125215,
      'KMORGAN   ',
      'File upload started                      ',
      '0'
    ),
    (
      1231227,
      083520,
      'TPETERSON ',
      'Database maintenance scheduled           ',
      '0'
    ),
    (
      1231227,
      094825,
      'LCOOPER   ',
      'User login successful                    ',
      '0'
    ),
    (
      1231227,
      110130,
      'CREED     ',
      'Report distribution completed            ',
      '0'
    ),
    (
      1231227,
      121435,
      'ABAILEY   ',
      'System backup initiated                  ',
      '0'
    ),
    (
      1231227,
      132740,
      'DRICHARDSN',
      'User session timeout warning            ',
      '0'
    ),
    (
      1231228,
      072045,
      'BCOX      ',
      'Application error logged                 ',
      '2'
    ),
    (
      1231228,
      083350,
      'JHOWARD   ',
      'Data synchronization started             ',
      '0'
    ),
    (
      1231228,
      094655,
      'MWARD     ',
      'User password expired                    ',
      '2'
    ),
    (
      1231228,
      110000,
      'RTORRES   ',
      'System performance optimal               ',
      '0'
    ),
    (
      1231228,
      121305,
      'SPETERSON ',
      'File transfer completed                  ',
      '0'
    ),
    (
      1231229,
      084610,
      'KGRAY     ',
      'Database query optimized                 ',
      '0'
    ),
    (
      1231229,
      095915,
      'TRAMIREZ  ',
      'User account unlocked                    ',
      '0'
    ),
    (
      1231229,
      111220,
      'LJAMES    ',
      'System alert cleared                     ',
      '0'
    ),
    (
      1231229,
      122525,
      'CWATSON   ',
      'Batch process initiated                  ',
      '0'
    ),
    (
      1231229,
      133830,
      'ABROOKS   ',
      'User profile updated                     ',
      '0'
    ),
    (
      1231230,
      071135,
      'DKELLY    ',
      'Application shutdown completed           ',
      '0'
    ),
    (
      1231230,
      082440,
      'BSANDERS  ',
      'Data validation failed                   ',
      '2'
    ),
    (
      1231230,
      093745,
      'JPRICE    ',
      'User login recorded                      ',
      '0'
    ),
    (
      1231230,
      105050,
      'MBENNETT  ',
      'System configuration backup created      ',
      '0'
    ),
    (
      1231230,
      120355,
      'RWOOD     ',
      'File access logged                       ',
      '0'
    ),
    (
      1231231,
      085700,
      'SBARNES   ',
      'Database connection timeout              ',
      '2'
    ),
    (
      1231231,
      100005,
      'KROSS     ',
      'User session established                 ',
      '0'
    ),
    (
      1231231,
      111310,
      'THENDERSON',
      'Report generation completed              ',
      '0'
    ),
    (
      1231231,
      122615,
      'LCOLEMAN  ',
      'System maintenance window started        ',
      '0'
    ),
    (
      1231231,
      133920,
      'CJENKINS  ',
      'User privileges escalated                ',
      '0'
    ),
    (
      0240101,
      074225,
      'APERRY    ',
      'New year system check completed          ',
      '0'
    ),
    (
      0240101,
      085530,
      'DPOWELL   ',
      'Data archive process started             ',
      '0'
    ),
    (
      0240101,
      100835,
      'BLONG     ',
      'User account reviewed                    ',
      '0'
    ),
    (
      0240101,
      112140,
      'JPATTERSON',
      'System log rotation completed            ',
      '0'
    ),
    (
      0240101,
      123445,
      'MHUGHES   ',
      'File cleanup process initiated           ',
      '0'
    ),
    (
      0240102,
      081750,
      'RFLORES   ',
      'Database integrity check passed          ',
      '0'
    ),
    (
      0240102,
      093055,
      'SWASHINTON',
      'User login from new location            ',
      '0'
    ),
    (
      0240102,
      104400,
      'KBUTLER   ',
      'System resource allocation updated       ',
      '0'
    ),
    (
      0240102,
      115705,
      'TSIMMONS  ',
      'Batch job queue processed                ',
      '0'
    ),
    (
      0240102,
      131010,
      'LFOSTER   ',
      'User session activity logged             ',
      '0'
    );

insert into SORTSFLPF (
      SORTDATE,
      SORTTIME,
      SORTUSER,
      SORTTEXT,
      SORTSTATUS
    )
  values
  -- January 2025
    (
      1250103,
      73015,
      'AWILLIAMS ',
      'Order #10042 submitted to warehouse     ',
      '0'
    ),
    (
      1250103,
      91230,
      'PCHANDRA  ',
      'Inventory count mismatch on SKU-887     ',
      '2'
    ),
    (
      1250103,
      143500,
      'RMCALLUM  ',
      'Monthly payroll cycle started           ',
      '0'
    ),
    (
      1250107,
      80045,
      'TNAKAMURA ',
      'Customer account ACME Corp updated      ',
      '0'
    ),
    (
      1250107,
      110220,
      'LBAUTISTA ',
      'Approval workflow stage 2 completed     ',
      '0'
    ),
    (
      1250107,
      154830,
      'GFOSTER   ',
      'Shipment SHP-3391 dispatched            ',
      '0'
    ),
    (
      1250108,
      75540,
      'KPETROVA  ',
      'Quality check failed for batch B-091    ',
      '2'
    ),
    (
      1250108,
      130115,
      'DTOBIAS   ',
      'New supplier contract SVC-2200 signed   ',
      '0'
    ),
    (
      1250109,
      83050,
      'AWILLIAMS ',
      'Order #10043 put on backorder hold      ',
      '2'
    ),
    (
      1250109,
      162345,
      'RMCALLUM  ',
      'Payroll exported to bank file           ',
      '0'
    ),
    -- February 2025
    (
      1250203,
      90000,
      'SSVENSSON ',
      'User PCHANDRA password reset requested  ',
      '0'
    ),
    (
      1250203,
      114510,
      'TNAKAMURA ',
      'Server APPSRV02 disk at 85 pct capacity ',
      '2'
    ),
    (
      1250204,
      80530,
      'JOKONKWO  ',
      'Purchase order PO-6610 approved         ',
      '0'
    ),
    (
      1250204,
      141500,
      'LBAUTISTA ',
      'Batch job RPTRUNJOB ended with warning  ',
      '2'
    ),
    (
      1250205,
      100025,
      'MVASQUEZ  ',
      'Customer refund REF-0992 processed      ',
      '0'
    ),
    (
      1250205,
      153045,
      'GFOSTER   ',
      'Scheduled maintenance window opened     ',
      '0'
    ),
    (
      1250206,
      73500,
      'KPETROVA  ',
      'Inventory reorder triggered for SKU-441 ',
      '0'
    ),
    (
      1250206,
      120000,
      'DTOBIAS   ',
      'Contract SVC-2200 first milestone met   ',
      '0'
    ),
    (
      1250207,
      84515,
      'SSVENSSON ',
      'User AWILLIAMS login from new IP addr   ',
      '2'
    ),
    (
      1250207,
      165030,
      'JOKONKWO  ',
      'PO-6610 goods received and verified     ',
      '0'
    ),
    -- March 2025
    (
      1250303,
      75545,
      'CFLANAGAN ',
      'Financial period Q1 close initiated     ',
      '0'
    ),
    (
      1250303,
      102100,
      'MVASQUEZ  ',
      'Credit limit raised for account #7741   ',
      '0'
    ),
    (
      1250304,
      83015,
      'HBERGMANN ',
      'Scheduled report WKLY-SALES generated   ',
      '0'
    ),
    (
      1250304,
      140530,
      'LBAUTISTA ',
      'Approval workflow stage 3 timed out     ',
      '2'
    ),
    (
      1250305,
      91045,
      'RMCALLUM  ',
      'Q1 payroll reconciliation completed     ',
      '0'
    ),
    (
      1250305,
      155600,
      'TNAKAMURA ',
      'APPSRV02 disk extended - capacity OK    ',
      '0'
    ),
    (
      1250306,
      80115,
      'AWILLIAMS ',
      'Order #10044 shipped to customer        ',
      '0'
    ),
    (
      1250306,
      113130,
      'CFLANAGAN ',
      'Q1 close completed - books locked       ',
      '0'
    ),
    (
      1250307,
      84645,
      'HBERGMANN ',
      'Database backup DB-MAIN completed       ',
      '0'
    ),
    (
      1250307,
      162200,
      'PCHANDRA  ',
      'Duplicate invoice INV-8820 flagged      ',
      '2'
    ),
    -- April 2025
    (
      1250401,
      73200,
      'JOKONKWO  ',
      'New hire YMOREAU account created        ',
      '0'
    ),
    (
      1250401,
      104515,
      'SSVENSSON ',
      'User RMCALLUM unlocked after lockout    ',
      '0'
    ),
    (
      1250402,
      81030,
      'MVASQUEZ  ',
      'Customer account GLOBEX Corp suspended  ',
      '2'
    ),
    (
      1250402,
      145045,
      'YMOREAU   ',
      'First login - profile setup completed   ',
      '0'
    ),
    (
      1250403,
      90600,
      'GFOSTER   ',
      'Maintenance window closed - all OK      ',
      '0'
    ),
    (
      1250403,
      121115,
      'KPETROVA  ',
      'SKU-441 restock received and counted    ',
      '0'
    ),
    (
      1250404,
      75630,
      'DTOBIAS   ',
      'Supplier contract SVC-2201 drafted      ',
      '0'
    ),
    (
      1250404,
      153145,
      'CFLANAGAN ',
      'Expense reports Q1 submitted for audit  ',
      '0'
    ),
    (
      1250407,
      84200,
      'HBERGMANN ',
      'Report WKLY-SALES format changed        ',
      '0'
    ),
    (
      1250407,
      170715,
      'AWILLIAMS ',
      'Order #10045 cancelled by customer      ',
      '2'
    ),
    -- May 2025
    (
      1250502,
      72815,
      'TNAKAMURA ',
      'Security scan SECCRON job started       ',
      '0'
    ),
    (
      1250502,
      113330,
      'PCHANDRA  ',
      'INV-8820 duplicate resolved - deleted   ',
      '0'
    ),
    (
      1250505,
      80845,
      'JOKONKWO  ',
      'PO-6620 raised for office supplies      ',
      '0'
    ),
    (
      1250505,
      142400,
      'MVASQUEZ  ',
      'GLOBEX Corp account reactivated         ',
      '0'
    ),
    (
      1250506,
      91415,
      'SSVENSSON ',
      'Patch PTFA02 applied to APPSRV01        ',
      '0'
    ),
    (
      1250506,
      154930,
      'LBAUTISTA ',
      'Batch RPTRUNJOB completed successfully  ',
      '0'
    ),
    (
      1250507,
      75945,
      'YMOREAU   ',
      'Report WKLY-SALES first run by YMOREAU ',
      '0'
    ),
    (
      1250507,
      120500,
      'CFLANAGAN ',
      'Mid-year budget forecast submitted      ',
      '0'
    ),
    (
      1250508,
      83515,
      'RMCALLUM  ',
      'May payroll run completed               ',
      '0'
    ),
    (
      1250508,
      165030,
      'KPETROVA  ',
      'SKU-887 count reconciled - variance 0   ',
      '0'
    ),
    -- June 2025
    (
      1250602,
      74030,
      'GFOSTER   ',
      'Delivery route RT-09 optimised          ',
      '0'
    ),
    (
      1250602,
      110545,
      'HBERGMANN ',
      'APPSRV01 rebooted after patch           ',
      '2'
    ),
    (
      1250603,
      82100,
      'DTOBIAS   ',
      'SVC-2201 contract signed - active now   ',
      '0'
    ),
    (
      1250603,
      143615,
      'AWILLIAMS ',
      'Order #10046 expedited per mgmt req     ',
      '0'
    ),
    (
      1250604,
      91130,
      'TNAKAMURA ',
      'Security scan found 2 expired certs     ',
      '2'
    ),
    (
      1250604,
      160145,
      'PCHANDRA  ',
      'Certs renewed - SECCRON rerun clean     ',
      '0'
    ),
    (
      1250605,
      75700,
      'JOKONKWO  ',
      'PO-6620 goods received - all correct    ',
      '0'
    ),
    (
      1250605,
      124215,
      'YMOREAU   ',
      'Quarterly KPI dashboard refreshed       ',
      '0'
    ),
    (
      1250606,
      83730,
      'MVASQUEZ  ',
      'Customer ACME Corp credit review done   ',
      '0'
    ),
    (
      1250606,
      165245,
      'SSVENSSON ',
      'APPSRV01 confirmed stable post reboot   ',
      '0'
    ),
    -- July 2025
    (
      1250701,
      72245,
      'CFLANAGAN ',
      'H1 financial close initiated            ',
      '0'
    ),
    (
      1250701,
      105800,
      'LBAUTISTA ',
      'Approval workflow redesign deployed     ',
      '0'
    ),
    (
      1250702,
      81315,
      'RMCALLUM  ',
      'June payroll reconciliation started     ',
      '0'
    ),
    (
      1250702,
      143830,
      'KPETROVA  ',
      'SKU-112 set to discontinued status      ',
      '2'
    ),
    (
      1250703,
      90345,
      'HBERGMANN ',
      'DB-MAIN full backup completed           ',
      '0'
    ),
    (
      1250703,
      162400,
      'GFOSTER   ',
      'SHP-3400 delayed - carrier issue noted  ',
      '2'
    ),
    (
      1250704,
      74915,
      'AWILLIAMS ',
      'Order #10047 part shipped to customer   ',
      '0'
    ),
    (
      1250704,
      120930,
      'DTOBIAS   ',
      'Supplier SVC-2200 contract renewed      ',
      '0'
    ),
    (
      1250707,
      83445,
      'TNAKAMURA ',
      'APPSRV02 patched - PTFA03 applied       ',
      '0'
    ),
    (
      1250707,
      154000,
      'CFLANAGAN ',
      'H1 close completed ahead of schedule    ',
      '0'
    ),
    -- August 2025
    (
      1250804,
      73000,
      'PCHANDRA  ',
      'INV-9100 raised for Q3 stock build      ',
      '0'
    ),
    (
      1250804,
      110515,
      'JOKONKWO  ',
      'PO-6630 approved and sent to supplier   ',
      '0'
    ),
    (
      1250805,
      81530,
      'MVASQUEZ  ',
      'Customer GLOBEX Corp address updated    ',
      '0'
    ),
    (
      1250805,
      144045,
      'YMOREAU   ',
      'August KPI targets entered into system  ',
      '0'
    ),
    (
      1250806,
      90600,
      'SSVENSSON ',
      'User HBERGMANN account locked out       ',
      '2'
    ),
    (
      1250806,
      162615,
      'HBERGMANN ',
      'Account unlocked - correct creds used   ',
      '0'
    ),
    (
      1250807,
      74130,
      'LBAUTISTA ',
      'Workflow stage 1 auto-rejected - resent ',
      '2'
    ),
    (
      1250807,
      121645,
      'RMCALLUM  ',
      'August payroll data entry completed     ',
      '0'
    ),
    (
      1250808,
      83200,
      'KPETROVA  ',
      'SKU-441 batch B-095 quarantined QC fail ',
      '2'
    ),
    (
      1250808,
      165715,
      'GFOSTER   ',
      'SHP-3400 carrier issue resolved         ',
      '0'
    ),
    -- September 2025
    (
      1250901,
      72715,
      'AWILLIAMS ',
      'Order #10048 confirmed and scheduled    ',
      '0'
    ),
    (
      1250901,
      105230,
      'DTOBIAS   ',
      'SVC-2201 first quarterly review done    ',
      '0'
    ),
    (
      1250902,
      81745,
      'CFLANAGAN ',
      'Q3 forecast vs actuals review started   ',
      '0'
    ),
    (
      1250902,
      143300,
      'TNAKAMURA ',
      'APPSRV01 memory upgraded to 32 GB       ',
      '0'
    ),
    (
      1250903,
      90815,
      'PCHANDRA  ',
      'INV-9100 approved and forwarded         ',
      '0'
    ),
    (
      1250903,
      162330,
      'JOKONKWO  ',
      'PO-6630 part-delivery received          ',
      '0'
    ),
    (
      1250904,
      74345,
      'MVASQUEZ  ',
      'ACME Corp order credit limit warning    ',
      '2'
    ),
    (
      1250904,
      120900,
      'YMOREAU   ',
      'Q3 KPI report submitted to management   ',
      '0'
    ),
    (
      1250905,
      83415,
      'SSVENSSON ',
      'Password policy updated - 90 day expiry ',
      '0'
    ),
    (
      1250905,
      165930,
      'HBERGMANN ',
      'DB-MAIN index rebuild completed         ',
      '0'
    ),
    -- October 2025
    (
      1251001,
      73930,
      'LBAUTISTA ',
      'Approval workflow updated for Q4 rules  ',
      '0'
    ),
    (
      1251001,
      111445,
      'RMCALLUM  ',
      'September payroll run completed         ',
      '0'
    ),
    (
      1251002,
      82000,
      'KPETROVA  ',
      'SKU-441 batch B-095 quarantine lifted   ',
      '0'
    ),
    (
      1251002,
      150015,
      'GFOSTER   ',
      'SHP-3415 dispatched - on schedule       ',
      '0'
    ),
    (
      1251003,
      91030,
      'AWILLIAMS ',
      'Order #10049 held - payment overdue     ',
      '2'
    ),
    (
      1251003,
      163545,
      'CFLANAGAN ',
      'Q3 close completed - actuals posted     ',
      '0'
    );

-- Verify insert count
select count(*) as TOTAL_ROWS
  from SORTSFLPF;


-- Display sample of inserted data
select *
  from SORTSFLPF
  order by SORTDATE,
           SORTTIME
  fetch first 50 rows only;