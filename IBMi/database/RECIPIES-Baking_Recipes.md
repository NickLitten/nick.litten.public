# RECIPIES - Baking Recipes Table

## Overview
**File Type:** SQL Table  
**Object Name:** RECIPIES  
**Author:** Nick Litten  
**Created:** 2026-05-14  
**Version:** 1.0

## Purpose
Baking recipes table designed to demonstrate CRUD operations and recipe management. This table stores baking recipes with preparation details, difficulty levels, and serving information, complete with 26 sample recipes for immediate testing.

## Description
RECIPIES is a SQL table that manages baking recipes for a kitchen or bakery operation. It includes an auto-increment identity column, tracks recipe details including preparation time and difficulty, and comes pre-populated with 26 diverse baking recipes spanning cookies, breads, cakes, pies, and desserts.

## Table Structure

### Columns
| Column Name | Data Type | Nullable | Default | Constraint | Description |
|-------------|-----------|----------|---------|------------|-------------|
| RECID | INTEGER | NOT NULL | IDENTITY | PRIMARY KEY | Auto-increment recipe ID |
| RECNAME | VARCHAR(50) | NOT NULL | Required | - | Name of the recipe |
| CATEGORY | VARCHAR(20) | NOT NULL | Required | - | Recipe category |
| PREPTIME | INTEGER | NOT NULL | 0 | - | Preparation time (minutes) |
| SERVINGS | INTEGER | NOT NULL | 0 | - | Number of servings |
| DIFFICULTY | VARCHAR(10) | NOT NULL | Required | - | Difficulty level |

### Constraints
- **Primary Key**: REC_PK on RECID
- **Identity Column**: RECID auto-increments starting from 1
- **NOT NULL**: All columns require values (with defaults for numeric fields)

### Category Values
| Category | Description | Sample Count |
|----------|-------------|--------------|
| Cookies | Cookie recipes | 6 recipes |
| Bread/Breads | Bread recipes | 5 recipes |
| Cakes | Cake recipes | 5 recipes |
| Pies | Pie recipes | 3 recipes |
| Desserts | Dessert recipes | 7 recipes |

### Difficulty Levels
| Level | Description | Sample Count |
|-------|-------------|--------------|
| Easy | Simple recipes for beginners | 9 recipes |
| Medium | Intermediate skill level | 10 recipes |
| Hard | Advanced techniques required | 7 recipes |

## Features
- Auto-increment identity column for automatic ID generation
- Primary key constraint ensures unique recipe IDs
- Default values for numeric fields (0 for time and servings)
- Category-based organization for easy filtering
- Difficulty level tracking for skill-appropriate selection
- 26 pre-populated sample recipes for immediate testing
- Comprehensive column labels for documentation

## Sample Data Summary

### Preparation Time Range
- Minimum: 20 minutes (Peanut Butter Cookies, Coconut Macaroons)
- Maximum: 240 minutes (Sourdough Bread)
- Average: ~65 minutes

### Serving Size Range
- Minimum: 1 serving (Sourdough Bread)
- Maximum: 36 servings (Sugar Cookies)
- Average: ~14 servings

## Usage Examples

### Create Operations

#### Insert New Recipe
```sql
INSERT INTO RECIPIES (RECNAME, CATEGORY, PREPTIME, SERVINGS, DIFFICULTY)
VALUES ('New Recipe', 'Cakes', 45, 8, 'Medium');
```

#### Insert Multiple Recipes
```sql
INSERT INTO RECIPIES (RECNAME, CATEGORY, PREPTIME, SERVINGS, DIFFICULTY)
VALUES 
  ('Oatmeal Cookies', 'Cookies', 25, 24, 'Easy'),
  ('French Bread', 'Breads', 120, 2, 'Medium'),
  ('Red Velvet Cake', 'Cakes', 60, 12, 'Medium');
```

### Read Operations

#### Get All Recipes
```sql
SELECT * FROM RECIPIES
ORDER BY RECNAME;
```

#### Get Recipes by Category
```sql
SELECT RECID, RECNAME, PREPTIME, SERVINGS, DIFFICULTY
FROM RECIPIES
WHERE CATEGORY = 'Cookies'
ORDER BY RECNAME;
```

#### Get Easy Recipes
```sql
SELECT RECNAME, CATEGORY, PREPTIME, SERVINGS
FROM RECIPIES
WHERE DIFFICULTY = 'Easy'
ORDER BY PREPTIME;
```

