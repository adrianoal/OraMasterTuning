create user ecommerce identified by ecommerce;
grant create session to ecommerce;
grant resource to ecommerce;
ALTER USER ecommerce QUOTA UNLIMITED ON ecommerce_d;
ALTER USER ecommerce QUOTA UNLIMITED ON ecommerce_i;
ALTER USER "ECOMMERCE" DEFAULT TABLESPACE "ECOMMERCE_D";