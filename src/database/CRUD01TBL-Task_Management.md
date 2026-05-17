# CRUD01TBL - Task Management Table

## Overview
**File Type:** SQL Table  
**Object Name:** CRUD01TBL  
**Author:** Nick Litten  
**Created:** 2026-05-14  
**Version:** 1.0

## Purpose
Task management table designed to demonstrate CRUD (Create, Read, Update, Delete) operations with a practical TODO list application. This table provides a simple yet complete example of task tracking with state management and ownership.

## Description
CRUD01TBL is a SQL table that manages tasks in a TODO list system. It tracks task information including descriptions, dates, completion status, and ownership. The table demonstrates fundamental database operations and serves as a learning tool for CRUD operations on IBM i.

## Table Structure

### Columns
| Column Name | Data Type | Precision | Scale | Nullable | Default | Description |
|-------------|-----------|-----------|-------|----------|---------|-------------|
| TASK_ID | NUMERIC | 10 | 0 | NOT NULL | Required | Unique task identifier (PK) |
| NAME | VARCHAR | 10 | - | NOT NULL | Required | Short name of the task |
| DESCR | VARCHAR | 150 | - | NOT NULL | Required | Detailed description |
| ENDDES | VARCHAR | 150 | - | NULL | - | End description/notes |
| STARTDATE | NUMERIC | 8 | 0 | NOT NULL | Required | Creation date (YYYYMMDD) |
| ENDDATE | NUMERIC | 8 | 0 | NOT NULL | Required | Completion date (YYYYMMDD) |
| STATE | NUMERIC | 1 | 0 | NOT NULL | Required | Task status (0/1) |
| OWNER | VARCHAR | 10 | - | NOT NULL | Required | Task creator |

### Constraints
- **Primary Key**: PK_TASK on TASK_ID
- **NOT NULL**: All columns except ENDDES require values

### State Values
| Value | Description |
|-------|-------------|
| 0 | Unfinished - Task is pending or in progress |
| 1 | Finished - Task has been completed |

### Date Format
Dates are stored as NUMERIC(8,0) in YYYYMMDD format:
- Example: 20260514 = May 14, 2026
- STARTDATE: When task was created
- ENDDATE: When task was completed (0 if not finished)

## Features
- Primary key constraint ensures unique task IDs
- Task ownership tracking for multi-user environments
- Date-based task management with start and end dates
- State tracking for task completion status
- End description field for completion notes
- Comprehensive column and table labels

## Usage Examples

### Create Operations

#### Insert New Task
```sql
INSERT INTO CRUD01TBL (
  TASK_ID, NAME, DESCR, ENDDES, 
  STARTDATE, ENDDATE, STATE, OWNER
) VALUES (
  1, 'Task1', 'Complete project documentation', NULL,
  20260514, 0, 0, 'USER1'
);
```

#### Insert Multiple Tasks
```sql
INSERT INTO CRUD01TBL VALUES
  (2, 'Task2', 'Review code changes', NULL, 20260514, 0, 0, 'USER1'),
  (3, 'Task3', 'Update test cases', NULL, 20260515, 0, 0, 'USER2'),
  (4, 'Task4', 'Deploy to production', NULL, 20260516, 0, 0, 'USER1');
```

### Read Operations

#### Get All Unfinished Tasks
```sql
SELECT * FROM CRUD01TBL 
WHERE STATE = 0
ORDER BY STARTDATE;
```

#### Get Tasks by Owner
```sql
SELECT TASK_ID, NAME, DESCR, STARTDATE
FROM CRUD01TBL
WHERE OWNER = 'USER1'
  AND STATE = 0;
```

#### Get Completed Tasks
```sql
SELECT TASK_ID, NAME, ENDDES, ENDDATE
FROM CRUD01TBL
WHERE STATE = 1
ORDER BY ENDDATE DESC;
```

#### Get Tasks by Date Range
```sql
SELECT * FROM CRUD01TBL
WHERE STARTDATE BETWEEN 20260501 AND 20260531
ORDER BY STARTDATE;
```

### Update Operations

#### Mark Task as Complete
```sql
UPDATE CRUD01TBL 
SET STATE = 1,
    ENDDATE = 20260517,
    ENDDES = 'Task completed successfully'
WHERE TASK_ID = 1;
```

#### Update Task Description
```sql
UPDATE CRUD01TBL
SET DESCR = 'Updated task description'
WHERE TASK_ID = 2;
```

#### Reassign Task Owner
```sql
UPDATE CRUD01TBL
SET OWNER = 'USER3'
WHERE TASK_ID = 3;
```

### Delete Operations

#### Delete Specific Task
```sql
DELETE FROM CRUD01TBL
WHERE TASK_ID = 4;
```

#### Delete Completed Tasks Older Than Date
```sql
DELETE FROM CRUD01TBL
WHERE STATE = 1
  AND ENDDATE < 20260101;
```

#### Delete All Tasks for User
```sql
DELETE FROM CRUD01TBL
WHERE OWNER = 'USER1';
```

## Advanced Queries

### Task Statistics by Owner
```sql
SELECT 
  OWNER,
  COUNT(*) AS TOTAL_TASKS,
  SUM(CASE WHEN STATE = 0 THEN 1 ELSE 0 END) AS PENDING,
  SUM(CASE WHEN STATE = 1 THEN 1 ELSE 0 END) AS COMPLETED
FROM CRUD01TBL
GROUP BY OWNER
ORDER BY OWNER;
```

