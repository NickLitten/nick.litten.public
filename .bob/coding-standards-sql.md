# IBM i SQL Coding Standards
## Nick Litten Project - Modern SQL Best Practices

---

## 1. Script Header Documentation

### SQL Scripts
Use double-dash (--) for all SQL comments:

```sql
-------------------------------------------------------------------------------
-- Script: SCRIPTNAME.SQL - Brief Description
-- Description: Comprehensive explanation of what this script does and why
--              it exists. Multiple lines are fine.
--
-- Purpose:
--   - Create database objects
--   - Define stored procedures
--   - Set up initial data
--
-- Features:
--   - Error handling
--   - Transaction control
--   - Rollback on failure
--
-- Usage:
--   RUNSQLSTM SRCFILE(LIB/QSQLSRC) SRCMBR(SCRIPTNAME)
--   Or run from ACS Run SQL Scripts
--
-- Dependencies:
--   - Table: TABLENAME
--   - Procedure: PROCNAME
--   - Function: FUNCNAME
--
-- Author: Nick Litten
--
-- Modification History:
-- v.001 YYYY.MM.DD - Nick Litten - Initial creation
-- v.002 YYYY.MM.DD - Nick Litten - Description of change
-------------------------------------------------------------------------------
```

---

## 2. Table Creation Standards

### Basic Table
```sql
-------------------------------------------------------------------------------
-- Table: CUSTOMER - Customer Master Table
-- Description: Stores customer information including contact details,
--              status, and balance information.
-------------------------------------------------------------------------------

-- Drop table if exists (for development)
DROP TABLE IF EXISTS MYLIB.CUSTOMER;

-- Create table
CREATE TABLE MYLIB.CUSTOMER (
    -- Primary Key
    CUSTOMER_ID         CHAR(10)        NOT NULL,
    
    -- Customer Information
    CUSTOMER_NAME       VARCHAR(50)     NOT NULL,
    CUSTOMER_EMAIL      VARCHAR(100),
    CUSTOMER_PHONE      CHAR(10),
    
    -- Address Information
    ADDRESS_LINE1       VARCHAR(50),
    ADDRESS_LINE2       VARCHAR(50),
    CITY                VARCHAR(30),
    STATE               CHAR(2),
    ZIP_CODE            CHAR(10),
    
    -- Business Information
    CUSTOMER_STATUS     CHAR(1)         NOT NULL DEFAULT 'A',
    CUSTOMER_BALANCE    DECIMAL(11,2)   NOT NULL DEFAULT 0.00,
    CREDIT_LIMIT        DECIMAL(11,2)   NOT NULL DEFAULT 0.00,
    
    -- Audit Fields
    CREATED_DATE        DATE            NOT NULL DEFAULT CURRENT_DATE,
    CREATED_TIME        TIME            NOT NULL DEFAULT CURRENT_TIME,
    CREATED_USER        CHAR(10)        NOT NULL DEFAULT USER,
    CHANGED_DATE        DATE            NOT NULL DEFAULT CURRENT_DATE,
    CHANGED_TIME        TIME            NOT NULL DEFAULT CURRENT_TIME,
    CHANGED_USER        CHAR(10)        NOT NULL DEFAULT USER,
    
    -- Constraints
    CONSTRAINT PK_CUSTOMER PRIMARY KEY (CUSTOMER_ID),
    CONSTRAINT CHK_STATUS CHECK (CUSTOMER_STATUS IN ('A', 'I', 'H')),
    CONSTRAINT CHK_BALANCE CHECK (CUSTOMER_BALANCE >= 0),
    CONSTRAINT CHK_CREDIT CHECK (CREDIT_LIMIT >= 0)
);

-- Add labels
LABEL ON TABLE MYLIB.CUSTOMER IS 'Customer Master';

LABEL ON COLUMN MYLIB.CUSTOMER (
    CUSTOMER_ID     IS 'Customer ID',
    CUSTOMER_NAME   IS 'Customer Name',
    CUSTOMER_EMAIL  IS 'Email Address',
    CUSTOMER_STATUS IS 'Status (A/I/H)',
    CUSTOMER_BALANCE IS 'Current Balance',
    CREATED_DATE    IS 'Created Date',
    CREATED_USER    IS 'Created By'
);

-- Create indexes
CREATE INDEX MYLIB.CUSTNAME_IDX 
    ON MYLIB.CUSTOMER (CUSTOMER_NAME);

CREATE INDEX MYLIB.CUSTEMAIL_IDX 
    ON MYLIB.CUSTOMER (CUSTOMER_EMAIL);

-- Grant permissions
GRANT SELECT, INSERT, UPDATE, DELETE 
    ON MYLIB.CUSTOMER 
    TO PUBLIC;

COMMIT;
```

