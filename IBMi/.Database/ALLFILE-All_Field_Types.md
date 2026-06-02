# ALLFILE - All Field Types Physical File

## Overview
**File Type:** DDS Physical File  
**Object Name:** ALLFILE  
**Record Format:** ALLREC  
**Author:** Nick Litten  
**Created:** 2026-04-03

## Purpose
Comprehensive reference guide demonstrating all available DDS field data types in IBM i database files. This file serves as an educational example showing the syntax and capabilities of DDS field definitions.

## Description
ALLFILE is a physical file that contains examples of every major field type supported by DDS (Data Description Specifications) on IBM i. It's designed as a learning tool and reference for developers working with legacy DDS files or needing to understand the full range of data types available.

## Record Structure

### Character Fields
| Field Name | Type | Length | Description |
|------------|------|--------|-------------|
| CHARFLD | A | 10 | Fixed-length character field |
| CHARVAR | A | 50 | Variable-length character (VARLEN) |
| CHARFIX | A | 1 | Single character field |

### Numeric Fields - Packed Decimal (P)
| Field Name | Type | Digits | Decimals | Description |
|------------|------|--------|----------|-------------|
| PACKFLD | P | 7 | 2 | Standard packed decimal |
| PACKINT | P | 9 | 0 | Packed integer (no decimals) |
| PACKSMALL | P | 3 | 0 | Small packed integer |
| PACKLARGE | P | 15 | 5 | Large packed decimal |

### Numeric Fields - Zoned Decimal (S)
| Field Name | Type | Digits | Decimals | Description |
|------------|------|--------|----------|-------------|
| ZONEDFLD | S | 7 | 2 | Standard zoned decimal |
| ZONEDINT | S | 5 | 0 | Zoned integer |
| ZONEDLRG | S | 11 | 3 | Large zoned decimal |

### Numeric Fields - Binary (B)
| Field Name | Type | Digits | Description |
|------------|------|--------|-------------|
| BINFLD2 | B | 4 | 2-byte binary integer |
| BINFLD4 | B | 9 | 4-byte binary integer |
| BINFLD8 | B | 18 | 8-byte binary integer |

### Numeric Fields - Floating Point (F)
| Field Name | Type | Bytes | Description |
|------------|------|-------|-------------|
| FLOATSGL | F | 4 | Single precision float |
| FLOATDBL | F | 8 | Double precision float |

### Date Fields (L)
| Field Name | Format | Description |
|------------|--------|-------------|
| DATEFLD | *ISO | YYYY-MM-DD format |
| DATEUSA | *USA | MM/DD/YYYY format |
| DATEEUR | *EUR | DD.MM.YYYY format |
| DATEJIS | *JIS | YYYY-MM-DD format |
| DATEYMD | *YMD | YYYYMMDD format |
| DATEMDY | *MDY | MMDDYYYY format |
| DATEDMY | *DMY | DDMMYYYY format |
| DATEJUL | *JUL | Julian date format |

### Time Fields (T)
| Field Name | Format | Description |
|------------|--------|-------------|
| TIMEFLD | *ISO | HH.MM.SS format |
| TIMEHMS | *HMS | HH:MM:SS format |
| TIMEUSA | *USA | HH:MM AM/PM format |
| TIMEEUR | *EUR | HH.MM.SS format |
| TIMEJIS | *JIS | HH:MM:SS format |

### Timestamp Field (Z)
| Field Name | Type | Description |
|------------|------|-------------|
| TSTAMPFLD | Z | Full timestamp with microseconds |

### Hexadecimal Field
| Field Name | Type | Length | Description |
|------------|------|--------|-------------|
| HEXFLD | A | 20 | Hexadecimal data storage |

### Graphic Fields (G) - DBCS
| Field Name | Type | Length | Description |
|------------|------|--------|-------------|
| GRPHFLD | G | 10 | Fixed-length graphic (DBCS) |
| GRPHVAR | G | 25 | Variable-length graphic (VARLEN) |

### Advanced Types (Commented Out)
The following field types are shown as examples but commented out because they require SQL DDL rather than DDS:
- **BLOBFLD**: Binary Large Object (1MB)
- **CLBFLD**: Character Large Object (512KB)
- **DBLBFLD**: DBCS Large Object (256KB)
- **DLINKFLD**: DataLink field (external file reference)
- **ROWIDFLD**: System-generated unique row identifier

## Key Definition
- **Primary Key:** CHARFLD

## Features
- Complete coverage of DDS data types
- Organized by category with clear section headers
- TEXT keyword on every field for documentation
- Examples of VARLEN (variable length) fields
- Multiple date/time format demonstrations
- DBCS (Double Byte Character Set) support
- Reference examples for LOB and advanced types

## Usage Examples

### Creating the File
```cl
CRTPF FILE(MYLIB/ALLFILE) SRCFILE(MYLIB/QDDSSRC) SRCMBR(ALLFILE)
```

### Reading Records
```rpgle
dcl-f ALLFILE usage(*input);
read ALLREC;
if not %eof(ALLFILE);
  // Process record
endif;
```

### Writing Records
```rpgle
dcl-f ALLFILE usage(*output);
CHARFLD = 'Test';
PACKFLD = 123.45;
DATEFLD = %date();
write ALLREC;
```

## Data Type Selection Guide

### When to Use Each Type:
- **Packed Decimal (P)**: Most efficient for decimal numbers, use for currency and calculations
- **Zoned Decimal (S)**: Human-readable format, use when external systems need readable data
- **Binary (B)**: Fastest for integer operations, use for counters and IDs
- **Floating Point (F)**: Scientific calculations requiring very large or small numbers
- **Character (A)**: Text data, names, descriptions
- **Date/Time (L/T/Z)**: Always use native date/time types for date arithmetic
- **Graphic (G)**: Asian languages and DBCS character sets

## Best Practices
1. Use packed decimal for most numeric fields (storage efficient)
2. Use native date/time types instead of numeric dates
3. Use VARLEN for fields with highly variable content
4. Consider binary for high-volume integer fields
5. Use appropriate date/time formats for your region
6. Document all fields with TEXT keyword

## Migration Notes
When migrating to SQL DDL:
- Packed decimal (P) → DECIMAL or NUMERIC
- Zoned decimal (S) → DECIMAL or NUMERIC
- Binary (B) → SMALLINT, INTEGER, or BIGINT
- Floating point (F) → REAL or DOUBLE
- Character (A) → CHAR or VARCHAR
- Date/Time (L/T/Z) → DATE, TIME, or TIMESTAMP
- Graphic (G) → GRAPHIC or VARGRAPHIC

## Related Files
- **ALLTABLE-All_Data_Types.sql**: SQL equivalent with modern data types
- See SQL version for LOB, XML, DATALINK, and ROWID examples

## References
- IBM i DDS Reference: https://www.ibm.com/docs/en/i/7.5?topic=dds
- Data Types Guide: https://www.ibm.com/docs/en/i/7.5?topic=concepts-data-types

---
*This file is part of the IBM i code samples repository demonstrating DDS field types and best practices.*