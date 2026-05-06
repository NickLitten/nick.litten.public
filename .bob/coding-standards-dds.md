# IBM i DDS (Data Description Specifications) Coding Standards
## Nick Litten Project - Modern DDS Best Practices

---

## 1. File Header Documentation

### Physical Files (PF)
Use asterisk (*) in position 7 for comments:

```
     A*-------------------------------------------------------------------------
     A* File: FILENAME - Brief Description
     A* Description: Comprehensive explanation of what this file contains
     A*              and its purpose in the application.
     A*
     A* Purpose:
     A*   - Primary data storage for [entity]
     A*   - Key access path definition
     A*   - Data validation rules
     A*
     A* Features:
     A*   - Unique key on [field]
     A*   - Foreign key to [parent file]
     A*   - Audit fields included
     A*
     A* Key Fields:
     A*   - CUSTID (Primary Key)
     A*   - ORDERID (Secondary Key)
     A*
     A* Indexes:
     A*   - CUSTIDX - Customer ID index
     A*   - ORDIDX - Order ID index
     A*
     A* Compilation:
     A*   CRTPF FILE(LIB/FILENAME) SRCFILE(LIB/QDDSSRC)
     A*
     A* Author: Nick Litten
     A*
     A* Modification History:
     A* v.001 YYYY.MM.DD - Nick Litten - Initial creation
     A* v.002 YYYY.MM.DD - Nick Litten - Added audit fields
     A*-------------------------------------------------------------------------
     A                                      UNIQUE
     A          R RECORDFMT
```

### Logical Files (LF)
```
     A*-------------------------------------------------------------------------
     A* File: FILENAME - Brief Description
     A* Description: Logical view over [physical file] providing
     A*              [specific access path or selection].
     A*
     A* Purpose:
     A*   - Provide keyed access by [field]
     A*   - Select only [criteria]
     A*   - Join [file1] with [file2]
     A*
     A* Based On:
     A*   - Physical File: PHYSFILE
     A*   - Format: RECORDFMT
     A*
     A* Key Fields:
     A*   - FIELD1 (Ascending)
     A*   - FIELD2 (Descending)
     A*
     A* Selection:
     A*   - STATUS = 'A' (Active records only)
     A*
     A* Compilation:
     A*   CRTLF FILE(LIB/FILENAME) SRCFILE(LIB/QDDSSRC)
     A*
     A* Author: Nick Litten
     A*
     A* Modification History:
     A* v.001 YYYY.MM.DD - Nick Litten - Initial creation
     A*-------------------------------------------------------------------------
     A          R RECORDFMT                 PFILE(PHYSFILE)
```

### Display Files (DSPF)
```
     A*-------------------------------------------------------------------------
     A* File: FILENAME - Brief Description
     A* Description: Display file for [screen purpose]
     A*
     A* Purpose:
     A*   - User interface for [function]
     A*   - Data entry screen
     A*   - Inquiry display
     A*
     A* Features:
     A*   - Subfile for list display
     A*   - Function key support (F3=Exit, F12=Cancel)
     A*   - Field validation
     A*   - Help text available
     A*
     A* Record Formats:
     A*   - HEADER - Screen header information
     A*   - DETAIL - Detail entry/display
     A*   - FOOTER - Function key legend
     A*   - SFLCTL - Subfile control
     A*   - SFLDTA - Subfile data
     A*
     A* Compilation:
     A*   CRTDSPF FILE(LIB/FILENAME) SRCFILE(LIB/QDDSSRC)
     A*
     A* Author: Nick Litten
     A*
     A* Modification History:
     A* v.001 YYYY.MM.DD - Nick Litten - Initial creation
     A*-------------------------------------------------------------------------
     A                                      DSPSIZ(24 80 *DS3)
     A                                      PRINT
     A                                      INDARA
     A                                      ERRSFL
```

---

## 2. Field Documentation