### Table with Foreign Keys
```sql
-------------------------------------------------------------------------------
-- Table: ORDERS - Order Header Table
-- Description: Stores order header information with foreign key to customer
-------------------------------------------------------------------------------

DROP TABLE IF EXISTS MYLIB.ORDERS;

CREATE TABLE MYLIB.ORDERS (
    -- Primary Key
    ORDER_ID            INTEGER         NOT NULL GENERATED ALWAYS AS IDENTITY,
    
    -- Foreign Keys
    CUSTOMER_ID         CHAR(10)        NOT NULL,
    
    -- Order Information
    ORDER_DATE          DATE            NOT NULL DEFAULT CURRENT_DATE,
    ORDER_STATUS        CHAR(1)         NOT NULL DEFAULT 'N',
    ORDER_TOTAL         DECIMAL(11,2)   NOT NULL DEFAULT 0.00,
    SHIPPING_COST       DECIMAL(9,2)    NOT NULL DEFAULT 0.00,
    TAX_AMOUNT          DECIMAL(9,2)    NOT NULL DEFAULT 0.00,
    
    -- Shipping Information
    SHIP_TO_NAME        VARCHAR(50),
    SHIP_TO_ADDRESS     VARCHAR(50),
    SHIP_TO_CITY        VARCHAR(30),
    SHIP_TO_STATE       CHAR(2),
    SHIP_TO_ZIP         CHAR(10),
    
    -- Audit Fields
    CREATED_DATE        DATE            NOT NULL DEFAULT CURRENT_DATE,
    CREATED_TIME        TIME            NOT NULL DEFAULT CURRENT_TIME,
    CREATED_USER        CHAR(10)        NOT NULL DEFAULT USER,
    CHANGED_DATE        DATE            NOT NULL DEFAULT CURRENT_DATE,
    CHANGED_TIME        TIME            NOT NULL DEFAULT CURRENT_TIME,
    CHANGED_USER        CHAR(10)        NOT NULL DEFAULT USER,
    
    -- Constraints
    CONSTRAINT PK_ORDERS PRIMARY KEY (ORDER_ID),
    CONSTRAINT FK_ORDERS_CUSTOMER 
        FOREIGN KEY (CUSTOMER_ID) 
        REFERENCES MYLIB.CUSTOMER (CUSTOMER_ID)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT CHK_ORDER_STATUS 
        CHECK (ORDER_STATUS IN ('N', 'P', 'S', 'C', 'X')),
    CONSTRAINT CHK_ORDER_TOTAL 
        CHECK (ORDER_TOTAL >= 0)
);

LABEL ON TABLE MYLIB.ORDERS IS 'Order Header';

CREATE INDEX MYLIB.ORDCUST_IDX 
    ON MYLIB.ORDERS (CUSTOMER_ID);

CREATE INDEX MYLIB.ORDDATE_IDX 
    ON MYLIB.ORDERS (ORDER_DATE);

GRANT SELECT, INSERT, UPDATE, DELETE 
    ON MYLIB.ORDERS 
    TO PUBLIC;

COMMIT;
```

