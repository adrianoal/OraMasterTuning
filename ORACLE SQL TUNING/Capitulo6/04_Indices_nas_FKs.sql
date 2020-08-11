-- desabilite o indice da pk da item_pedido para ele nao ser utilizado no teste abaixo:
alter index soe.ORDER_ITEMS_PK INvisible;

-- 1: Execute a query abaixo e veja o plano de execucao
EXPLAIN PLAN FOR   
    SELECT      	o.*
    FROM        	soe.orders o
    INNER JOIN  	soe.order_items i
        ON      	o.order_id = i.order_id
    WHERE       	o.order_id BETWEEN 14387823 AND 14399999;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- 2: crie o indice abaixo:
--CREATE INDEX ECOMMERCE.IX_ITEMPEDIDO_CDPEDIDO ON ECOMMERCE.ITEM_PEDIDO(CD_PEDIDO);
alter index soe.ORDER_ITEMS_PK visible;

-- 3: execute novamente a query do passo 1 e veja se o plano melhorou