# SAMPLEDB - European Country Information Table

## Overview
**File Type:** SQL Table  
**Object Name:** SAMPLEDB  
**Author:** Nick Litten  
**Created:** 2026-02-06  
**Version:** 1.0

## Purpose
Comprehensive European country information reference table designed to store ISO country codes, geographic data, demographic information, EU membership tracking, and currency details. This table provides a complete dataset of European countries for testing, demonstrations, and production use.

## Description
SAMPLEDB is a SQL table that manages detailed information about European countries. It includes ISO 3166-1 alpha-2 country codes, official and local country names, capital cities, geographic regions, population and area statistics, EU membership status and join dates, currency information, and audit timestamps. The table comes with complete European country data and includes multiple indexes and a summary view for reporting.

## Table Structure

### Columns
| Column Name | Data Type | Length | Nullable | Constraint | Description |
|-------------|-----------|--------|----------|------------|-------------|
| COUNTRY_CODE | CHAR | 2 | NOT NULL | PRIMARY KEY | ISO 3166-1 alpha-2 code |
| COUNTRY_NAME | VARCHAR | 100 | NOT NULL | - | Official English country name |
| COUNTRY_NAME_LOCAL | VARCHAR | 100 | NULL | - | Local language country name |
| CAPITAL_CITY | VARCHAR | 100 | NULL | - | Capital city name |
| REGION | VARCHAR | 50 | NULL | - | Geographic region classification |
| POPULATION | BIGINT | - | NULL | - | Current population estimate |
| AREA_KM2 | DECIMAL | 12,2 | NULL | - | Land area in square kilometers |
| EU_MEMBER | CHAR | 1 | NULL | CHECK | EU membership flag (Y/N) |
| EU_JOIN_DATE | DATE | - | NULL | - | Date country joined EU |
| CURRENCY_CODE | CHAR | 3 | NULL | - | ISO 4217 currency code |
| CURRENCY_NAME | VARCHAR | 50 | NULL | - | Currency name |
| CREATED_AT | TIMESTAMP | - | NOT NULL | DEFAULT | Record creation timestamp |
| UPDATED_AT | TIMESTAMP | - | NOT NULL | DEFAULT | Last update timestamp |

### Constraints
- **Primary Key**: COUNTRY_CODE (ISO 3166-1 alpha-2)
- **Check Constraint**: EU_MEMBER IN ('Y', 'N')
- **Default Values**: CREATED_AT and UPDATED_AT use CURRENT_TIMESTAMP

### Indexes
- **IDX_SAMPLEDB_NAME**: Index on COUNTRY_NAME for name searches
- **IDX_SAMPLEDB_REGION**: Index on REGION for regional queries
- **IDX_SAMPLEDB_EU**: Index on EU_MEMBER for EU membership filtering

### Geographic Regions
- Northern Europe (Scandinavia, Baltic states)
- Western Europe (UK, France, Germany, Benelux)
- Southern Europe (Mediterranean countries)
- Eastern Europe (Former Eastern Bloc)
- Central Europe (Austria, Switzerland, Czech Republic)

## Features
- ISO 3166-1 alpha-2 country codes (international standard)
- Bilingual country names (English and local language)
- Complete geographic and demographic data
- EU membership tracking with join dates
- ISO 4217 currency codes and names
- Audit timestamps for data tracking
- Multiple indexes for query optimization
- Summary view for reporting (V_SAMPLEDB_SUMMARY)
- Check constraint for data validation
- Complete European country dataset

## Usage Examples

### Read Operations

#### Get All Countries
```sql
SELECT * FROM SAMPLEDB
ORDER BY COUNTRY_NAME;
```

#### Get EU Member Countries
```sql
SELECT COUNTRY_CODE, COUNTRY_NAME, EU_JOIN_DATE, CURRENCY_CODE
FROM SAMPLEDB
WHERE EU_MEMBER = 'Y'
ORDER BY EU_JOIN_DATE;
```

