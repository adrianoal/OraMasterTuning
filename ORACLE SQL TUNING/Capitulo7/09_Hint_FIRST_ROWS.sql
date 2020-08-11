--create index ecommerce.ix_ip_cdproduto on ecommerce.item_pedido(cd_produto);

-- Ao inves de:
EXPLAIN PLAN FOR
    SELECT          *
    FROM            ECOMMERCE.ITEM_PEDIDO    	
    WHERE         	CD_PRODUTO = 3;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Escreva:
EXPLAIN PLAN FOR
    SELECT          /*+ FIRST_ROWS */  *
    FROM            ECOMMERCE.ITEM_PEDIDO    	
    WHERE         	CD_PRODUTO = 3;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- ou escreva:
EXPLAIN PLAN FOR
    SELECT          /*+ FIRST_ROWS(10) */  *
    FROM            ECOMMERCE.ITEM_PEDIDO    	
    WHERE         	CD_PRODUTO = 3;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- drop index ecommerce.ix_ip_cdproduto;