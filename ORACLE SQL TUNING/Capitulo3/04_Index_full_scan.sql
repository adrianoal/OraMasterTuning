EXPLAIN PLAN FOR
    SELECT  cd_pedido
    FROM    ECOMMERCE.item_PEDIDO
    order by cd_pedido;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY); 