#### Get Countries by Region
```sql
SELECT COUNTRY_NAME, CAPITAL_CITY, POPULATION
FROM SAMPLEDB
WHERE REGION = 'Western Europe'
ORDER BY POPULATION DESC;
```

#### Get Countries Using Euro
```sql
SELECT COUNTRY_CODE, COUNTRY_NAME, EU_JOIN_DATE
FROM SAMPLEDB
WHERE CURRENCY_CODE = 'EUR'
ORDER BY COUNTRY_NAME;
```

#### Get Largest Countries by Area
```sql
SELECT COUNTRY_NAME, AREA_KM2, POPULATION
FROM SAMPLEDB
ORDER BY AREA_KM2 DESC
FETCH FIRST 10 ROWS ONLY;
```

#### Get Most Populous Countries
```sql
SELECT COUNTRY_NAME, POPULATION, CAPITAL_CITY
FROM SAMPLEDB
ORDER BY POPULATION DESC
FETCH FIRST 10 ROWS ONLY;
```

#### Search by Country Name
```sql
SELECT * FROM SAMPLEDB
WHERE COUNTRY_NAME LIKE '%land%'
ORDER BY COUNTRY_NAME;
```

### Create Operations

#### Insert New Country
```sql
INSERT INTO SAMPLEDB (
  COUNTRY_CODE, COUNTRY_NAME, COUNTRY_NAME_LOCAL,
  CAPITAL_CITY, REGION, POPULATION, AREA_KM2,
  EU_MEMBER, EU_JOIN_DATE, CURRENCY_CODE, CURRENCY_NAME
) VALUES (
  'XX', 'Example Country', 'País Ejemplo',
  'Example City', 'Western Europe', 10000000, 50000.00,
  'N', NULL, 'XXX', 'Example Currency'
);
```

### Update Operations

#### Update Population
```sql
UPDATE SAMPLEDB
SET POPULATION = 67500000,
    UPDATED_AT = CURRENT_TIMESTAMP
WHERE COUNTRY_CODE = 'FR';
```

#### Update EU Membership
```sql
UPDATE SAMPLEDB
SET EU_MEMBER = 'Y',
    EU_JOIN_DATE = '2026-01-01',
    UPDATED_AT = CURRENT_TIMESTAMP
WHERE COUNTRY_CODE = 'XX';
```

#### Update Currency Information
```sql
UPDATE SAMPLEDB
SET CURRENCY_CODE = 'EUR',
    CURRENCY_NAME = 'Euro',
    UPDATED_AT = CURRENT_TIMESTAMP
WHERE COUNTRY_CODE = 'XX';
```

### Delete Operations

#### Delete Specific Country
```sql
DELETE FROM SAMPLEDB
WHERE COUNTRY_CODE = 'XX';
```

## Advanced Queries

### EU vs Non-EU Statistics
```sql
SELECT 
  EU_MEMBER,
  COUNT(*) AS COUNTRY_COUNT,
  SUM(POPULATION) AS TOTAL_POPULATION,
  SUM(AREA_KM2) AS TOTAL_AREA,
  AVG(POPULATION) AS AVG_POPULATION
FROM SAMPLEDB
GROUP BY EU_MEMBER;
```

### Regional Statistics
```sql
SELECT 
  REGION,
  COUNT(*) AS COUNTRY_COUNT,
  SUM(POPULATION) AS TOTAL_POPULATION,
  AVG(POPULATION) AS AVG_POPULATION,
  SUM(AREA_KM2) AS TOTAL_AREA,
  COUNT(CASE WHEN EU_MEMBER = 'Y' THEN 1 END) AS EU_MEMBERS
FROM SAMPLEDB
GROUP BY REGION
ORDER BY TOTAL_POPULATION DESC;
```

### Currency Usage
```sql
SELECT 
  CURRENCY_CODE,
  CURRENCY_NAME,
  COUNT(*) AS COUNTRY_COUNT,
  SUM(POPULATION) AS TOTAL_POPULATION
FROM SAMPLEDB
GROUP BY CURRENCY_CODE, CURRENCY_NAME
ORDER BY COUNTRY_COUNT DESC;
```