---

## 3. View Creation Standards

### Simple View
```sql
-------------------------------------------------------------------------------
-- View: ACTIVE_CUSTOMERS - Active Customers Only
-- Description: Provides access to active customers with formatted data
-------------------------------------------------------------------------------

CREATE OR REPLACE VIEW MYLIB.ACTIVE_CUSTOMERS AS
SELECT 
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CUSTOMER_EMAIL,
    CUSTOMER_PHONE,
    CITY,
    STATE,
    CUSTOMER_BALANCE,
    CREDIT_LIMIT,
    CREATED_DATE
FROM 
    MYLIB.CUSTOMER
WHERE 
    CUSTOMER_STATUS = 'A'
WITH CHECK OPTION;

LABEL ON TABLE MYLIB.ACTIVE_CUSTOMERS IS 'Active Customers View';

GRANT SELECT ON MYLIB.ACTIVE_CUSTOMERS TO PUBLIC;

COMMIT;
```

### Complex View with Joins
```sql
-------------------------------------------------------------------------------
-- View: ORDER_SUMMARY - Order Summary with Customer Information
-- Description: Joins orders with customer data for reporting
-------------------------------------------------------------------------------

CREATE OR REPLACE VIEW MYLIB.ORDER_SUMMARY AS
SELECT 
    O.ORDER_ID,
    O.ORDER_DATE,
    O.ORDER_STATUS,
    O.ORDER_TOTAL,
    C.CUSTOMER_ID,
    C.CUSTOMER_NAME,
    C.CUSTOMER_EMAIL,
    C.CITY,
    C.STATE,
    CASE O.ORDER_STATUS
        WHEN 'N' THEN 'New'
        WHEN 'P' THEN 'Processing'
        WHEN 'S' THEN 'Shipped'
        WHEN 'C' THEN 'Complete'
        WHEN 'X' THEN 'Cancelled'
        ELSE 'Unknown'
    END AS STATUS_DESCRIPTION
FROM 
    MYLIB.ORDERS O
    INNER JOIN MYLIB.CUSTOMER C 
        ON O.CUSTOMER_ID = C.CUSTOMER_ID;

LABEL ON TABLE MYLIB.ORDER_SUMMARY IS 'Order Summary View';

GRANT SELECT ON MYLIB.ORDER_SUMMARY TO PUBLIC;

COMMIT;
```

---

## 4. Stored Procedure Standards

### Basic Procedure
```sql
-------------------------------------------------------------------------------
-- Procedure: GET_CUSTOMER_INFO
-- Description: Retrieves customer information by customer ID
--
-- Parameters:
--   IN  p_customer_id  - Customer ID to retrieve
--   OUT p_customer_name - Customer name
--   OUT p_status       - Customer status
--   OUT p_balance      - Customer balance
--   OUT p_error_msg    - Error message if any
--
-- Returns: 0 = Success, -1 = Error
-------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE MYLIB.GET_CUSTOMER_INFO (
    IN  p_customer_id   CHAR(10),
    OUT p_customer_name VARCHAR(50),
    OUT p_status        CHAR(1),
    OUT p_balance       DECIMAL(11,2),
    OUT p_error_msg     VARCHAR(256)
)
LANGUAGE SQL
SPECIFIC MYLIB.GETCUSTINFO
MODIFIES SQL DATA
BEGIN
    -- Declare variables
    DECLARE v_count INTEGER DEFAULT 0;
    
    -- Declare condition handler for SQL errors
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET p_error_msg = 'SQL Error: ' || SQLSTATE;
    
    -- Initialize output parameters
    SET p_customer_name = '';
    SET p_status = '';
    SET p_balance = 0;
    SET p_error_msg = '';
    
    -- Validate input
    IF p_customer_id IS NULL OR TRIM(p_customer_id) = '' THEN
        SET p_error_msg = 'Customer ID is required';
        RETURN;
    END IF;
    
    -- Check if customer exists
    SELECT COUNT(*) INTO v_count
    FROM MYLIB.CUSTOMER
    WHERE CUSTOMER_ID = p_customer_id;
    
    IF v_count = 0 THEN
        SET p_error_msg = 'Customer not found';
        RETURN;
    END IF;
    
    -- Retrieve customer information
    SELECT 
        CUSTOMER_NAME,
        CUSTOMER_STATUS,
        CUSTOMER_BALANCE
    INTO 
        p_customer_name,
        p_status,
        p_balance
    FROM 
        MYLIB.CUSTOMER
    WHERE 
        CUSTOMER_ID = p_customer_id;
        
END;

LABEL ON SPECIFIC PROCEDURE MYLIB.GETCUSTINFO 
    IS 'Get Customer Information';

GRANT EXECUTE ON PROCEDURE MYLIB.GET_CUSTOMER_INFO TO PUBLIC;

COMMIT;
```

