-- ---------------------------------------------------------------------------
-- {OBJECT_TYPE}: {OBJECT_NAME}
-- Description: {DESCRIPTION}
-- Author: {AUTHOR}
-- Created: {DATE}
-- ---------------------------------------------------------------------------
-- Purpose: {PURPOSE}
--   - {PURPOSE_ITEM_1}
--   - {PURPOSE_ITEM_2}
--   - {PURPOSE_ITEM_3}
--
-- Features:
--   - {FEATURE_1}
--   - {FEATURE_2}
--   - {FEATURE_3}
--
-- Usage: {USAGE_EXAMPLE}
--
-- Columns:
--   - {COLUMN_1}: {COLUMN_1_DESC}
--   - {COLUMN_2}: {COLUMN_2_DESC}
--
-- Indexes:
--   - {INDEX_1}: {INDEX_1_DESC}
--
-- Dependencies:
--   - {DEPENDENCY_1}
--   - {DEPENDENCY_2}
--
-- Reference:
--   {REFERENCE_URL}
--
-- Modification History:
--   {VERSION} {DATE} | {AUTHOR} | {CHANGE_DESCRIPTION}
-- ---------------------------------------------------------------------------

-- ------------------------------------------------------------------
-- Drop existing objects (if needed)
-- ------------------------------------------------------------------
-- DROP TABLE IF EXISTS {schema}.{table_name};
-- DROP VIEW IF EXISTS {schema}.{view_name};
-- DROP INDEX IF EXISTS {schema}.{index_name};
-- DROP PROCEDURE IF EXISTS {schema}.{procedure_name};
-- DROP FUNCTION IF EXISTS {schema}.{function_name};

-- ------------------------------------------------------------------
-- Create Table
-- ------------------------------------------------------------------
CREATE OR REPLACE TABLE
    {TABLE_NAME} (
        -- Primary Key
        {PK_COLUMN} {PK_TYPE} NOT NULL,
        
        -- Data Columns
        {COLUMN_NAME} {COLUMN_TYPE},
        
        -- Constraints
        CONSTRAINT PK_{TABLE_NAME} PRIMARY KEY ({PK_COLUMN})
    ) RCDFMT {RECORD_FORMAT};

-- ------------------------------------------------------------------
-- Add table comment
-- ------------------------------------------------------------------
LABEL ON TABLE {schema}.{table_name} IS '{table_description}';

-- ------------------------------------------------------------------
-- Add column comments
-- ------------------------------------------------------------------
LABEL ON COLUMN {schema}.{table_name} (
  {id_field} IS 'Unique identifier',
  {field_name1} IS 'Field 1 description',
  {field_name2} IS 'Field 2 description',
  {status_field} IS 'Status: A=Active, I=Inactive, D=Deleted',
  created_by IS 'User who created the record',
  created_timestamp IS 'Timestamp when record was created',
  modified_by IS 'User who last modified the record',
  modified_timestamp IS 'Timestamp when record was last modified'
);

-- ---------------------------------------------------------------------------
-- Indexes
-- ---------------------------------------------------------------------------

CREATE INDEX IDX_{TABLE_NAME}_{COLUMN_NAME}
    ON {TABLE_NAME} ({COLUMN_NAME});

-- ---------------------------------------------------------------------------
-- Comments
-- ---------------------------------------------------------------------------

COMMENT ON TABLE {TABLE_NAME} IS '{TABLE_DESCRIPTION}';
COMMENT ON COLUMN {TABLE_NAME}.{COLUMN_NAME} IS '{COLUMN_DESCRIPTION}';