#### Get Quick Recipes (Under 30 Minutes)
```sql
SELECT RECNAME, CATEGORY, PREPTIME, DIFFICULTY
FROM RECIPIES
WHERE PREPTIME <= 30
ORDER BY PREPTIME;
```

#### Get Recipes by Serving Size
```sql
SELECT RECNAME, CATEGORY, SERVINGS, DIFFICULTY
FROM RECIPIES
WHERE SERVINGS >= 12
ORDER BY SERVINGS DESC;
```

#### Search by Name
```sql
SELECT * FROM RECIPIES
WHERE RECNAME LIKE '%Chocolate%'
ORDER BY RECNAME;
```

### Update Operations

#### Update Preparation Time
```sql
UPDATE RECIPIES
SET PREPTIME = 60
WHERE RECID = 1;
```

#### Update Difficulty Level
```sql
UPDATE RECIPIES
SET DIFFICULTY = 'Hard'
WHERE RECNAME = 'Sourdough Bread';
```

#### Update Multiple Fields
```sql
UPDATE RECIPIES
SET PREPTIME = 50,
    SERVINGS = 10,
    DIFFICULTY = 'Medium'
WHERE RECID = 5;
```

#### Recategorize Recipes
```sql
UPDATE RECIPIES
SET CATEGORY = 'Breads'
WHERE CATEGORY = 'Bread';
```

### Delete Operations

#### Delete Specific Recipe
```sql
DELETE FROM RECIPIES
WHERE RECID = 100;
```

#### Delete by Category
```sql
DELETE FROM RECIPIES
WHERE CATEGORY = 'Test';
```

#### Delete Hard Recipes
```sql
DELETE FROM RECIPIES
WHERE DIFFICULTY = 'Hard';
```

## Advanced Queries

### Recipe Statistics by Category
```sql
SELECT 
  CATEGORY,
  COUNT(*) AS RECIPE_COUNT,
  AVG(PREPTIME) AS AVG_PREP_TIME,
  AVG(SERVINGS) AS AVG_SERVINGS,
  MIN(PREPTIME) AS MIN_PREP_TIME,
  MAX(PREPTIME) AS MAX_PREP_TIME
FROM RECIPIES
GROUP BY CATEGORY
ORDER BY CATEGORY;
```

### Recipe Statistics by Difficulty
```sql
SELECT 
  DIFFICULTY,
  COUNT(*) AS RECIPE_COUNT,
  AVG(PREPTIME) AS AVG_PREP_TIME,
  MIN(PREPTIME) AS MIN_TIME,
  MAX(PREPTIME) AS MAX_TIME
FROM RECIPIES
GROUP BY DIFFICULTY
ORDER BY 
  CASE DIFFICULTY
    WHEN 'Easy' THEN 1
    WHEN 'Medium' THEN 2
    WHEN 'Hard' THEN 3
  END;
```

### Quick and Easy Recipes
```sql
SELECT RECNAME, CATEGORY, PREPTIME, SERVINGS
FROM RECIPIES
WHERE DIFFICULTY = 'Easy'
  AND PREPTIME <= 30
ORDER BY PREPTIME, RECNAME;
```

### Recipe Complexity Score
```sql
SELECT 
  RECNAME,
  CATEGORY,
  PREPTIME,
  DIFFICULTY,
  CASE DIFFICULTY
    WHEN 'Easy' THEN PREPTIME * 1
    WHEN 'Medium' THEN PREPTIME * 1.5
    WHEN 'Hard' THEN PREPTIME * 2
  END AS COMPLEXITY_SCORE
FROM RECIPIES
ORDER BY COMPLEXITY_SCORE DESC;
```

### Recipes for Large Groups (12+ Servings)
```sql
SELECT 
  RECNAME,
  CATEGORY,
  SERVINGS,
  PREPTIME,
  DIFFICULTY
FROM RECIPIES
WHERE SERVINGS >= 12
ORDER BY SERVINGS DESC, PREPTIME;
```

### Category Distribution
```sql
SELECT 
  CATEGORY,
  COUNT(*) AS COUNT,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS PERCENTAGE
FROM RECIPIES
GROUP BY CATEGORY
ORDER BY COUNT DESC;
```

## RPGLE Integration Example