### Procedure with Transaction Control
```sql
-------------------------------------------------------------------------------
-- Procedure: CREATE_ORDER
-- Description: Creates a new order with transaction control
--
-- Parameters:
--   IN  p_customer_id  - Customer ID
--   IN  p_order_total  - Order total amount
--   OUT p_order_id     - Generated order ID
--   OUT p_error_msg    - Error message if any
--
-- Returns: 0 = Success, -1 = Error
-------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE MYLIB.CREATE_ORDER (
    IN  p_customer_id  CHAR(10),
    IN  p_order_total  DECIMAL(11,2),
    OUT p_order_id     INTEGER,
    OUT p_error_msg    VARCHAR(256)
)
LANGUAGE SQL
SPECIFIC MYLIB.CREATEORDER
MODIFIES SQL DATA
BEGIN
    -- Declare variables
    DECLARE v_customer_count INTEGER DEFAULT 0;
    DECLARE v_credit_limit DECIMAL(11,2) DEFAULT 0;
    DECLARE v_balance DECIMAL(11,2) DEFAULT 0;
    DECLARE v_new_balance DECIMAL(11,2) DEFAULT 0;
    
    -- Declare condition handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_error_msg = 'SQL Error: ' || SQLSTATE;
        ROLLBACK;
    END;
    
    -- Initialize output
    SET p_order_id = 0;
    SET p_error_msg = '';
    
    -- Start transaction
    BEGIN
        -- Validate customer exists
        SELECT COUNT(*), CREDIT_LIMIT, CUSTOMER_BALANCE
        INTO v_customer_count, v_credit_limit, v_balance
        FROM MYLIB.CUSTOMER
        WHERE CUSTOMER_ID = p_customer_id
        AND CUSTOMER_STATUS = 'A';
        
        IF v_customer_count = 0 THEN
            SET p_error_msg = 'Customer not found or inactive';
            RETURN;
        END IF;
        
        -- Check credit limit
        SET v_new_balance = v_balance + p_order_total;
        IF v_new_balance > v_credit_limit THEN
            SET p_error_msg = 'Order exceeds credit limit';
            RETURN;
        END IF;
        
        -- Create order
        INSERT INTO MYLIB.ORDERS (
            CUSTOMER_ID,
            ORDER_DATE,
            ORDER_STATUS,
            ORDER_TOTAL,
            CREATED_USER,
            CHANGED_USER
        ) VALUES (
            p_customer_id,
            CURRENT_DATE,
            'N',
            p_order_total,
            USER,
            USER
        );
        
        -- Get generated order ID
        SET p_order_id = IDENTITY_VAL_LOCAL();
        
        -- Update customer balance
        UPDATE MYLIB.CUSTOMER
        SET CUSTOMER_BALANCE = v_new_balance,
            CHANGED_DATE = CURRENT_DATE,
            CHANGED_TIME = CURRENT_TIME,
            CHANGED_USER = USER
        WHERE CUSTOMER_ID = p_customer_id;
        
        -- Commit transaction
        COMMIT;
        
    END;
    
END;

LABEL ON SPECIFIC PROCEDURE MYLIB.CREATEORDER 
    IS 'Create New Order';

GRANT EXECUTE ON PROCEDURE MYLIB.CREATE_ORDER TO PUBLIC;

COMMIT;
```

