-- ---------------------------------------------------------------------------
-- SQL Table: RECIPIES
-- Description: Baking recipes table for CRUD operations demonstration
-- Author: Nick Litten
-- Created: 2026-05-14
-- ---------------------------------------------------------------------------
-- Purpose: Demonstrate recipe management and CRUD operations
--   - Store baking recipes with preparation details
--   - Track recipe difficulty and serving sizes
--   - Categorize recipes by type
--
-- Features:
--   - Auto-increment identity column for recipe ID
--   - Primary key constraint on RECID
--   - Default values for numeric fields
--   - 26 sample baking recipes included
--   - Category-based organization
--
-- Usage: Recipe management and CRUD demonstrations
--   SELECT * FROM RECIPIES WHERE DIFFICULTY = 'Easy';
--   INSERT INTO RECIPIES (RECNAME, CATEGORY, PREPTIME, SERVINGS, DIFFICULTY)
--     VALUES('New Recipe', 'Cakes', 45, 8, 'Medium');
--   UPDATE RECIPIES SET PREPTIME = 60 WHERE RECID = 1;
--
-- Columns:
--   - RECID: Auto-increment recipe identifier (primary key)
--   - RECNAME: Name of the recipe
--   - CATEGORY: Recipe category (Cookies, Bread, Cakes, Pies, Desserts)
--   - PREPTIME: Preparation time in minutes
--   - SERVINGS: Number of servings produced
--   - DIFFICULTY: Difficulty level (Easy, Medium, Hard)
--
-- Dependencies:
--   None
--
-- Reference:
--   https://www.ibm.com/docs/en/i/7.5?topic=reference-sql
--
-- Modification History:
--   1.0 2026-05-14 | Nick Litten | Initial creation with 26 sample recipes
-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------
-- Drop existing objects if they exist
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS RECIPIES;


-- ---------------------------------------------------------------------
-- Create table
-- ---------------------------------------------------------------------
CREATE OR REPLACE TABLE
    RECIPIES (
        RECID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
        RECNAME VARCHAR(50) NOT NULL
        WITH
            DEFAULT,
            CATEGORY VARCHAR(20) NOT NULL
        WITH
            DEFAULT,
            PREPTIME INTEGER NOT NULL
        WITH
            DEFAULT 0,
            SERVINGS INTEGER NOT NULL
        WITH
            DEFAULT 0,
            DIFFICULTY VARCHAR(10) NOT NULL
        WITH
            DEFAULT,
            CONSTRAINT REC_PK PRIMARY KEY (RECID)
    );


LABEL ON TABLE RECIPIES IS 'Baking Recipies';


LABEL ON COLUMN RECIPIES (
    RECID IS 'Recipie ID',
    RECNAME IS 'Recipie Name',
    CATEGORY IS 'Category',
    PREPTIME IS 'Prep Time (min)',
    SERVINGS IS 'Servings',
    DIFFICULTY IS 'Difficulty'
);


-- Insert sample data
INSERT INTO
    RECIPIES (RECNAME, CATEGORY, PREPTIME, SERVINGS, DIFFICULTY)
VALUES
    (
        'Chocolate Chip Cookies',
        'Cookies',
        30,
        24,
        'Easy'
    ),
    ('Banana Bread', 'Bread', 60, 8, 'Easy'),
    ('Apple Pie', 'Pies', 90, 8, 'Medium'),
    ('Vanilla Cupcakes', 'Cakes', 45, 12, 'Easy'),
    ('Sourdough Bread', 'Bread', 240, 1, 'Hard'),
    ('Chocolate Cake', 'Cakes', 50, 10, 'Medium'),
    ('Sugar Cookies', 'Cookies', 25, 36, 'Easy'),
    ('Blueberry Muffins', 'Breads', 35, 12, 'Easy'),
    ('Carrot Cake', 'Cakes', 55, 12, 'Medium'),
    (
        'Peanut Butter Cookies',
        'Cookies',
        20,
        24,
        'Easy'
    ),
    ('Croissants', 'Breads', 180, 8, 'Hard'),
    ('Lemon Bars', 'Desserts', 40, 16, 'Medium'),
    ('Tiramisu', 'Desserts', 30, 12, 'Medium'),
    ('Cheesecake', 'Cakes', 70, 8, 'Hard'),
    ('Brownies', 'Desserts', 35, 12, 'Easy'),
    ('Focaccia', 'Breads', 120, 4, 'Medium'),
    ('Macarons', 'Cookies', 90, 24, 'Hard'),
    ('Cinnamon Rolls', 'Breads', 150, 12, 'Medium'),
    ('Strawberry Shortcake', 'Cakes', 60, 8, 'Medium'),
    ('Donuts', 'Desserts', 45, 12, 'Hard'),
    ('Meringue Pie', 'Pies', 75, 8, 'Hard'),
    ('Shortbread', 'Cookies', 30, 20, 'Easy'),
    ('Eclairs', 'Desserts', 120, 12, 'Hard'),
    ('Pumpkin Pie', 'Pies', 85, 8, 'Medium'),
    ('Churros', 'Desserts', 40, 24, 'Medium'),
    ('Coconut Macaroons', 'Cookies', 20, 24, 'Easy');