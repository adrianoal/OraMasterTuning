-- Obs.: nem sempre o plano de execucao gerado entre as 2 queries é diferente, mas se o filtro estiver na subquery utilize IN, caso contrário, utilize EXISTS.

--  Utilize IN se o filtro é na subquery:
EXPLAIN PLAN FOR
SELECT      P.*
FROM        ECOMMERCE.PEDIDO P
WHERE       P.CD_CLIENTE IN (SELECT   CD_CLIENTE
                             FROM     ECOMMERCE.CLIENTE C
							 WHERE    C.CD_CLIENTE = P.CD_CLIENTE
                             AND      C.CD_CLIENTE = 4);
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);  


--  Utilize EXISTS se o filtro é na query principal:
EXPLAIN PLAN FOR
SELECT          P.*
FROM            ECOMMERCE.PEDIDO P
WHERE           EXISTS (SELECT     CD_CLIENTE
                        FROM       ECOMMERCE.CLIENTE C
                        WHERE      C.CD_CLIENTE = P.CD_CLIENTE)
AND             P.CD_CLIENTE = 4;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);  