---

## 5. Function Standards

### Scalar Function
```sql
-------------------------------------------------------------------------------
-- Function: CALCULATE_TAX
-- Description: Calculates sales tax based on amount and state
--
-- Parameters:
--   p_amount - Amount to calculate tax on
--   p_state  - State code for tax rate
--
-- Returns: Tax amount
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION MYLIB.CALCULATE_TAX (
    p_amount DECIMAL(11,2),
    p_state  CHAR(2)
)
RETURNS DECIMAL(9,2)
LANGUAGE SQL
SPECIFIC MYLIB.CALCTAX
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_tax_rate DECIMAL(5,4) DEFAULT 0;
    DECLARE v_tax_amount DECIMAL(9,2) DEFAULT 0;
    
    -- Get tax rate for state
    SET v_tax_rate = CASE p_state
        WHEN 'CA' THEN 0.0725
        WHEN 'NY' THEN 0.0800
        WHEN 'TX' THEN 0.0625
        WHEN 'FL' THEN 0.0600
        ELSE 0.0500
    END;
    
    -- Calculate tax
    SET v_tax_amount = p_amount * v_tax_rate;
    
    RETURN v_tax_amount;
END;

LABEL ON SPECIFIC FUNCTION MYLIB.CALCTAX 
    IS 'Calculate Sales Tax';

GRANT EXECUTE ON FUNCTION MYLIB.CALCULATE_TAX TO PUBLIC;

COMMIT;
```

### Table Function
```sql
-------------------------------------------------------------------------------
-- Function: GET_CUSTOMER_ORDERS
-- Description: Returns all orders for a customer
--
-- Parameters:
--   p_customer_id - Customer ID
--
-- Returns: Table of orders
-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION MYLIB.GET_CUSTOMER_ORDERS (
    p_customer_id CHAR(10)
)
RETURNS TABLE (
    ORDER_ID     INTEGER,
    ORDER_DATE   DATE,
    ORDER_STATUS CHAR(1),
    ORDER_TOTAL  DECIMAL(11,2)
)
LANGUAGE SQL
SPECIFIC MYLIB.GETCUSTORDS
READS SQL DATA
BEGIN
    RETURN
        SELECT 
            ORDER_ID,
            ORDER_DATE,
            ORDER_STATUS,
            ORDER_TOTAL
        FROM 
            MYLIB.ORDERS
        WHERE 
            CUSTOMER_ID = p_customer_id
        ORDER BY 
            ORDER_DATE DESC;
END;

LABEL ON SPECIFIC FUNCTION MYLIB.GETCUSTORDS 
    IS 'Get Customer Orders';

GRANT EXECUTE ON FUNCTION MYLIB.GET_CUSTOMER_ORDERS TO PUBLIC;

COMMIT;
```

---

## 6. Trigger Standards

### Before Insert Trigger
```sql
-------------------------------------------------------------------------------
-- Trigger: CUSTOMER_BEFORE_INSERT
-- Description: Sets audit fields before insert
-------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER MYLIB.CUSTOMER_BEFORE_INSERT
BEFORE INSERT ON MYLIB.CUSTOMER
REFERENCING NEW AS N
FOR EACH ROW
MODE DB2SQL
BEGIN
    -- Set audit fields
    SET N.CREATED_DATE = CURRENT_DATE;
    SET N.CREATED_TIME = CURRENT_TIME;
    SET N.CREATED_USER = USER;
    SET N.CHANGED_DATE = CURRENT_DATE;
    SET N.CHANGED_TIME = CURRENT_TIME;
    SET N.CHANGED_USER = USER;
END;

COMMIT;
```

