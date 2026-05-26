-- ---------------------------------------------------------------------------
-- SQL Table: CRUD01TBL
-- Description: Task management table for TODO list operations
-- Author: Nick Litten
-- Created: 2026-05-14
-- ---------------------------------------------------------------------------
-- Purpose: Demonstrate CRUD operations with task management
--   - Create, Read, Update, Delete operations
--   - Task tracking with start/end dates
--   - Task state management (finished/unfinished)
--
-- Features:
--   - Primary key constraint on TASK_ID
--   - Task ownership tracking
--   - Date-based task management
--   - State tracking for task completion
--
-- Usage: Task management and TODO list operations
--   INSERT INTO CRUD01TBL VALUES(1, 'Task1', 'Description', NULL, 20260514, 0, 0, 'USER1');
--   SELECT * FROM CRUD01TBL WHERE STATE = 0;
--   UPDATE CRUD01TBL SET STATE = 1 WHERE TASK_ID = 1;
--
-- Columns:
--   - TASK_ID: Unique task identifier (primary key)
--   - NAME: Short name of the task
--   - DESCR: Detailed description of task
--   - ENDDES: End description/notes when task completed
--   - STARTDATE: Date task was created (YYYYMMDD format)
--   - ENDDATE: Date task was completed (YYYYMMDD format)
--   - STATE: Task status (0=Unfinished, 1=Finished)
--   - OWNER: User who created the task
--
-- Dependencies:
--   None
--
-- Reference:
--   https://www.ibm.com/docs/en/i/7.5?topic=reference-sql
--
-- Modification History:
--   1.0 2026-05-14 | Nick Litten | Initial creation
-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------
-- Drop existing objects if they exist
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS CRUD01TBL;


-- ---------------------------------------------------------------------
-- Create table
-- ---------------------------------------------------------------------
CREATE OR REPLACE TABLE
    CRUD01TBL (
        TASK_ID NUMERIC (10, 0) NOT NULL DEFAULT,
        NAME VARCHAR(10) NOT NULL DEFAULT,
        DESCR VARCHAR(150) NOT NULL DEFAULT,
        ENDDES VARCHAR(150),
        STARTDATE NUMERIC (8, 0) NOT NULL DEFAULT,
        ENDDATE NUMERIC (8, 0) NOT NULL DEFAULT,
        STATE NUMERIC (1, 0) NOT NULL DEFAULT,
        OWNER VARCHAR(10) NOT NULL DEFAULT,
        -- ADD PRIMARY KEY
        CONSTRAINT PK_TASK PRIMARY KEY (TASK_ID)
    );


-- TABLE TAG
LABEL ON TABLE CRUD01TBL IS 'TASKS TODO LIST';


-- ADDING TEXT DESCRIPTION TO FIELDS
LABEL ON CRUD01TBL (
    TASK_ID TEXT IS 'TASK ID',
    NAME TEXT IS 'NAME OF THE TASK',
    DESCR TEXT IS 'DESCRIPTION OF TASK',
    ENDDES TEXT IS 'END DESCRIPTION OF TASK',
    STARTDATE TEXT IS 'DATE OF TASK CREATION',
    ENDDATE TEXT IS 'DATE OF TASK FINALIZATION',
    STATE TEXT IS 'STATE TASK 0-UNFINISHED 1-FINISHED',
    OWNER TEXT IS 'CREATOR OF THE TASK'
);


-- ADDING COLUMN TAG NAME
LABEL ON COLUMN CRUD01TBL (
    TASK_ID IS 'TASK ID',
    NAME IS 'NAME OF TASK',
    DESCR IS 'DESCRIPTION',
    ENDDES IS 'END DESCRIPTION',
    STARTDATE IS 'DATE OF CREATION',
    ENDDATE IS 'DATE OF FINISH',
    STATE IS 'STATE OF TASK',
    OWNER IS 'CREATOR OF TASK'
);