### Field Definition Standards
```
     A*-------------------------------------------------------------------------
     A* Field Definitions
     A*-------------------------------------------------------------------------
     A* CUSTID    - Customer ID (Primary Key)
     A* CUSTNAME  - Customer Name
     A* CUSTSTATUS- Customer Status (A=Active, I=Inactive, H=Hold)
     A* CUSTBALANCE- Customer Balance
     A* CREATEDATE- Record Creation Date
     A* CREATETIME- Record Creation Time
     A* CREATEUSER- User who created record
     A* CHANGEDATE- Last Change Date
     A* CHANGETIME- Last Change Time
     A* CHANGEUSER- User who last changed record
     A*-------------------------------------------------------------------------
     A          R CUSTREC
     A            CUSTID        10A         COLHDG('Customer' 'ID')
     A                                      TEXT('Customer Identifier')
     A            CUSTNAME      50A         COLHDG('Customer' 'Name')
     A                                      TEXT('Customer Full Name')
     A            CUSTSTATUS     1A         COLHDG('Status')
     A                                      TEXT('Customer Status')
     A                                      VALUES('A' 'I' 'H')
     A            CUSTBALANCE   11P 2       COLHDG('Balance')
     A                                      TEXT('Customer Balance')
     A                                      EDTCDE(J)
```

---

## 3. Physical File Standards

### Basic Physical File
```
     A*-------------------------------------------------------------------------
     A* Physical File: CUSTOMER - Customer Master File
     A*-------------------------------------------------------------------------
     A                                      UNIQUE
     A          R CUSTREC                   TEXT('Customer Record')
     A*
     A*-------------------------------------------------------------------------
     A* Key Fields
     A*-------------------------------------------------------------------------
     A            CUSTID        10A         COLHDG('Customer' 'ID')
     A                                      TEXT('Customer Identifier')
     A*
     A*-------------------------------------------------------------------------
     A* Data Fields
     A*-------------------------------------------------------------------------
     A            CUSTNAME      50A         COLHDG('Customer' 'Name')
     A                                      TEXT('Customer Full Name')
     A            CUSTADDR1     50A         COLHDG('Address' 'Line 1')
     A                                      TEXT('Address Line 1')
     A            CUSTADDR2     50A         COLHDG('Address' 'Line 2')
     A                                      TEXT('Address Line 2')
     A            CUSTCITY      30A         COLHDG('City')
     A                                      TEXT('City')
     A            CUSTSTATE      2A         COLHDG('State')
     A                                      TEXT('State Code')
     A            CUSTZIP       10A         COLHDG('Zip' 'Code')
     A                                      TEXT('Zip/Postal Code')
     A            CUSTSTATUS     1A         COLHDG('Status')
     A                                      TEXT('Customer Status')
     A                                      VALUES('A' 'I' 'H')
     A            CUSTBALANCE   11P 2       COLHDG('Balance')
     A                                      TEXT('Customer Balance')
     A                                      EDTCDE(J)
     A*
     A*-------------------------------------------------------------------------
     A* Audit Fields
     A*-------------------------------------------------------------------------
     A            CREATEDATE     L         COLHDG('Created' 'Date')
     A                                      TEXT('Creation Date')
     A            CREATETIME     T         COLHDG('Created' 'Time')
     A                                      TEXT('Creation Time')
     A            CREATEUSER    10A         COLHDG('Created' 'By')
     A                                      TEXT('Creating User')
     A            CHANGEDATE     L         COLHDG('Changed' 'Date')
     A                                      TEXT('Last Change Date')
     A            CHANGETIME     T         COLHDG('Changed' 'Time')
     A                                      TEXT('Last Change Time')
     A            CHANGEUSER    10A         COLHDG('Changed' 'By')
     A                                      TEXT('Last Change User')
     A*
     A*-------------------------------------------------------------------------
     A* Key Specification
     A*-------------------------------------------------------------------------
     A          K CUSTID
```