### Before Update Trigger
```sql
-------------------------------------------------------------------------------
-- Trigger: CUSTOMER_BEFORE_UPDATE
-- Description: Updates audit fields before update
-------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER MYLIB.CUSTOMER_BEFORE_UPDATE
BEFORE UPDATE ON MYLIB.CUSTOMER
REFERENCING NEW AS N OLD AS O
FOR EACH ROW
MODE DB2SQL
BEGIN
    -- Update changed audit fields only
    SET N.CHANGED_DATE = CURRENT_DATE;
    SET N.CHANGED_TIME = CURRENT_TIME;
    SET N.CHANGED_USER = USER;
    
    -- Preserve created audit fields
    SET N.CREATED_DATE = O.CREATED_DATE;
    SET N.CREATED_TIME = O.CREATED_TIME;
    SET N.CREATED_USER = O.CREATED_USER;
END;

COMMIT;
```

---

## 7. Query Standards

### SELECT Statements
```sql
-- Good - Formatted and readable
SELECT 
    C.CUSTOMER_ID,
    C.CUSTOMER_NAME,
    C.CUSTOMER_EMAIL,
    C.CITY,
    C.STATE,
    O.ORDER_ID,
    O.ORDER_DATE,
    O.ORDER_TOTAL
FROM 
    MYLIB.CUSTOMER C
    INNER JOIN MYLIB.ORDERS O 
        ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE 
    C.CUSTOMER_STATUS = 'A'
    AND O.ORDER_DATE >= CURRENT_DATE - 30 DAYS
ORDER BY 
    O.ORDER_DATE DESC,
    C.CUSTOMER_NAME;

-- Use meaningful aliases
SELECT 
    CUST.CUSTOMER_NAME AS "Customer Name",
    ORD.ORDER_DATE AS "Order Date",
    ORD.ORDER_TOTAL AS "Total Amount"
FROM 
    MYLIB.CUSTOMER CUST
    INNER JOIN MYLIB.ORDERS ORD 
        ON CUST.CUSTOMER_ID = ORD.CUSTOMER_ID;
```

### INSERT Statements
```sql
-- Good - Explicit column list
INSERT INTO MYLIB.CUSTOMER (
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CUSTOMER_EMAIL,
    CUSTOMER_STATUS,
    CREATED_USER,
    CHANGED_USER
) VALUES (
    'CUST000001',
    'John Doe',
    'john.doe@example.com',
    'A',
    USER,
    USER
);

-- Insert from SELECT
INSERT INTO MYLIB.CUSTOMER_ARCHIVE
SELECT * FROM MYLIB.CUSTOMER
WHERE CUSTOMER_STATUS = 'I'
AND CHANGED_DATE < CURRENT_DATE - 365 DAYS;
```

### UPDATE Statements
```sql
-- Good - Clear and specific
UPDATE MYLIB.CUSTOMER
SET 
    CUSTOMER_STATUS = 'I',
    CHANGED_DATE = CURRENT_DATE,
    CHANGED_TIME = CURRENT_TIME,
    CHANGED_USER = USER
WHERE 
    CUSTOMER_ID = 'CUST000001';

-- Update with subquery
UPDATE MYLIB.CUSTOMER C
SET CUSTOMER_BALANCE = (
    SELECT COALESCE(SUM(ORDER_TOTAL), 0)
    FROM MYLIB.ORDERS O
    WHERE O.CUSTOMER_ID = C.CUSTOMER_ID
    AND O.ORDER_STATUS IN ('N', 'P')
)
WHERE EXISTS (
    SELECT 1 FROM MYLIB.ORDERS O
    WHERE O.CUSTOMER_ID = C.CUSTOMER_ID
);
```

