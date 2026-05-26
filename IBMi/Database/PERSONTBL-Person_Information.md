# PERSONTBL - Person Information Table

## Overview
**File Type:** SQL Table  
**Object Name:** PERSONTBL  
**Record Format:** PERSONR  
**Author:** Nick Litten  
**Created:** 2026-02-03  
**Version:** 1.0

## Purpose
Person information table designed for testing and demonstrations, particularly for expanding page subfile examples. This table stores basic person information including name, date of birth, and address, with 50 sample records covering comprehensive US address data.

## Description
PERSONTBL is a SQL table that manages person information for testing purposes. It contains 50 pre-populated records with realistic US addresses spanning multiple states and cities. The table is specifically designed for demonstrating subfile operations, paging techniques, and basic person entity management in IBM i applications.

## Table Structure

### Columns
| Column Name | Data Type | Length | Nullable | Constraint | Description |
|-------------|-----------|--------|----------|------------|-------------|
| PNAME | VARCHAR | 50 | NOT NULL | PRIMARY KEY | Person's full name |
| PDOB | DATE | - | NULL | - | Date of birth |
| PADDRESS | VARCHAR | 100 | NULL | - | Full mailing address |

### Constraints
- **Primary Key**: PNAME (person's full name)
- **Record Format**: PERSONR (specified for compatibility)

### Sample Data Coverage
The table includes 50 sample records with:
- Names from A to Z (alphabetically distributed)
- Birth dates ranging from 1975 to 1997
- Addresses from 30+ major US cities
- Complete street addresses with city, state, and ZIP code

## Features
- Primary key on person name for unique identification
- Record format name specified (PERSONR) for DDS compatibility
- 50 pre-populated sample records for immediate testing
- Comprehensive US address coverage across multiple states
- Realistic date of birth data spanning 22 years
- Column and table labels for documentation
- Comment on table for additional metadata

## Usage Examples

### Read Operations

#### Get All Persons
```sql
SELECT * FROM PERSONTBL
ORDER BY PNAME;
```

#### Search by Name Pattern
```sql
SELECT * FROM PERSONTBL 
WHERE PNAME LIKE 'A%'
ORDER BY PNAME;
```

#### Get Persons by Birth Year
```sql
SELECT PNAME, PDOB, PADDRESS
FROM PERSONTBL
WHERE YEAR(PDOB) = 1990
ORDER BY PDOB;
```

#### Get Persons by State
```sql
SELECT PNAME, PDOB, PADDRESS
FROM PERSONTBL
WHERE PADDRESS LIKE '%CA%'  -- California
ORDER BY PNAME;
```

#### Get Persons by Age Range
```sql
SELECT PNAME, PDOB, 
       YEAR(CURRENT_DATE) - YEAR(PDOB) AS AGE
FROM PERSONTBL
WHERE YEAR(CURRENT_DATE) - YEAR(PDOB) BETWEEN 30 AND 40
ORDER BY PDOB;
```

#### Paginated Results (for Subfile)
```sql
-- First page (10 records)
SELECT * FROM PERSONTBL
ORDER BY PNAME
FETCH FIRST 10 ROWS ONLY;

-- Second page (next 10 records)
SELECT * FROM PERSONTBL
ORDER BY PNAME
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
```

### Create Operations

#### Insert New Person
```sql
INSERT INTO PERSONTBL (PNAME, PDOB, PADDRESS)
VALUES (
  'John Doe', 
  '1990-01-01', 
  '123 Main Street, Anytown, CA 90210'
);
```

#### Insert Multiple Persons
```sql
INSERT INTO PERSONTBL VALUES
  ('Jane Smith', '1985-05-15', '456 Oak Avenue, Boston, MA 02101'),
  ('Bob Johnson', '1992-08-22', '789 Pine Road, Seattle, WA 98101'),
  ('Mary Williams', '1988-03-10', '321 Elm Street, Chicago, IL 60601');
```

### Update Operations

#### Update Address
```sql
UPDATE PERSONTBL
SET PADDRESS = '456 New Street, Portland, OR 97201'
WHERE PNAME = 'Alice Anderson';
```

#### Update Date of Birth
```sql
UPDATE PERSONTBL
SET PDOB = '1985-02-15'
WHERE PNAME = 'Benjamin Baker';
```

#### Update Multiple Fields
```sql
UPDATE PERSONTBL
SET PDOB = '1990-06-20',
    PADDRESS = '999 Updated Ave, Miami, FL 33101'
WHERE PNAME = 'Catherine Clark';
```

### Delete Operations

#### Delete Specific Person
```sql
DELETE FROM PERSONTBL
WHERE PNAME = 'John Doe';
```

#### Delete by Pattern
```sql
DELETE FROM PERSONTBL
WHERE PNAME LIKE 'Test%';
```

## Advanced Queries

### Age Statistics
```sql
SELECT 
  MIN(YEAR(CURRENT_DATE) - YEAR(PDOB)) AS YOUNGEST_AGE,
  MAX(YEAR(CURRENT_DATE) - YEAR(PDOB)) AS OLDEST_AGE,
  AVG(YEAR(CURRENT_DATE) - YEAR(PDOB)) AS AVERAGE_AGE,
  COUNT(*) AS TOTAL_PERSONS
FROM PERSONTBL;
```

### Persons by State
```sql
SELECT 
  SUBSTR(PADDRESS, LOCATE(',', PADDRESS, LOCATE(',', PADDRESS) + 1) + 2, 2) AS STATE,
  COUNT(*) AS PERSON_COUNT
FROM PERSONTBL
GROUP BY SUBSTR(PADDRESS, LOCATE(',', PADDRESS, LOCATE(',', PADDRESS) + 1) + 2, 2)
ORDER BY PERSON_COUNT DESC;
```

### Birthday List (Current Month)
```sql
SELECT PNAME, PDOB, PADDRESS
FROM PERSONTBL
WHERE MONTH(PDOB) = MONTH(CURRENT_DATE)
ORDER BY DAY(PDOB);
```

### Persons by Decade
```sql
SELECT 
  CASE 
    WHEN YEAR(PDOB) BETWEEN 1970 AND 1979 THEN '1970s'
    WHEN YEAR(PDOB) BETWEEN 1980 AND 1989 THEN '1980s'
    WHEN YEAR(PDOB) BETWEEN 1990 AND 1999 THEN '1990s'
    ELSE 'Other'
  END AS DECADE,
  COUNT(*) AS PERSON_COUNT
FROM PERSONTBL
GROUP BY 
  CASE 
    WHEN YEAR(PDOB) BETWEEN 1970 AND 1979 THEN '1970s'
    WHEN YEAR(PDOB) BETWEEN 1980 AND 1989 THEN '1980s'
    WHEN YEAR(PDOB) BETWEEN 1990 AND 1999 THEN '1990s'
    ELSE 'Other'
  END
ORDER BY DECADE;
```

## RPGLE Subfile Example

```rpgle
**FREE

dcl-f PERSONTBL usage(*input) keyed;
dcl-f PERSONDSF workstn indds(indicators);

dcl-ds indicators;
  sflDsp ind pos(31);
  sflClr ind pos(32);
  sflEnd ind pos(33);
end-ds;

dcl-s rrn uns(5);
dcl-s pName varchar(50);
dcl-s pDob date;
dcl-s pAddress varchar(100);

// Clear subfile
sflClr = *on;
write SFLCTL;
sflClr = *off;

// Load subfile
rrn = 0;
setll *start PERSONTBL;
read PERSONTBL;

dow not %eof(PERSONTBL);
  rrn += 1;
  pName = PNAME;
  pDob = PDOB;
  pAddress = PADDRESS;
  write SFLREC;
  read PERSONTBL;
enddo;

// Display subfile
if rrn > 0;
  sflDsp = *on;
  sflEnd = *on;
  exfmt SFLCTL;
endif;

*inlr = *on;
```

## SQL Subfile Example

```rpgle
**FREE

dcl-f PERSONDSF workstn indds(indicators);

dcl-ds indicators;
  sflDsp ind pos(31);
  sflClr ind pos(32);
  sflEnd ind pos(33);
end-ds;

dcl-s rrn uns(5);
dcl-s pName varchar(50);
dcl-s pDob date;
dcl-s pAddress varchar(100);

// Clear subfile
sflClr = *on;
write SFLCTL;
sflClr = *off;

// Load subfile using SQL
exec sql DECLARE C1 CURSOR FOR
  SELECT PNAME, PDOB, PADDRESS
  FROM PERSONTBL
  ORDER BY PNAME;

exec sql OPEN C1;

rrn = 0;
dow sqlstate = '00000';
  exec sql FETCH C1 INTO :pName, :pDob, :pAddress;
  if sqlstate = '00000';
    rrn += 1;
    write SFLREC;
  endif;
enddo;

exec sql CLOSE C1;

// Display subfile
if rrn > 0;
  sflDsp = *on;
  sflEnd = *on;
  exfmt SFLCTL;
endif;

*inlr = *on;
```

## CL Integration Example

```cl
PGM

DCL VAR(&NAME) TYPE(*CHAR) LEN(50)
DCL VAR(&DOB) TYPE(*CHAR) LEN(10)
DCL VAR(&ADDR) TYPE(*CHAR) LEN(100)

/* Query person information */
RUNSQL SQL('SELECT PNAME, PDOB, PADDRESS +
            FROM PERSONTBL +
            WHERE PNAME = ''Alice Anderson''') +
       COMMIT(*NONE)

/* Add new person */
RUNSQL SQL('INSERT INTO PERSONTBL +
            VALUES(''New Person'', +
                   ''1995-01-01'', +
                   ''123 Test St, City, ST 12345'')') +
       COMMIT(*NONE)

ENDPGM
```

## Best Practices

### Name Management
- Ensure names are unique (primary key constraint)
- Use consistent name format (First Last)
- Consider adding separate first/last name columns
- Handle special characters in names properly

### Date Handling
- Always use DATE data type for dates
- Validate dates before insertion
- Consider adding age validation constraints
- Use date functions for age calculations

### Address Management
- Consider normalizing address into separate fields
- Validate address format before insertion
- Consider adding city, state, ZIP as separate columns
- Use consistent address formatting

### Performance
- Primary key on PNAME provides automatic indexing
- Consider additional indexes for frequent queries
- Use FETCH FIRST for pagination
- Consider partitioning for very large datasets

## Potential Enhancements

### Normalize Address Structure
```sql
ALTER TABLE PERSONTBL ADD COLUMN STREET VARCHAR(50);
ALTER TABLE PERSONTBL ADD COLUMN CITY VARCHAR(30);
ALTER TABLE PERSONTBL ADD COLUMN STATE CHAR(2);
ALTER TABLE PERSONTBL ADD COLUMN ZIP CHAR(10);
ALTER TABLE PERSONTBL ADD COLUMN COUNTRY VARCHAR(30) DEFAULT 'USA';
```

### Add Additional Person Fields
```sql
ALTER TABLE PERSONTBL ADD COLUMN FIRST_NAME VARCHAR(25);
ALTER TABLE PERSONTBL ADD COLUMN LAST_NAME VARCHAR(25);
ALTER TABLE PERSONTBL ADD COLUMN EMAIL VARCHAR(100);
ALTER TABLE PERSONTBL ADD COLUMN PHONE VARCHAR(20);
ALTER TABLE PERSONTBL ADD COLUMN GENDER CHAR(1);
ALTER TABLE PERSONTBL ADD COLUMN CREATED_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE PERSONTBL ADD COLUMN UPDATED_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
```

### Add Constraints
```sql
-- Ensure reasonable birth dates
ALTER TABLE PERSONTBL 
ADD CONSTRAINT CHK_DOB CHECK (
  PDOB BETWEEN DATE('1900-01-01') AND CURRENT_DATE
);

-- Add email format validation (if email column added)
ALTER TABLE PERSONTBL
ADD CONSTRAINT CHK_EMAIL CHECK (
  EMAIL LIKE '%@%.%'
);
```

### Create Indexes
```sql
CREATE INDEX IDX_PERSONTBL_DOB ON PERSONTBL(PDOB);
CREATE INDEX IDX_PERSONTBL_STATE ON PERSONTBL(
  SUBSTR(PADDRESS, LOCATE(',', PADDRESS, LOCATE(',', PADDRESS) + 1) + 2, 2)
);
```

### Create Views
```sql
-- View with calculated age
CREATE VIEW V_PERSON_AGE AS
SELECT 
  PNAME,
  PDOB,
  YEAR(CURRENT_DATE) - YEAR(PDOB) AS AGE,
  PADDRESS
FROM PERSONTBL;

-- View for current month birthdays
CREATE VIEW V_BIRTHDAY_THIS_MONTH AS
SELECT * FROM PERSONTBL
WHERE MONTH(PDOB) = MONTH(CURRENT_DATE);
```

## Sample Data Summary

### Geographic Distribution
The 50 sample records include addresses from:
- California (CA): 7 records
- Texas (TX): 4 records
- Florida (FL): 2 records
- Massachusetts (MA): 2 records
- And 20+ other states

### Age Distribution
- 1970s births: 5 records
- 1980s births: 18 records
- 1990s births: 27 records

### Name Distribution
- Alphabetically distributed from A to Z
- Mix of common and unique names
- Consistent "First Last" format

## Related Files
- **SAMPLESFL**: Subfile program using PERSONTBL
- Display file definitions for person management
- Report programs for person listings

## References
- IBM i SQL Reference: https://www.ibm.com/docs/en/i/7.5?topic=reference-sql
- Subfile Programming: https://www.ibm.com/docs/en/i/7.5?topic=programming-subfiles

---
*This table is part of the IBM i code samples repository demonstrating person management and subfile operations.*