-- ============================================================================
-- Script Name: SIMPLETBL-Super_Simple_file_with_NAME_ADDRESS.sql
-- Description: Populate SIMPLETBL with 100 celebrity and well-known people
-- Author: Nick Litten
-- Created: 2026-05-17
-- ============================================================================
-- Purpose:
--   - Insert 100 rows of sample data into SIMPLETBL
--   - Uses names of celebrities and well-known historical figures
--   - Provides realistic address data for testing
-- ============================================================================
set schema NICKLITTEN;

create or replace table SIMPLETBL (
      NAME char(50) not null,
      ADDRESS char(500) not null
    )
  rcdfmt RSIMPLE;

label on table SIMPLETBL is 'Simple file with name and address';

label on column SIMPLETBL (
  NAME is 'THIS IS THE NAME',
  ADDRESS is 'THIS IS THE ADDRESS'
);


