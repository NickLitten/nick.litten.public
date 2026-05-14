**free

/// Program: GETENC - Get Encryption Data
///
/// Description: Demonstrates SQL encryption and decryption functions for
///              protecting sensitive customer data such as Social Security
///              Numbers and credit card information. Shows how to set encryption
///              passwords, encrypt data during INSERT operations, and decrypt
///              data during SELECT operations using IBM i SQL encryption.
///
/// Purpose: Educational example demonstrating:
///   - SQL encryption password management with SET ENCRYPTION PASSWORD
///   - AES encryption using ENCRYPT_AES function
///   - Data decryption using DECRYPT_BIT function
///   - Encryption hints for password recovery
///   - Secure storage of sensitive customer information
///   - Error handling for encryption operations
///
/// Features:
///   - Sets session encryption password
///   - Encrypts SSN and credit card data on insert
///   - Stores both plain and encrypted versions for comparison
///   - Retrieves and decrypts sensitive data
///   - Displays decrypted values for verification
///   - Comprehensive error handling with custom error program
///   - Uses password hints for encryption key management
///
/// Usage: CALL GETENC
///        (Demonstrates encryption/decryption with sample customer data)
///
/// Parameters: None
///
/// SQL Usage:
///   - SET ENCRYPTION PASSWORD to establish session encryption key
///   - ENCRYPT_AES() function for AES encryption with hints
///   - DECRYPT_BIT() function for decrypting encrypted data
///   - INSERT with encrypted column values
///   - SELECT with decryption of sensitive fields
///
/// Dependencies:
///   - Table: NICKLITTEN.CUSTENC (customer encryption table)
///   - Columns: CUSTOMER_ID, CUSTOMER_NAME, SSN_PLAIN, SSN_ENCRYPTED, CREDIT_CARD_ENCRYPTED
///   - Program: ERRORMSG (custom error handling program)
///
/// Security Notes:
///   - Password should be stored securely, not hardcoded
///   - Encryption password is session-specific
///   - Hints should not reveal actual password
///   - Consider key rotation policies
///
/// Control Options:
///   - dftactgrp(*no): Required for ILE and SQL
///   - actgrp('NICKLITTEN'): Named activation group
///   - option(*nodebugio): Disables debug I/O
///   - option(*srcstmt): Includes source statements
///   - datfmt(*ISO): ISO date format
///
/// Modification History:
/// 1.0 2026-01-23 | Nick Litten | Initial creation
/// 1.1 2026-04-02 | Bob AI | Added comprehensive triple-slash documentation

/TITLE Customer Data Encryption Example
ctl-opt dftactgrp(*no) actgrp('NICKLITTEN')
 option(*nodebugio:*srcstmt:*nounref)
 datfmt(*ISO) decedit('0.')
 copyright('| GETENC V1.0 Customer Data Encryption Example');

// Prototype for error handling
// this would be your own error handling program called 'ERRORMSG'
dcl-pr HandleError extpgm('ERRORMSG');
  ErrorMsg varchar(256) const;
end-pr;

// Variable declarations
dcl-s Password varchar(50) inz('MySuperSecretPassword123!');
dcl-s Hint varchar(100) inz('The usual password we use for testing');
dcl-s CustomerID varchar(10);
dcl-s CustomerName varchar(50);
dcl-s SSN varchar(11);
dcl-s CreditCard varchar(20);
dcl-s DecryptedSSN varchar(11);
dcl-s DecryptedCard varchar(20);
dcl-s DebugMSG varchar(52);

// Set up encryption password for this session
exec sql
  SET ENCRYPTION PASSWORD = :Password;

// Check for errors after setting password
if sqlstate <> '00000';
  HandleError('Failed to set encryption password: ' + sqlstate);
  return;
endif;

// Example: Insert a new customer with encrypted data
CustomerID = 'CUST002';
CustomerName = 'Jane Doe';
SSN = '987-65-4321';
CreditCard = '5555-5555-5555-5555';

exec sql
  insert into NICKLITTEN.CUSTENC
  values
    (
      :CUSTOMERID,
      :CUSTOMERNAME,
      :SSN,
      encrypt_aes(:SSN, :PASSWORD, HINT => :HINT),
      encrypt_aes(:CREDITCARD, :PASSWORD, HINT => :HINT)
    );

// Check for insert errors
if sqlstate <> '00000';
  HandleError('Failed to insert customer: ' + sqlstate);
  return;
endif;

// Example: Retrieve and decrypt customer data
exec sql
  select CUSTOMER_NAME,
       SSN_PLAIN,
       decrypt_bit(SSN_ENCRYPTED),
       decrypt_bit(CREDIT_CARD_ENCRYPTED)
  into :CUSTOMERNAME,
       :SSN,
       :DECRYPTEDSSN,
       :DECRYPTEDCARD
  from NICKLITTEN.CUSTENC
  where CUSTOMER_ID = :CUSTOMERID;

if sqlstate = '00000';
  // Display results (in a real app, you'd do something useful)
  DebugMSG = ('Customer: ' + %trim(CustomerName));
  dsply DebugMSG;
  DebugMSG = ('SSN: ' + %trim(DecryptedSSN));
  dsply DebugMSG;
  DebugMSG = ('Card: ' + %trim(DecryptedCard));
  dsply DebugMSG;
else;
  HandleError('Failed to retrieve customer: ' + sqlstate);
endif;

*INLR = *ON;
return;
