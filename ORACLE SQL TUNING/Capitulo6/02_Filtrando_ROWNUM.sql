-- ao inves de:
EXPLAIN PLAN FOR
  SELECT    CD_CLIENTE
  FROM      ECOMMERCE.PEDIDO
  WHERE     CD_CLIENTE = 29212;	  
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- ou:
EXPLAIN PLAN FOR
  SELECT    DISTINCT CD_CLIENTE
  FROM      ECOMMERCE.PEDIDO
  WHERE     CD_CLIENTE = 29212;	  
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- escreva:
EXPLAIN PLAN FOR
  SELECT    CD_CLIENTE
  FROM      ECOMMERCE.PEDIDO
  WHERE     CD_CLIENTE = 29212
  AND       ROWNUM=1;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);