### Population Density
```sql
SELECT 
  COUNTRY_NAME,
  POPULATION,
  AREA_KM2,
  ROUND(POPULATION / AREA_KM2, 2) AS POPULATION_DENSITY
FROM SAMPLEDB
WHERE AREA_KM2 > 0
ORDER BY POPULATION_DENSITY DESC;
```

### EU Expansion Timeline
```sql
SELECT 
  YEAR(EU_JOIN_DATE) AS JOIN_YEAR,
  COUNT(*) AS COUNTRIES_JOINED,
  LISTAGG(COUNTRY_NAME, ', ') WITHIN GROUP (ORDER BY COUNTRY_NAME) AS COUNTRIES
FROM SAMPLEDB
WHERE EU_MEMBER = 'Y'
  AND EU_JOIN_DATE IS NOT NULL
GROUP BY YEAR(EU_JOIN_DATE)
ORDER BY JOIN_YEAR;
```

### Countries by Size Category
```sql
SELECT 
  CASE 
    WHEN AREA_KM2 < 10000 THEN 'Small'
    WHEN AREA_KM2 < 100000 THEN 'Medium'
    WHEN AREA_KM2 < 500000 THEN 'Large'
    ELSE 'Very Large'
  END AS SIZE_CATEGORY,
  COUNT(*) AS COUNTRY_COUNT,
  AVG(POPULATION) AS AVG_POPULATION
FROM SAMPLEDB
GROUP BY 
  CASE 
    WHEN AREA_KM2 < 10000 THEN 'Small'
    WHEN AREA_KM2 < 100000 THEN 'Medium'
    WHEN AREA_KM2 < 500000 THEN 'Large'
    ELSE 'Very Large'
  END
ORDER BY 
  CASE SIZE_CATEGORY
    WHEN 'Small' THEN 1
    WHEN 'Medium' THEN 2
    WHEN 'Large' THEN 3
    ELSE 4
  END;
```

### Recently Updated Records
```sql
SELECT COUNTRY_NAME, UPDATED_AT
FROM SAMPLEDB
ORDER BY UPDATED_AT DESC
FETCH FIRST 10 ROWS ONLY;
```

## RPGLE Integration Example

```rpgle
**FREE

dcl-s countryCode char(2);
dcl-s countryName varchar(100);
dcl-s capitalCity varchar(100);
dcl-s region varchar(50);
dcl-s population packed(20:0);
dcl-s euMember char(1);
dcl-s currencyCode char(3);

// Query EU member countries
exec sql DECLARE C1 CURSOR FOR
  SELECT COUNTRY_CODE, COUNTRY_NAME, CAPITAL_CITY, 
         REGION, POPULATION, CURRENCY_CODE
  FROM SAMPLEDB
  WHERE EU_MEMBER = 'Y'
  ORDER BY COUNTRY_NAME;

exec sql OPEN C1;

dow sqlstate = '00000';
  exec sql FETCH C1 INTO :countryCode, :countryName, :capitalCity,
                         :region, :population, :currencyCode;
  if sqlstate = '00000';
    // Process country data
  endif;
enddo;

exec sql CLOSE C1;

// Get specific country
exec sql SELECT COUNTRY_NAME, CAPITAL_CITY, POPULATION
         INTO :countryName, :capitalCity, :population
         FROM SAMPLEDB
         WHERE COUNTRY_CODE = :countryCode;

if sqlstate = '00000';
  // Country found
else;
  // Country not found
endif;
```

## CL Integration Example

