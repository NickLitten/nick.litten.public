# ALLTABLE - All Data Types SQL Table

## Overview
**File Type:** SQL Table  
**Object Name:** ALLTABLE  
**Author:** Nick Litten  
**Created:** 2026-04-03  
**Version:** 1.0

## Purpose
Comprehensive reference table demonstrating all available IBM i SQL data types. This table serves as an educational example and reference guide for developers working with modern SQL DDL on IBM i.

## Description
ALLTABLE is a SQL table that contains examples of every major data type supported by IBM i SQL, including character strings, numeric types, date/time types, large objects, and advanced types like XML, DATALINK, ROWID, BOOLEAN, and ARRAY. It demonstrates modern SQL features including identity columns, generated columns, and CCSID specifications.

## Table Structure

### Character String Types
| Column Name | Data Type | Length | CCSID | Description |
|-------------|-----------|--------|-------|-------------|
| CHAR_FLD | CHAR | 10 | Default | Fixed-length character |
| VARCHAR_FLD | VARCHAR | 100 | Default | Variable-length character |
| CHAR_CCSID | CHAR | 10 | 37 | Character with CCSID 37 (EBCDIC) |
| VARCHAR_CCSID | VARCHAR | 100 | 37 | Variable char with CCSID |

### Graphic String Types (DBCS)
| Column Name | Data Type | Length | CCSID | Description |
|-------------|-----------|--------|-------|-------------|
| GRAPHIC_FLD | GRAPHIC | 10 | Default | Fixed-length graphic |
| VARGRAPHIC_FLD | VARGRAPHIC | 50 | Default | Variable-length graphic |
| GRAPHIC_CCSID | GRAPHIC | 10 | 13488 | Graphic with CCSID (Unicode) |

### Binary String Types
| Column Name | Data Type | Length | Description |
|-------------|-----------|--------|-------------|
| BINARY_FLD | BINARY | 20 | Fixed-length binary |
| VARBINARY_FLD | VARBINARY | 100 | Variable-length binary |

### Numeric Types - Exact Integers
| Column Name | Data Type | Range | Description |
|-------------|-----------|-------|-------------|
| SMALLINT_FLD | SMALLINT | -32,768 to 32,767 | 2-byte integer |
| INTEGER_FLD | INTEGER | -2.1B to 2.1B | 4-byte integer |
| INT_FLD | INT | -2.1B to 2.1B | 4-byte integer (alias) |
| BIGINT_FLD | BIGINT | -9.2E18 to 9.2E18 | 8-byte integer |

### Numeric Types - Decimal
| Column Name | Data Type | Precision | Scale | Description |
|-------------|-----------|-----------|-------|-------------|
| DECIMAL_FLD | DECIMAL | 15 | 5 | Decimal 15 digits, 5 decimal |
| DEC_FLD | DEC | 9 | 2 | Decimal 9 digits, 2 decimal |
| NUMERIC_FLD | NUMERIC | 11 | 3 | Numeric 11 digits, 3 decimal |
| NUM_FLD | NUM | 7 | 2 | Numeric 7 digits, 2 decimal |

### Numeric Types - Floating Point
| Column Name | Data Type | Precision | Description |
|-------------|-----------|-----------|-------------|
| REAL_FLD | REAL | Single | Single precision float (32-bit) |
| FLOAT_FLD | FLOAT | Double | Double precision float (64-bit) |
| DOUBLE_FLD | DOUBLE | Double | Double precision float |
| DOUBLE_PREC | DOUBLE PRECISION | Double | Double precision float |
| DECFLOAT16_FLD | DECFLOAT(16) | 16 digits | Decimal float 16 digits |
| DECFLOAT34_FLD | DECFLOAT(34) | 34 digits | Decimal float 34 digits |

### Date/Time Types
| Column Name | Data Type | Precision | Description |
|-------------|-----------|-----------|-------------|
| DATE_FLD | DATE | - | Date field (YYYY-MM-DD) |
| TIME_FLD | TIME | - | Time field (HH:MM:SS) |
| TIMESTAMP_FLD | TIMESTAMP | Default | Timestamp default precision |
| TIMESTAMP_0 | TIMESTAMP(0) | 0 | Timestamp 0 fractional seconds |
| TIMESTAMP_6 | TIMESTAMP(6) | 6 | Timestamp 6 fractional seconds |
| TIMESTAMP_12 | TIMESTAMP(12) | 12 | Timestamp 12 fractional seconds |

### Large Object Types
| Column Name | Data Type | Size | CCSID | Description |
|-------------|-----------|------|-------|-------------|
| CLOB_FLD | CLOB | 1M | Default | Character large object 1MB |
| CLOB_CCSID | CLOB | 512K | 37 | CLOB with CCSID 512KB |
| BLOB_FLD | BLOB | 1M | - | Binary large object 1MB |
| DBCLOB_FLD | DBCLOB | 512K | Default | DBCS large object 512KB |
| DBCLOB_CCSID | DBCLOB | 256K | 13488 | DBCLOB with CCSID 256KB |

### Advanced Types
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| XML_FLD | XML | XML document storage |
| DATALINK_FLD | DATALINK(200) | External file reference |
| ROWID_FLD | ROWID | System-generated unique identifier |
| BOOLEAN_FLD | BOOLEAN | True/false values (7.3+) |
| ARRAY_FLD | INTEGER ARRAY[10] | Integer array with 10 elements (7.1+) |

### Special Columns
| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| ID_FLD | INTEGER | Auto-increment identity (primary key) |
| GENERATED_FLD | INTEGER | Computed column (SMALLINT_FLD + INTEGER_FLD) |