### DELETE Statements
```sql
-- Good - Specific with WHERE clause
DELETE FROM MYLIB.ORDERS
WHERE ORDER_STATUS = 'X'
AND ORDER_DATE < CURRENT_DATE - 365 DAYS;

-- Delete with subquery
DELETE FROM MYLIB.ORDERS
WHERE CUSTOMER_ID IN (
    SELECT CUSTOMER_ID
    FROM MYLIB.CUSTOMER
    WHERE CUSTOMER_STATUS = 'I'
);
```

---

## 8. Naming Conventions

### Database Objects
- **Tables**: UPPER_SNAKE_CASE (e.g., `CUSTOMER`, `ORDER_DETAIL`)
- **Views**: UPPER_SNAKE_CASE with descriptive suffix (e.g., `ACTIVE_CUSTOMERS`, `ORDER_SUMMARY`)
- **Procedures**: UPPER_SNAKE_CASE, verb-based (e.g., `GET_CUSTOMER_INFO`, `CREATE_ORDER`)
- **Functions**: UPPER_SNAKE_CASE, verb-based (e.g., `CALCULATE_TAX`, `FORMAT_PHONE`)
- **Triggers**: Table name + action (e.g., `CUSTOMER_BEFORE_INSERT`)

### Columns
- **Primary Keys**: Singular table name + _ID (e.g., `CUSTOMER_ID`, `ORDER_ID`)
- **Foreign Keys**: Referenced table + _ID (e.g., `CUSTOMER_ID` in ORDERS table)
- **Dates**: Descriptive + _DATE (e.g., `ORDER_DATE`, `CREATED_DATE`)
- **Times**: Descriptive + _TIME (e.g., `ORDER_TIME`, `CREATED_TIME`)
- **Status**: Descriptive + _STATUS (e.g., `ORDER_STATUS`, `CUSTOMER_STATUS`)
- **Amounts**: Descriptive + _AMOUNT or _TOTAL (e.g., `TAX_AMOUNT`, `ORDER_TOTAL`)

---

## 9. Best Practices

### Always Include
- Comprehensive header comments
- Error handling in procedures
- Transaction control where appropriate
- Audit fields (created/changed date, time, user)
- Proper constraints (PK, FK, CHECK)
- Indexes on frequently queried columns
- Labels for documentation
- GRANT statements for permissions

### Performance
- Use appropriate indexes
- Avoid SELECT *
- Use EXISTS instead of IN for large datasets
- Use FETCH FIRST n ROWS for limiting results
- Consider materialized query tables for complex queries

### Security
- Use parameterized queries
- Grant minimum necessary permissions
- Validate input in stored procedures
- Use views to restrict data access

---

## 10. Comment Standards

### Inline Comments
```sql
-- Single-line comment for brief explanations

/* Multi-line comment for more detailed
   explanations that span multiple lines
   and provide context */

SELECT 
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CUSTOMER_BALANCE  -- Current balance
FROM MYLIB.CUSTOMER;
```

### Section Separators
Use dashes (-) only:

```sql
-------------------------------------------------------------------------------
-- SECTION NAME
-------------------------------------------------------------------------------
```

---

## Summary Checklist

- [ ] Double-dash (--) comments for documentation
- [ ] Dash (-) separators only, never equals (=)
- [ ] Author: Nick Litten
- [ ] Comprehensive modification history
- [ ] Explicit column lists in INSERT/UPDATE
- [ ] Proper WHERE clauses in UPDATE/DELETE
- [ ] Transaction control in procedures
- [ ] Error handling in procedures
- [ ] Audit fields in tables
- [ ] Constraints (PK, FK, CHECK)
- [ ] Indexes on key columns
- [ ] Labels for documentation
- [ ] GRANT statements for permissions
- [ ] Meaningful aliases
- [ ] Formatted and readable SQL
- [ ] Consistent naming conventions