```rpgle
**FREE

dcl-s recId int(10);
dcl-s recName varchar(50);
dcl-s category varchar(20);
dcl-s prepTime int(10);
dcl-s servings int(10);
dcl-s difficulty varchar(10);

// Add new recipe (RECID auto-generated)
exec sql INSERT INTO RECIPIES (
  RECNAME, CATEGORY, PREPTIME, SERVINGS, DIFFICULTY
) VALUES (
  :recName, :category, :prepTime, :servings, :difficulty
);

if sqlstate = '00000';
  // Get the generated RECID
  exec sql VALUES(IDENTITY_VAL_LOCAL()) INTO :recId;
  // Success - recId now contains the new recipe ID
else;
  // Handle error
endif;

// Query recipes by category
exec sql DECLARE C1 CURSOR FOR
  SELECT RECID, RECNAME, PREPTIME, SERVINGS, DIFFICULTY
  FROM RECIPIES
  WHERE CATEGORY = :category
  ORDER BY RECNAME;

exec sql OPEN C1;

dow sqlstate = '00000';
  exec sql FETCH C1 INTO :recId, :recName, :prepTime, :servings, :difficulty;
  if sqlstate = '00000';
    // Process recipe
  endif;
enddo;

exec sql CLOSE C1;
```

## CL Integration Example

```cl
PGM

DCL VAR(&RECID) TYPE(*DEC) LEN(10 0)
DCL VAR(&PREPTIME) TYPE(*DEC) LEN(10 0)

/* Add new recipe */
RUNSQL SQL('INSERT INTO RECIPIES +
            (RECNAME, CATEGORY, PREPTIME, SERVINGS, DIFFICULTY) +
            VALUES(''New Cake'', ''Cakes'', 50, 10, ''Medium'')') +
       COMMIT(*NONE)

/* Update recipe */
RUNSQL SQL('UPDATE RECIPIES +
            SET PREPTIME = 60 +
            WHERE RECID = 1') +
       COMMIT(*NONE)

/* Query easy recipes */
RUNSQL SQL('SELECT RECNAME, PREPTIME +
            FROM RECIPIES +
            WHERE DIFFICULTY = ''Easy''') +
       COMMIT(*NONE)

ENDPGM
```

## Best Practices

### Recipe ID Management
- Never manually insert RECID values (use identity column)
- Use IDENTITY_VAL_LOCAL() to get generated ID after insert
- Never reuse deleted recipe IDs
- Consider sequence objects for more control

### Category Management
- Standardize category names (consistent capitalization)
- Consider creating a category reference table
- Use check constraint to enforce valid categories
- Document category definitions

### Time Management
- Store time in minutes for consistency
- Consider adding cook time separate from prep time
- Validate time values (must be positive)
- Consider total time calculation (prep + cook)

### Difficulty Assessment
- Use consistent difficulty levels (Easy, Medium, Hard)
- Consider numeric scale (1-5) for more granularity
- Document criteria for each difficulty level
- Consider user skill level in recommendations

### Performance
- Primary key on RECID provides automatic indexing
- Create index on CATEGORY for filtering
- Create index on DIFFICULTY for filtering
- Consider composite index on (CATEGORY, DIFFICULTY)

## Potential Enhancements

### Additional Columns
```sql
ALTER TABLE RECIPIES ADD COLUMN COOKTIME INTEGER DEFAULT 0;
ALTER TABLE RECIPIES ADD COLUMN TOTALTIME INTEGER GENERATED ALWAYS AS (PREPTIME + COOKTIME);
ALTER TABLE RECIPIES ADD COLUMN INSTRUCTIONS CLOB(64K);
ALTER TABLE RECIPIES ADD COLUMN RATING DECIMAL(3,2);
ALTER TABLE RECIPIES ADD COLUMN AUTHOR VARCHAR(50);
ALTER TABLE RECIPIES ADD COLUMN CREATED_DATE DATE DEFAULT CURRENT_DATE;
ALTER TABLE RECIPIES ADD COLUMN UPDATED_DATE DATE DEFAULT CURRENT_DATE;
ALTER TABLE RECIPIES ADD COLUMN IMAGE_URL VARCHAR(200);
ALTER TABLE RECIPIES ADD COLUMN NOTES VARCHAR(500);
```

