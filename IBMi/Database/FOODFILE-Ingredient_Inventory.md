# FOODFILE - Ingredient Inventory Table

## Overview
**File Type:** SQL Table  
**Object Name:** FOODFILE  
**Author:** Nick Litten  
**Created:** 2026-05-14  
**Version:** 1.0

## Purpose
Food ingredient inventory management table designed to track ingredient quantities, expiration dates, and organic certification status. This table provides a practical example of inventory management with category-based organization and data validation.

## Description
FOODFILE is a SQL table that manages food ingredient inventory for a kitchen, bakery, or food service operation. It tracks ingredient details including quantities, units of measure, expiration dates, and organic certification. The table demonstrates practical database design with check constraints and proper data typing.

## Table Structure

### Columns
| Column Name | Data Type | Precision | Scale | Nullable | Constraint | Description |
|-------------|-----------|-----------|-------|----------|------------|-------------|
| INGID | DECIMAL | 10 | 0 | NOT NULL | PRIMARY KEY | Unique ingredient identifier |
| INGNAME | VARCHAR | 30 | - | NOT NULL | - | Name of the ingredient |
| CATEGORY | VARCHAR | 20 | - | NULL | - | Food category classification |
| MEASURE | VARCHAR | 10 | - | NULL | - | Unit of measurement |
| QUANTITY | DECIMAL | 7 | 2 | NULL | - | Available quantity in stock |
| EXPDATE | DATE | - | - | NULL | - | Expiration date |
| ORGANIC | CHAR | 1 | - | NULL | CHECK | Organic certification (Y/N) |

### Constraints
- **Primary Key**: INGID (unique ingredient identifier)
- **Check Constraint**: ORGANIC IN ('Y', 'N')

### Category Examples
- Baking (flour, sugar, baking powder)
- Dairy (milk, butter, cheese)
- Produce (fruits, vegetables)
- Spices (cinnamon, vanilla, salt)
- Proteins (eggs, meat, fish)
- Oils (olive oil, vegetable oil)

### Measure Examples
- kg (kilograms)
- lbs (pounds)
- oz (ounces)
- g (grams)
- L (liters)
- ml (milliliters)
- units (individual items)

## Features
- Primary key constraint ensures unique ingredient IDs
- Check constraint validates organic flag values
- Expiration date tracking for inventory management
- Flexible unit of measure system
- Category-based organization
- Comprehensive column labels for documentation

## Usage Examples

### Create Operations

#### Insert New Ingredient
```sql
INSERT INTO FOODFILE (
  INGID, INGNAME, CATEGORY, MEASURE, 
  QUANTITY, EXPDATE, ORGANIC
) VALUES (
  1, 'Flour', 'Baking', 'kg', 
  25.50, '2026-12-31', 'Y'
);
```

#### Insert Multiple Ingredients
```sql
INSERT INTO FOODFILE VALUES
  (2, 'Sugar', 'Baking', 'kg', 10.00, '2027-06-30', 'N'),
  (3, 'Butter', 'Dairy', 'kg', 5.00, '2026-06-15', 'Y'),
  (4, 'Eggs', 'Dairy', 'units', 144.00, '2026-05-25', 'Y'),
  (5, 'Vanilla Extract', 'Spices', 'ml', 500.00, '2028-01-01', 'N');
```

### Read Operations

#### Get All Ingredients
```sql
SELECT * FROM FOODFILE
ORDER BY INGNAME;
```

#### Get Ingredients by Category
```sql
SELECT INGID, INGNAME, QUANTITY, MEASURE
FROM FOODFILE
WHERE CATEGORY = 'Baking'
ORDER BY INGNAME;
```

#### Get Organic Ingredients
```sql
SELECT INGNAME, CATEGORY, QUANTITY, MEASURE
FROM FOODFILE
WHERE ORGANIC = 'Y'
ORDER BY CATEGORY, INGNAME;
```

#### Check Expiring Soon (Next 30 Days)
```sql
SELECT INGID, INGNAME, EXPDATE, QUANTITY
FROM FOODFILE
WHERE EXPDATE BETWEEN CURRENT_DATE AND CURRENT_DATE + 30 DAYS
ORDER BY EXPDATE;
```

#### Get Expired Ingredients
```sql
SELECT INGID, INGNAME, EXPDATE, QUANTITY
FROM FOODFILE
WHERE EXPDATE < CURRENT_DATE
ORDER BY EXPDATE;
```

#### Get Low Stock Items (Example: Less than 5 units)
```sql
SELECT INGNAME, QUANTITY, MEASURE, CATEGORY
FROM FOODFILE
WHERE QUANTITY < 5
ORDER BY QUANTITY;
```