### Physical File with Constraints
```
     A*-------------------------------------------------------------------------
     A* Physical File: ORDERS - Order Header File
     A*-------------------------------------------------------------------------
     A                                      UNIQUE
     A          R ORDREC                    TEXT('Order Record')
     A*
     A            ORDERID        9P 0       COLHDG('Order' 'Number')
     A                                      TEXT('Order Number')
     A            CUSTID        10A         COLHDG('Customer' 'ID')
     A                                      TEXT('Customer Identifier')
     A                                      REFFLD(CUSTID CUSTOMER)
     A            ORDERDATE      L         COLHDG('Order' 'Date')
     A                                      TEXT('Order Date')
     A            ORDERSTATUS    1A         COLHDG('Status')
     A                                      TEXT('Order Status')
     A                                      VALUES('N' 'P' 'S' 'C')
     A            ORDERTOTAL    11P 2       COLHDG('Order' 'Total')
     A                                      TEXT('Order Total Amount')
     A                                      EDTCDE(J)
     A*
     A          K ORDERID
```

---

## 4. Logical File Standards

### Simple Keyed Access
```
     A*-------------------------------------------------------------------------
     A* Logical File: CUSTNAMEL - Customer by Name
     A* Purpose: Provides access to customers sorted by name
     A*-------------------------------------------------------------------------
     A          R CUSTREC                   PFILE(CUSTOMER)
     A          K CUSTNAME
     A          K CUSTID
```

### Select/Omit Logical
```
     A*-------------------------------------------------------------------------
     A* Logical File: CUSTACTIVEL - Active Customers Only
     A* Purpose: Selects only active customers (STATUS = 'A')
     A*-------------------------------------------------------------------------
     A          R CUSTREC                   PFILE(CUSTOMER)
     A          S CUSTSTATUS                CMP(EQ 'A')
     A          K CUSTID
```

### Join Logical File
```
     A*-------------------------------------------------------------------------
     A* Logical File: ORDCUSTJ - Orders with Customer Information
     A* Purpose: Joins order and customer files for reporting
     A*-------------------------------------------------------------------------
     A          J                           JOIN(ORDERS CUSTOMER)
     A                                      JFLD(CUSTID CUSTID)
     A          R ORDJREC                   JFILE(ORDERS CUSTOMER)
     A            ORDERID                   JREF(1)
     A            ORDERDATE                 JREF(1)
     A            ORDERSTATUS               JREF(1)
     A            ORDERTOTAL                JREF(1)
     A            CUSTID                    JREF(2)
     A            CUSTNAME                  JREF(2)
     A            CUSTCITY                  JREF(2)
     A            CUSTSTATE                 JREF(2)
     A          K ORDERID
```

---

## 5. Display File Standards

### Basic Display Format
```
     A*-------------------------------------------------------------------------
     A* Display File: CUSTINQD - Customer Inquiry Display
     A*-------------------------------------------------------------------------
     A                                      DSPSIZ(24 80 *DS3)
     A                                      PRINT
     A                                      INDARA
     A*
     A*-------------------------------------------------------------------------
     A* Record Format: CUSTINQ - Customer Inquiry Screen
     A*-------------------------------------------------------------------------
     A          R CUSTINQ
     A*
     A*-------------------------------------------------------------------------
     A* Screen Header
     A*-------------------------------------------------------------------------
     A                                  1  2'Customer Inquiry'
     A                                      DSPATR(HI)
     A                                  1 70DATE
     A                                      EDTCDE(Y)
     A                                  2 70TIME
     A*
     A*-------------------------------------------------------------------------
     A* Input Fields
     A*-------------------------------------------------------------------------
     A                                  4  2'Customer ID . . . .'
     A            CUSTID        10A  B  4 25
     A*
     A*-------------------------------------------------------------------------
     A* Display Fields
     A*-------------------------------------------------------------------------
     A                                  6  2'Customer Name . . .'
     A            CUSTNAME      50A  O  6 25
     A                                  7  2'Address . . . . . .'
     A            CUSTADDR1     50A  O  7 25
     A            CUSTADDR2     50A  O  8 25
     A                                  9  2'City, State, Zip  .'
     A            CUSTCITY      30A  O  9 25
     A            CUSTSTATE      2A  O  9 57
     A            CUSTZIP       10A  O  9 60
     A                                 10  2'Status  . . . . . .'
     A            CUSTSTATUS     1A  O 10 25
     A                                 11  2'Balance . . . . . .'
     A            CUSTBALANCE   11Y 2O 11 25EDTCDE(J)
     A*
     A*-------------------------------------------------------------------------
     A* Function Keys
     A*-------------------------------------------------------------------------
     A                                 23  2'F3=Exit   F12=Cancel'
     A                                      COLOR(BLU)
     A  03                                  CF03(03 'Exit')
     A  12                                  CF12(12 'Cancel')
```

