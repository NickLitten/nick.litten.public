create or replace table NICKLITTEN.CUSTENC (
      CUSTOMER_ID varchar(10),
      CUSTOMER_NAME varchar(50),
      SSN_PLAIN varchar(11),
      SSN_ENCRYPTED varchar(128) for bit data,
      CREDIT_CARD_ENCRYPTED varchar(128) for bit data,
      primary key (CUSTOMER_ID)
    )
  on replace delete rows;

set encryption password = 'MySuperSecretPassword123!';

insert into NICKLITTEN.CUSTENC
  values
    (
      'CUST001',
      'John Smith',
      '123-45-6789', -- Plain text for comparison (remove in production!)
      encrypt_aes('123-45-6789', 'MySuperSecretPassword123!', HINT => 'My Super Secret One'),
      encrypt_aes('4111-1111-1111-1111', 'ThisFieldIsDifferent$1', HINT => 'This is Different')
    );

select CUSTOMER_ID,
       CUSTOMER_NAME,
       decrypt_bit(SSN_ENCRYPTED) as SSN_DECRYPTED,
       decrypt_bit(CREDIT_CARD_ENCRYPTED) as CARD_DECRYPTED
  from NICKLITTEN.CUSTENC
  where CUSTOMER_ID = 'CUST001';