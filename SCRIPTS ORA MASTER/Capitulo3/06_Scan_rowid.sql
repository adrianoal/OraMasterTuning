EXPLAIN PLAN FOR
    SELECT  rowid, i.*
    FROM    ECOMMERCE.item_PEDIDO i
    where   rowid = 'AAASKKAAUAAAACDAAA';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);    