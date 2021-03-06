-- Ao inves de alterar utilizando a PK:
EXPLAIN PLAN FOR
  UPDATE  ECOMMERCE.ITEM_PEDIDO IP1
  SET     VL_TOTAL = VL_TOTAL * 2
  WHERE   (CD_PEDIDO, CD_PRODUTO) IN 
                  (SELECT  CD_PEDIDO, CD_PRODUTO
                   FROM    ECOMMERCE.ITEM_PEDIDO IP2
                   WHERE   ROWNUM < 100000);    
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());

-- Execute a alteracao utilizando o ROWID:
EXPLAIN PLAN FOR
  UPDATE  ECOMMERCE.ITEM_PEDIDO IP1
  SET     VL_TOTAL = VL_TOTAL * 2
  WHERE   ROWID IN 
                  (SELECT  ROWID
                   FROM    ECOMMERCE.ITEM_PEDIDO IP2
                   WHERE   ROWNUM < 100000);
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());