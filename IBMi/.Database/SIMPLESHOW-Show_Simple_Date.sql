

-- Verify record count
select count(*) as RECORD_COUNT
  from SIMPLETBL;


-- Display first 10 records
select *
  from SIMPLETBL
  fetch first 10 rows only;