```cl
PGM

DCL VAR(&CTRYCODE) TYPE(*CHAR) LEN(2)
DCL VAR(&CTRYNAME) TYPE(*CHAR) LEN(100)
DCL VAR(&POPULATION) TYPE(*DEC) LEN(20 0)

/* Query country information */
RUNSQL SQL('SELECT COUNTRY_NAME, POPULATION +
            FROM SAMPLEDB +
            WHERE COUNTRY_CODE = ''DE''') +
       COMMIT(*NONE)

/* Get EU member count */
RUNSQL SQL('SELECT COUNT(*) +
            FROM SAMPLEDB +
            WHERE EU_MEMBER = ''Y''') +
       COMMIT(*NONE)

/* Update population */
RUNSQL SQL('UPDATE SAMPLEDB +
            SET POPULATION = 83000000, +
                UPDATED_AT = CURRENT_TIMESTAMP +
            WHERE COUNTRY_CODE = ''DE''') +
       COMMIT(*NONE)

ENDPGM
```

## Summary View

### V_SAMPLEDB_SUMMARY
The table includes a summary view for reporting:

```sql
CREATE VIEW V_SAMPLEDB_SUMMARY AS
SELECT 
  REGION,
  COUNT(*) AS COUNTRY_COUNT,
  SUM(POPULATION) AS TOTAL_POPULATION,
  AVG(POPULATION) AS AVG_POPULATION,
  SUM(AREA_KM2) AS TOTAL_AREA,
  COUNT(CASE WHEN EU_MEMBER = 'Y' THEN 1 END) AS EU_MEMBER_COUNT,
  COUNT(DISTINCT CURRENCY_CODE) AS CURRENCY_COUNT
FROM SAMPLEDB
GROUP BY REGION;
```

Usage:
```sql
SELECT * FROM V_SAMPLEDB_SUMMARY
ORDER BY TOTAL_POPULATION DESC;
```

## Best Practices

### Country Code Management
- Always use ISO 3166-1 alpha-2 codes (2 characters)
- Uppercase codes only (DE, FR, GB, etc.)
- Never modify country codes after creation
- Reference ISO standard for new countries

### Data Maintenance
- Update UPDATED_AT timestamp on every change
- Keep population data current (annual updates)
- Verify EU membership status changes
- Maintain both English and local names
- Document data sources

### Currency Handling
- Use ISO 4217 currency codes (3 characters)
- Update when countries change currencies
- Track Euro adoption dates
- Consider historical currency data

### Performance
- Use indexed columns in WHERE clauses
- COUNTRY_CODE is primary key (fastest access)
- Use REGION index for regional queries
- Use EU_MEMBER index for membership filtering
- Consider materialized views for complex reports

## Potential Enhancements

### Additional Columns
```sql
ALTER TABLE SAMPLEDB ADD COLUMN PHONE_CODE VARCHAR(10);
ALTER TABLE SAMPLEDB ADD COLUMN INTERNET_TLD VARCHAR(10);
ALTER TABLE SAMPLEDB ADD COLUMN LANGUAGES VARCHAR(200);
ALTER TABLE SAMPLEDB ADD COLUMN GDP_USD DECIMAL(15,2);
ALTER TABLE SAMPLEDB ADD COLUMN GDP_PER_CAPITA DECIMAL(10,2);
ALTER TABLE SAMPLEDB ADD COLUMN TIMEZONE VARCHAR(50);
ALTER TABLE SAMPLEDB ADD COLUMN CONTINENT VARCHAR(20) DEFAULT 'Europe';
ALTER TABLE SAMPLEDB ADD COLUMN ISO3_CODE CHAR(3);
ALTER TABLE SAMPLEDB ADD COLUMN NUMERIC_CODE CHAR(3);
ALTER TABLE SAMPLEDB ADD COLUMN FLAG_URL VARCHAR(200);
```

### Add More Constraints
```sql
ALTER TABLE SAMPLEDB 
ADD CONSTRAINT CHK_POPULATION CHECK (POPULATION >= 0);

ALTER TABLE SAMPLEDB
ADD CONSTRAINT CHK_AREA CHECK (AREA_KM2 >= 0);

ALTER TABLE SAMPLEDB
ADD CONSTRAINT CHK_COUNTRY_CODE CHECK (
  LENGTH(TRIM(COUNTRY_CODE)) = 2
);

ALTER TABLE SAMPLEDB
ADD CONSTRAINT CHK_CURRENCY_CODE CHECK (
  LENGTH(TRIM(CURRENCY_CODE)) = 3
);
```

