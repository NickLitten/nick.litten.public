-- Create Input File for EBCDIC to ASCII Conversion Program
-- File: FILEIN & FILEOUT (Fixed-length 80 character table)
-- Author: Nick Litten
-- Created: 2026-03-25

-- Create FILEIN table with single 80-character fixed-length field
CREATE OR REPLACE TABLE
    FILEIN (RECORD CHAR(80) NOT NULL DEFAULT '')
    RCDFMT RFILEIN;

LABEL ON TABLE FILEIN IS 'EBCDIC Input File - 80 byte records';

LABEL ON COLUMN FILEIN.RECORD IS '80 character fixed length record';


-- Create FILEOUT table with single 80-character fixed-length field
CREATE OR REPLACE TABLE
    FILEOUT (RECORD CHAR(80) NOT NULL DEFAULT '')
    RCDFMT RFILEOUT;

LABEL ON TABLE FILEOUT IS 'ASCII Output File - 80 byte records';

LABEL ON COLUMN FILEOUT.RECORD IS '80 character fixed length record';