-- Script: FATQPFRA - Performance Data Object Statistics (After Cleanup)
-- Purpose: Analyze QPFRDATA library objects by size after cleanup operations
-- Author: IBM Bob
-- Created: 2026-02-05
--
-- Description:
--   Creates a temporary table showing the top 20 largest objects in QPFRDATA
--   library, grouped by object name and type. This provides visibility into
--   space consumption after performing cleanup operations, allowing comparison
--   with pre-cleanup metrics.
--
-- Dependencies:
--   - QSYS2.OBJECT_STATISTICS table function
--   - QPFRDATA library must exist
--
-- Usage:
--   Run this script after cleanup to measure effectiveness
--   Compare results with FATQPFRB (before cleanup) for analysis
-- Drop existing table if it exists (defensive programming)
-- Note: CREATE OR REPLACE handles this, but explicit DROP provides clearer intent
BEGIN
DECLARE CONTINUE HANDLER FOR SQLSTATE '42704' -- Table not found
BEGIN END;


-- Ignore error if table doesn't exist
DROP TABLE QTEMP.FATQPFRA;


END;


-- Create analysis table with improved structure and documentation
CREATE OR REPLACE TABLE
    QTEMP.FATQPFRA AS (
        SELECT
            OBJNAME AS OBJECT_NAME,
            OBJTYPE AS OBJECT_TYPE,
            SUM(OBJSIZE) AS SIZE_KB,
            COUNT(*) AS OBJECT_COUNT,
            CURRENT_TIMESTAMP AS ANALYSIS_TIMESTAMP
        FROM
            TABLE (
                QSYS2.OBJECT_STATISTICS (
                    OBJECT_SCHEMA => 'QPFRDATA',
                    OBJTYPELIST => '*ALL'
                )
            ) AS OBJ_STATS
        GROUP BY
            OBJNAME,
            OBJTYPE
        ORDER BY
            SIZE_KB DESC
        FETCH FIRST
            20 ROWS ONLY
    )
WITH
    DATA;


-- Add descriptive labels to the table
LABEL ON TABLE QTEMP.FATQPFRA IS 'Performance Data Objects - Post-Cleanup Analysis';


LABEL ON COLUMN QTEMP.FATQPFRA (
    OBJECT_NAME IS 'Object Name',
    OBJECT_TYPE IS 'Object Type (*FILE, *PGM, etc.)',
    SIZE_KB IS 'Total Size in Kilobytes',
    OBJECT_COUNT IS 'Number of Objects',
    ANALYSIS_TIMESTAMP IS 'Analysis Run Timestamp'
);


-- Create index for potential queries
CREATE INDEX QTEMP.FATQPFRA_IDX1 ON QTEMP.FATQPFRA (SIZE_KB DESC);


-- Display results with formatted output
SELECT
    OBJECT_NAME,
    OBJECT_TYPE,
    CHAR(SIZE_KB, '999,999,999') AS SIZE_KB_FORMATTED,
    OBJECT_COUNT,
    CHAR(ANALYSIS_TIMESTAMP, ISO) AS ANALYSIS_TIME
FROM
    QTEMP.FATQPFRA
ORDER BY
    SIZE_KB DESC;


-- Optional: Generate summary statistics
SELECT
    'SUMMARY' AS REPORT_TYPE,
    COUNT(*) AS TOTAL_OBJECT_TYPES,
    SUM(SIZE_KB) AS TOTAL_SIZE_KB,
    CHAR(SUM(SIZE_KB), '999,999,999') AS TOTAL_SIZE_FORMATTED,
    AVG(SIZE_KB) AS AVG_SIZE_KB,
    MAX(SIZE_KB) AS MAX_SIZE_KB,
    MIN(SIZE_KB) AS MIN_SIZE_KB
FROM
    QTEMP.FATQPFRA;


