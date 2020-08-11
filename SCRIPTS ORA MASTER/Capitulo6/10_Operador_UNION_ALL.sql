--Ao inves de:     
EXPLAIN PLAN FOR
    SELECT          'Vendas 1.000 a 10.000' AS "Tipo venda", COUNT(1) AS TOTAL
    FROM            SOE.ORDERS O
    WHERE           O.ORDER_TOTAL BETWEEN 1000 AND 10000
    UNION 
    SELECT          'Vendas 5.000 a 10.000 prod. 299' as "Tipo venda", COUNT(1)
    FROM            SOE.ORDERS O
    INNER JOIN      SOE.ORDER_ITEMS I
        ON          O.ORDER_ID = I.ORDER_ID  
    WHERE           O.ORDER_TOTAL BETWEEN 5000 AND 10000 
    AND             I.PRODUCT_ID = 299;    
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Escreva: 
EXPLAIN PLAN FOR
    SELECT          'Vendas 1.000 a 10.000' AS "Tipo venda", COUNT(1) AS TOTAL
    FROM            SOE.ORDERS O
    WHERE           O.ORDER_TOTAL BETWEEN 1000 AND 10000
    UNION ALL
    SELECT          'Vendas 5.000 a 10.000 prod. 299' as "Tipo venda", COUNT(1)
    FROM            SOE.ORDERS O
    INNER JOIN      SOE.ORDER_ITEMS I
        ON          O.ORDER_ID = I.ORDER_ID  
    WHERE           O.ORDER_TOTAL BETWEEN 5000 AND 10000 
    AND             I.PRODUCT_ID = 299;    
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- ATENCAO: paralelismo pode ocorer automaticamente nos SQLs se tiver consultas remotas:
-- crie o dblink DB_SOE para ser usado no SQL que vem a seguir:
CREATE PUBLIC DATABASE LINK DB_SOE CONNECT TO soe IDENTIFIED BY soe USING 'pdbxe';

EXPLAIN PLAN FOR
   SELECT          'Vendas 1.000 a 10.000' AS "Tipo venda", COUNT(1) AS TOTAL
    FROM            SOE.ORDERS O
    WHERE           O.ORDER_TOTAL BETWEEN 1000 AND 10000
    UNION ALL
    SELECT          'Vendas 5.000 a 10.000 prod. 299' as "Tipo venda", COUNT(1)
    FROM            SOE.ORDERS@DB_SOE O
    INNER JOIN      SOE.ORDER_ITEMS@DB_SOE I
        ON          O.ORDER_ID = I.ORDER_ID  
    WHERE           O.ORDER_TOTAL BETWEEN 5000 AND 10000 
    AND             I.PRODUCT_ID = 299; 
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);    