### Average Task Duration
```sql
SELECT 
  OWNER,
  AVG(ENDDATE - STARTDATE) AS AVG_DAYS_TO_COMPLETE
FROM CRUD01TBL
WHERE STATE = 1
  AND ENDDATE > 0
GROUP BY OWNER;
```

### Overdue Tasks (Example: Tasks older than 30 days)
```sql
SELECT TASK_ID, NAME, OWNER, STARTDATE
FROM CRUD01TBL
WHERE STATE = 0
  AND STARTDATE < 20260417  -- 30 days ago from 2026-05-17
ORDER BY STARTDATE;
```

### Task Summary Report
```sql
SELECT 
  CASE STATE 
    WHEN 0 THEN 'Unfinished'
    WHEN 1 THEN 'Finished'
  END AS STATUS,
  COUNT(*) AS TASK_COUNT,
  MIN(STARTDATE) AS EARLIEST_TASK,
  MAX(STARTDATE) AS LATEST_TASK
FROM CRUD01TBL
GROUP BY STATE;
```

## RPGLE Integration Example

```rpgle
**FREE

dcl-s taskId packed(10:0);
dcl-s taskName varchar(10);
dcl-s taskDesc varchar(150);
dcl-s startDate packed(8:0);
dcl-s taskState packed(1:0);
dcl-s taskOwner varchar(10);

// Create new task
exec sql INSERT INTO CRUD01TBL (
  TASK_ID, NAME, DESCR, STARTDATE, ENDDATE, STATE, OWNER
) VALUES (
  :taskId, :taskName, :taskDesc, :startDate, 0, 0, :taskOwner
);

if sqlstate = '00000';
  // Success
else;
  // Handle error
endif;

// Read unfinished tasks
exec sql DECLARE C1 CURSOR FOR
  SELECT TASK_ID, NAME, DESCR, STATE
  FROM CRUD01TBL
  WHERE OWNER = :taskOwner AND STATE = 0;

exec sql OPEN C1;

dow sqlstate = '00000';
  exec sql FETCH C1 INTO :taskId, :taskName, :taskDesc, :taskState;
  if sqlstate = '00000';
    // Process task
  endif;
enddo;

exec sql CLOSE C1;
```

## CL Integration Example

```cl
PGM

DCL VAR(&TASKID) TYPE(*DEC) LEN(10 0)
DCL VAR(&STATE) TYPE(*DEC) LEN(1 0)
DCL VAR(&ENDDATE) TYPE(*DEC) LEN(8 0)

/* Mark task as complete */
RUNSQL SQL('UPDATE CRUD01TBL +
            SET STATE = 1, +
                ENDDATE = 20260517 +
            WHERE TASK_ID = 1') +
       COMMIT(*NONE)

ENDPGM
```

## Best Practices

### Task ID Management
- Use sequential numbering or generate from sequence
- Consider using identity column for auto-increment
- Never reuse deleted task IDs

### Date Handling
- Always validate date format (YYYYMMDD)
- Use 0 for ENDDATE on unfinished tasks
- Consider migrating to DATE data type for better date arithmetic

### State Management
- Only use 0 (unfinished) or 1 (finished)
- Consider adding more states (pending, in-progress, blocked, etc.)
- Use check constraint to enforce valid states

### Performance
- Create index on STATE for filtering
- Create index on OWNER for user-specific queries
- Create index on STARTDATE for date-range queries

## Potential Enhancements

### Additional Columns
```sql
ALTER TABLE CRUD01TBL ADD COLUMN PRIORITY NUMERIC(1,0) DEFAULT 3;
ALTER TABLE CRUD01TBL ADD COLUMN DUE_DATE NUMERIC(8,0) DEFAULT 0;
ALTER TABLE CRUD01TBL ADD COLUMN CATEGORY VARCHAR(20) DEFAULT '';
ALTER TABLE CRUD01TBL ADD COLUMN CREATED_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE CRUD01TBL ADD COLUMN UPDATED_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
```

### Improved Date Handling
```sql
-- Migrate to proper DATE columns
ALTER TABLE CRUD01TBL ADD COLUMN START_DATE DATE;
ALTER TABLE CRUD01TBL ADD COLUMN END_DATE DATE;

-- Convert existing data
UPDATE CRUD01TBL 
SET START_DATE = TO_DATE(CHAR(STARTDATE), 'YYYYMMDD');
```

### Add Check Constraints
```sql
ALTER TABLE CRUD01TBL 
ADD CONSTRAINT CHK_STATE CHECK (STATE IN (0, 1));

ALTER TABLE CRUD01TBL
ADD CONSTRAINT CHK_DATES CHECK (ENDDATE >= STARTDATE OR ENDDATE = 0);
```

## Related Files
- Example CRUD programs using this table
- Task management UI programs
- Reporting programs for task statistics

## References
- IBM i SQL Reference: https://www.ibm.com/docs/en/i/7.5?topic=reference-sql
- CRUD Operations Guide: https://www.ibm.com/docs/en/i/7.5?topic=statements-sql

---
*This table is part of the IBM i code samples repository demonstrating CRUD operations and task management.*