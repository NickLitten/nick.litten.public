# Embedded SQL Syntax Standards

## CRITICAL: Host Variable vs SQL Keyword Rules

### Host Variables (RPG Variables in SQL)
**ALWAYS use `:` prefix when referencing RPG variables in SQL statements:**

```rpgle
Exec SQL select * from mytable where id = :myRpgVariable;
Exec SQL fetch next from c1 into :myDataStructure;
Exec SQL insert into mytable values(:field1, :field2, :field3);
```

### SQL Keywords and Commands
**NEVER use `:` prefix with SQL keywords or commands:**

```rpgle
// CORRECT - No colon on SQL commands
Exec SQL open c1;
Exec SQL close c1;
Exec SQL fetch next from c1 into :variable;
Exec SQL declare c1 cursor for select * from mytable;
Exec SQL commit;
Exec SQL rollback;

// WRONG - Never add colon to SQL keywords
Exec SQL :open c1;        // WRONG
Exec SQL :close c1;       // WRONG
Exec SQL :fetch next;     // WRONG
Exec SQL :declare c1;     // WRONG
```

## Common SQL Commands (No Colon)
- `open` - Open a cursor
- `close` - Close a cursor
- `fetch` - Fetch rows from cursor
- `declare` - Declare a cursor
- `prepare` - Prepare a dynamic statement
- `execute` - Execute a prepared statement
- `commit` - Commit transaction
- `rollback` - Rollback transaction
- `connect` - Connect to database
- `disconnect` - Disconnect from database
- `set` - Set SQL options

## When to Use Colon
**Only use `:` when referencing:**
1. RPG variables in WHERE clauses: `where id = :rpgId`
2. RPG variables in SELECT lists: `select :rpgField from table`
3. RPG variables in INSERT/UPDATE: `insert into table values(:var1, :var2)`
4. RPG variables in FETCH INTO: `fetch next from c1 into :myDs`
5. Host variable indicators: `:variable:indicator`

## Pattern Recognition
If it's defined in your RPG code with `Dcl-S` or `Dcl-Ds`, it needs a colon in SQL.
If it's an SQL keyword from the SQL reference manual, it never gets a colon.

## Verification
Before using a colon, ask: "Is this an RPG variable or an SQL keyword?"
- RPG variable → use `:`
- SQL keyword → no `:`