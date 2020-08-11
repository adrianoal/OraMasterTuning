-- nem sempre o plano de execucao das 2 queries eh diferente

-- Ao inves de:
EXPLAIN PLAN FOR
  SELECT        P.*
  FROM          ECOMMERCE.PEDIDO P
  WHERE         P.CD_CLIENTE IN (   SELECT   CD_CLIENTE
                                    FROM     ECOMMERCE.CLIENTE C)
  AND           P.CD_PEDIDO BETWEEN 1 AND 100;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Escreva:
EXPLAIN PLAN FOR
SELECT          P.*
FROM            ECOMMERCE.PEDIDO P
INNER JOIN      ECOMMERCE.CLIENTE C
    ON          P.CD_CLIENTE = C.CD_CLIENTE
WHERE           P.CD_PEDIDO BETWEEN 1 AND 100;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
