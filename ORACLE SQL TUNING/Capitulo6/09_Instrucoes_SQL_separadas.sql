--Ao inves de (or e left join sao viloes nessa query):     
EXPLAIN PLAN FOR  -- 504s
    SELECT	        COUNT(DISTINCT CASE WHEN O.ORDER_TOTAL
                                            BETWEEN 1000 AND 10000 THEN O.ORDER_ID
                                            ELSE  NULL  
                    END) AS "Descontos_1000_10000",
                    COUNT(DISTINCT CASE WHEN O.ORDER_TOTAL
                                            BETWEEN 5000 AND 10000 AND I.PRODUCT_ID = 299 THEN O.ORDER_ID
                                            ELSE  NULL 
                    END) "Descontos_5000_10000_prod_299"   
    FROM            SOE.ORDERS O
    LEFT JOIN       SOE.ORDER_ITEMS I
        ON          O.ORDER_ID = I.ORDER_ID  
    WHERE           O.ORDER_TOTAL BETWEEN 1000 AND 10000 
    OR              I.PRODUCT_ID = 299;   
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- execute:
EXPLAIN PLAN FOR        -- 64s
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
    