### Update Operations

#### Update Quantity After Use
```sql
UPDATE FOODFILE 
SET QUANTITY = QUANTITY - 1.5
WHERE INGID = 1;
```

#### Restock Ingredient
```sql
UPDATE FOODFILE
SET QUANTITY = QUANTITY + 10.0,
    EXPDATE = '2027-01-31'
WHERE INGID = 2;
```

#### Update Category
```sql
UPDATE FOODFILE
SET CATEGORY = 'Baking Supplies'
WHERE CATEGORY = 'Baking';
```

#### Mark as Organic
```sql
UPDATE FOODFILE
SET ORGANIC = 'Y'
WHERE INGID = 5;
```

### Delete Operations

#### Delete Expired Ingredient
```sql
DELETE FROM FOODFILE
WHERE INGID = 10;
```

#### Delete All Expired Items
```sql
DELETE FROM FOODFILE
WHERE EXPDATE < CURRENT_DATE;
```

#### Delete Empty Stock Items
```sql
DELETE FROM FOODFILE
WHERE QUANTITY <= 0;
```

## Advanced Queries

### Inventory Value by Category
```sql
SELECT 
  CATEGORY,
  COUNT(*) AS INGREDIENT_COUNT,
  SUM(QUANTITY) AS TOTAL_QUANTITY,
  COUNT(CASE WHEN ORGANIC = 'Y' THEN 1 END) AS ORGANIC_COUNT
FROM FOODFILE
GROUP BY CATEGORY
ORDER BY CATEGORY;
```

### Expiration Report
```sql
SELECT 
  CASE 
    WHEN EXPDATE < CURRENT_DATE THEN 'Expired'
    WHEN EXPDATE <= CURRENT_DATE + 7 DAYS THEN 'Expires This Week'
    WHEN EXPDATE <= CURRENT_DATE + 30 DAYS THEN 'Expires This Month'
    ELSE 'Good'
  END AS STATUS,
  COUNT(*) AS ITEM_COUNT,
  SUM(QUANTITY) AS TOTAL_QUANTITY
FROM FOODFILE
GROUP BY 
  CASE 
    WHEN EXPDATE < CURRENT_DATE THEN 'Expired'
    WHEN EXPDATE <= CURRENT_DATE + 7 DAYS THEN 'Expires This Week'
    WHEN EXPDATE <= CURRENT_DATE + 30 DAYS THEN 'Expires This Month'
    ELSE 'Good'
  END
ORDER BY 
  CASE STATUS
    WHEN 'Expired' THEN 1
    WHEN 'Expires This Week' THEN 2
    WHEN 'Expires This Month' THEN 3
    ELSE 4
  END;
```

### Shopping List (Low Stock Items)
```sql
SELECT 
  INGNAME AS "Ingredient",
  QUANTITY AS "Current Stock",
  MEASURE AS "Unit",
  CATEGORY
FROM FOODFILE
WHERE QUANTITY < 5
ORDER BY CATEGORY, INGNAME;
```

### Organic vs Non-Organic Summary
```sql
SELECT 
  ORGANIC,
  COUNT(*) AS INGREDIENT_COUNT,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS PERCENTAGE
FROM FOODFILE
GROUP BY ORGANIC;
```

## RPGLE Integration Example

```rpgle
**FREE

dcl-s ingId packed(10:0);
dcl-s ingName varchar(30);
dcl-s category varchar(20);
dcl-s measure varchar(10);
dcl-s quantity packed(7:2);
dcl-s expDate date;
dcl-s organic char(1);

// Add new ingredient
exec sql INSERT INTO FOODFILE (
  INGID, INGNAME, CATEGORY, MEASURE, QUANTITY, EXPDATE, ORGANIC
) VALUES (
  :ingId, :ingName, :category, :measure, :quantity, :expDate, :organic
);

if sqlstate = '00000';
  // Success
else;
  // Handle error
endif;

// Check expiring ingredients
exec sql DECLARE C1 CURSOR FOR
  SELECT INGID, INGNAME, EXPDATE, QUANTITY
  FROM FOODFILE
  WHERE EXPDATE BETWEEN CURRENT_DATE AND CURRENT_DATE + 30 DAYS
  ORDER BY EXPDATE;

exec sql OPEN C1;

dow sqlstate = '00000';
  exec sql FETCH C1 INTO :ingId, :ingName, :expDate, :quantity;
  if sqlstate = '00000';
    // Send alert or notification
  endif;
enddo;

exec sql CLOSE C1;
```

## CL Integration Example