## Indexes
- **ALLTABLE_IDX1**: Index on CHAR_FLD for character searches
- **ALLTABLE_IDX2**: Index on DATE_FLD for date-based queries
- **ALLTABLE_IDX3**: Index on INTEGER_FLD for numeric searches

## Constraints
- **Primary Key**: ID_FLD (auto-increment identity column)
- **NOT NULL**: All columns defined with NOT NULL WITH DEFAULT
- **Generated Always**: ROWID_FLD and ID_FLD

## Features
- Complete coverage of IBM i SQL data types
- CCSID specifications for character and graphic fields
- Identity column with auto-increment
- Generated computed column
- ROWID for unique row identification
- Array type support (IBM i 7.1+)
- Boolean type support (IBM i 7.3+)
- DECFLOAT for high-precision decimal floating point
- Multiple timestamp precisions (0, 6, 12 fractional seconds)
- Large object types (CLOB, BLOB, DBCLOB)
- XML document storage
- DATALINK for external file references

## Usage Examples

### Creating Similar Tables
```sql
-- Create table with same structure
CREATE TABLE MYTABLE LIKE ALLTABLE;

-- Create table with subset of columns
CREATE TABLE MYTABLE AS (
  SELECT CHAR_FLD, INTEGER_FLD, DATE_FLD 
  FROM ALLTABLE
) WITH NO DATA;
```

### Querying Data
```sql
-- Select all records
SELECT * FROM ALLTABLE WHERE ID_FLD = 1;

-- Query by date
SELECT * FROM ALLTABLE 
WHERE DATE_FLD BETWEEN '2026-01-01' AND '2026-12-31';

-- Query EU members
SELECT CHAR_FLD, INTEGER_FLD, BOOLEAN_FLD
FROM ALLTABLE
WHERE BOOLEAN_FLD = TRUE;
```

### Inserting Data
```sql
INSERT INTO ALLTABLE (
  CHAR_FLD, VARCHAR_FLD, INTEGER_FLD, 
  DECIMAL_FLD, DATE_FLD, BOOLEAN_FLD
) VALUES (
  'Test', 'Variable text', 12345, 
  123.45, CURRENT_DATE, TRUE
);
```

### Working with Arrays
```sql
-- Insert array data (IBM i 7.1+)
INSERT INTO ALLTABLE (ARRAY_FLD)
VALUES (ARRAY[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

-- Query array elements
SELECT ARRAY_FLD[1], ARRAY_FLD[5] FROM ALLTABLE;
```

### Working with LOBs
```sql
-- Insert CLOB data
INSERT INTO ALLTABLE (CLOB_FLD)
VALUES ('Large text content...');

-- Query CLOB length
SELECT LENGTH(CLOB_FLD) FROM ALLTABLE;
```

## Data Type Selection Guide

### Character Data
- **CHAR**: Fixed-length, padded with spaces, use for codes/flags
- **VARCHAR**: Variable-length, use for names/descriptions
- **CLOB**: Very large text (>32KB), use for documents

### Numeric Data
- **SMALLINT/INTEGER/BIGINT**: Whole numbers, fastest performance
- **DECIMAL/NUMERIC**: Exact decimal values, use for currency
- **REAL/DOUBLE**: Floating point, use for scientific calculations
- **DECFLOAT**: High-precision decimal floating point

### Date/Time Data
- **DATE**: Calendar dates only
- **TIME**: Time of day only
- **TIMESTAMP**: Date and time with fractional seconds

### Binary Data
- **BINARY/VARBINARY**: Small binary data
- **BLOB**: Large binary objects (images, files)

### Special Types
- **BOOLEAN**: True/false values (clearer than CHAR(1))
- **ARRAY**: Multiple values in single column
- **XML**: Structured XML documents
- **DATALINK**: References to external files
- **ROWID**: Unique row identifier for fast access

## Version Requirements
- **IBM i 7.1+**: Required for ARRAY and DECFLOAT types
- **IBM i 7.3+**: Required for BOOLEAN type
- **IBM i 7.4+**: Recommended for full SQL feature support

## Best Practices
1. Use appropriate data types for your data (don't use VARCHAR for numbers)
2. Specify CCSID when working with international character sets
3. Use TIMESTAMP with appropriate precision (don't use 12 if 0 is sufficient)
4. Consider VARCHAR over CHAR for variable-length data (saves space)
5. Use BOOLEAN instead of CHAR(1) for true/false values
6. Use identity columns for auto-incrementing primary keys
7. Use generated columns for computed values
8. Add column labels for documentation
9. Create indexes on frequently queried columns
10. Use LOB types only when necessary (performance impact)

## Migration from DDS
When migrating from DDS Physical Files:
- A (Character) → CHAR or VARCHAR
- P (Packed) → DECIMAL or NUMERIC
- S (Zoned) → DECIMAL or NUMERIC
- B (Binary) → SMALLINT, INTEGER, or BIGINT
- F (Float) → REAL or DOUBLE
- L (Date) → DATE
- T (Time) → TIME
- Z (Timestamp) → TIMESTAMP
- G (Graphic) → GRAPHIC or VARGRAPHIC

## Related Files
- **ALLFILE-All_Field_Types.pf**: DDS equivalent with legacy data types
- See DDS version for comparison with legacy field definitions

## References
- IBM i SQL Reference: https://www.ibm.com/docs/en/i/7.5?topic=reference-sql
- SQL Data Types: https://www.ibm.com/docs/en/i/7.5?topic=elements-data-types
- CCSID Information: https://www.ibm.com/docs/en/i/7.5?topic=support-ccsids

---
*This table is part of the IBM i code samples repository demonstrating modern SQL data types and best practices.*