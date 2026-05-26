# SIMPCRUD - Simple CRUD Example for New RPG Programmers

## Overview

This is a complete, working example that demonstrates how to connect a **display file (screen)** to a **database table** in RPG. It's designed specifically for new programmers who are struggling to understand this fundamental connection.

## What This Example Teaches

1. **How to read data from a database table**
2. **How to display that data on a screen using a subfile**
3. **How to process user selections (CRUD operations)**
4. **How to update the database based on user actions**

## Files Included

### 1. RECIPES.table
The database table definition containing baking recipe information:
- Recipe ID (auto-generated)
- Recipe Name
- Category (Cookies, Bread, Pies, Cakes)
- Prep Time (in minutes)
- Servings
- Difficulty (Easy, Medium, Hard)

### 2. SIMPCRUD.dspf
The display file (screen layout) with:
- **Program Header** - Shows date, time, program name, user
- **Column Headers** - Labels for the data columns
- **Subfile** - The scrollable list of recipes
- **Function Key Footer** - Shows available function keys
- **Detail Screen** - For adding, changing, displaying, and deleting records

### 3. SIMPCRUD.pgm.rpgle
The RPG program that connects everything together. This is heavily commented to explain each step.

## The Key Connection: Database → Screen

The magic happens in the `LoadSubfile()` procedure:

```rpgle
// 1. Clear the subfile
SflClr = *on;
write SFLCTL;

// 2. Read records from database using SQL
exec sql declare C1 cursor for
  select RECIPEID, RECIPENAME, CATEGORY
  from RECIPES
  order by RECIPENAME;

exec sql open C1;
exec sql fetch next from C1 into :RECIPEID, :RECIPENAME, :CATEGORY;

// 3. Loop through database records
dow sqlcode = 0;
  RRN += 1;
  
  // 4. Write each database record to the subfile
  // THIS IS THE KEY STEP - database data becomes screen data!
  write SFLREC;
  
  exec sql fetch next from C1 into :RECIPEID, :RECIPENAME, :CATEGORY;
enddo;

// 5. Display the subfile
SflDsp = *on;
```

## How to Build and Run

### Step 1: Create the Database Table
```sql
-- Run the SQL in RECIPES.table to create the table and insert sample data
RUNSQLSTM SRCSTMF('/path/to/RECIPES.table')
```

Or use the IBM i SQL interface to run the CREATE TABLE and INSERT statements.

### Step 2: Create the Display File
```
CRTDSPF FILE(YOURLIB/SIMPCRUD) SRCSTMF('/path/to/SIMPCRUD.dspf')
```

### Step 3: Create the Program
```
CRTSQLRPGI OBJ(YOURLIB/SIMPCRUD) SRCSTMF('/path/to/SIMPCRUD.pgm.rpgle') +
           COMMIT(*NONE) DBGVIEW(*SOURCE)
```

### Step 4: Run the Program
```
CALL YOURLIB/SIMPCRUD
```

## Using the Program

### Main Screen (Subfile List)
- **F3** = Exit the program
- **F5** = Refresh the list (reload from database)
- **F6** = Add a new recipe
- **Option 2** = Change an existing recipe
- **Option 4** = Delete a recipe
- **Option 5** = Display recipe details (read-only)

### Detail Screen (Add/Change/Display/Delete)
- **F3** = Exit
- **F12** = Cancel and return to list
- **Enter** = Confirm the action

## Understanding the Flow

### 1. Program Starts
```
Main Loop → LoadSubfile() → DisplaySubfile() → ProcessSelections()
```

### 2. LoadSubfile() - THE CRITICAL PROCEDURE
This is where the database connects to the screen:
- Opens SQL cursor to read RECIPES table
- Loops through each database record
- Writes each record to the subfile (SFLREC)
- Sets indicators to display the subfile

### 3. DisplaySubfile()
- Sets header information (program name, user, date, time)
- Displays the subfile control record (SFLCTL)
- Waits for user input

### 4. ProcessSelections()
- Reads each subfile record
- Checks if user entered an option (2, 4, or 5)
- Calls appropriate procedure (Add, Change, Delete, Display)
- Updates database based on user action

## Key Concepts Explained

### Subfile Basics
A subfile is like a scrollable table on the screen:
- **SFLREC** = The individual row format (what each line looks like)
- **SFLCTL** = The control record (manages the entire subfile)
- **RRN** = Relative Record Number (which row we're on)

### Indicators
Indicators control display file behavior:
- **Indicator 31** (SflDsp) = Display the subfile
- **Indicator 32** (SflDspCtl) = Display subfile control
- **Indicator 33** (SflClr) = Clear the subfile
- **Indicator 34** (SflEnd) = More records indicator

### The Write Operation
```rpgle
write SFLREC;
```
This single line takes the data in your program variables (RECIPEID, RECIPENAME, CATEGORY) and writes them to the screen. This is the fundamental connection between database and display!

### The EXFMT Operation
```rpgle
exfmt SFLCTL;
```
EXFMT = Execute Format
- Writes the record to the screen
- Waits for user input
- Reads the user's response back into program variables

## Common Mistakes to Avoid

1. **Forgetting to clear the subfile** before loading
   - Always set SflClr = *on and write SFLCTL first

2. **Not setting display indicators** properly
   - Must set SflDsp and SflDspCtl to *on to see the subfile

3. **Forgetting to increment RRN**
   - Each subfile record needs a unique relative record number

4. **Not handling SQLCODE**
   - Always check SQLCODE after SQL operations

5. **Mixing up field names**
   - Display file field names must match program variable names

## Extending This Example

Once you understand this basic example, you can:
- Add search/filter functionality
- Implement sorting by different columns
- Add more fields to the detail screen
- Create relationships between tables
- Add data validation
- Implement security/authority checking

## Questions This Example Answers

**Q: How do I get database records to show on screen?**
A: Use SQL to read records, then write each one to a subfile using `write SFLREC`

**Q: What's the connection between the display file and the program?**
A: Field names in the display file must match variable names in the program

**Q: How do I make the screen interactive?**
A: Use EXFMT to display and wait for input, then process based on indicators and field values

**Q: How do I update the database from the screen?**
A: Read user input from screen fields, then use SQL UPDATE/INSERT/DELETE statements

## Additional Resources

- IBM i Knowledge Center: Display Files
- IBM i Knowledge Center: Subfiles
- IBM i Knowledge Center: Embedded SQL in RPG

## Support

This is a learning example. Study the comments in the code, experiment with changes, and use this as a foundation for your own programs.

---
**Created by:** IBM Bob  
**Fixed and Refined by:** Nick Litten  
**Purpose:** Educational example for new RPG programmers  
**License:** Free to use and modify