### Add Check Constraints
```sql
ALTER TABLE RECIPIES 
ADD CONSTRAINT CHK_PREPTIME CHECK (PREPTIME >= 0);

ALTER TABLE RECIPIES
ADD CONSTRAINT CHK_SERVINGS CHECK (SERVINGS > 0);

ALTER TABLE RECIPIES
ADD CONSTRAINT CHK_DIFFICULTY CHECK (
  DIFFICULTY IN ('Easy', 'Medium', 'Hard')
);

ALTER TABLE RECIPIES
ADD CONSTRAINT CHK_CATEGORY CHECK (
  CATEGORY IN ('Cookies', 'Breads', 'Cakes', 'Pies', 'Desserts')
);
```

### Create Indexes
```sql
CREATE INDEX IDX_RECIPIES_CATEGORY ON RECIPIES(CATEGORY);
CREATE INDEX IDX_RECIPIES_DIFFICULTY ON RECIPIES(DIFFICULTY);
CREATE INDEX IDX_RECIPIES_PREPTIME ON RECIPIES(PREPTIME);
CREATE INDEX IDX_RECIPIES_NAME ON RECIPIES(RECNAME);
```

### Create Views
```sql
-- View for quick recipes
CREATE VIEW V_QUICK_RECIPES AS
SELECT * FROM RECIPIES
WHERE PREPTIME <= 30;

-- View for easy recipes
CREATE VIEW V_EASY_RECIPES AS
SELECT * FROM RECIPIES
WHERE DIFFICULTY = 'Easy';

-- View with calculated total time (if cooktime added)
CREATE VIEW V_RECIPE_TIMES AS
SELECT 
  RECID,
  RECNAME,
  CATEGORY,
  PREPTIME,
  COOKTIME,
  PREPTIME + COOKTIME AS TOTALTIME,
  SERVINGS,
  DIFFICULTY
FROM RECIPIES;
```

## Related Tables

### Recipe Ingredients Link
```sql
-- Link recipes to ingredients from FOODFILE
CREATE TABLE RECIPE_INGREDIENTS (
  RECID INTEGER NOT NULL,
  INGID DECIMAL(10,0) NOT NULL,
  QUANTITY DECIMAL(7,2) NOT NULL,
  MEASURE VARCHAR(10),
  NOTES VARCHAR(100),
  PRIMARY KEY (RECID, INGID),
  FOREIGN KEY (RECID) REFERENCES RECIPIES(RECID) ON DELETE CASCADE,
  FOREIGN KEY (INGID) REFERENCES FOODFILE(INGID)
);
```

### Recipe Categories Reference
```sql
CREATE TABLE RECIPE_CATEGORIES (
  CATEGORY_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
  CATEGORY_NAME VARCHAR(20) NOT NULL UNIQUE,
  DESCRIPTION VARCHAR(100),
  PRIMARY KEY (CATEGORY_ID)
);
```

### Recipe Ratings
```sql
CREATE TABLE RECIPE_RATINGS (
  RATING_ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
  RECID INTEGER NOT NULL,
  USER_NAME VARCHAR(50) NOT NULL,
  RATING DECIMAL(3,2) CHECK (RATING BETWEEN 0 AND 5),
  REVIEW VARCHAR(500),
  RATING_DATE DATE DEFAULT CURRENT_DATE,
  PRIMARY KEY (RATING_ID),
  FOREIGN KEY (RECID) REFERENCES RECIPIES(RECID) ON DELETE CASCADE
);
```

## Integration with FOODFILE

### Check Ingredient Availability
```sql
SELECT 
  r.RECNAME,
  ri.QUANTITY,
  ri.MEASURE,
  f.INGNAME,
  f.QUANTITY AS AVAILABLE_QTY,
  CASE 
    WHEN f.QUANTITY >= ri.QUANTITY THEN 'Available'
    ELSE 'Insufficient'
  END AS STATUS
FROM RECIPIES r
JOIN RECIPE_INGREDIENTS ri ON r.RECID = ri.RECID
JOIN FOODFILE f ON ri.INGID = f.INGID
WHERE r.RECID = 1;
```

## References
- IBM i SQL Reference: https://www.ibm.com/docs/en/i/7.5?topic=reference-sql
- Identity Columns: https://www.ibm.com/docs/en/i/7.5?topic=definition-identity-column

---
*This table is part of the IBM i code samples repository demonstrating recipe management and CRUD operations.*