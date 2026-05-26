     /*-                                                                            +
      * Copyright (c) 2005-2011 Scott C. Klement                                    +
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
      /if defined(SQLCLI_H_DEFINED)
      /eof
      /endif
      /define SQLCLI_H_DEFINED

      *
      * General purpose constants
      *
     D SQL_FALSE       C                   0
     D SQL_TRUE        C                   1
     D SQL_NTS         C                   -3
     D SQL_SQLSTATE_SIZE...
     D                 C                   5
     D SQL_MAX_MESSAGE_LENGTH...
     D                 C                   512
     D SQL_MAX_OPTION_STRING_LENGTH...
     D                 C                   128

      *
      * return values
      *
     D SQL_SUCCESS     c                   0
     D SQL_SUCCESS_WITH_INFO...
     D                 c                   1
     D SQL_NO_DATA_FOUND...
     D                 c                   100
     D SQL_NEED_DATA...
     D                 c                   99
     D SQL_NO_DATA...
     D                 c                   100
     D SQL_ERROR       c                   -1
     D SQL_INVALID_HANDLE...
     D                 c                   -2
     D SQL_STILL_EXECUTING...
     D                 c                   2
     D SQL_ROW_SUCCESS...
     D                 c                   0
     D SQL_ROW_NOROW...
     D                 c                   -1

      *
      * values for SQLFreeStmt
      *
     D SQL_CLOSE       c                   0
     D SQL_DROP        c                   1
     D SQL_UNBIND      c                   2
     D SQL_RESET_PARAMS...
     D                 c                   3

      *
      *  SQLSetParam defines
      *
     D SQL_C_DEFAULT   c                   99

      *
      * SqlEndTran option values
      *
     D SQL_COMMIT...
     D                 C                   0
     D SQL_ROLLBACK...
     D                 C                   1
     D SQL_COMMIT_HOLD...
     D                 C                   2
     D SQL_ROLLBACK_HOLD...
     D                 C                   3
     D SQL_SAVEPOINT_NAME_RELEASE...
     D                 C                   4
     D SQL_SAVEPOINT_NAME_ROLLBACK...
     D                 C                   5

      *
      * SQLDriverConnect option values
      *
     D SQL_DRIVER_COMPLETE...
     D                 C                   1
     D SQL_DRIVER_COMPLETE_REQUIRED...
     D                 C                   1
     D SQL_DRIVER_NOPROMPT...
     D                 C                   1
     D SQL_DRIVER_PROMPT...
     D                 C                   0

      *
      * Valid option codes for GetInfo procedure
      *
     D SQL_ACTIVE_CONNECTIONS...
     D                 C                   0
     D SQL_MAX_DRIVER_CONNECTIONS...
     D                 C                   0
     D SQL_MAX_CONCURRENT_ACTIVITIES...
     D                 C                   1
     D SQL_ACTIVE_STATEMENTS...
     D                 C                   1
     D SQL_PROCEDURES...
     D                 C                   2
     D SQL_DRIVER_NAME...
     D                 C                   6
     D SQL_ODBC_API_CONFORMANCE...
     D                 C                   9
     D SQL_ODBC_SQL_CONFORMANCE...
     D                 C                   10
     D SQL_DBMS_NAME...
     D                 C                   17
     D SQL_DBMS_VER...
     D                 C                   18
     D SQL_DRIVER_VER...
     D                 C                   18
     D SQL_IDENTIFIER_CASE...
     D                 C                   28
     D SQL_IDENTIFIER_QUOTE_CHAR...
     D                 C                   29
     D SQL_MAX_COLUMN_NAME_LEN...
     D                 C                   30
     D SQL_MAX_CURSOR_NAME_LEN...
     D                 C                   31
     D SQL_MAX_OWNER_NAME_LEN...
     D                 C                   32
     D SQL_MAX_SCHEMA_NAME_LEN...
     D                 C                   33
     D SQL_MAX_TABLE_NAME_LEN...
     D                 C                   35
     D SQL_MAX_COLUMNS_IN_GROUP_BY...
     D                 C                   36
     D SQL_MAX_COLUMNS_IN_ORDER_BY...
     D                 C                   37
     D SQL_MAX_COLUMNS_IN_SELECT...
     D                 C                   38
     D SQL_MAX_COLUMNS_IN_TABLE...
     D                 C                   39
     D SQL_MAX_TABLES_IN_SELECT...
     D                 C                   40
     D SQL_COLUMN_ALIAS...
     D                 C                   41
     D SQL_DATA_SOURCE_NAME...
     D                 C                   42
     D SQL_DATASOURCE_NAME...
     D                 C                   42
     D SQL_DATABASE_NAME...
     D                 C                   42
     D SQL_MAX_COLUMNS_IN_INDEX...
     D                 C                   43
     D SQL_PROCEDURE_TERM...
     D                 C                   44
     D SQL_QUALIFIER_TERM...
     D                 C                   45
     D SQL_TXN_CAPABLE...
     D                 C                   46
     D SQL_OWNER_TERM...
     D                 C                   47
     D SQL_DATA_SOURCE_READ_ONLY...
     D                 C                   48
     D SQL_DEFAULT_TXN_ISOLATION...
     D                 C                   49
     D SQL_MULTIPLE_ACTIVE_TXN...
     D                 C                   55
     D SQL_QUALIFIER_NAME_SEPARATOR...
     D                 C                   65
     D SQL_CORRELATION_NAME...
     D                 C                   74
     D SQL_NON_NULLABLE_COLUMNS...
     D                 C                   75
     D SQL_DRIVER_ODBC_VER...
     D                 C                   77
     D SQL_GROUP_BY...
     D                 C                   88
     D SQL_ORDER_BY_COLUMNS_IN_SELECT...
     D                 C                   90
     D SQL_OWNER_USAGE...
     D                 C                   91
     D SQL_QUALIFIER_USAGE...
     D                 C                   92
     D SQL_QUOTED_IDENTIFIER_CASE...
     D                 C                   93
     D SQL_MAX_ROW_SIZE...
     D                 C                   104
     D SQL_QUALIFIER_LOCATION...
     D                 C                   114
     D SQL_MAX_CATALOG_NAME_LEN...
     D                 C                   115
     D SQL_MAX_STATEMENT_LEN...
     D                 C                   116
     D SQL_SEARCH_PATTERN_ESCAPE...
     D                 C                   117
     D SQL_OUTER_JOINS...
     D                 C                   118
     D SQL_LIKE_ESCAPE_CLAUSE...
     D                 C                   119
     D SQL_CATALOG_NAME...
     D                 C                   120
     D SQL_DESCRIBE_PARAMETER...
     D                 C                   121
     D SQL_STRING_FUNCTIONS...
     D                 C                   50
     D SQL_NUMERIC_FUNCTIONS...
     D                 C                   51
     D SQL_CONVERT_FUNCTIONS...
     D                 C                   52
     D SQL_TIMEDATE_FUNCTIONS...
     D                 C                   53
     D SQL_SQL92_PREDICATES...
     D                 C                   160
     D SQL_SQL92_VALUE_EXPRESSIONS...
     D                 C                   165
     D SQL_AGGREGATE_FUNCTIONS...
     D                 C                   169
     D SQL_SQL_CONFORMANCE...
     D                 C                   170
     D SQL_CONVERT_CHAR...
     D                 C                   171
     D SQL_CONVERT_NUMERIC...
     D                 C                   172
     D SQL_CONVERT_DECIMAL...
     D                 C                   173
     D SQL_CONVERT_INTEGER...
     D                 C                   174
     D SQL_CONVERT_SMALLINT...
     D                 C                   175
     D SQL_CONVERT_FLOAT...
     D                 C                   176
     D SQL_CONVERT_REAL...
     D                 C                   177
     D SQL_CONVERT_DOUBLE...
     D                 C                   178
     D SQL_CONVERT_VARCHAR...
     D                 C                   179
     D SQL_CONVERT_LONGVARCHAR...
     D                 C                   180
     D SQL_CONVERT_BINARY...
     D                 C                   181
     D SQL_CONVERT_VARBINARY...
     D                 C                   182
     D SQL_CONVERT_BIT...
     D                 C                   183
     D SQL_CONVERT_TINYINT...
     D                 C                   184
     D SQL_CONVERT_BIGINT...
     D                 C                   185
     D SQL_CONVERT_DATE...
     D                 C                   186
     D SQL_CONVERT_TIME...
     D                 C                   187
     D SQL_CONVERT_TIMESTAMP...
     D                 C                   188
     D SQL_CONVERT_LONGVARBINARY...
     D                 C                   189
     D SQL_CONVERT_INTERVAL_YEAR_MONTH...
     D                 C                   190
     D SQL_CONVERT_INTERVAL_DAY_TIME...
     D                 C                   191
     D SQL_CONVERT_WCHAR...
     D                 C                   192
     D SQL_CONVERT_WLONGVARCHAR...
     D                 C                   193
     D SQL_CONVERT_WVARCHAR...
     D                 C                   194
     D SQL_CONVERT_BLOB...
     D                 C                   195
     D SQL_CONVERT_CLOB...
     D                 C                   196
     D SQL_CONVERT_DBCLOB...
     D                 C                   197
     D SQL_CURSOR_COMMIT_BEHAVIOR...
     D                 C                   198
     D SQL_CURSOR_ROLLBACK_BEHAVIOR...
     D                 C                   199
     D SQL_POSITIONED_STATEMENTS...
     D                 C                   200
     D SQL_KEYWORDS...
     D                 C                   201
     D SQL_CONNECTION_JOB_NAME...
     D                 C                   202


      *
      * Aliased option codes (ODBC 3.0)
      *
     D SQL_SCHEMA_TERM...
     D                 C                   47
     D SQL_SCHEMA_USAGE...
     D                 C                   91
     D SQL_CATALOG_LOCATION...
     D                 C                   114
     D SQL_CATALOG_TERM...
     D                 C                   45
     D SQL_CATALOG_USAGE...
     D                 C                   92
     D SQL_CATALOG_NAME_SEPARATOR...
     D                 C                   65

      *
      * Output values for SQL_ODBC_API_CONFORMANCE
      * info type in SQLGetInfo
      *
     D SQL_OAC_NONE...
     D                 C                   0
     D SQL_OAC_LEVEL1...
     D                 C                   1
     D SQL_OAC_LEVEL2...
     D                 C                   2

      *
      * Output values for SQL_ODBC_SQL_CONFORMANCE
      * info type in SQLGetInfo
      *
     D SQL_OSC_MINIMUM...
     D                 C                   0
     D SQL_OSC_CORE...
     D                 C                   1
     D SQL_OSC_EXTENDED...
     D                 C                   2

      *
      * Output values for SQL_QUALIFIER_USAGE
      * info type in SQLGetInfo
      *
     D SQL_QU_NOT_SUPPORTED...
     D                 C                   x'00000000'
     D SQL_QU_DML_STATEMENTS...
     D                 C                   x'00000001'
     D SQL_QU_PROCEDURE_INVOCATION...
     D                 C                   x'00000002'
     D SQL_QU_TABLE_DEFINITION...
     D                 C                   x'00000004'
     D SQL_QU_INDEX_DEFINITION...
     D                 C                   x'00000008'
     D SQL_QU_PRIVILEGE_DEFINITION...
     D                 C                   x'00000010'

      *
      * Output values for SQL_QUALIFIER_LOCATION
      * info type in SQLGetInfo
      *
     D SQL_QL_START...
     D                 C                   1
     D SQL_QL_END...
     D                 C                   2

      *
      * Output values for SQL_OWNER_USAGE
      * info type in SQLGetInfo
      *
     D SQL_OU_DML_STATEMENTS...
     D                 C                   x'00000001'
     D SQL_OU_PROCEDURE_INVOCATION...
     D                 C                   x'00000002'
     D SQL_OU_TABLE_DEFINITION...
     D                 C                   x'00000004'
     D SQL_OU_INDEX_DEFINITION...
     D                 C                   x'00000008'
     D SQL_OU_PRIVILEGE_DEFINITION...
     D                 C                   x'00000010'

      *
      * Output values for SQL_TXN_CAPABLE
      * info type in SQLGetInfo
      *
     D SQL_TC_NONE...
     D                 C                   0
     D SQL_TC_DML...
     D                 C                   1
     D SQL_TC_ALL...
     D                 C                   2
     D SQL_TC_DDL_COMMIT...
     D                 C                   3
     D SQL_TC_DDL_IGNORE...
     D                 C                   4

      *
      * Output values for SQL_DEFAULT_TXN_ISOLATION
      * info type in SQLGetInfo
      *
     D SQL_TXN_READ_UNCOMMITTED_MASK...
     D                 C                   x'00000001'
     D SQL_TXN_READ_COMMITTED_MASK...
     D                 C                   x'00000002'
     D SQL_TXN_REPEATABLE_READ_MASK...
     D                 C                   x'00000004'
     D SQL_TXN_SERIALIZABLE_MASK...
     D                 C                   x'00000008'

      *
      * Output values for SQL_STRING_FUNCTIONS
      * info type in SQLGetInfo
      *
     D SQL_FN_STR_CONCAT...
     D                 C                   x'00000001'
     D SQL_FN_STR_UCASE...
     D                 C                   x'00000002'
     D SQL_FN_STR_LCASE...
     D                 C                   x'00000004'
     D SQL_FN_STR_SUBSTRING...
     D                 C                   x'00000008'
     D SQL_FN_STR_LENGTH...
     D                 C                   x'00000010'
     D SQL_FN_STR_POSITION...
     D                 C                   x'00000020'
     D SQL_FN_STR_LTRIM...
     D                 C                   x'00000040'
     D SQL_FN_STR_RTRIM...
     D                 C                   x'00000080'

      *
      * Output values for SQL_NUMERIC_FUNCTIONS
      * info type in SQLGetInfo
      *
     D SQL_FN_NUM_ABS...
     D                 C                   x'00000001'
     D SQL_FN_NUM_ACOS...
     D                 C                   x'00000002'
     D SQL_FN_NUM_ASIN...
     D                 C                   x'00000004'
     D SQL_FN_NUM_ATAN...
     D                 C                   x'00000008'
     D SQL_FN_NUM_ATAN2...
     D                 C                   x'00000010'
     D SQL_FN_NUM_CEILING...
     D                 C                   x'00000020'
     D SQL_FN_NUM_COS...
     D                 C                   x'00000040'
     D SQL_FN_NUM_COT...
     D                 C                   x'00000080'
     D SQL_FN_NUM_EXP...
     D                 C                   x'00000100'
     D SQL_FN_NUM_FLOOR...
     D                 C                   x'00000200'
     D SQL_FN_NUM_LOG...
     D                 C                   x'00000400'
     D SQL_FN_NUM_MOD...
     D                 C                   x'00000800'
     D SQL_FN_NUM_SIGN...
     D                 C                   x'00001000'
     D SQL_FN_NUM_SIN...
     D                 C                   x'00002000'
     D SQL_FN_NUM_SQRT...
     D                 C                   x'00004000'
     D SQL_FN_NUM_TAN...
     D                 C                   x'00008000'
     D SQL_FN_NUM_PI...
     D                 C                   x'00010000'
     D SQL_FN_NUM_RAND...
     D                 C                   x'00020000'
     D SQL_FN_NUM_DEGREES...
     D                 C                   x'00040000'
     D SQL_FN_NUM_LOG10...
     D                 C                   x'00080000'
     D SQL_FN_NUM_POWER...
     D                 C                   x'00100000'
     D SQL_FN_NUM_RADIANS...
     D                 C                   x'00200000'
     D SQL_FN_NUM_ROUND...
     D                 C                   x'00400000'
     D SQL_FN_NUM_TRUNCATE...
     D                 C                   x'00800000'

      *
      * SQL_SQL92_VALUE_EXPRESSIONS bitmasks
      *
     D SQL_SVE_CASE...
     D                 C                   x'00000001'
     D SQL_SVE_CAST...
     D                 C                   x'00000002'
     D SQL_SVE_COALESCE...
     D                 C                   x'00000004'
     D SQL_SVE_NULLIF...
     D                 C                   x'00000008'

      *
      * SQL_SQL92_PREDICATES bitmasks
      *
     D SQL_SP_EXISTS...
     D                 C                   x'00000001'
     D SQL_SP_ISNOTNULL...
     D                 C                   x'00000002'
     D SQL_SP_ISNULL...
     D                 C                   x'00000004'
     D SQL_SP_MATCH_FULL...
     D                 C                   x'00000008'
     D SQL_SP_MATCH_PARTIAL...
     D                 C                   x'00000010'
     D SQL_SP_MATCH_UNIQUE_FULL...
     D                 C                   x'00000020'
     D SQL_SP_MATCH_UNIQUE_PARTIAL...
     D                 C                   x'00000040'
     D SQL_SP_OVERLAPS...
     D                 C                   x'00000080'
     D SQL_SP_UNIQUE...
     D                 C                   x'00000100'
     D SQL_SP_LIKE...
     D                 C                   x'00000200'
     D SQL_SP_IN...
     D                 C                   x'00000400'
     D SQL_SP_BETWEEN...
     D                 C                   x'00000800'
     D SQL_SP_COMPARISON...
     D                 C                   x'00001000'
     D SQL_SP_QUANTIFIED_COMPARISON...
     D                 C                   x'00002000'

      *
      * SQL_SQL92_AGGREGATE_FUNCTIONS bitmasks
      *
     D SQL_AF_AVG...
     D                 C                   x'00000001'
     D SQL_AF_COUNT...
     D                 C                   x'00000002'
     D SQL_AF_MAX...
     D                 C                   x'00000004'
     D SQL_AF_MIN...
     D                 C                   x'00000008'
     D SQL_AF_SUM...
     D                 C                   x'00000010'
     D SQL_AF_DISTINCT...
     D                 C                   x'00000020'
     D SQL_AF_ALL...
     D                 C                   x'00000040'

      *
      * SQL_SQL_CONFORMANCE bitmasks
      *
     D SQL_SC_SQL92_ENTRY...
     D                 C                   x'00000001'
     D SQL_SC_FIPS127_2_TRANSITIONAL...
     D                 C                   x'00000002'
     D SQL_SC_SQL92_INTERMEDIATE...
     D                 C                   x'00000004'
     D SQL_SC_SQL92_FULL...
     D                 C                   x'00000008'

      *
      * SQL_CONVERT_FUNCTIONS bitmasks
      *
     D SQL_FN_CVT_CONVERT...
     D                 C                   x'00000001'
     D SQL_FN_CVT_CAST...
     D                 C                   x'00000002'

      *
      * SQL_POSITIONED_STATEMENTS bitmasks
      *
     D SQL_PS_POSITIONED_DELETE...
     D                 C                   x'00000001'
     D SQL_PS_POSITIONED_UPDATE...
     D                 C                   x'00000002'
     D SQL_PS_SELECT_FOR_UPDATE...
     D                 C                   x'00000004'

      *
      * SQL supported conversion bitmasks
      *
     D SQL_CVT_CHAR...
     D                 C                   x'00000001'
     D SQL_CVT_NUMERIC...
     D                 C                   x'00000002'
     D SQL_CVT_DECIMAL...
     D                 C                   x'00000004'
     D SQL_CVT_INTEGER...
     D                 C                   x'00000008'
     D SQL_CVT_SMALLINT...
     D                 C                   x'00000010'
     D SQL_CVT_FLOAT...
     D                 C                   x'00000020'
     D SQL_CVT_REAL...
     D                 C                   x'00000040'
     D SQL_CVT_DOUBLE...
     D                 C                   x'00000080'
     D SQL_CVT_VARCHAR...
     D                 C                   x'00000100'
     D SQL_CVT_LONGVARCHAR...
     D                 C                   x'00000200'
     D SQL_CVT_BINARY...
     D                 C                   x'00000400'
     D SQL_CVT_VARBINARY...
     D                 C                   x'00000800'
     D SQL_CVT_BIT...
     D                 C                   x'00001000'
     D SQL_CVT_TINYINT...
     D                 C                   x'00002000'
     D SQL_CVT_BIGINT...
     D                 C                   x'00004000'
     D SQL_CVT_DATE...
     D                 C                   x'00008000'
     D SQL_CVT_TIME...
     D                 C                   x'00010000'
     D SQL_CVT_TIMESTAMP...
     D                 C                   x'00020000'
     D SQL_CVT_LONGVARBINARY...
     D                 C                   x'00040000'
     D SQL_CVT_INTERVAL_YEAR_MONTH...
     D                 C                   x'00080000'
     D SQL_CVT_INTERVAL_DAY_TIME...
     D                 C                   x'00100000'
     D SQL_CVT_WCHAR...
     D                 C                   x'00200000'
     D SQL_CVT_WLONGVARCHAR...
     D                 C                   x'00400000'
     D SQL_CVT_WVARCHAR...
     D                 C                   x'00800000'
     D SQL_CVT_BLOB...
     D                 C                   x'01000000'
     D SQL_CVT_CLOB...
     D                 C                   x'02000000'
     D SQL_CVT_DBCLOB...
     D                 C                   x'04000000'

      *
      * SQL_TIMEDATE_FUNCTIONS bitmasks
      *
     D SQL_FN_TD_NOW...
     D                 C                   x'00000001'
     D SQL_FN_TD_CURDATE...
     D                 C                   x'00000002'
     D SQL_FN_TD_DAYOFMONTH...
     D                 C                   x'00000004'
     D SQL_FN_TD_DAYOFWEEK...
     D                 C                   x'00000008'
     D SQL_FN_TD_DAYOFYEAR...
     D                 C                   x'00000010'
     D SQL_FN_TD_MONTH...
     D                 C                   x'00000020'
     D SQL_FN_TD_QUARTER...
     D                 C                   x'00000040'
     D SQL_FN_TD_WEEK...
     D                 C                   x'00000080'
     D SQL_FN_TD_YEAR...
     D                 C                   x'00000100'
     D SQL_FN_TD_CURTIME...
     D                 C                   x'00000200'
     D SQL_FN_TD_HOUR...
     D                 C                   x'00000400'
     D SQL_FN_TD_MINUTE...
     D                 C                   x'00000800'
     D SQL_FN_TD_SECOND...
     D                 C                   x'00001000'
     D SQL_FN_TD_TIMESTAMPADD...
     D                 C                   x'00002000'
     D SQL_FN_TD_TIMESTAMPDIFF...
     D                 C                   x'00004000'
     D SQL_FN_TD_DAYNAME...
     D                 C                   x'00008000'
     D SQL_FN_TD_MONTHNAME...
     D                 C                   x'00010000'
     D SQL_FN_TD_CURRENT_DATE...
     D                 C                   x'00020000'
     D SQL_FN_TD_CURRENT_TIME...
     D                 C                   x'00040000'
     D SQL_FN_TD_CURRENT_TIMESTAMP...
     D                 C                   x'00080000'
     D SQL_FN_TD_EXTRACT...
     D                 C                   x'00100000'

      *
      * Output values for SQL_CORRELATION_NAME
      * info type in SQLGetInfo
      *
     D SQL_CN_NONE...
     D                 C                   0
     D SQL_CN_DIFFERENT...
     D                 C                   1
     D SQL_CN_ANY...
     D                 C                   2

      *
      * Output values for SQL_IDENTIFIER_CASE
      * info type in SQLGetInfo
      *
     D SQL_IC_UPPER...
     D                 C                   1
     D SQL_IC_LOWER...
     D                 C                   2
     D SQL_IC_SENSITIVE...
     D                 C                   3
     D SQL_IC_MIXED...
     D                 C                   4

      *
      * Output values for SQL_NON_NULLABLE_COLUMNS
      * info type in SQLGetInfo
      *
     D SQL_NNC_NULL...
     D                 C                   0
     D SQL_NNC_NON_NULL...
     D                 C                   1

      *
      * Output values for SQL_GROUP_BY
      * info type in SQLGetInfo
      *
     D SQL_GB_NO_RELATION...
     D                 C                   0
     D SQL_GB_NOT_SUPPORTED...
     D                 C                   1
     D SQL_GB_GROUP_BY_EQUALS_SELECT...
     D                 C                   2
     D SQL_GB_GROUP_BY_CONTAINS_SELECT...
     D                 C                   3

      *
      * Standard SQL data types
      *
     D SQL_CHAR        C                   1
     D SQL_NUMERIC     C                   2
     D SQL_DECIMAL     C                   3
     D SQL_INTEGER     C                   4
     D SQL_SMALLINT    C                   5
     D SQL_FLOAT       C                   6
     D SQL_REAL        C                   7
     D SQL_DOUBLE      C                   8
     D SQL_DATETIME    C                   9
     D SQL_VARCHAR     C                   12
     D SQL_BLOB        C                   13
     D SQL_CLOB        C                   14
     D SQL_DBCLOB      C                   15
     D SQL_DATALINK    C                   16
     D SQL_WCHAR       C                   17
     D SQL_WUARCHAR    C                   18
     D SQL_BIGINT      C                   19
     D SQL_BLOB_LOCATOR...
     D                 C                   20
     D SQL_CLOB_LOCATOR...
     D                 C                   21
     D SQL_DBCLOB_LOCATOR...
     D                 C                   22
     D SQL_UTF8_CHAR...
     D                 C                   23
     D SQL_GRAPHIC     C                   95
     D SQL_VARGRAPHIC  C                   96
     D SQL_BINARY      C                   97
     D SQL_VARBINARY   C                   98
     D SQL_DATE        C                   91
     D SQL_TYPE_DATE   C                   91
     D SQL_TIME        C                   92
     D SQL_TYPE_TIME   C                   92
     D SQL_TIMESTAMP   C                   93
     D SQL_TYPE_TIMESTAMP...
     D                 C                   93
     D SQL_ALL_TYPES   C                   0
      *
      * Output values for cursor behavior
      *
     D SQL_CB_DELETE...
     D                 C                   1
     D SQL_CB_CLOSE...
     D                 C                   2
     D SQL_CB_PRESERVE...
     D                 C                   3

      *
      * Templates for SQL data types
      *
     D SQLSMALLINT     s              5I 0 based(Template)
     D SQLUSMALLINT    s              5U 0 based(Template)
     D SQLUINTEGER     s             10U 0 based(Template)
     D SQLDOUBLE       s              8F   based(Template)
     D SQLREAL         s              4F   based(Template)
     D SQLINTEGER      s             10I 0 based(Template)
     D SQLHENV         s             10I 0 based(Template)
     D SQLHDBC         s             10I 0 based(Template)
     D SQLHSTMT        s             10I 0 based(Template)
     D SQLHDESC        s             10I 0 based(Template)
     D SQLHANDLE       s             10I 0 based(Template)
     D SQLRETURN       s                   like(SQLINTEGER) based(Template)
     D SFLOAT          s              4F   based(Template)
     D SQLPOINTER      s               *   based(Template)
     D SQLHWND         s               *   based(Template)

      *
      * Handle types
      *
     D SQL_UNUSED...
     D                 C                   0
     D SQL_HANDLE_ENV...
     D                 C                   1
     D SQL_HANDLE_DBC...
     D                 C                   2
     D SQL_HANDLE_STMT...
     D                 C                   3
     D SQL_HANDLE_DESC...
     D                 C                   4
     D SQL_NULL_HANDLE...
     D                 C                   0
     D SQL_HANDLE_DBC_UNICODE...
     D                 C                   100

      *
      * NULL status constants; these are used in SQLColAttributes,
      *  SQLDescribeCol, to describe the nullability of a column
      *  in a table.
      *
     D SQL_NO_NULLS...
     D                 C                   0
     D SQL_NULLABLE...
     D                 C                   1
     D SQL_NULLABLE_UNKNOWN...
     D                 C                   2

      *
      * Special length values
      *
     D SQL_NO_TOTAL...
     D                 C                   0
     D SQL_NULL_DATA...
     D                 C                   -1
     D SQL_DATA_AT_EXEC...
     D                 C                   -2
     D SQL_BIGINT_PREC...
     D                 C                   19
     D SQL_INTEGER_PREC...
     D                 C                   10
     D SQL_SMALLINT_PREC...
     D                 C                   5

      *
      * SQLColAttributes constants
      *
     D SQL_ATTR_READONLY...
     D                 C                   0
     D SQL_ATTR_WRITE...
     D                 C                   1
     D SQL_ATTR_READWRITE_UNKNOWN...
     D                 C                   2

      *
      * Valid concurrency values
      *
     D SQL_CONCUR_LOCK...
     D                 C                   0
     D SQL_CONCUR_READ_ONLY...
     D                 C                   1
     D SQL_CONCUR_ROWVER...
     D                 C                   3
     D SQL_CONCUR_VALUES...
     D                 C                   4

      *
      * Valid environment attributes
      *
     D SQL_ATTR_OUTPUT_NTS...
     D                 C                   10001
     D SQL_ATTR_SYS_NAMING...
     D                 C                   10002
     D SQL_ATTR_DEFAULT_LIB...
     D                 C                   10003
     D SQL_ATTR_SERVER_MODE...
     D                 C                   10004
     D SQL_ATTR_JOB_SORT_SEQUENCE...
     D                 C                   10005
     D SQL_ATTR_ENVHNDL_COUNTER...
     D                 C                   10009
     D SQL_ATTR_ESCAPE_CHAR...
     D                 C                   10010
     D SQL_ATTR_INCLUDE_NULL_IN_LEN...
     D                 C                   10031
     D SQL_ATTR_UTF8...
     D                 C                   10032
     D SQL_ATTR_SYSCAP...
     D                 C                   10033
     D SQL_ATTR_REQUIRE_PROFILE...
     D                 C                   10034
     D SQL_ATTR_UCS2...
     D                 C                   10035
     D SQL_ATTR_TRUNCATION_RTNC...
     D                 C                   10036

      *
      * Valid environment/connection attributes
      *
     D SQL_ATTR_EXTENDED_COL_INFO...
     D                 C                   10019
     D SQL_ATTR_DATE_FMT...
     D                 C                   10020
     D SQL_ATTR_DATE_SEP...
     D                 C                   10021
     D SQL_ATTR_TIME_FMT...
     D                 C                   10022
     D SQL_ATTR_TIME_SEP...
     D                 C                   10023
     D SQL_ATTR_DECIMAL_SEP...
     D                 C                   10024
     D SQL_ATTR_TXN_INFO...
     D                 C                   10025
     D SQL_ATTR_TXN_EXTERNAL...
     D                 C                   10026
     D SQL_ATTR_2ND_LEVEL_TEXT...
     D                 C                   10027
     D SQL_ATTR_SAVEPOINT_NAME...
     D                 C                   10028
     D SQL_ATTR_TRACE...
     D                 C                   10029
     D SQL_ATTR_MAX_PRECISION...
     D                 C                   10040
     D SQL_ATTR_MAX_SCALE...
     D                 C                   10041
     D SQL_ATTR_MIN_DIVIDE_SCALE...
     D                 C                   10042
     D SQL_ATTR_HEX_LITERALS...
     D                 C                   10043
     D SQL_ATTR_CORRELATOR...
     D                 C                   10044

      *
      * Valid transaction info operations
      *
     D SQL_TXN_FIND...
     D                 C                   1
     D SQL_TXN_CREATE...
     D                 C                   2
     D SQL_TXN_CLEAR...
     D                 C                   3
     D SQL_TXN_END...
     D                 C                   4
     D SQL_TXN_HOLD...
     D                 C                   5

      *
      * Valid environment/connection values
      *
     D SQL_FMT_ISO...
     D                 C                   1
     D SQL_FMT_USA...
     D                 C                   2
     D SQL_FMT_EUR...
     D                 C                   3
     D SQL_FMT_JIS...
     D                 C                   4
     D SQL_FMT_MDY...
     D                 C                   5
     D SQL_FMT_DMY...
     D                 C                   6
     D SQL_FMT_YMD...
     D                 C                   7
     D SQL_FMT_JUL...
     D                 C                   8
     D SQL_FMT_HMS...
     D                 C                   9
     D SQL_FMT_JOB...
     D                 C                   10
     D SQL_SEP_SLASH...
     D                 C                   1
     D SQL_SEP_DASH...
     D                 C                   2
     D SQL_SEP_PERIOD...
     D                 C                   3
     D SQL_SEP_COMMA...
     D                 C                   4
     D SQL_SEP_BLANK...
     D                 C                   5
     D SQL_SEP_COLON...
     D                 C                   6
     D SQL_SEP_JOB...
     D                 C                   7
     D SQL_HEX_IS_CHAR...
     D                 C                   1
     D SQL_HEX_IS_BINARY...
     D                 C                   2

      *
      * Valid values for type in GetCol
      *
     D SQL_DEFAULT...
     D                 C                   99
     D SQL_ARD_TYPE...
     D                 C                   -99

      *
      * Valid values for UPDATE_RULE and DELETE_RULE in SQLForeignKeys
      *
     D SQL_CASCADE...
     D                 C                   1
     D SQL_RESTRICT...
     D                 C                   2
     D SQL_NO_ACTION...
     D                 C                   3
     D SQL_SET_NULL...
     D                 C                   4
     D SQL_SET_DEFAULT...
     D                 C                   5

      *
      * Valid values for COLUMN_TYPE in SQLProcedureColumns
      *
     D SQL_PARAM_INPUT...
     D                 C                   1
     D SQL_PARAM_OUTPUT...
     D                 C                   2
     D SQL_PARAM_INPUT_OUTPUT...
     D                 C                   3

      *
      * Statement attributes
      *
     D SQL_ATTR_APP_ROW_DESC...
     D                 C                   10010
     D SQL_ATTR_APP_PARAM_DESC...
     D                 C                   10011
     D SQL_ATTR_IMP_ROW_DESC...
     D                 C                   10012
     D SQL_ATTR_IMP_PARAM_DESC...
     D                 C                   10013
     D SQL_ATTR_FOR_FETCH_ONLY...
     D                 C                   10014
     D SQL_ATTR_CONCURRENCY...
     D                 C                   10014
     D SQL_CONCURRENCY...
     D                 C                   10014
     D SQL_ATTR_CURSOR_SCROLLABLE...
     D                 C                   10015
     D SQL_ATTR_ROWSET_SIZE...
     D                 C                   10016
     D SQL_ROWSET_SIZE...
     D                 C                   10016
     D SQL_ATTR_ROW_ARRAY_SIZE...
     D                 C                   10016
     D SQL_ATTR_CURSOR_HOLD...
     D                 C                   10017
     D SQL_ATTR_FULL_OPEN...
     D                 C                   10018
     D SQL_ATTR_BIND_TYPE...
     D                 C                   10049
     D SQL_BIND_TYPE...
     D                 C                   10049
     D SQL_ATTR_CURSOR_TYPE...
     D                 C                   10050
     D SQL_CURSOR_TYPE...
     D                 C                   10050
     D SQL_ATTR_CURSOR_SENSITIVITY...
     D                 C                   10051
     D SQL_CURSOR_SENSITIVE...
     D                 C                   10051

      *
      * Values for setting statement attributes
      *
     D SQL_BIND_BY_ROW...
     D                 C                   0
     D SQL_BIND_BY_COLUMN...
     D                 C                   1
     D SQL_CURSOR_FORWARD_ONLY...
     D                 C                   0
     D SQL_CURSOR_STATIC...
     D                 C                   1
     D SQL_CURSOR_DYNAMIC...
     D                 C                   2
     D SQL_CURSOR_KEYSET_DRIVEN...
     D                 C                   3
     D SQL_UNSPECIFIED...
     D                 C                   0
     D SQL_INSENSITIVE...
     D                 C                   1
     D SQL_SENSITIVE...
     D                 C                   2

      *
      * Codes used in SQLFetchScroll and SQLExtendedFetch
      *
     D SQL_FETCH_NEXT...
     D                 C                   1
     D SQL_FETCH_FIRST...
     D                 C                   2
     D SQL_FETCH_LAST...
     D                 C                   3
     D SQL_FETCH_PRIOR...
     D                 C                   4
     D SQL_FETCH_ABSOLUTE...
     D                 C                   5
     D SQL_FETCH_RELATIVE...
     D                 C                   6

      *
      * SQLColAttributes constants
      *
     D SQL_DESC_COUNT...
     D                 C                   1
     D SQL_DESC_TYPE...
     D                 C                   2
     D SQL_DESC_LENGTH...
     D                 C                   3
     D SQL_DESC_LENGTH_PTR...
     D                 C                   4
     D SQL_DESC_PRECISION...
     D                 C                   5
     D SQL_DESC_SCALE...
     D                 C                   6
     D SQL_DESC_DATETIME_INTERVAL_CODE...
     D                 C                   7
     D SQL_DESC_NULLABLE...
     D                 C                   8
     D SQL_DESC_INDICATOR_PTR...
     D                 C                   9
     D SQL_DESC_DATA_PTR...
     D                 C                   10
     D SQL_DESC_NAME...
     D                 C                   11
     D SQL_DESC_UNNAMED...
     D                 C                   12
     D SQL_DESC_DISPLAY_SIZE...
     D                 C                   13
     D SQL_DESC_AUTO_INCREMENT...
     D                 C                   14
     D SQL_DESC_SEARCHABLE...
     D                 C                   15
     D SQL_DESC_UPDATABLE...
     D                 C                   16
     D SQL_DESC_BASE_COLUMN...
     D                 C                   17
     D SQL_DESC_BASE_TABLE...
     D                 C                   18
     D SQL_DESC_BASE_SCHEMA...
     D                 C                   19
     D SQL_DESC_LABEL...
     D                 C                   20
     D SQL_DESC_MONEY...
     D                 C                   21
     D SQL_DESC_ALLOC_TYPE...
     D                 C                   99
     D SQL_DESC_ALLOC_AUTO...
     D                 C                   1
     D SQL_DESC_ALLOC_USER...
     D                 C                   2

     D SQL_COLUMN_COUNT...
     D                 C                   1
     D SQL_COLUMN_TYPE...
     D                 C                   2
     D SQL_COLUMN_LENGTH...
     D                 C                   3
     D SQL_COLUMN_LENGTH_PTR...
     D                 C                   4
     D SQL_COLUMN_PRECISION...
     D                 C                   5
     D SQL_COLUMN_SCALE...
     D                 C                   6
     D SQL_COLUMN_DATETIME_INTERVAL_CODE...
     D                 C                   7
     D SQL_COLUMN_NULLABLE...
     D                 C                   8
     D SQL_COLUMN_INDICATOR_PTR...
     D                 C                   9
     D SQL_COLUMN_DATA_PTR...
     D                 C                   10
     D SQL_COLUMN_NAME...
     D                 C                   11
     D SQL_COLUMN_UNNAMED...
     D                 C                   12
     D SQL_COLUMN_DISPLAY_SIZE...
     D                 C                   13
     D SQL_COLUMN_AUTO_INCREMENT...
     D                 C                   14
     D SQL_COLUMN_SEARCHABLE...
     D                 C                   15
     D SQL_COLUMN_UPDATABLE...
     D                 C                   16
     D SQL_COLUMN_BASE_COLUMN...
     D                 C                   17
     D SQL_COLUMN_BASE_TABLE...
     D                 C                   18
     D SQL_COLUMN_BASE_SCHEMA...
     D                 C                   19
     D SQL_COLUMN_LABEL...
     D                 C                   20
     D SQL_COLUMN_MONEY...
     D                 C                   21
     D SQL_COLUMN_ALLOC_TYPE...
     D                 C                   99
     D SQL_COLUMN_ALLOC_AUTO...
     D                 C                   1
     D SQL_COLUMN_ALLOC_USER...
     D                 C                   2

      *
      * Valid codes for SpecialColumns procedure
      *
     D SQL_SCOPE_CURROW...
     D                 C                   0
     D SQL_SCOPE_TRANSACTION...
     D                 C                   1
     D SQL_SCOPE_SESSION...
     D                 C                   2
     D SQL_PC_UNKNOWN...
     D                 C                   0
     D SQL_PC_NOT_PSEUDO...
     D                 C                   1
     D SQL_PC_PSEUDO...
     D                 C                   2

      *
      * Valid values for connect attribute
      *
     D SQL_ATTR_AUTO_IPD...
     D                 C                   10001
     D SQL_ATTR_ACCESS_MODE...
     D                 C                   10002
     D SQL_ACCESS_MODE...
     D                 C                   10002
     D SQL_ATTR_AUTOCOMMIT...
     D                 C                   10003
     D SQL_AUTOCOMMIT...
     D                 C                   10003
     D SQL_ATTR_DBC_SYS_NAMING...
     D                 C                   10004
     D SQL_ATTR_DBC_DEFAULT_LIB...
     D                 C                   10005
     D SQL_ATTR_ADOPT_OWNER_AUTH...
     D                 C                   10006
     D SQL_ATTR_SYSBAS_CMT...
     D                 C                   10007
     D SQL_ATTR_COMMIT...
     D                 C                   0
     D SQL_MODE_READ_ONLY...
     D                 C                   0
     D SQL_MODE_READ_WRITE...
     D                 C                   1
     D SQL_MODE_DEFAULT...
     D                 C                   1
     D SQL_AUTOCOMMIT_OFF...
     D                 C                   0
     D SQL_AUTOCOMMIT_ON...
     D                 C                   1
     D SQL_TXN_ISOLATION...
     D                 C                   0
     D SQL_ATTR_TXN_ISOLATION...
     D                 C                   0
     D SQL_COMMIT_NONE...
     D                 C                   1
     D SQL_TXN_NO_COMMIT...
     D                 C                   1
     D SQL_TXN_NOCOMMIT...
     D                 C                   1
     D SQL_COMMIT_CHG...
     D                 C                   2
     D SQL_COMMIT_UR...
     D                 C                   2
     D SQL_TXN_READ_UNCOMMITTED...
     D                 C                   2
     D SQL_COMMIT_CS...
     D                 C                   3
     D SQL_TXN_READ_COMMITTED...
     D                 C                   3
     D SQL_COMMIT_ALL...
     D                 C                   4
     D SQL_COMMIT_RS...
     D                 C                   4
     D SQL_TXN_REPEATABLE_READ...
     D                 C                   4
     D SQL_COMMIT_RR...
     D                 C                   5
     D SQL_TXN_SERIALIZABLE...
     D                 C                   5

      *
      * Valid index flags
      *
     D SQL_INDEX_UNIQUE...
     D                 C                   0
     D SQL_INDEX_ALL...
     D                 C                   1
     D SQL_INDEX_OTHER...
     D                 C                   3
     D SQL_TABLE_STAT...
     D                 C                   0
     D SQL_ENSURE...
     D                 C                   1
     D SQL_QUICK...
     D                 C                   0

      *
      * Valid trace values
      *
     D SQL_ATTR_TRACE_CLI...
     D                 C                   1
     D SQL_ATTR_TRACE_DBMON...
     D                 C                   2
     D SQL_ATTR_TRACE_DEBUG...
     D                 C                   4
     D SQL_ATTR_TRACE_JOBLOG...
     D                 C                   8
     D SQL_ATTR_TRACE_STRTRC...
     D                 C                   16

      *
      * Valid file options
      *
     D SQL_FILE_READ...
     D                 C                   2
     D SQL_FILE_CREATE...
     D                 C                   8
     D SQL_FILE_OVERWRITE...
     D                 C                   16
     D SQL_FILE_APPEND...
     D                 C                   32
     D SQL_DIAG_RETURNCODE...
     D                 C                   1
     D SQL_DIAG_NUMBER...
     D                 C                   2

      *
      * Valid types for GetDiagField
      *
     D SQL_DIAG_ROW_COUNT...
     D                 C                   3
     D SQL_DIAG_SQLSTATE...
     D                 C                   4
     D SQL_DIAG_NATIVE...
     D                 C                   5
     D SQL_DIAG_MESSAGE_TEXT...
     D                 C                   6
     D SQL_DIAG_DYNAMIC_FUNCTION...
     D                 C                   7
     D SQL_DIAG_CLASS_ORIGIN...
     D                 C                   8
     D SQL_DIAG_SUBCLASS_ORIGIN...
     D                 C                   9
     D SQL_DIAG_CONNECTION_NAME...
     D                 C                   10
     D SQL_DIAG_SERVER_NAME...
     D                 C                   11
     D SQL_DIAG_MESSAGE_TOKENS...
     D                 C                   12
     D SQL_DIAG_AUTOGEN_KEY...
     D                 C                   14

      *
      * SQLColAttributes constants
      * These are also used by SQLGetInfo
      *
     D SQL_UNSEARCHABLE...
     D                 C                   0
     D SQL_LIKE_ONLY...
     D                 C                   1
     D SQL_ALL_EXCEPT_LIKE...
     D                 C                   2
     D SQL_SEARCHABLE...
     D                 C                   3

      *
      * GetFunctions() values to identify CLI functions
      *
     D SQL_API_SQLALLOCCONNECT...
     D                 C                   1
     D SQL_API_SQLALLOCENV...
     D                 C                   2
     D SQL_API_SQLALLOCHANDLE...
     D                 C                   1001
     D SQL_API_SQLALLOCSTMT...
     D                 C                   3
     D SQL_API_SQLBINDCOL...
     D                 C                   4
     D SQL_API_SQLBINDFILETOCOL...
     D                 C                   2002
     D SQL_API_SQLBINDFILETOPARAM...
     D                 C                   2003
     D SQL_API_SQLBINDPARAM...
     D                 C                   1002
     D SQL_API_SQLBINDPARAMETER...
     D                 C                   1023
     D SQL_API_SQLCANCEL...
     D                 C                   5
     D SQL_API_SQLCLOSECURSOR...
     D                 C                   1003
     D SQL_API_SQLCOLATTRIBUTES...
     D                 C                   6
     D SQL_API_SQLCOLUMNPRIVILEGES...
     D                 C                   2010
     D SQL_API_SQLCOLUMNS...
     D                 C                   40
     D SQL_API_SQLCONNECT...
     D                 C                   7
     D SQL_API_SQLCOPYDESC...
     D                 C                   1004
     D SQL_API_SQLDATASOURCES...
     D                 C                   57
     D SQL_API_SQLDESCRIBECOL...
     D                 C                   8
     D SQL_API_SQLDESCRIBEPARAM...
     D                 C                   58
     D SQL_API_SQLDISCONNECT...
     D                 C                   9
     D SQL_API_SQLDRIVERCONNECT...
     D                 C                   68
     D SQL_API_SQLENDTRAN...
     D                 C                   1005
     D SQL_API_SQLERROR...
     D                 C                   10
     D SQL_API_SQLEXECDIRECT...
     D                 C                   11
     D SQL_API_SQLEXECUTE...
     D                 C                   12
     D SQL_API_SQLEXTENDEDFETCH...
     D                 C                   1022
     D SQL_API_SQLFETCH...
     D                 C                   13
     D SQL_API_SQLFETCHSCROLL...
     D                 C                   1021
     D SQL_API_SQLFOREIGNKEYS...
     D                 C                   60
     D SQL_API_SQLFREECONNECT...
     D                 C                   14
     D SQL_API_SQLFREEENV...
     D                 C                   15
     D SQL_API_SQLFREEHANDLE...
     D                 C                   1006
     D SQL_API_SQLFREESTMT...
     D                 C                   16
     D SQL_API_SQLGETCOL...
     D                 C                   43
     D SQL_API_SQLGETCONNECTATTR...
     D                 C                   1007
     D SQL_API_SQLGETCONNECTOPTION...
     D                 C                   42
     D SQL_API_SQLGETCURSORNAME...
     D                 C                   17
     D SQL_API_SQLGETDATA...
     D                 C                   43
     D SQL_API_SQLGETDESCFIELD...
     D                 C                   1008
     D SQL_API_SQLGETDESCREC...
     D                 C                   1009
     D SQL_API_SQLGETDIAGFIELD...
     D                 C                   1010
     D SQL_API_SQLGETDIAGREC...
     D                 C                   1011
     D SQL_API_SQLGETENVATTR...
     D                 C                   1012
     D SQL_API_SQLGETFUNCTIONS...
     D                 C                   44
     D SQL_API_SQLGETINFO...
     D                 C                   45
     D SQL_API_SQLGETLENGTH...
     D                 C                   2004
     D SQL_API_SQLGETPOSITION...
     D                 C                   2005
     D SQL_API_SQLGETSTMTATTR...
     D                 C                   1014
     D SQL_API_SQLGETSTMTOPTION...
     D                 C                   46
     D SQL_API_SQLGETSUBSTRING...
     D                 C                   2006
     D SQL_API_SQLGETTYPEINFO...
     D                 C                   47
     D SQL_API_SQLLANGUAGES...
     D                 C                   2001
     D SQL_API_SQLMORERESULTS...
     D                 C                   61
     D SQL_API_SQLNATIVESQL...
     D                 C                   62
     D SQL_API_SQLNEXTRESULT...
     D                 C                   2009
     D SQL_API_SQLNUMPARAMS...
     D                 C                   63
     D SQL_API_SQLNUMRESULTCOLS...
     D                 C                   18
     D SQL_API_SQLPARAMDATA...
     D                 C                   48
     D SQL_API_SQLPARAMOPTIONS...
     D                 C                   2007
     D SQL_API_SQLPREPARE...
     D                 C                   19
     D SQL_API_SQLPRIMARYKEYS...
     D                 C                   65
     D SQL_API_SQLPROCEDURECOLUMNS...
     D                 C                   66
     D SQL_API_SQLPROCEDURES...
     D                 C                   67
     D SQL_API_SQLPUTDATA...
     D                 C                   49
     D SQL_API_SQLRELEASEENV...
     D                 C                   1015
     D SQL_API_SQLROWCOUNT...
     D                 C                   20
     D SQL_API_SQLSETCONNECTATTR...
     D                 C                   1016
     D SQL_API_SQLSETCONNECTOPTION...
     D                 C                   50
     D SQL_API_SQLSETCURSORNAME...
     D                 C                   21
     D SQL_API_SQLSETDESCFIELD...
     D                 C                   1017
     D SQL_API_SQLSETDESCREC...
     D                 C                   1018
     D SQL_API_SQLSETENVATTR...
     D                 C                   1019
     D SQL_API_SQLSETPARAM...
     D                 C                   22
     D SQL_API_SQLSETSTMTATTR...
     D                 C                   1020
     D SQL_API_SQLSETSTMTOPTION...
     D                 C                   51
     D SQL_API_SQLSPECIALCOLUMNS...
     D                 C                   52
     D SQL_API_SQLSTARTTRAN...
     D                 C                   2008
     D SQL_API_SQLSTATISTICS...
     D                 C                   53
     D SQL_API_SQLTABLEPRIVILEGES...
     D                 C                   2011
     D SQL_API_SQLTABLES...
     D                 C                   54
     D SQL_API_SQLTRANSACT...
     D                 C                   23

      *
      * NULL handle constants
      *
     D SQL_NULL_HENV...
     D                 C                   0
     D SQL_NULL_HDBC...
     D                 C                   0
     D SQL_NULL_HSTMT...
     D                 C                   0

      *
      * truncated values return this sqlstate
      *
     D SQL_WARN_VAL_TRUNC...
     D                 C                   '01004'

      *
      * date structure
      *
     D DATE_STRUCT     ds                  qualified
     D                                     based(Template)
     D                                     align
     D   year                              like(SQLSMALLINT)
     D   month                             like(SQLSMALLINT)
     D   day                               like(SQLSMALLINT)

      *
      * time structure
      *
     D TIME_STRUCT     ds                  qualified
     D                                     based(Template)
     D                                     align
     D   hour                              like(SQLSMALLINT)
     D   minute                            like(SQLSMALLINT)
     D   second                            like(SQLSMALLINT)


      *
      * timestamp structure
      *
     D TIMESTAMP_STRUCT...
     D                 ds                  qualified
     D                                     based(Template)
     D                                     align
     D   year                              like(SQLSMALLINT)
     D   month                             like(SQLSMALLINT)
     D   day                               like(SQLSMALLINT)
     D   hour                              like(SQLSMALLINT)
     D   minute                            like(SQLSMALLINT)
     D   second                            like(SQLSMALLINT)
     D   fraction                          like(SQLINTEGER)

      *
      * Transaction info structure
      *
     D TXN_STRUCT      ds                  qualified
     D                                     based(Template)
     D                                     align
     D   operation                         like(SQLINTEGER)
     D   tminfo                      10A
     D                                2A
     D   XID                           *
     D   timeoutval                        like(SQLINTEGER)
     D   locktimeout                       like(SQLINTEGER)
     D                                8A


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLAllocConnect(): Allocate a connection handle
      *
      *     henv = (input) environment to allocate in
      *    phdbc = (output) new connection handle
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SqlAllocConnect...
     D                 PR                  ExtProc('SQLAllocConnect')
     D                                     like(SQLRETURN)
     D   henv                              like(SQLHENV) value
     D   phdbc                             like(SQLHDBC)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLAllocEnv(): Allocate an environment for SQL and return
      *                an environment handle
      *
      *        phenv = (output) environment handle
      *
      * Returns SQL_SUCCESS or SQL_ERROR
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SqlAllocEnv     PR                  ExtProc('SQLAllocEnv')
     D                                     like(SQLRETURN)
     D   phenv                             like(SQLHENV)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLAllocHandle(): Allocate any type of handle
      *
      *        type = (input) handle type
      *     ihandle = (input) handle describing context
      *               (i.e. is the new handle inside an env? conn?)
      *     ohandle = (output) new handle returned
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SqlAllocHandle...
     D                 PR                  ExtProc('SQLAllocHandle')
     D                                     like(SQLRETURN)
     D   type                              like(SQLSMALLINT) value
     D   ihandle                           like(SQLINTEGER) value
     D   ohandle                           like(SQLINTEGER)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLAllocStmt(): Allocate a new SQL statement handle
      *
      *    hdbc = (input) handle to database connection
      *  phstmt = (output) new statement handle
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLAllocStmt    PR                  ExtProc('SQLAllocStmt')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    phstmt                           like(SQLHSTMT)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLBindCol(): Bind column to application variable
      *
      *      hstmt = (input) statement handle
      *       icol = (input) column number to bind
      *     fCType = (input) application data type for column
      *   rgbValue = (output) pointer to variable where data is placed
      * cbValueMax = (input) max size of variable (in bytes or DBCS chars))
      *   pcbValue = (output) number of bytes returned
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLBindCol      PR                  ExtProc('SQLBindCol')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    icol                             like(SQLSMALLINT) value
     D    fCType                           like(SQLSMALLINT) value
     D    rgbValue                         like(SQLPOINTER) value
     D    cbValueMax                       like(SQLINTEGER) value
     D    pcbValue                         like(SQLINTEGER) options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLBindFileToCol():  Bind LOB File Reference to LOB Column
      *
      * (This is used to populate an IFS stream file with the
      *  contents of a LOB, or vice-versa)
      *
      *         stmt = (input) statement handle
      *     ColumnNo = (input) ordinal column number to bind
      *     FileName = (input/deferred) variable that contains filename.
      *                this is not used immediately, but the var will
      *                be read when the file is actually created (so
      *                if you change it, you'll change the filename.)
      *  FileNameLen = (input/deferred) variable that contains the
      *                %len of the file name in the FileName parm.
      *     FileOpts = (input/deferred) variable that contains the
      *                option for SQL_FILE_CREATE, SQL_FILE_OVERWRITE
      *                or SQL_FILE_APPEND.
      *  MaxFileName = (input) %size of FileName variable
      *    StringLen = (output/deferred) variable to contain the length
      *                in bytes of the LOB returned.  This variable will
      *                be changed on each fetch.
      *        Indic = (output/deferred) variable to contain the
      *                indicator value for the column. This variable will
      *                be changed on each fetch.
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLBindFileToCol...
     D                 PR                  ExtProc('SQLBindFileToCol')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    ColumnNo                         like(SQLSMALLINT) value
     D    FileName                32767A   options(*varsize)
     D    FileNameLen                      like(SQLINTEGER)
     D                                     options(*omit)
     D    FileOpts                         like(SQLINTEGER)
     D    MaxFileName                      like(SQLINTEGER) value
     D    StringLen                        like(SQLINTEGER)
     D                                     options(*omit)
     D    Indic                            like(SQLINTEGER)
     D                                     options(*omit)
      * (Same as above, but with arrays)
     D SQLBindFileToColA...
     D                 PR                  ExtProc('SQLBindFileToCol')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    ColumnNo                         like(SQLSMALLINT) value
     D    FileName                     *   dim(32767) options(*varsize)
     D    FileNameLen                      like(SQLINTEGER)
     D                                     dim(32767)
     D                                     options(*varsize:*omit)
     D    FileOpts                         like(SQLINTEGER)
     D                                     dim(32767) options(*varsize)
     D    MaxFileName                      like(SQLINTEGER) value
     D    StringLen                        like(SQLINTEGER)
     D                                     dim(32767)
     D                                     options(*omit:*varsize)
     D    Indic                            like(SQLINTEGER)
     D                                     dim(32767)
     D                                     options(*omit:*varsize)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLBindFileToParam(): Bind LOB File reference to LOB Parm
      *
      *   (Associates a parameter marker for a LOB with an IFS
      *    stream file.)
      *
      *         stmt = (input) statement handle
      *       ParmNo = (input) ordinal parameter number to bind
      *     FileName = (input/deferred) variable that contains filename.
      *                this is not used immediately, but the var will
      *                be read when the file is actually created (so
      *                if you change it, you'll change the filename.)
      *  FileNameLen = (input/deferred) variable that contains the
      *                %len of the file name in the FileName parm.
      *     FileOpts = (input/deferred) variable that contains the
      *                option. It must be SQL_FILE_READ
      *  MaxFileName = (input) %size of FileName variable
      *    StringLen = (output/deferred) variable to contain the length
      *                in bytes of the LOB returned.  This variable will
      *                be changed on each fetch.
      *        Indic = (input/deferred) variable to contain the
      *                indicator value for the column. This variable will
      *                be changed on each fetch.
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLBindFileToParam...
     D                 PR                  ExtProc('SQLBindFileToParam')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    ParmNo                           like(SQLSMALLINT) value
     D    DataType                         like(SQLSMALLINT) value
     D    FileName                32767A   options(*varsize)
     D    FileNameLen                      like(SQLINTEGER)
     D    FileOpts                         like(SQLINTEGER)
     D    MaxFileName                      like(SQLINTEGER) value
     D    Indic                            like(SQLINTEGER)
     D                                     options(*omit)
      * (Same as above, but with arrays)
     D SQLBindFileToParamA...
     D                 PR                  ExtProc('SQLBindFileToParam')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    ParmNo                           like(SQLSMALLINT) value
     D    DataType                         like(SQLSMALLINT) value
     D    FileName                     *   dim(32767) options(*varsize)
     D    FileNameLen                      like(SQLINTEGER) dim(32767)
     D                                     options(*varsize:*omit)
     D    FileOpts                         like(SQLINTEGER) dim(32767)
     D                                     options(*varsize)
     D    MaxFileName                      like(SQLINTEGER) value
     D    Indic                            like(SQLINTEGER) dim(32767)
     D                                     options(*omit:*varsize)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLBindParam(): Set Parameter
      *
      *      hstmt = (input) statement handle
      *       ipar = (input) parameter marker number to bind
      *     fCType = (input) application data type for column
      *   fSqlType = (input) SQL data type for column
      * cbParamDef = (input) precision of corresponding param marker
      *    ibScale = (input) scale of parm marker (decimal places)
      *   rgbValue = (i/o)   pointer to variable for data
      *                        or SQL_NULL_DATA if no data.
      *   pcbValue = (input) length of data, or SQL_NTS, or zero
      *                        or *OMIT if no data
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLBindParam    PR                  ExtProc('SQLBindParam')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    ipar                             like(SQLSMALLINT) value
     D    fCType                           like(SQLSMALLINT) value
     D    fSqlType                         like(SQLSMALLINT) value
     D    cbParamDef                       like(SQLINTEGER) value
     D    ibScale                          like(SQLSMALLINT) value
     D    rgbValue                         like(SQLPOINTER) value
     D    pcbValue                         like(SQLINTEGER)
     D                                     options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLBindParameter(): Set Parameter (extended)
      *
      *       stmt = (input) statement handle
      *     ParmNo = (input) parameter marker number to bind
      *  InOutType = (input) whether parameter is input,output or both
      *   DataType = (input) RPG data type of the parameter
      *    SqlType = (input) SQL data type for the parameter
      *    ColSize = (input) precision of corresponding param marker
      *                      (This is the length or number of digits)
      *      Scale = (input) scale of parm marker (decimal places)
      *      Value = (i/o/deferred) Variable that contains the value
      *                        of the data (variable is used when the
      *                        statement is executed, not when this
      *                        procedure is called)
      *                        can be *NULL if InOutType=SQL_PARAM_OUTPUT
      *                        and you don't want the data.
      *  BufferLen = (input) Not used.
      * Len_Or_Ind = (i/o/deferred) Variable containing the length of
      *                             the *data* (vs. the size of the field)
      *                             This variable is used when the
      *                             statement is executed (not when
      *                             SQLBindParameter is run.)
      *                             May contain SQL_NULL_DATA if an SQL
      *                             null value is desired, SQL_NTS if
      *                             a zero-terminated string is used,
      *                             or SQL_DATA_AT_EXEC if the data
      *                             should be supplied by SQLPutData()
      *                             For output fields, this will also be
      *                             used to return the length of the data,
      *                             (or SQL_NULL_DATA/SQL_NTS)
      *                             can be *OMIT if the InOutType parm
      *                             is SQL_PARAM_OUTPUT and you don't
      *                             want the data.
      *
      *  NOTE: You can *OMIT/*NULL both the 'Value' and 'Len_Or_Ind'
      *        parameters for an output-only parameter if you want
      *        to discard the data.
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLBindParameter...
     D                 PR                  ExtProc('SQLBindParameter')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    ParmNo                           like(SQLSMALLINT) value
     D    inouttype                        like(SQLSMALLINT) value
     D    datatype                         like(SQLSMALLINT) value
     D    SqlType                          like(SQLSMALLINT) value
     D    ColSize                          like(SQLINTEGER) value
     D    Scale                            like(SQLSMALLINT) value
     D    Value                            like(SQLPOINTER) value
     D    BufferLen                        like(SQLINTEGER) value
     D    Len_Or_Ind                       like(SQLINTEGER) options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLCancel(): This doesn't do anything, it's here for
      *              the sake of matching the CLI standards.
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLCancel       PR                  ExtProc('SQLCancel')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLCloseCursor(): Close cursor
      *
      *       stmt = (input) statement handle
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLCloseCursor  PR                  ExtProc('SQLCloseCursor')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLColAttributes():  Get Column Attributes
      *
      *       stmt = (input)  statement handle
      *      ColNo = (input)  ordinal column number
      *   DescType = (input)  attribute to retrieve
      *    DescBuf = (output) value of attribute (if a char string)
      *   DescSize = (input)  maximum size of desc buf
      *    rtnSize = (output) actual number of bytes used in desc buf
      *    DescInt = (output) value of attribute (if numeric)
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLColAttributes...
     D                 PR                  ExtProc('SQLColAttributes')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    ColNo                            like(SQLSMALLINT) value
     D    DescType                         like(SQLSMALLINT) value
     D    DescBuf                 32767A   options(*varsize: *omit)
     D    DescSize                         like(SQLINTEGER) value
     D    RtnSize                          like(SQLINTEGER)
     D    DescInt                          like(SQLINTEGER) options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLColumnPrivledges(): Get privleges associated with the
      *                        columns of a table.
      *
      *  The result data is returned in a result set, so you should
      *  use SQLBindCol() and SQLFetch() to get the results.
      *
      *         stmt = (input) statement handle
      *  CatalogName = (input) catalog qualifier of 3 part table name
      *                        This must ALWAYS be *OMIT.
      *  NameLength1 = (input) length of catalog name, ALWAYS 0
      *   SchemaName = (input) Schema qualifier of table name
      *  NameLength2 = (input) Length of SchemaName
      *    TableName = (input) Table name
      *  NameLength3 = (input) Length of TableName
      *   ColumnName = (input) Column name
      *  NameLength4 = (input) Length of ColumnName
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         -- data is returned in a result set --
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLColumnPrivledges...
     D                 PR                  ExtProc('SqlColumnPrivledges')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    CatalogName             32767A   options(*varsize:*omit)
     D    NameLength1                      like(SQLSMALLINT) value
     D    SchemaName              32767A   options(*varsize:*omit)
     D    NameLength2                      like(SQLSMALLINT) value
     D    TableName               32767A   options(*varsize:*omit)
     D    NameLength3                      like(SQLSMALLINT) value
     D    ColumnName              32767A   options(*varsize:*omit)
     D    NameLength4                      like(SQLSMALLINT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLColumns(): Get column information for a table
      *
      *  The result data is returned in a result set, so you should
      *  use SQLBindCol() and SQLFetch() to get the results.
      *
      *         stmt = (input) statement handle
      *  CatalogName = (input) catalog qualifier of 3 part table name
      *                        This must ALWAYS be *OMIT.
      *  NameLength1 = (input) length of catalog name, ALWAYS 0
      *   SchemaName = (input) Schema qualifier of table name
      *  NameLength2 = (input) Length of SchemaName
      *    TableName = (input) Table name
      *  NameLength3 = (input) Length of TableName
      *   ColumnName = (input) Column name
      *  NameLength4 = (input) Length of ColumnName
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         -- data is returned in a result set --
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLColumns      PR                  ExtProc('SQLColumns')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    CatalogName             32767A   options(*varsize:*omit)
     D    NameLength1                      like(SQLSMALLINT) value
     D    SchemaName              32767A   options(*varsize:*omit)
     D    NameLength2                      like(SQLSMALLINT) value
     D    TableName               32767A   options(*varsize:*omit)
     D    NameLength3                      like(SQLSMALLINT) value
     D    ColumnName              32767A   options(*varsize:*omit)
     D    NameLength4                      like(SQLSMALLINT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLConnect(): Connect to a data source
      *
      *       hdbc = (input) connection handle
      *      szDSN = (input) Data source name to connect to
      *      cbDSN = (input) length of szDSN parameter
      *      szUID = (input) Autorization name (UserID)
      *      cbUID = (input) Length of szUID parameter
      *  szAuthStr = (input) Autorization name (UserID)
      *  cbAuthStr = (input) Length of szUID parameter
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLConnect      PR                  Extproc('SQLConnect')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    szDSN                        *   value options(*string)
     D    cbDSN                            like(SQLSMALLINT) value
     D    szUID                        *   value options(*string)
     D    cbUID                            like(SQLSMALLINT) value
     D    szAuthStr                    *   value options(*string)
     D    cbAuthStr                        like(SQLSMALLINT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLCopyDesc(): Copy description statement
      *
      *    sDesc = (input) source descriptor handle
      *    tDesc = (input) target descriptor handle
      *
      * Returns SQL_SUCCESS,
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLCopyDesc     PR                  ExtProc('SQLCopyDesc')
     D                                     like(SQLRETURN)
     D    sDesc                            like(SQLHDESC) value
     D    tDesc                            like(SQLHDESC) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLDataSources(): Get List of Data Sources
      *
      *         env = (input)  environment handle
      *   direction = (input)  SQL_FETCH_FIRST or SQL_FETCH_NEXT
      *                 used to get the first, or next, data source
      *  serverName = (output) name of DSN
      *  BufferLen1 = (input)  size of serverName variable
      *    NameLen1 = (output) len used in serverName variable
      * Description = (output) description of data source
      *  BufferLen2 = (input)  size of description variable
      *    NameLen2 = (output) len used in description variable
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLDataSources  PR                  ExtProc('SQLDataSources')
     D                                     like(SQLRETURN)
     D    env                              like(SQLHENV) value
     D    direction                        like(SQLSMALLINT) value
     D    serverName                513A   options(*varsize:*omit)
     D    BufferLen1                       like(SQLSMALLINT) value
     D    NameLen1                         like(SQLSMALLINT) options(*omit)
     D    Description               513A   options(*varsize:*omit)
     D    BufferLen2                       like(SQLSMALLINT) value
     D    NameLen2                         like(SQLSMALLINT) options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLDescribeCol(): Describe Column Attributes
      *
      *         stmt = (input)  statement handle
      *        ColNo = (input)  ordinal column number to describe
      *      ColName = (output) returned column name
      *   ColNameMax = (input)  %size() of ColName parameter
      *   ColNameLen = (output) returned length of ColName parameter
      *  SqlDataType = (output) returned data type of column
      *    Precision = (output) returned precision (length) of column
      *        Scale = (output) returned scale (dec pos) of numeric columns
      *     Nullable = (output) returned info about null capability.
      *                         SQL_NO_NULLS or SQL_NULLABLE
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLDescribeCol  PR                  ExtProc('SQLDescribeCol')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    ColNo                            like(SQLSMALLINT) value
     D    ColName                   513A   options(*varsize: *omit)
     D    ColNameMax                       like(SQLSMALLINT) value
     D    ColNameLen                       like(SQLSMALLINT)
     D    SqlDataType                      like(SQLSMALLINT)
     D    Precision                        like(SQLINTEGER)
     D    Scale                            like(SQLSMALLINT)
     D    Nullable                         like(SQLSMALLINT)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLDescribeParam(): Describe Parameter Marker
      *
      *       stmt = (input)  statement handle
      *    ParamNo = (input)  ordinal parameter number to describe
      *   datatype = (output) returned data type of parameter
      *       size = (output) returned size of parameter
      *     decpos = (output) returned decimal digits of parameter
      *   nullable = (output) returned info about null capability
      *           SQL_NO_NULLS, SQL_NULLABLE or SQL_NULLABLE_UNKNOWN
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_STILL_EXECUTING
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLDescribeParam...
     D                 PR                  ExtProc('SQLDescribeParam')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    ParamNo                          like(SQLSMALLINT) value
     D    datatype                         like(SQLSMALLINT)
     D    size                             like(SQLINTEGER)
     D    decpos                           like(SQLSMALLINT)
     D    nullable                         like(SQLSMALLINT)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLDisconnect(): Disconnect from a data source
      *
      *  hdbc = (input) database connection handle to disconnect
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLDisconnect   PR                  Extproc('SQLDisconnect')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLDriverConnect(): Connect to a data source (expanded)
      *
      *          hdbc = (input)  Connection handle
      *          hwnd = (input)  Window handle (ignored on iSeries)
      *    in_ConnStr = (input)  Connection string
      *    in_ConnLen = (input)  length of in_ConnStr (SQL_NTS)
      *   out_ConnStr = (output) completed connection string
      *   out_ConnSiz = (input)  %size() of outConnStr variable
      *   out_ConnRtn = (output) length of out_ConnStr used
      *   drivercompl = (input)  when should DB2 prompt user?
      *           SQL_DRIVER_COMPLETE, SQL_DRIVER_COMPLETE_REQUIRED
      *           or SQL_DRIVER_NOPROMPT
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLDriverConnect...
     D                 PR                  extproc('SQLDriverConnect')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    hwnd                             like(SQLHWND) value
     D    in_ConnStr                   *   value options(*string)
     D    in_ConnLen                       like(SQLSMALLINT) value
     D    out_ConnStr             32767A   options(*varsize:*omit)
     D    out_ConnSiz                      like(SQLSMALLINT) value
     D    out_ConnRtn                      like(SQLSMALLINT)
     D    drivercompl                      like(SQLSMALLINT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLEndTran(): Commit or rollback a transaction
      *
      *   htype = (input) type of handle:
      *                         SQL_HANDLE_ENV or SQL_HANDLE_DBC
      *  handle = (input) handle to use
      *  action = (input) action to perform:
      *                         SQL_COMMIT
      *                         SQL_ROLLBACK
      *                         SQL_COMMIT_HOLD
      *                         SQL_ROLLBACK_HOLD
      *                         SQL_SAVEPOINT_NAME_ROLLBACK
      *                         SQL_SAVEPOINT_NAME_RELEASE
      * Returns SQL_SUCCESS
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLEndTran      PR                  extproc('SQLEndTran')
     D                                     like(SQLRETURN)
     D    htype                            like(SQLSMALLINT) value
     D    handle                           like(SQLINTEGER) value
     D    action                           like(SQLSMALLINT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLError(): Retrieve Error Information
      *
      *        henv = (input) environment handle
      *        hdbc = (input) database connection handle
      *                       (or SQL_NULL_HDBC)
      *       hstmt = (input) statement handle (or SQL_NULL_HSTMT)
      *  szSqlState = (output) SQL State (null-terminated)
      * pfNativeErr = (output) Native error code
      *  szErrorMsg = (output) Message text of error message
      * cbErrMsgMax = (input) max size of szErrorMsg parameter
      * pcbErrorMsg = (output) total bytes available for err msg.
      *
      * Returns SQL_SUCCESS,
      *         SQL_NO_DATA_FOUND
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLError        PR                  extproc('SQLError')
     D                                     like(SQLRETURN)
     D   henv                              like(SQLHENV) value
     D   hdbc                              like(SQLHDBC) value
     D   hstmt                             like(SQLHSTMT) value
     D   szSqlState                   6A
     D   pfNativeErr                       like(SQLINTEGER)
     D   szErrorMsg                 513A   options(*varsize)
     D   cbErrMsgMax                       like(SQLSMALLINT) value
     D   pcbErrorMsg                       like(SQLSMALLINT)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *  SQLExecDirect(): Execute an SQL Statement Directly
      *
      *     hstmt = (input) handle of SQL Statement
      *  szSqlStr = (input) SQL statement to execute
      *  cbSqlStr = (input) length of SQL statement
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLExecDirect...
     D                 PR                  Extproc('SQLExecDirect')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    szSqlStr                     *   value options(*string)
     D    cbSqlStr                         like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLExecute(): Execute a prepared statement
      *
      *     hstmt = (input) handle of prepared SQL Statement
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLExecute      PR                  Extproc('SQLExecute')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLExtendedFetch(): Fetch Array of Rows
      *
      * Note: Number of rows fetched is set by calling SQLSetStmtAttr()
      *       and specifying SQL_ROWSET_SIZE
      *
      *     hstmt = (input) handle of prepared SQL Statement
      *    orient = (input) fetch orientation
      *                     (must be SQL_FETCH_NEXT if non-scrollable)
      *    offset = (input) Row offset for relative positioning
      *  rowcount = (output) rows that were fetched by API
      * rowstatus = (output) array of success/fail flags for
      *                      each row returned.  This can be
      *                      SQL_ROW_SUCCESS or SQL_ROW_NOROW
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND  (also indicates end of result set)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLExtendedFetch...
     D                 PR                  Extproc('SQLExtendedFetch')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    orient                           like(SQLSMALLINT) value
     D    offset                           like(SQLINTEGER) value
     D    rowcount                         like(SQLINTEGER)
     D    rowstatus                        like(SQLSMALLINT)
     D                                     dim(32767) options(*varsize)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLFetch(): Fetch next row from result set
      *
      *     hstmt = (input) handle of prepared SQL Statement
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND  (also indicates end of result set)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFetch        PR                  Extproc('SQLFetch')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLFetchScroll(): Fetch next row from scrollable cursor
      *
      *     hstmt = (input) handle of prepared SQL Statement
      *    orient = (input) fetch orientation
      *                     (must be SQL_FETCH_NEXT if non-scrollable)
      *    offset = (input) Row offset for relative positioning
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND  (also indicates end of result set)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFetchScroll  PR                  Extproc('SQLFetchScroll')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    orient                           like(SQLSMALLINT) value
     D    offset                           like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLForeignKeys(): Get the list of foreign key columns
      *
      *  NOTE: Results from this API are returned in a result set.
      *        To get them, use SQLFetch() and friends.
      *
      *          stmt = (input) statement handle
      *     pkcatalog = (input) must be *OMIT
      *  pkcataloglen = (input) must be 0
      *      pkschema = (input) schema qualifier of primary key tbl
      *   pkschemalen = (input) pkschema len, or SQL_NTS
      *       pktable = (input) name of table containing primary key
      *    pktablelen = (input) pktable len, or SQL_NTS
      *     fkcatalog = (input) must be *OMIT
      *  fkcataloglen = (input) must be 0
      *      fkschema = (input) schema qualifier of foreign key tbl
      *   fkschemalen = (input) fkschema len, or SQL_NTS
      *       fktable = (input) name of table containing foreign key
      *    fktablelen = (input) fktable len, or SQL_NTS
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_STILL_EXECUTING
      * - results are returned in a result set -
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLForeignKeys  PR                  Extproc('SQLForeignKeys')
     D                                     like(SQLRETURN)
     D   stmt                              like(SQLHSTMT) value
     D   pkcatalog                32767A   const options(*varsize:*omit)
     D   pkcataloglen                      like(SQLINTEGER) value
     D   pkschema                      *   value options(*string)
     D   pkschemalen                       like(SQLINTEGER) value
     D   pktable                       *   value options(*string)
     D   pktablelen                        like(SQLINTEGER) value
     D   fkcatalog                32767A   const options(*varsize:*omit)
     D   fkcataloglen                      like(SQLINTEGER) value
     D   fkschema                      *   value options(*string)
     D   fkschemalen                       like(SQLINTEGER) value
     D   fktable                       *   value options(*string)
     D   fktablelen                        like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLFreeConnect(): Free SQL connection handle
      *
      *     hdbc = (input) handle of data source connection
      *                   that has already been disconnected
      *                   by SQLDisconnect()
      *
      * Returns SQL_SUCCESS,
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFreeConnect  PR                  Extproc('SQLFreeConnect')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLFreeEnv(): Free Environment Handle
      *              (SQLFreeConnect needs to be called first)
      *
      *     henv = (input) environment handle to free up
      *
      * Returns SQL_SUCCESS,
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFreeEnv      PR                  Extproc('SQLFreeEnv')
     D                                     like(SQLRETURN)
     D    henv                             like(SQLHENV) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLFreeHandle(): Free a Handle (any type)
      *
      *   htype = (input) type of handle to free
      *              SQL_HANDLE_ENV, SQL_HANDLE_DBC, SQL_HANDLE_STMT
      *              SQL_HANDLE_DESC
      *  handle = (input) handle to free
      *
      * Returns SQL_SUCCESS,
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFreeHandle   PR                  Extproc('SQLFreeHandle')
     D                                     like(SQLRETURN)
     D    htype                            like(SQLSMALLINT) value
     D    handle                           like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLFreeStmt(): Free or Reset an SQL Statement Handle
      *
      *    hstmt = (input) statement handle to free or reset
      *  fOption = (input) option to perform, the values are:
      *              SQL_CLOSE  = Close a cursor
      *              SQL_DROP   = Drop a statement handle/free resources
      *              SQL_UNBIND = unbind columns from variables
      *              SQL_RESET_PARAMS = Reset parameters
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFreeStmt     PR                  Extproc('SQLFreeStmt')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    fOption                          like(SQLSMALLINT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetCol(): Gets a column from a fetched row
      *
      *     hstmt  = (input) statement handle of fetch
      *      icol  = (input) column number to get
      *    fCType  = (input) application (not database) data type
      *                      of column identified by icol
      *                      (SQL_CHAR, SQL_VARCHAR, etc...)
      *   rgbValue = (input) pointer to memory (variable) where the
      *                      retrieved column data will be stored
      * cbValueMax = (input) maximum size of data to return
      *                        for DECIMAL or NUMERIC, this is
      *                        (precision * 256) + scale.
      *                        For anything else, it's bytes.
      *   pcbValue = (output) size of data available in database
      *                        or, amount remaining if fetching in pieces
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND (also indicates end of result set)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetCol       PR                  ExtProc('SQLGetCol')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   icol                              like(SQLSMALLINT) value
     D   fCType                            like(SQLSMALLINT) value
     D   rgbValue                          like(SQLPOINTER) value
     D   cbValueMax                        like(SQLINTEGER) value
     D   pcbValue                          like(SQLINTEGER) options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetConnectAttr(): Get connection attribute
      *
      *    hdbc = (input)  connection handle
      *    attr = (input)  attribute to retrieve
      *  vParam = (output) returned value, can be an integer or
      *                      a null-terminated char string.
      *    bLen = (input)  %size() of variable passed for vParam
      *    sLen = (output) Length used if output is a string.
      *
      *  Returns SQL_SUCCESS
      *          SQL_NO_DATA_FOUND
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetConnectAttr...
     D                 PR                  ExtProc('SQLGetConnectAttr')
     D                                     like(SQLRETURN)
     D   hdbc                              like(SQLHDBC) value
     D   Attr                              like(SQLINTEGER) value
     D   vParam                            like(SQLPOINTER) value
     D   bLen                              like(SQLINTEGER) value
     D   sLen                              like(SQLINTEGER) options(*omit)
     D SQLGetConnectAttrI...
     D                 PR                  ExtProc('SQLGetConnectAttr')
     D                                     like(SQLRETURN)
     D   hdbc                              like(SQLHDBC) value
     D   Attr                              like(SQLINTEGER) value
     D   vParam                            like(SQLINTEGER)
     D   bLen                              like(SQLINTEGER) value
     D   sLen                              like(SQLINTEGER) options(*omit)
     D SQLGetConnectAttrS...
     D                 PR                  ExtProc('SQLGetConnectAttr')
     D                                     like(SQLRETURN)
     D   hdbc                              like(SQLHDBC) value
     D   Attr                              like(SQLINTEGER) value
     D   vParam                   32767A   options(*varsize:*omit)
     D   bLen                              like(SQLINTEGER) value
     D   sLen                              like(SQLINTEGER) options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetConnectOption(): Get connection attribute
      *
      * Deprecated: Use SQLGetConnectAttr()
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetConnectOption...
     D                 PR                  ExtProc('SQLGetConnectOption')
     D                                     like(SQLRETURN)
     D   hdbc                              like(SQLHDBC) value
     D   fOption                           like(SQLINTEGER) value
     D   vParam                            like(SQLPOINTER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetCursorName():  Retrieve cursor name
      *
      *       stmt = (input) statement handle
      *     cursor = (output) returned cursor name
      *  cursormax = (input)  %size() of variable for cursor
      *  cursorlen = (output) returned length of cursor name
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetCursorName...
     D                 PR                  ExtProc('SQLGetCursorName')
     D                                     like(SQLRETURN)
     D   stmt                              like(SQLHSTMT) value
     D   cursor                   32767A   options(*varsize)
     D   cursormax                         like(SQLSMALLINT) value
     D   cursorlen                         like(SQLSMALLINT)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetData():  Get Data From a Column
      *
      *  Note: This is identical to SQLGetCol.
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetData      PR                  ExtProc('SQLGetData')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   icol                              like(SQLSMALLINT) value
     D   fCType                            like(SQLSMALLINT) value
     D   rgbValue                          like(SQLPOINTER) value
     D   cbValueMax                        like(SQLINTEGER) value
     D   pcbValue                          like(SQLINTEGER) options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetDescField():  Get Descriptor Field
      *
      *       hdesc = (input) descriptor handle
      *        irec = (input) record number (column or parameter no)
      *   fDescType = (input) descriptor type
      *     rgbDesc = (output) pointer to buffer for result
      *        bLen = (input) length of rgbDesc buffer
      *        sLen = (output) actual number of bytes returnable
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetDescField...
     D                 PR                  ExtProc('SQLGetDescField')
     D                                     like(SQLRETURN)
     D   hdesc                             like(SQLHDESC) value
     D   irec                              like(SQLSMALLINT) value
     D   fDescType                         like(SQLSMALLINT) value
     D   rgbDesc                           like(SQLPOINTER) value
     D   bLen                              like(SQLINTEGER) value
     D   sLen                              like(SQLINTEGER)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetDescRec(): Get Descriptor record
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetDescRec...
     D                 PR                  ExtProc('SQLGetDescRec')
     D                                     like(SQLRETURN)
     D   hdesc                             like(SQLHDESC) value
     D   irec                              like(SQLSMALLINT) value
     D   name                       513A   options(*varsize:*omit)
     D   namelen                           like(SQLSMALLINT) value
     D   totallen                          like(SQLSMALLINT)
     D   type                              like(SQLSMALLINT)
     D   subtype                           like(SQLSMALLINT)
     D   length                            like(SQLINTEGER)
     D   prec                              like(SQLSMALLINT)
     D   scale                             like(SQLSMALLINT)
     D   nullable                          like(SQLSMALLINT)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetDiagField(): Get Diagnostic Info by Field
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetDiagField...
     D                 PR                  ExtProc('SQLGetDiagField')
     D                                     like(SQLRETURN)
     D   htype                             like(SQLSMALLINT) value
     D   handle                            like(SQLINTEGER) value
     D   recNum                            like(SQLSMALLINT) value
     D   diagId                            like(SQLSMALLINT) value
     D   diagInfo                          like(SQLPOINTER) value
     D   bLen                              like(SQLSMALLINT) value
     D   sLen                              like(SQLSMALLINT) options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetDiagRec(): Get Diagnostic Info by Record
      *
      *        htype = (input) handle type
      *       handle = (input) handle for which diagnostics are reqd
      *     SqlState = (output) SQL state (error) code
      *      SqlCode = (output) IBM SQL status/error code
      *     errorMsg = (output) message text for error
      *  errorMsgMax = (input) %size() of errorMsg variable
      *  errorMsgLen = (output) length of returned data for errorMsg
      *
      * Returns SQL_SUCCESS,
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetDiagRec...
     D                 PR                  ExtProc('SQLGetDiagRec')
     D                                     like(SQLRETURN)
     D   htype                             like(SQLSMALLINT) value
     D   handle                            like(SQLINTEGER) value
     D   recNum                            like(SQLSMALLINT) value
     D   SqlState                     6A
     D   SqlCode                           like(SQLINTEGER)
     D   errorMsg                   513A   options(*varsize)
     D   errorMsgMax                       like(SQLSMALLINT) value
     D   errorMsgLen                       like(SQLSMALLINT)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetEnvAttr(): Get environment attribute
      *
      *    henv = (input)  environment handle
      *    attr = (input)  attribute to retrieve
      *  vParam = (output) returned value, can be an integer or
      *                      a null-terminated char string.
      *    bLen = (input)  %size() of variable passed for vParam
      *    sLen = (output) Length used if output is a string.
      *
      *  Returns SQL_SUCCESS
      *          SQL_NO_DATA_FOUND
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetEnvAttr...
     D                 PR                  ExtProc('SQLGetEnvAttr')
     D                                     like(SQLRETURN)
     D   henv                              like(SQLHENV) value
     D   Attr                              like(SQLINTEGER) value
     D   vParam                            like(SQLPOINTER) value
     D   bLen                              like(SQLINTEGER) value
     D   sLen                              like(SQLINTEGER) options(*omit)
     D SQLGetEnvAttrI...
     D                 PR                  ExtProc('SQLGetEnvAttr')
     D                                     like(SQLRETURN)
     D   henv                              like(SQLHENV) value
     D   Attr                              like(SQLINTEGER) value
     D   vParam                            like(SQLINTEGER)
     D   bLen                              like(SQLINTEGER) value
     D   sLen                              like(SQLINTEGER) options(*omit)
     D SQLGetEnvAttrS...
     D                 PR                  ExtProc('SQLGetEnvAttr')
     D                                     like(SQLRETURN)
     D   henv                              like(SQLHENV) value
     D   Attr                              like(SQLINTEGER) value
     D   vParam                   32767A   options(*varsize:*omit)
     D   bLen                              like(SQLINTEGER) value
     D   sLen                              like(SQLINTEGER) options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetFunctions(): Get functions
      *
      *   Checks which functions are available.
      *
      *        hdbc = (input) connection handle
      *   fFunction = (input) one of the SQL_API_xxx flags
      *  fSupported = (output) SQL_TRUE if function supported,
      *                        SQL_FALSE otherwise.
      *
      * Returns SQL_SUCCESS,
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetFunctions...
     D                 PR                  ExtProc('SQLGetFunctions')
     D                                     like(SQLRETURN)
     D   hdbc                              like(SQLHDBC) value
     D   fFunction                         like(SQLSMALLINT) value
     D   fSupported                        like(SQLSMALLINT)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetInfo(): Get general information about the DBMS
      *
      *          hdbc = (input) connection handle
      *      InfoType = (input) type of information desired
      *     InfoValue = (output) address of variable that will
      *                          contain returned result.
      *    InfoValMax = (input) %size() of variable provided for
      *                          InfoValue.
      *  InfoValAvail = (output) amount of data available to be
      *                           returned in InfoValue
      *
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetInfo      PR                  ExtProc('SQLGetInfo')
     D                                     like(SQLRETURN)
     D   hdbc                              like(SQLHDBC) value
     D   InfoType                          like(SQLSMALLINT) value
     D   InfoValue                         like(SQLPOINTER) value
     D   InfoValueMax                      like(SQLSMALLINT) value
     D   InfoValAvail                      like(SQLSMALLINT)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetLength(): Get the length of a LOB column
      *
      *         hstmt = (input) statement handle
      *   LocatorType = (input) type of locator. values are:
      *                         SQL_C_BLOB_LOCATOR
      *                         SQL_C_CLOB_LOCATOR
      *                         SQL_C_DBCLOB_LOCATOR
      *       Locator = (input) LOB locator to get length for
      *        Length = (output) returned length of LOB
      *         Indic = (output) always returns 0.
      *
      * Returns SQL_SUCCESS
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_STILL_EXECUTING
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetLength    PR                  ExtProc('SQLGetLength')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   LocatorType                       like(SQLSMALLINT) value
     D   Locator                           like(SQLINTEGER) value
     D   Length                            like(SQLINTEGER)
     D   Indic                             like(SQLINTEGER)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetPosition(): Get the position of a search string in
      *                   a LOB column.
      *
      *         hstmt = (input) statement handle
      *   LocatorType = (input) type of locator. values are:
      *                         SQL_C_BLOB_LOCATOR
      *                         SQL_C_CLOB_LOCATOR
      *                         SQL_C_DBCLOB_LOCATOR
      *       Locator = (input) Source LOB locator (the LOB to be
      *                         searched)
      *   SrchLocator = (input) Search LOB locator (the LOB containing
      *                         the string to search for -- only used
      *                         if SearchLen = 0)
      *     SearchFor = (input) String to search for, or *OMIT if
      *                         SrchLocator should be used.
      *     SearchLen = (input) Length of string to search for, or
      *                         0 if SrchLocator should be used.
      *       FromPos = (input) position to start searching at
      *                         (byte position for a BLOB/CLOB or
      *                         character position for a DBCLOB)
      *     LocatedAt = (output) position where matching string was
      *                          found.
      *         Indic = (output) always returns 0.
      *
      * Returns SQL_SUCCESS
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_STILL_EXECUTING
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetPosition  PR                  ExtProc('SQLGetPosition')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   LocatorType                       like(SQLSMALLINT) value
     D   Locator                           like(SQLINTEGER) value
     D   SrchLocator                       like(SQLINTEGER) value
     D   SearchFor                32767A   const options(*varsize:*omit)
     D   SearchLen                         like(SQLINTEGER) value
     D   FromPos                           like(SQLINTEGER) value
     D   LocatedAt                         like(SQLINTEGER)
     D   Indic                             like(SQLINTEGER)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetStmtAttr(): Get statement attribute
      *
      *     hstmt = (input) statement handle
      *     fAttr = (input) attribute to retrieve
      *   pvParam = (output) address of variable to receive value
      *      bLen = (input) %size() of pvParam variable
      *      sLen = (output) length of returned data
      *
      * Returns SQL_SUCCESS
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetStmtAttr  PR                  ExtProc('SQLGetStmtAttr')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   fAttr                             like(SQLINTEGER) value
     D   pvParam                           like(SQLPOINTER) value
     D   bLen                              like(SQLINTEGER) value
     D   sLen                              like(SQLINTEGER)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetStmtOption(): Get statement option
      *
      *  Deprecated:  Use SQLGetStmtAttr()
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetStmtOption...
     D                 PR                  ExtProc('SQLGetStmtOption')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   fAttr                             like(SQLINTEGER) value
     D   pvParam                           like(SQLPOINTER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetSubString(): Retrieve a portion of a LOB value
      *
      *         hstmt = (input) statement handle
      *   LocatorType = (input) type of locator. values are:
      *                         SQL_C_BLOB_LOCATOR
      *                         SQL_C_CLOB_LOCATOR
      *                         SQL_C_DBCLOB_LOCATOR
      *       Locator = (input) Source LOB locator
      *       FromPos = (input) position of the first byte (BLOB/CLOB)
      *                         or character (DBCLOB) to be returned
      *     ForLength = (input) length of the substring
      *    TargetType = (input) data type of the variable that results
      *                         are placed into.
      *       DataPtr = (output) address of the variable that results
      *                          are placed into
      *       VarSize = (input) %size() of the variable that results
      *                          are placed into
      *        RtnLen = (output) returned length of data retrieved
      *         Indic = (output) always returns 0
      *
      * Returns SQL_SUCCESS
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_STILL_EXECUTING
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetSubString...
     D                 PR                  ExtProc('SQLGetSubString')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   LocatorType                       like(SQLSMALLINT) value
     D   Locator                           like(SQLINTEGER) value
     D   FromPos                           like(SQLINTEGER) value
     D   ForLength                         like(SQLINTEGER) value
     D   TargetType                        like(SQLSMALLINT) value
     D   DataPtr                           like(SQLPOINTER) value
     D   VarSize                           like(SQLINTEGER) value
     D   RtnLen                            like(SQLINTEGER)
     D   Indic                             like(SQLINTEGER)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetTypeInfo(): Get Information About the Data Types
      *                   supported by the connected DBMS
      *
      *      hstmt = (input) statement handle
      *   DataType = (input) SQL data type to query for
      *
      * Returns SQL_SUCCESS
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *  -results are supplied in a result set-
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetTypeInfo...
     D                 PR                  ExtProc('SQLGetTypeInfo')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   DataType                          like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLLanguages(): Get SQL Dialect or conformance information
      *
      *    hstmt = (input) statement handle
      *
      * Returns SQL_SUCCESS
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *  -results are supplied in a result set-
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLLanguages...
     D                 PR                  ExtProc('SQLLanguages')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLMoreResults(): Close the cursor to the current result
      *                   set and determine if there are more
      *                   result sets available.
      *
      *    hstmt = (input) statement handle
      *
      * Returns SQL_SUCCESS          <- when more result sets found
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_STILL_EXECUTING
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND    <- when no more are found.
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLMoreResults...
     D                 PR                  ExtProc('SQLLanguages')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLNativeSQL(): Get native SQL Text
      *
      * This is ostensibly provided to see the statement after any
      * vendor escape clauses have been interpreted.  However, the
      * iSeries doesn't use vendor escape clauses.  This function
      * is still useful as an SQL statement syntax checker.
      *
      *       hstmt = (input) statement handle
      *      inStmt = (input) SQL statement to interpret
      *   inStmtLen = (input) should be SQL_NTS
      *     outStmt = (output) returned statement
      * outStmtSize = (i/o) variable size of output statement.
      *                this'll be changed to SQL_NULL_DATA if
      *                no output string is generated.
      *
      * Returns SQL_SUCCESS
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLNativeSQL...
     D                 PR                  ExtProc('SQLNativeSQL')
     D                                     like(SQLRETURN)
     D   hdbc                              like(SQLHDBC) value
     D   inStmt                        *   value options(*string)
     D   inStmtLen                         like(SQLINTEGER) value
     D   outStmt                  32767A   options(*varsize)
     D   outStmtSize                       like(SQLINTEGER)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLNextResult(): Associate Next Result Set with a
      *                  statement handle.
      *
      * This lets you move the next result set from the current
      * statement handle to another one so that it can be processed
      * at the same time as the current one.
      *
      *     hstmt = (input) Statement handle containing result sets
      *  nextstmt = (input) Statement handle to move the next
      *                     result set to.
      *
      * Returns SQL_SUCCESS
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND   <-- if no more result sets found
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLNextResult...
     D                 PR                  ExtProc('SQLNextResult')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   nextstmt                          like(SQLHSTMT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLNumParams(): Returns the number of parameter markers
      *                 in an SQL statement.
      *
      *  hstmt = (input) statement handle
      *  count = (output) number of parameters
      *
      * Returns SQL_SUCCESS
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_STILL_EXECUTING
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLNumParams...
     D                 PR                  ExtProc('SQLNumParams')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   count                             like(SQLSMALLINT)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLNumResultCols(): Returns the number of columns in the
      *                 result set.
      *
      *  hstmt = (input) statement handle
      *  count = (output) number of result columns
      *
      * Returns SQL_SUCCESS
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLNumResultCols...
     D                 PR                  ExtProc('SQLNumResultCols')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   count                             like(SQLSMALLINT)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLParamData(): Get next parameter for which data is needed
      *
      * This is used when SQL_DATA_AT_EXEC is passed to SQLBindParam
      * it is used to iterate through the parameters, while
      * SQLPutData() is used to set the actual data values.
      *
      *    hstmt = (input) Statement handle
      * rgbValue = (output) This is assigned by your application
      *                 when SQLBindParam() is called.  Here it's
      *                 returned to you.  Use it as you like.
      *
      * Returns SQL_SUCCESS         <-- returned when all data set.
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NEED_DATA       <-- returned to tell you to call
      *                                 SQLPutData()
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLParamData...
     D                 PR                  ExtProc('SQLParamData')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   rgbValue                          like(SQLINTEGER) options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLParamOptions():  Specify an Input Array for a Parameter
      *
      *  Signals that multiple row INSERT statements are to be
      *  used.  This statement specifies the size of the array
      *  of values to be inserted, SQLBindParam() must specify
      *  the array to insert from.  Parameter values must be
      *  arranged in a row-wise fashion and must be contiguous.
      *
      *        hstmt = (input) statement handle
      *         Crow = (input) number of values for each parameter
      *                        (i.e. size of array.)
      *  FetchOffset = (output) not used
      *
      * Returns SQL_SUCCESS
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLParamOptions...
     D                 PR                  ExtProc('SQLParamOptions')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   Crow                              like(SQLINTEGER) value
     D   FetchOffset                       like(SQLINTEGER) options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLPrepare(): Prepare an SQL statement to be executed
      *               one or more times.
      *
      *    hstmt = (input) statement handle to prepare into
      * szSqlStr = (input) SQL Statement to prepare
      * cbSqlStr = (input) length of SQL statement
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLPrepare      PR                  Extproc('SQLPrepare')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    szSqlStr                     *   value options(*string)
     D    cbSqlStr                         like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLPrimaryKeys(): Get the list of primary key columns
      *
      *  NOTE: Results from this API are returned in a result set.
      *        To get them, use SQLFetch() and friends.
      *
      *          stmt = (input) statement handle
      *       catalog = (input) must be *OMIT
      *    cataloglen = (input) must be 0
      *        schema = (input) schema qualifier of table
      *     schemalen = (input) schema len, or SQL_NTS
      *         table = (input) name of table
      *      tablelen = (input) table name len, or SQL_NTS
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_STILL_EXECUTING
      * - results are returned in a result set -
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLPrimaryKeys  PR                  Extproc('SQLPrimaryKeys')
     D                                     like(SQLRETURN)
     D   stmt                              like(SQLHSTMT) value
     D   catalog                  32767A   const options(*varsize:*omit)
     D   cataloglen                        like(SQLINTEGER) value
     D   schema                        *   value options(*string)
     D   schemalen                         like(SQLINTEGER) value
     D   table                         *   value options(*string)
     D   tablelen                          like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLProcedureColumns(): Get I/O Parameter Info for a procedure
      *
      *        stmt = (input) statement handle
      *     catalog = (input) must be *OMIT
      *  cataloglen = (input) must be 0
      *      schema = (input) schema name (pattern)
      *   schemalen = (input) length of schema (SQL_NTS)
      *    procName = (input) procedure name to return
      *     procLen = (input) length of procName (SQL_NTS)
      *     procLen = (input) length of procName (SQL_NTS)
      *  columnName = (input) pattern value for cols to return
      *   columnLen = (input) length of columnName (SQL_NTS)
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_STILL_EXECUTING
      * - results are returned in a result set -
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLProcedureColumns...
     D                 PR                  Extproc('SQLProcedureColumns')
     D                                     like(SQLRETURN)
     D   stmt                              like(SQLHSTMT) value
     D   catalog                  32767A   const options(*varsize:*omit)
     D   cataloglen                        like(SQLINTEGER) value
     D   schema                        *   value options(*string)
     D   schemalen                         like(SQLINTEGER) value
     D   procName                      *   value options(*string)
     D   procLen                           like(SQLINTEGER) value
     D   columnName                    *   value options(*string)
     D   colLen                            like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLProcedures(): Return a list of registered procedures
      *
      *        stmt = (input) statement handle
      *     catalog = (input) must be *OMIT
      *  cataloglen = (input) must be 0
      *      schema = (input) pattern-value of schema
      *   schemalen = (input) length of schema (SQL_NTS)
      *    procName = (input) pattern-value of procedure name
      *     proclen = (input) length of procName (SQL_NTS)
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_STILL_EXECUTING
      * - results are returned in a result set -
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLProcedures...
     D                 PR                  Extproc('SQLProcedures')
     D                                     like(SQLRETURN)
     D   stmt                              like(SQLHSTMT) value
     D   catalog                  32767A   const options(*varsize:*omit)
     D   cataloglen                        like(SQLINTEGER) value
     D   schema                        *   value options(*string)
     D   schemalen                         like(SQLINTEGER) value
     D   procName                      *   value options(*string)
     D   procLen                           like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLPutData(): Pass data values at exec time for a parameter
      *
      *  This procedure is always called after SQLParamData()
      *  and can be called multiple times to set a large value
      *  in chunks.  When finished, SQLParamData() must be
      *  called again to move to the next parameter.
      *
      *      stmt = (input) statement handle
      *      data = (input) pointer to data to place in parameter
      *   datalen = (input) length of data in previous parameter
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLPutData...
     D                 PR                  Extproc('SQLPutData')
     D                                     like(SQLRETURN)
     D   stmt                              like(SQLHSTMT) value
     D   data                              like(SQLPOINTER) value
     D   datalen                           like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLReleaseEnv(): Release all SQL CLI Environment Resources
      *
      *     henv = (input) environment handle to blow away
      *                    (SQLFreeConnect must already be done.)
      *
      * Returns SQL_SUCCESS
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLReleaseEnv...
     D                 PR                  Extproc('SQLReleaseEnv')
     D                                     like(SQLRETURN)
     D   henv                              like(SQLHENV) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLRowCount(): Get Row Count of last SQL statement
      *
      *  Call this after an UPDATE, DELETE or INSERT to get a count
      *  of the number of rows that were affected.
      *
      *    hstmt = (input) statement handle
      *     crow = (output) count of rows returned by statement
      *
      * Returns SQL_SUCCESS
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLRowCount...
     D                 PR                  Extproc('SQLRowCount')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   crow                              like(SQLINTEGER)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSetConnectAttr(): Set connection attributes
      *
      *    hdbc = (input) connection handle to set attributes of
      *   fAttr = (input) Attribute to set
      *  vParam = (input) pointer to new attribute value
      *    sLen = (input) length of new attribute value
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSetConnectAttr...
     D                 PR                  Extproc('SQLSetConnectAttr')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                           like(SQLPOINTER) value
     D    sLen                             like(SQLINTEGER) value
     D SQLSetConnectAttrI...
     D                 PR                  Extproc('SQLSetConnectAttr')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                           like(SQLINTEGER) const
     D    sLen                             like(SQLINTEGER) value
     D SQLSetConnectAttrS...
     D                 PR                  Extproc('SQLSetConnectAttr')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                  32767A   options(*varsize) const
     D    sLen                             like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSetConnectOption(): Set connection option
      *
      * DEPRECATED: Use SQLSetConnectAttr() instead.  This is the
      * same function, but the API will make assuptions about the
      * size of vParam.
      *
      *    hdbc = (input) connection handle to set attributes of
      * fOption = (input) Option to set
      *  vParam = (input) pointer to new attribute value
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSetConnectOption...
     D                 PR                  Extproc('SQLSetConnectOption')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    fOption                          like(SQLINTEGER) value
     D    vParam                           like(SQLPOINTER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSetCursorName(): Set a friendly name for an SQL Cursor
      *
      *        hstmt = (input) statement handle
      *   CursorName = (input) New cursor name to set (<=18 chars)
      *    CursorLen = (input) Length of cursor name (SQL_NTS)
      *
      * Returns SQL_SUCCESS,
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSetCursorName...
     D                 PR                  Extproc('SQLSetCursorName')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    CursorName                   *   value options(*string)
     D    CursorLen                        like(SQLSMALLINT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSetDescField(): Set a descriptor field
      *
      *       hdesc = (input) descriptor handle
      *        irec = (input) record number
      *   fDescType = (input) descriptor field to set
      *      buffer = (input) pointer to buffer (value to set)
      *   bufferlen = (input) length of buffer parameter
      *
      * Returns SQL_SUCCESS
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSetDescField...
     D                 PR                  Extproc('SQLSetDescField')
     D                                     like(SQLRETURN)
     D    hdesc                            like(SQLHDESC) value
     D    irec                             like(SQLSMALLINT) value
     D    fDescType                        like(SQLSMALLINT) value
     D    buffer                           like(SQLPOINTER) value
     D    bufferlen                        like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSetDescRec(): Set all descriptor fields
      *
      *       hdesc = (input) descriptor handle
      *        irec = (input) record number
      *        Type = (input) TYPE field for record
      *     subtype = (input) DATETIME_INTERVAL_CODE field for
      *                       records where TYPE=SQL_DATETIME
      *      length = (input) LENGTH field for record
      *        prec = (input) PRECISION field for record
      *       scale = (input) SCALE field for record
      *        data = (input) DATA_PTR field for record
      *        sLen = (input) LENGTH_PTR field for record
      *       indic = (input) INDICATOR_PTR field for record
      *
      * Returns SQL_SUCCESS
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSetDescRec...
     D                 PR                  Extproc('SQLSetDescRec')
     D                                     like(SQLRETURN)
     D    hdesc                            like(SQLHDESC) value
     D    irec                             like(SQLSMALLINT) value
     D    type                             like(SQLSMALLINT) value
     D    subtype                          like(SQLSMALLINT) value
     D    length                           like(SQLINTEGER) value
     D    prec                             like(SQLSMALLINT) value
     D    scale                            like(SQLSMALLINT) value
     D    data                             like(SQLPOINTER) value
     D    sLen                             like(SQLINTEGER)
     D    indic                            like(SQLINTEGER)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSetEnvAttr(): Set environment attributes
      *
      *    henv = (input) environment to set attributes of
      *   fAttr = (input) Attribute to set
      *  vParam = (input) pointer to new attribute value
      *    sLen = (input) length of new attribute value
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSetEnvAttr...
     D                 PR                  Extproc('SQLSetEnvAttr')
     D                                     like(SQLRETURN)
     D    henv                             like(SQLHENV) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                           like(SQLPOINTER) value
     D    sLen                             like(SQLINTEGER) value
     D SQLSetEnvAttrI...
     D                 PR                  Extproc('SQLSetEnvAttr')
     D                                     like(SQLRETURN)
     D    henv                             like(SQLHENV) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                           like(SQLINTEGER) const
     D    sLen                             like(SQLINTEGER) value
     D SQLSetEnvAttrS...
     D                 PR                  Extproc('SQLSetEnvAttr')
     D                                     like(SQLRETURN)
     D    henv                             like(SQLHENV) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                  32767A   options(*varsize) const
     D    sLen                             like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSetParam(): Set Parameter
      *
      *      hstmt = (input) statement handle
      *       ipar = (input) parameter marker number to bind
      *     fCType = (input) application data type for column
      *   fSqlType = (input) SQL data type for column
      * cbParamDef = (input) precision of corresponding param marker
      *    ibScale = (input) scale of parm marker (decimal places)
      *   rgbValue = (i/o)   pointer to variable for data
      *                        or SQL_NULL_DATA if no data.
      *   pcbValue = (input) length of data, or SQL_NTS, or zero
      *                        or *OMIT if no data
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSetParam     PR                  ExtProc('SQLSetParam')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    ipar                             like(SQLSMALLINT) value
     D    fCType                           like(SQLSMALLINT) value
     D    fSqlType                         like(SQLSMALLINT) value
     D    cbParamDef                       like(SQLINTEGER) value
     D    ibScale                          like(SQLSMALLINT) value
     D    rgbValue                         like(SQLPOINTER) value
     D    pcbValue                         like(SQLINTEGER) const
     d                                     options(*omit)


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSetStmtAttr(): Set statement attributes
      *
      *    stmt = (input) statement to set attributes of
      *   fAttr = (input) Attribute to set
      *  vParam = (input) pointer to new attribute value
      *    sLen = (input) length of new attribute value
      *
      * Returns SQL_SUCCESS,
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSetStmtAttr...
     D                 PR                  Extproc('SQLSetStmtAttr')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                           like(SQLPOINTER) value
     D    sLen                             like(SQLINTEGER) value
     D SQLSetStmtAttrI...
     D                 PR                  Extproc('SQLSetStmtAttr')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                           like(SQLINTEGER) const
     D    sLen                             like(SQLINTEGER) value
     D SQLSetStmtAttrS...
     D                 PR                  Extproc('SQLSetStmtAttr')
     D                                     like(SQLRETURN)
     D    stmt                             like(SQLHSTMT) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                  32767A   options(*varsize) const
     D    sLen                             like(SQLINTEGER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSetStmtOption(): Set Statement Option
      *
      *  Deprecated:  Use SQLSetStmtAttr() instead.
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSetStmtOption...
     D                 PR                  Extproc('SQLSetStmtOption')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    fOption                          like(SQLINTEGER) value
     D    vParam                           like(SQLPOINTER) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSpecialColumns(): Get Special (Row identifying) columns
      *
      *       hstmt = (input) Statement handle
      *     ColType = (input) reserved for future use (ignored)
      *     Catalog = (input) Must be *OMIT
      *  CatalogLen = (input) Must be 0
      *  SchemaName = (input) Schema qualifier for table
      *   SchemaLen = (input) Length of SchemaName parm, use SQL_NTS
      *   TableName = (input) Table name to get cols from
      *    TableLen = (input) Length of TableName parm, use SQL_NTS
      *       Scope = (input) duration for which identifier is valid
      *                       SQL_SCOPE_CURROW      -- until fetch
      *                       SQL_SCOPE_TRANSACTION -- until commit
      *                       SQL_SCOPE_SESSION     -- until disconnect
      *    Nullable = (input) Return null-capable columns?
      *                       SQL_NO_NULLS = don't return them.
      *                       SQL_NULLABLE = return them.
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      * - results are returned in a result set -
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSpecialColumns...
     D                 PR                  Extproc('SQLSpecialColumns')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    ColType                          like(SQLSMALLINT) value
     D    Catalog                 32767A   const options(*varsize:*omit)
     D    CataLogLen                       like(SQLSMALLINT) value
     D    SchemaName                   *   value options(*string)
     D    SchemaLen                        like(SQLSMALLINT) value
     D    TableName                    *   value options(*string)
     D    TableLen                         like(SQLSMALLINT) value
     D    Scope                            like(SQLSMALLINT) value
     D    Nullable                         like(SQLSMALLINT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLStatistics(): Get Index and Statistics Information
      *                  For a Base Table
      *
      *       hstmt = (input) Statement handle
      *     Catalog = (input) Must be *omit
      *  CatalogLen = (input) Must be 0
      *  SchemaName = (input) Schema qualifier of table
      *   SchemaLen = (input) Length of SchemaName parm, use SQL_NTS
      *   TableName = (input) Name of table to get stats/index for
      *    TableLen = (input) Length of TableName parm, use SQL_NTS
      *      Unique = (input) Type of index info to return
      *                      SQL_INDEX_UNIQUE = only unique indexes
      *                      SQL_INDEX_ALL = every index
      *    Accuracy = (input) Not used.  Pass 0
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      * - results are returned in a result set -
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLStatistics   PR                  Extproc('SQLStatistics')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    Catalog                 32767A   const options(*varsize:*omit)
     D    CataLogLen                       like(SQLSMALLINT) value
     D    SchemaName                   *   value options(*string)
     D    SchemaLen                        like(SQLSMALLINT) value
     D    TableName                    *   value options(*string)
     D    TableLen                         like(SQLSMALLINT) value
     D    Unique                           like(SQLSMALLINT) value
     D    Accuracy                         like(SQLSMALLINT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLTablePriveledges(): Get tables and associated priveldges
      *
      *       hstmt = (input) Statement handle
      *     Catalog = (input) Must be *omit
      *  CatalogLen = (input) Must be 0
      *  SchemaName = (input) Schema qualifier, may contain patterns
      *   SchemaLen = (input) Length of SchemaName parm, use SQL_NTS
      *   TableName = (input) Name of table, may contain patterns
      *    TableLen = (input) Length of TableName parm, use SQL_NTS
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_STILL_EXECUTING
      * - results are returned in a result set -
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLTablePriveledges...
     D                 PR                  Extproc('SQLTablePriveledges')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    Catalog                 32767A   const options(*varsize:*omit)
     D    CataLogLen                       like(SQLSMALLINT) value
     D    SchemaName                   *   value options(*string)
     D    SchemaLen                        like(SQLSMALLINT) value
     D    TableName                    *   value options(*string)
     D    TableLen                         like(SQLSMALLINT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLTables(): Get Table Information
      *
      *       hstmt = (input) Statement handle
      *     Catalog = (input) Must be *omit
      *  CatalogLen = (input) Must be 0
      *  SchemaName = (input) Schema qualifier, may contain patterns
      *   SchemaLen = (input) Length of SchemaName parm, use SQL_NTS
      *   TableName = (input) Name of table, may contain patterns
      *    TableLen = (input) Length of TableName parm, use SQL_NTS
      *   TableType = (input) Types of tables to return.  This is
      *                       a comma-separated list of the following
      *                        ALL,BASE TABLE,TABLE,VIEW,SYSTEM TABLE
      *                       or you can pass *NULL to mean "ALL"
      * TableTypLen = (input) Length of TableType parm, use SQL_NTS
      *                       or 0 if you pass *NULL
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      * - results are returned in a result set -
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLTables       PR                  Extproc('SQLTables')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    Catalog                 32767A   const options(*varsize:*omit)
     D    CataLogLen                       like(SQLSMALLINT) value
     D    SchemaName                   *   value options(*string)
     D    SchemaLen                        like(SQLSMALLINT) value
     D    TableName                    *   value options(*string)
     D    TableLen                         like(SQLSMALLINT) value
     D    TableType                    *   value options(*string)
     D    TableTypLen                      like(SQLSMALLINT) value


      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLTransact():  Commit or roll-back the current transaction
      *
      *    henv = (input) environment handle.  Ignored unless
      *                   hdbc is set to SQL_NULL_HDBC
      *    hdbc = (input) connection handle.
      *   fType = (input) desired action for transaction
      *                   SQL_COMMIT
      *                   SQL_ROLLBACK
      *                   SQL_COMMIT_HOLD
      *                   SQL_ROLLBACK_HOLD
      *
      * Returns SQL_SUCCESS,
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLTransact     PR                  Extproc('SQLTransact')
     D                                     like(SQLRETURN)
     D    henv                             like(SQLHENV) value
     D    hdbc                             like(SQLHDBC) value
     D    fType                            like(SQLSMALLINT) value
