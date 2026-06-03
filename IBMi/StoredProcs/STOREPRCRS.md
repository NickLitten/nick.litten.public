# STOREPRCRS - Stored Procedure with Result Set

## Overview
STOREPRCRS demonstrates how to create an IBM i SQL stored procedure that returns multiple rows using result sets. This is the standard approach for returning dynamic result sets to calling applications, allowing clients to fetch an unlimited number of rows.

## Purpose
- Demonstrate SQL stored procedure with result set return
- Show how to use DECLARE CURSOR for result sets
- Illustrate OPEN cursor with RETURN TO CALLER
- Enable multiple row retrieval capability
- Provide parameter-based filtering examples

## Key Features
- **Result Set Return**: Returns multiple rows via SQL result set
- **Dynamic Row Count**: No limitation on number of rows returned
- **Cursor-Based**: Uses SQL cursor to define result set
- **Parameter Filtering**: Accepts department code as search criteria
- **Efficient Processing**: Set-based SQL operations
- **Standard Interface**: Compatible with JDBC, ODBC, and SQL clients
- **PCML Generation**: Automatic interface documentation

## Technical Details

### Result Set Pattern
```rpgle
// 1. Declare cursor for result set
exec sql
     declare c1 cursor for
     select columns...
     from table
     where condition;

// 2. Open cursor (leaves it open for caller)
exec sql
     open c1;

// 3. Tell SQL this procedure returns result sets
exec sql
     set result sets cursor c1;
```

### Parameters
- **dept_code_in**: char(10) const - Department code to filter employees

### Result Set Columns
- **emp_id**: int(10) - Employee ID
- **emp_name**: char(50) - Employee name
- **city**: char(30) - Employee city
- **salary**: dec(11,2) - Employee salary

## Usage

### SQL Call
```sql
-- Call the stored procedure
CALL NICKLITTEN.STOREPRCRS('SALES');

-- Result set is automatically returned
-- Fetch rows using SQL client
```

### JDBC Example
```java
Connection conn = DriverManager.getConnection(url, user, password);
CallableStatement cs = conn.prepareCall("CALL NICKLITTEN.STOREPRCRS(?)");
cs.setString(1, "SALES");

// Execute and get result set
ResultSet rs = cs.executeQuery();

while (rs.next()) {
    int empId = rs.getInt("emp_id");
    String empName = rs.getString("emp_name");
    String city = rs.getString("emp_city");
    BigDecimal salary = rs.getBigDecimal("salary");
    
    System.out.println(empId + ": " + empName + " - " + city);
}

rs.close();
cs.close();
```

### ODBC Example (Python)
```python
import pyodbc

conn = pyodbc.connect('DSN=myibmi;UID=user;PWD=password')
cursor = conn.cursor()

# Call stored procedure
cursor.execute("CALL NICKLITTEN.STOREPRCRS(?)", 'SALES')

# Fetch all rows from result set
for row in cursor.fetchall():
    print(f"{row.emp_id}: {row.emp_name} - {row.city}")

cursor.close()
conn.close()
```

### Node.js Example (odbc)
```javascript
const odbc = require('odbc');

async function callStoredProc() {
    const connection = await odbc.connect('DSN=myibmi;UID=user;PWD=password');
    
    const result = await connection.query(
        'CALL NICKLITTEN.STOREPRCRS(?)',
        ['SALES']
    );
    
    result.forEach(row => {
        console.log(`${row.EMP_ID}: ${row.EMP_NAME} - ${row.CITY}`);
    });
    
    await connection.close();
}
```

## Compilation

### Using CRTSQLRPGI
```
CRTSQLRPGI OBJ(NICKLITTEN/STOREPRCRS) +
  SRCSTMF('/home/nicklitten/source/storeprcrs.sqlrpgle') +
  COMMIT(*NONE) OBJTYPE(*PGM) DBGVIEW(*SOURCE) +
  CLOSQLCSR(*ENDACTGRP)
```

### Register as SQL Stored Procedure
```sql
CREATE OR REPLACE PROCEDURE NICKLITTEN.STOREPRCRS (
    IN DEPT_CODE CHAR(10)
)
DYNAMIC RESULT SETS 1
LANGUAGE RPGLE
SPECIFIC STOREPRCRS
NOT DETERMINISTIC
MODIFIES SQL DATA
CALLED ON NULL INPUT
EXTERNAL NAME NICKLITTEN.STOREPRCRS
PARAMETER STYLE GENERAL;
```

### Using GNU Make (TOBi/MAKEI)
```bash
make STOREPRCRS
```

## Example Output

### Input
```sql
CALL NICKLITTEN.STOREPRCRS('SALES');
```

### Result Set
```
EMP_ID  EMP_NAME           CITY            SALARY
------  -----------------  --------------  ----------
101     Alice Johnson      New York        75000.00
102     Bob Smith          Chicago         68000.00
103     Carol Williams     Los Angeles     72000.00
```