### Subfile Display
```
     A*-------------------------------------------------------------------------
     A* Display File: CUSTLSTD - Customer List Display with Subfile
     A*-------------------------------------------------------------------------
     A                                      DSPSIZ(24 80 *DS3)
     A                                      PRINT
     A                                      INDARA
     A                                      ERRSFL
     A*
     A*-------------------------------------------------------------------------
     A* Record Format: SFLCTL - Subfile Control
     A*-------------------------------------------------------------------------
     A          R SFLCTL                    SFLCTL(SFLDTA)
     A                                      SFLSIZ(9999)
     A                                      SFLPAG(0014)
     A  31                                  SFLDSP
     A  32                                  SFLDSPCTL
     A  33                                  SFLCLR
     A  34                                  SFLEND(*MORE)
     A*
     A*-------------------------------------------------------------------------
     A* Screen Header
     A*-------------------------------------------------------------------------
     A                                  1  2'Customer List'
     A                                      DSPATR(HI)
     A                                  1 70DATE
     A                                      EDTCDE(Y)
     A                                  2 70TIME
     A*
     A*-------------------------------------------------------------------------
     A* Subfile Header
     A*-------------------------------------------------------------------------
     A                                  4  2'Opt'
     A                                  4  7'Customer ID'
     A                                  4 19'Customer Name'
     A                                  4 55'Status'
     A                                  4 63'Balance'
     A*
     A*-------------------------------------------------------------------------
     A* Function Keys
     A*-------------------------------------------------------------------------
     A                                 23  2'F3=Exit   F5=Refresh   F12=Cancel'
     A                                      COLOR(BLU)
     A  03                                  CF03(03 'Exit')
     A  05                                  CF05(05 'Refresh')
     A  12                                  CF12(12 'Cancel')
     A*
     A*-------------------------------------------------------------------------
     A* Record Format: SFLDTA - Subfile Data
     A*-------------------------------------------------------------------------
     A          R SFLDTA                    SFL
     A            OPT            1A  B  5  2VALUES(' ' '2' '4' '5')
     A            CUSTID        10A  O  5  7
     A            CUSTNAME      30A  O  5 19
     A            CUSTSTATUS     1A  O  5 55
     A            CUSTBALANCE   11Y 2O  5 63EDTCDE(J)
     A  99                                  SFLNXTCHG
```

---

## 6. Naming Conventions

### File Names
- **Physical Files**: Descriptive, max 10 chars (e.g., `CUSTOMER`, `ORDERS`)
- **Logical Files**: Base name + L suffix (e.g., `CUSTOMERL`, `CUSTNAMEL`)
- **Display Files**: Base name + D suffix (e.g., `CUSTINQD`, `CUSTLSTD`)
- **Printer Files**: Base name + P suffix (e.g., `CUSTLSTP`, `INVOICEP`)

### Record Format Names
- **Physical Files**: Base name + REC (e.g., `CUSTREC`, `ORDREC`)
- **Logical Files**: Match physical or descriptive (e.g., `CUSTREC`, `ORDJREC`)
- **Display Files**: Descriptive of function (e.g., `CUSTINQ`, `SFLCTL`, `SFLDTA`)

