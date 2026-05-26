-- --------------------------------------------------------------------------
-- Script: ENCRYPTSQL-Create_Encrypted_Stuff.sql
-- Purpose: Demonstrates IBM i SQL encryption capabilities
-- Author: Nick Litten
-- --------------------------------------------------------------------------
-- Description:
--   Creates a customer table with encrypted fields demonstrating AES
--   encryption for sensitive data (SSN and credit card numbers).
--   Shows both encryption and decryption operations.
--
-- Features:
--   - AES encryption with password protection
--   - Encryption hints for password recovery assistance
--   - Side-by-side plain text comparison (for demo only)
--   - Immediate decryption verification
--
-- Security Notes:
--   - Plain text SSN field is for demonstration only - REMOVE in production
--   - Use strong, unique passwords for each encrypted field
--   - Store encryption passwords securely (not in source code)
--   - Consider using IBM i encryption key management
--
-- Usage:
--   Run this script to create and populate the encrypted customer table
--   Use ENCRYPTHNT-Get_Hint.sql to retrieve encryption hints
--   Use GETENC program to decrypt data programmatically
--
-- Reference:
--   - IBM i SQL Reference - ENCRYPT_AES function
--   - IBM i Security Reference - Data Encryption
--   - https://www.nicklitten.com/ibm-i-sql-encryption/
-- --------------------------------------------------------------------------
CREATE OR REPLACE TABLE
  NICKLITTEN.CUSTENC (
    CUSTOMER_ID VARCHAR(10),
    CUSTOMER_NAME VARCHAR(50),
    SSN_PLAIN VARCHAR(11),
    SSN_ENCRYPTED VARCHAR(128) FOR BIT DATA,
    CREDIT_CARD_ENCRYPTED VARCHAR(128) FOR BIT DATA,
    PRIMARY KEY (CUSTOMER_ID)
  ) ON REPLACE
DELETE
  ROWS;


SET ENCRYPTION PASSWORD = 'MySuperSecretPassword123!';


INSERT INTO
  NICKLITTEN.CUSTENC
VALUES
  (
    'CUST001',
    'John Smith',
    '123-45-6789', -- Plain text for comparison (remove in production!)
    ENCRYPT_AES(
      '123-45-6789',
      'MySuperSecretPassword123!',
      HINT => 'My Super Secret One'
    ),
    ENCRYPT_AES(
      '4111-1111-1111-1111',
      'ThisFieldIsDifferent$1',
      HINT => 'This is Different'
    )
  );


SELECT
  CUSTOMER_ID,
  CUSTOMER_NAME,
  DECRYPT_BIT(SSN_ENCRYPTED) AS SSN_DECRYPTED,
  DECRYPT_BIT(CREDIT_CARD_ENCRYPTED) AS CARD_DECRYPTED
FROM
  NICKLITTEN.CUSTENC
WHERE
  CUSTOMER_ID = 'CUST001';