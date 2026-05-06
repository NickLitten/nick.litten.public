-------------------------------------------------------------------------------
-- Script: {SCRIPT_NAME}.SQL - {BRIEF_DESCRIPTION}
-- Description: {DETAILED_DESCRIPTION}
--
-- Purpose:
--   - {PURPOSE_1}
--   - {PURPOSE_2}
--   - {PURPOSE_3}
--
-- Features:
--   - {FEATURE_1}
--   - {FEATURE_2}
--   - {FEATURE_3}
--
-- Usage:
--   RUNSQLSTM SRCFILE(LIB/QSQLSRC) SRCMBR({SCRIPT_NAME})
--   Or run from ACS Run SQL Scripts
--
-- Dependencies:
--   - {DEPENDENCY_1}
--   - {DEPENDENCY_2}
--
-- Author: Nick Litten
--
-- Modification History:
-- v.001 {CURRENT_DATE} - Nick Litten - Initial creation
-------------------------------------------------------------------------------

-- Set SQL options
SET OPTION COMMIT = *NONE, CLOSQLCSR = *ENDMOD;

-------------------------------------------------------------------------------
-- Table: {TABLE_NAME} - {TABLE_DESCRIPTION}
-------------------------------------------------------------------------------

-- Drop table if exists (for development)
DROP TABLE IF EXISTS {LIBRARY}.{TABLE_NAME};

-- Create table
CREATE TABLE {LIBRARY}.{TABLE_NAME} (
    -- Primary Key
    {PK_FIELD}          {TYPE}          NOT NULL,
    
    -- Data Fields
    {FIELD_1}           {TYPE}          NOT NULL,
    {FIELD_2}           {TYPE},
    
    -- Audit Fields
    CREATED_DATE        DATE            NOT NULL DEFAULT CURRENT_DATE,
    CREATED_TIME        TIME            NOT NULL DEFAULT CURRENT_TIME,
    CREATED_USER        CHAR(10)        NOT NULL DEFAULT USER,
    CHANGED_DATE        DATE            NOT NULL DEFAULT CURRENT_DATE,
    CHANGED_TIME        TIME            NOT NULL DEFAULT CURRENT_TIME,
    CHANGED_USER        CHAR(10)        NOT NULL DEFAULT USER,
    
    -- Constraints
    CONSTRAINT PK_{TABLE_NAME} PRIMARY KEY ({PK_FIELD})
);

-- Add labels
LABEL ON TABLE {LIBRARY}.{TABLE_NAME} IS '{TABLE_LABEL}';

LABEL ON COLUMN {LIBRARY}.{TABLE_NAME} (
    {PK_FIELD}      IS '{PK_LABEL}',
    {FIELD_1}       IS '{FIELD_1_LABEL}',
    CREATED_DATE    IS 'Created Date',
    CREATED_USER    IS 'Created By'
);

-- Create indexes
CREATE INDEX {LIBRARY}.{INDEX_NAME} 
    ON {LIBRARY}.{TABLE_NAME} ({INDEX_FIELD});

-- Grant permissions
GRANT SELECT, INSERT, UPDATE, DELETE 
    ON {LIBRARY}.{TABLE_NAME} 
    TO PUBLIC;

COMMIT;

-- Made with Bob
