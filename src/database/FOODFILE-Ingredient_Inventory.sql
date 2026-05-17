-- ---------------------------------------------------------------------------
-- SQL Table: FOODFILE
-- Description: Food ingredient inventory management table
-- Author: Nick Litten
-- Created: 2026-05-14
-- ---------------------------------------------------------------------------
-- Purpose: Manage food ingredient inventory
--   - Track ingredient quantities and expiration dates
--   - Categorize ingredients by type
--   - Monitor organic certification status
--
-- Features:
--   - Primary key on ingredient ID
--   - Check constraint for organic flag validation
--   - Expiration date tracking
--   - Unit of measure flexibility
--   - Category-based organization
--
-- Usage: Ingredient inventory management
--   INSERT INTO FOODFILE VALUES(1, 'Flour', 'Baking', 'kg', 25.50, '2026-12-31', 'Y');
--   SELECT * FROM FOODFILE WHERE EXPDATE < CURRENT_DATE;
--   UPDATE FOODFILE SET QUANTITY = QUANTITY - 1 WHERE INGID = 1;
--
-- Columns:
--   - INGID: Unique ingredient identifier (primary key)
--   - INGNAME: Name of the ingredient
--   - CATEGORY: Food category classification
--   - MEASURE: Unit of measurement (kg, lbs, oz, etc.)
--   - QUANTITY: Available quantity in stock
--   - EXPDATE: Expiration date
--   - ORGANIC: Organic certification flag (Y/N)
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
CREATE OR REPLACE TABLE
    FOODFILE (
        INGID DECIMAL(10, 0) NOT NULL PRIMARY KEY,
        INGNAME VARCHAR(30) NOT NULL,
        CATEGORY VARCHAR(20),
        MEASURE VARCHAR(10),
        QUANTITY DECIMAL(7, 2),
        EXPDATE DATE,
        ORGANIC CHAR(1) CHECK (ORGANIC IN ('Y', 'N'))
    );


-- ---------------------------------------------------------------------
-- Add column labels for documentation
-- ---------------------------------------------------------------------
LABEL ON COLUMN FOODFILE (
    INGID IS 'Ingredient ID',
    INGNAME IS 'Ingredient Name',
    CATEGORY IS 'Food Category',
    MEASURE IS 'Unit of Measure',
    QUANTITY IS 'Quantity Available',
    EXPDATE IS 'Expiration Date',
    ORGANIC IS 'Organic Flag (Y/N)'
);


-- ---------------------------------------------------------------------
-- Add table comment
-- ---------------------------------------------------------------------
LABEL ON TABLE FOODFILE IS 'Food Ingredient Inventory';


-- Made with Bob