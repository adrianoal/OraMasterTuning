-- Ao  inves de:
EXPLAIN PLAN FOR
    SELECT  *
    FROM    ECOMMERCE.CLIENTE C;  
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Escreva
EXPLAIN PLAN FOR
  	SELECT  CD_CLIENTE, NM_CLIENTE 
  	FROM    ECOMMERCE.CLIENTE C;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