-- Optional: Compare with BEFORE cleanup data (if available)
-- This query will fail gracefully if FATQPFRB doesn't exist
BEGIN
DECLARE CONTINUE HANDLER FOR SQLSTATE '42704' -- Table not found
BEGIN END;


SELECT
    'COMPARISON' AS REPORT_TYPE,
    COALESCE(B.TOTAL_SIZE_KB, 0) AS BEFORE_SIZE_KB,
    COALESCE(A.TOTAL_SIZE_KB, 0) AS AFTER_SIZE_KB,
    COALESCE(B.TOTAL_SIZE_KB, 0) - COALESCE(A.TOTAL_SIZE_KB, 0) AS SPACE_FREED_KB,
    CHAR(
        COALESCE(B.TOTAL_SIZE_KB, 0) - COALESCE(A.TOTAL_SIZE_KB, 0),
        '999,999,999'
    ) AS SPACE_FREED_FORMATTED,
    CASE
        WHEN COALESCE(B.TOTAL_SIZE_KB, 0) > 0 THEN DECIMAL(
            (
                COALESCE(B.TOTAL_SIZE_KB, 0) - COALESCE(A.TOTAL_SIZE_KB, 0)
            ) * 100.0 / B.TOTAL_SIZE_KB,
            5,
            2
        )
        ELSE 0
    END AS REDUCTION_PERCENT
FROM
    (
        SELECT
            SUM(SIZE_KB) AS TOTAL_SIZE_KB
        FROM
            QTEMP.FATQPFRA
    ) AS A,
    (
        SELECT
            SUM(SIZE_KB) AS TOTAL_SIZE_KB
        FROM
            QTEMP.FATQPFRB
    ) AS B;


END;


-- IMPROVEMENT NOTES:
--
-- 1. READABILITY & MAINTAINABILITY:
--    - Added comprehensive header documentation with purpose and usage
--    - Used descriptive column aliases (OBJECT_NAME vs OBJNAME)
--    - Formatted SQL with proper indentation and consistent line breaks
--    - Added inline comments explaining key sections
--    - Used named parameters for OBJECT_STATISTICS function (clearer intent)
--    - Added column labels for better metadata and self-documentation
--    - Separated logical sections with clear comment blocks
--
-- 2. PERFORMANCE OPTIMIZATION:
--    - Added OBJECT_COUNT to track multiple objects with same name/type
--    - Created index on SIZE_KB for faster subsequent queries
--    - Used meaningful table alias (OBJ_STATS vs X) for clarity
--    - Added ANALYSIS_TIMESTAMP for audit trail and temporal queries
--    - Optimized GROUP BY to use original column names (avoids alias issues)
--
-- 3. BEST PRACTICES:
--    - Added error handling for table existence (CONTINUE HANDLER)
--    - Used named parameters for function calls (self-documenting)
--    - Added table and column labels (IBM i best practice)
--    - Included summary statistics query for quick analysis
--    - Formatted output with CHAR() for better readability
--    - Used proper SQL naming conventions (uppercase keywords, descriptive names)
--    - Added comparison query to measure cleanup effectiveness
--    - Consistent with FATQPFRB structure for easy comparison
--
-- 4. ERROR HANDLING & EDGE CASES:
--    - CONTINUE HANDLER for non-existent table (SQLSTATE 42704)
--    - CREATE OR REPLACE prevents errors if table already exists
--    - Handles empty result sets gracefully (no errors on zero rows)
--    - Added timestamp for tracking when analysis was run
--    - Summary query provides validation of results
--    - Comparison query uses COALESCE to handle NULL values
--    - Defensive programming with explicit DROP before CREATE
--    - Handles case where FATQPFRB might not exist (comparison query)
--
-- 5. ADDITIONAL ENHANCEMENTS:
--    - Added comparison query to automatically calculate space savings
--    - Calculates reduction percentage for easy reporting
--    - Formatted numbers with thousands separators for readability
--    - Consistent structure with FATQPFRB for maintainability
--    - Ready for integration with email reporting (CLRPFRDATA program)