### Field Names
- Descriptive, max 10 characters
- Prefix with file abbreviation for clarity (e.g., `CUSTID`, `CUSTNAME`)
- Use consistent suffixes:
  - `ID` for identifiers
  - `DATE` for dates
  - `TIME` for times
  - `USER` for user IDs
  - `STATUS` for status codes
  - `AMT` or `TOTAL` for amounts

---

## 7. Field Attributes

### Common Edit Codes
```
     A            AMOUNT        11P 2       EDTCDE(J)    /* Comma, decimal */
     A            QUANTITY       7P 0       EDTCDE(L)    /* Comma, no decimal */
     A            PERCENT        5P 2       EDTCDE(1)    /* Decimal only */
     A            PHONE         10A         EDTWRD('   -   -    ')
     A            SSN            9A         EDTWRD('   -  -    ')
     A            DATE           L         EDTCDE(Y)    /* MM/DD/YY */
```

### Field Validation
```
     A            STATUS         1A         VALUES('A' 'I' 'H')
     A            QUANTITY       7P 0       RANGE(1 9999999)
     A            PERCENT        5P 2       RANGE(0.00 100.00)
     A            CUSTID        10A         CHECK(ME)    /* Mandatory entry */
```

### Reference Fields
```
     A            CUSTID        10A         REFFLD(CUSTID CUSTOMER)
     A            ORDERID        9P 0       REFFLD(ORDERID ORDERS)
```

---

## 8. Display Attributes

### Color Coding
```
     A                                      COLOR(BLU)   /* Blue */
     A                                      COLOR(GRN)   /* Green */
     A                                      COLOR(RED)   /* Red */
     A                                      COLOR(WHT)   /* White */
     A                                      COLOR(YLW)   /* Yellow */
```

### Display Attributes
```
     A                                      DSPATR(HI)   /* High intensity */
     A                                      DSPATR(RI)   /* Reverse image */
     A                                      DSPATR(BL)   /* Blink */
     A                                      DSPATR(UL)   /* Underline */
     A                                      DSPATR(ND)   /* Non-display */
```

### Field Usage
```
     A            FIELD         10A  I      /* Input only */
     A            FIELD         10A  O      /* Output only */
     A            FIELD         10A  B      /* Both input and output */
     A            FIELD         10A  H      /* Hidden */
     A            FIELD         10A  M      /* Message field */
     A            FIELD         10A  P      /* Program-to-system */
```

---

## 9. Best Practices

### Always Include
- TEXT keyword for all fields and records
- COLHDG for all fields
- Audit fields (create/change date, time, user)
- Proper key specifications
- Field validation where appropriate

### Physical Files
- Use UNIQUE for files with unique keys
- Include TEXT descriptions
- Define proper field lengths
- Use appropriate data types
- Include audit trail fields

### Logical Files
- Keep simple and focused
- Use meaningful names
- Document selection criteria
- Specify key fields clearly

### Display Files
- Use INDARA for indicator area
- Include PRINT for print capability
- Use ERRSFL for error handling
- Provide clear field labels
- Include function key legend
- Use consistent screen layout

---

## 10. Version Control

### Modification History Format
```
     A* Modification History:
     A* v.001 2026.01.15 - Nick Litten - Initial creation
     A* v.002 2026.02.20 - Nick Litten - Added audit fields
     A* v.003 2026.03.10 - Nick Litten - Added status validation
```

---

## Summary Checklist

- [ ] Asterisk (*) comment documentation at file level
- [ ] Dash (-) separators only, never equals (=)
- [ ] Author: Nick Litten
- [ ] Comprehensive modification history
- [ ] TEXT keyword for all fields and records
- [ ] COLHDG for all fields
- [ ] Proper field naming conventions
- [ ] Appropriate data types and lengths
- [ ] Field validation where needed
- [ ] Audit fields included
- [ ] Clear key specifications
- [ ] Consistent formatting and indentation
- [ ] Function key support in display files
- [ ] Error handling in display files
- [ ] Meaningful record format names