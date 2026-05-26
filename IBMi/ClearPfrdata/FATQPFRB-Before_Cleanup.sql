-- Script: FATQPFRB - Performance Data Object Statistics (Before Cleanup)
-- Purpose: Analyze QPFRDATA library objects by size before cleanup operations
-- Author: IBM Bob
-- Created: 2026-02-05
--
-- Description:
--   Creates a temporary table showing the top 20 largest objects in QPFRDATA
--   library, grouped by object name and type. This provides visibility into
--   space consumption before performing cleanup operations.
--
-- Dependencies:
--   - QSYS2.OBJECT_STATISTICS table function
--   - QPFRDATA library must exist
--
-- Usage:
--   Run this script before cleanup to establish baseline metrics
-- Drop existing table if it exists (defensive programming)
-- Note: CREATE OR REPLACE handles this, but explicit DROP provides clearer intent
BEGIN
DECLARE CONTINUE HANDLER FOR SQLSTATE '42704' -- Table not found
BEGIN END;


-- Ignore error if table doesn't exist
DROP TABLE QTEMP.FATQPFRB;


END;


-- Create analysis table with improved structure and documentation
CREATE OR REPLACE TABLE
    QTEMP.FATQPFRB AS (
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
LABEL ON TABLE QTEMP.FATQPFRB IS 'Performance Data Objects - Pre-Cleanup Analysis';


LABEL ON COLUMN QTEMP.FATQPFRB (
    OBJECT_NAME IS 'Object Name',
    OBJECT_TYPE IS 'Object Type (*FILE, *PGM, etc.)',
    SIZE_KB IS 'Total Size in Kilobytes',
    OBJECT_COUNT IS 'Number of Objects',
    ANALYSIS_TIMESTAMP IS 'Analysis Run Timestamp'
);


-- Create index for potential queries
CREATE INDEX QTEMP.FATQPFRB_IDX1 ON QTEMP.FATQPFRB (SIZE_KB DESC);


-- Display results with formatted output
SELECT
    OBJECT_NAME,
    OBJECT_TYPE,
    CHAR(SIZE_KB, '999,999,999') AS SIZE_KB_FORMATTED,
    OBJECT_COUNT,
    CHAR(ANALYSIS_TIMESTAMP, ISO) AS ANALYSIS_TIME
FROM
    QTEMP.FATQPFRB
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
    QTEMP.FATQPFRB;


-- IMPROVEMENT NOTES:
--
-- 1. READABILITY & MAINTAINABILITY:
--    - Added comprehensive header documentation
--    - Used descriptive column aliases (OBJECT_NAME vs OBJNAME)
--    - Formatted SQL with proper indentation and line breaks
--    - Added inline comments explaining key sections
--    - Used named parameters for OBJECT_STATISTICS function
--    - Added column labels for better metadata
--
-- 2. PERFORMANCE OPTIMIZATION:
--    - Added OBJECT_COUNT to track multiple objects with same name
--    - Created index on SIZE_KB for faster queries
--    - Used meaningful table alias (OBJ_STATS vs X)
--    - Added ANALYSIS_TIMESTAMP for audit trail
--
-- 3. BEST PRACTICES:
--    - Added error handling for table existence
--    - Used named parameters for clarity
--    - Added table and column labels
--    - Included summary statistics query
--    - Formatted output for better readability
--    - Used proper SQL naming conventions
--
-- 4. ERROR HANDLING & EDGE CASES:
--    - CONTINUE HANDLER for non-existent table
--    - CREATE OR REPLACE prevents errors if table exists
--    - Handles empty result sets gracefully
--    - Added timestamp for tracking when analysis was run
--    - Summary query provides validation of results