```cl
PGM

DCL VAR(&INGID) TYPE(*DEC) LEN(10 0)
DCL VAR(&QTY) TYPE(*DEC) LEN(7 2)

/* Update quantity after use */
RUNSQL SQL('UPDATE FOODFILE +
            SET QUANTITY = QUANTITY - 2.5 +
            WHERE INGID = 1') +
       COMMIT(*NONE)

/* Check for low stock */
RUNSQL SQL('SELECT INGNAME, QUANTITY +
            FROM FOODFILE +
            WHERE QUANTITY < 5') +
       COMMIT(*NONE)

ENDPGM
```

## Best Practices

### Ingredient ID Management
- Use sequential numbering starting from 1
- Consider using identity column for auto-increment
- Never reuse deleted ingredient IDs
- Document ID ranges for different categories

### Quantity Management
- Always use positive quantities
- Update quantities atomically to avoid race conditions
- Consider adding minimum stock levels
- Track quantity changes in audit table

### Expiration Date Handling
- Always enter expiration dates for perishable items
- Set up automated alerts for expiring items
- Regular cleanup of expired items
- Consider "best before" vs "use by" dates

### Category Management
- Standardize category names
- Use consistent capitalization
- Consider creating a category reference table
- Allow for hierarchical categories

### Performance
- Create index on CATEGORY for filtering
- Create index on EXPDATE for expiration queries
- Create index on ORGANIC for organic filtering
- Consider partitioning by category for large datasets

## Potential Enhancements

### Additional Columns
```sql
ALTER TABLE FOODFILE ADD COLUMN SUPPLIER VARCHAR(50);
ALTER TABLE FOODFILE ADD COLUMN COST DECIMAL(9,2);
ALTER TABLE FOODFILE ADD COLUMN MIN_STOCK DECIMAL(7,2) DEFAULT 5.0;
ALTER TABLE FOODFILE ADD COLUMN MAX_STOCK DECIMAL(7,2) DEFAULT 50.0;
ALTER TABLE FOODFILE ADD COLUMN LOCATION VARCHAR(20);
ALTER TABLE FOODFILE ADD COLUMN BARCODE VARCHAR(20);
ALTER TABLE FOODFILE ADD COLUMN CREATED_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE FOODFILE ADD COLUMN UPDATED_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
```

### Add Check Constraints
```sql
ALTER TABLE FOODFILE 
ADD CONSTRAINT CHK_QUANTITY CHECK (QUANTITY >= 0);

ALTER TABLE FOODFILE
ADD CONSTRAINT CHK_EXPDATE CHECK (EXPDATE >= CURRENT_DATE - 1 YEAR);
```

### Create Indexes
```sql
CREATE INDEX IDX_FOODFILE_CATEGORY ON FOODFILE(CATEGORY);
CREATE INDEX IDX_FOODFILE_EXPDATE ON FOODFILE(EXPDATE);
CREATE INDEX IDX_FOODFILE_ORGANIC ON FOODFILE(ORGANIC);
CREATE INDEX IDX_FOODFILE_NAME ON FOODFILE(INGNAME);
```

### Create Views
```sql
-- View for expiring items
CREATE VIEW V_EXPIRING_SOON AS
SELECT * FROM FOODFILE
WHERE EXPDATE BETWEEN CURRENT_DATE AND CURRENT_DATE + 30 DAYS;

-- View for low stock items
CREATE VIEW V_LOW_STOCK AS
SELECT * FROM FOODFILE
WHERE QUANTITY < 5;

-- View for organic items
CREATE VIEW V_ORGANIC_ITEMS AS
SELECT * FROM FOODFILE
WHERE ORGANIC = 'Y';
```

## Related Tables

### Suggested Related Tables
- **SUPPLIERS**: Supplier information
- **PURCHASES**: Purchase history
- **USAGE_LOG**: Ingredient usage tracking
- **RECIPES**: Recipe ingredients relationship
- **CATEGORIES**: Category reference table

## Integration with RECIPIES Table
```sql
-- Link ingredients to recipes
CREATE TABLE RECIPE_INGREDIENTS (
  RECID INTEGER NOT NULL,
  INGID DECIMAL(10,0) NOT NULL,
  QUANTITY DECIMAL(7,2) NOT NULL,
  MEASURE VARCHAR(10),
  PRIMARY KEY (RECID, INGID),
  FOREIGN KEY (RECID) REFERENCES RECIPIES(RECID),
  FOREIGN KEY (INGID) REFERENCES FOODFILE(INGID)
);
```

## References
- IBM i SQL Reference: https://www.ibm.com/docs/en/i/7.5?topic=reference-sql
- Check Constraints: https://www.ibm.com/docs/en/i/7.5?topic=definition-check-constraint

---
*This table is part of the IBM i code samples repository demonstrating inventory management and data validation.*