## Multiple Result Sets

To return multiple result sets, declare and open multiple cursors:

```rpgle
Dcl-Proc mainline;
   Dcl-Pi *n;
      dept_code_in char(10) const;
   end-pi;

   // First result set - employees
   exec sql
        declare c1 cursor for
        select emp_id, emp_name, salary
        from nicklitten/employee_master
        where dept_code = :dept_code_in;

   // Second result set - department summary
   exec sql
        declare c2 cursor for
        select dept_code, count(*) as emp_count, avg(salary) as avg_salary
        from nicklitten/employee_master
        where dept_code = :dept_code_in
        group by dept_code;

   exec sql open c1;
   exec sql open c2;

   // Return both result sets
   exec sql set result sets cursor c1, cursor c2;

   Return;
end-proc;
```

## Best Practices Demonstrated

1. **Cursor Declaration**: Declare cursor before opening
2. **Parameter Usage**: Use host variables in WHERE clause
3. **Result Set Registration**: Use SET RESULT SETS to declare cursors
4. **Ordering**: Include ORDER BY for predictable results
5. **Error Handling**: SQL handles cursor errors automatically
6. **Resource Management**: Cursor closed automatically when procedure ends
7. **PCML Generation**: Enables external program calls

## Common Use Cases

- **Web Services**: Return data to REST APIs
- **Report Generation**: Provide data for reporting tools
- **Data Export**: Export filtered data to external systems
- **Dashboard Queries**: Supply data for business intelligence tools
- **Batch Processing**: Return sets of records for processing
- **Integration**: Interface with Java, .NET, Python applications

## Advantages Over Output Parameters

### Result Sets
- ✅ Return unlimited rows
- ✅ Dynamic column count
- ✅ Standard SQL interface
- ✅ Efficient memory usage
- ✅ Compatible with all SQL clients
- ✅ Supports complex queries

### Output Parameters
- ❌ Limited to single row
- ❌ Fixed column count
- ❌ Requires array handling for multiple rows
- ❌ More complex client code
- ❌ Memory limitations

## Performance Considerations

- **Cursor Overhead**: Minimal - cursors are efficient
- **Memory Usage**: Rows fetched on demand, not all at once
- **Network Traffic**: Only requested rows are transmitted
- **Indexing**: Ensure WHERE clause columns are indexed
- **Result Set Size**: Consider pagination for very large sets
- **Connection Pooling**: Reuse connections for better performance

## Troubleshooting

### No Rows Returned
- Verify department code exists in table
- Check WHERE clause logic
- Ensure table has data
- Review SQL error messages

### Cursor Not Found
- Verify cursor is declared before OPEN
- Check cursor name matches in SET RESULT SETS
- Ensure OPEN statement executed successfully

### Connection Issues
- Verify SQL connection is active
- Check user has authority to table
- Ensure library is in library list
- Review commitment control settings

### PCML Generation Failed
- Verify pgminfo(*pcml:*module) in ctl-opt
- Check parameter definitions are valid
- Ensure compilation completed successfully

## Related Examples

- **STOREPRCS**: Simple stored procedure with output parameters
- **STOREPRCR**: Stored procedure with RPG file I/O
- **SQL Cursors**: Other cursor processing examples
- **Result Set Pagination**: Examples with LIMIT/OFFSET

## Notes

- Result sets are automatically closed when procedure ends
- Multiple result sets can be returned (up to 256)
- Cursor must remain open when procedure returns
- SET RESULT SETS must be called before RETURN
- Compatible with all SQL clients (JDBC, ODBC, .NET, etc.)
- PCML enables calls from Java and other languages
- actgrp(*new) ensures clean activation group per call

## Security Considerations

- **SQL Injection**: Use parameter markers, not string concatenation
- **Authority**: Caller needs SELECT authority on tables
- **Adopted Authority**: Consider using USRPRF(*OWNER) if needed
- **Data Filtering**: Implement row-level security if required
- **Audit Logging**: Consider logging procedure calls

## Advanced Features

### Dynamic SQL in Result Sets
```rpgle
Dcl-S sqlStmt varchar(1000);

sqlStmt = 'SELECT * FROM nicklitten/employee_master WHERE dept_code = ?';

exec sql
     prepare stmt1 from :sqlStmt;

exec sql
     declare c1 cursor for stmt1;

exec sql
     open c1 using :dept_code_in;

exec sql
     set result sets cursor c1;
```

### Conditional Result Sets
```rpgle
If (include_details = 'Y');
   exec sql open c1;  // Detailed result set
   exec sql set result sets cursor c1;
Else;
   exec sql open c2;  // Summary result set
   exec sql set result sets cursor c2;
EndIf;
```

## Author
Nick Litten

## Version History
- **V1.0** (2026-06-03): Initial creation

## License
This code is provided as an educational example for IBM i developers.