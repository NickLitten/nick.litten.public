-- --------------------------------------------------------------------------
-- Script: ENCRYPTHNT-Get_Hint.sql
-- Purpose: Retrieves encryption hint from encrypted field
-- Author: Nick Litten
-- --------------------------------------------------------------------------
-- Description:
--   Demonstrates the GETHINT function to retrieve the encryption hint
--   stored with an encrypted field. Hints can assist with password
--   recovery without exposing the actual password.
--
-- Usage:
--   Run after ENCRYPTSQL-Create_Encrypted_Stuff.sql to see encryption hints
--   Modify field name to check hints for different encrypted columns
--
-- Reference:
--   - IBM i SQL Reference - GETHINT function
--   - https://www.nicklitten.com/ibm-i-sql-encryption/
-- --------------------------------------------------------------------------
SELECT
  GETHINT(SSN_ENCRYPTED)
FROM
  NICKLITTEN.CUSTENC
FETCH FIRST
  1 ROW ONLY;