### Create Additional Indexes
```sql
CREATE INDEX IDX_SAMPLEDB_CAPITAL ON SAMPLEDB(CAPITAL_CITY);
CREATE INDEX IDX_SAMPLEDB_CURRENCY ON SAMPLEDB(CURRENCY_CODE);
CREATE INDEX IDX_SAMPLEDB_POPULATION ON SAMPLEDB(POPULATION);
```

### Create Additional Views
```sql
-- View for EU members only
CREATE VIEW V_EU_MEMBERS AS
SELECT * FROM SAMPLEDB
WHERE EU_MEMBER = 'Y';

-- View for Eurozone countries
CREATE VIEW V_EUROZONE AS
SELECT * FROM SAMPLEDB
WHERE CURRENCY_CODE = 'EUR';

-- View with calculated fields
CREATE VIEW V_COUNTRY_STATS AS
SELECT 
  COUNTRY_CODE,
  COUNTRY_NAME,
  POPULATION,
  AREA_KM2,
  CASE WHEN AREA_KM2 > 0 
    THEN ROUND(POPULATION / AREA_KM2, 2) 
    ELSE 0 
  END AS POPULATION_DENSITY,
  EU_MEMBER,
  CURRENCY_CODE
FROM SAMPLEDB;
```

## Related Tables

### Suggested Related Tables
```sql
-- Country languages
CREATE TABLE COUNTRY_LANGUAGES (
  COUNTRY_CODE CHAR(2) NOT NULL,
  LANGUAGE_CODE CHAR(3) NOT NULL,
  LANGUAGE_NAME VARCHAR(50),
  IS_OFFICIAL CHAR(1) CHECK (IS_OFFICIAL IN ('Y', 'N')),
  PRIMARY KEY (COUNTRY_CODE, LANGUAGE_CODE),
  FOREIGN KEY (COUNTRY_CODE) REFERENCES SAMPLEDB(COUNTRY_CODE)
);

-- Historical population data
CREATE TABLE POPULATION_HISTORY (
  COUNTRY_CODE CHAR(2) NOT NULL,
  YEAR INTEGER NOT NULL,
  POPULATION BIGINT,
  PRIMARY KEY (COUNTRY_CODE, YEAR),
  FOREIGN KEY (COUNTRY_CODE) REFERENCES SAMPLEDB(COUNTRY_CODE)
);

-- Country borders
CREATE TABLE COUNTRY_BORDERS (
  COUNTRY_CODE CHAR(2) NOT NULL,
  BORDER_COUNTRY_CODE CHAR(2) NOT NULL,
  BORDER_LENGTH_KM DECIMAL(10,2),
  PRIMARY KEY (COUNTRY_CODE, BORDER_COUNTRY_CODE),
  FOREIGN KEY (COUNTRY_CODE) REFERENCES SAMPLEDB(COUNTRY_CODE),
  FOREIGN KEY (BORDER_COUNTRY_CODE) REFERENCES SAMPLEDB(COUNTRY_CODE)
);
```

## Data Sources and Standards
- **ISO 3166-1**: Country codes (https://www.iso.org/iso-3166-country-codes.html)
- **ISO 4217**: Currency codes (https://www.iso.org/iso-4217-currency-codes.html)
- **EU Official**: EU membership data (https://europa.eu)
- **UN Data**: Population and area statistics
- **World Bank**: Economic data

## References
- IBM i SQL Reference: https://www.ibm.com/docs/en/i/7.5?topic=reference-sql
- ISO 3166-1: https://www.iso.org/iso-3166-country-codes.html
- ISO 4217: https://www.iso.org/iso-4217-currency-codes.html

---
*This table is part of the IBM i code samples repository demonstrating country reference data and geographic information management.*