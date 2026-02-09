**FREE

/TITLE Customer Data Encryption Example
// GETENC-Get_Encryption_Data.pgm.sqlrpgle (fully /free)
// This SQL RPGLE program demonstrates how to use SQL encryption functions.
//
// MODIFICATION HISTORY:
// 2026.01.23 Nick Litten V1.0 Created
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