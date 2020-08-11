-- ATENCAO: O custo no PE fica pouca coisa menor, mas o tempo de execucao melhora muito com o WITH, por isso SEMPRE TESTE A EXECUCAO DO SQL


-- Ao inves de:
explain plan for -- 580s
        SELECT      P.PRODUCT_NAME,
                    SUM(O.ORDER_TOTAL) AS TOTAL
        FROM        SOE.PRODUCT_INFORMATION P
        INNER JOIN  SOE.ORDER_ITEMS I
            ON      P.PRODUCT_ID = I.PRODUCT_ID
        INNER JOIN  SOE.ORDERS O
            ON      O.ORDER_ID = I.ORDER_ID                
        GROUP BY    P.PRODUCT_NAME
        HAVING      SUM(O.ORDER_TOTAL) >  (
                                            SELECT  SUM(TOTAL)/COUNT(*)
                                            FROM    (
                                                        SELECT      P.PRODUCT_NAME,
                                                                    SUM(O.ORDER_TOTAL) AS TOTAL
                                                        FROM        SOE.PRODUCT_INFORMATION P
                                                        INNER JOIN  SOE.ORDER_ITEMS I
                                                            ON      P.PRODUCT_ID = I.PRODUCT_ID
                                                        INNER JOIN  SOE.ORDERS O
                                                            ON      O.ORDER_ID = I.ORDER_ID    
                                                        GROUP BY    P.PRODUCT_NAME)
                                            )                                                        
        ORDER BY    P.PRODUCT_NAME;
select * from table(dbms_xplan.display);

-- escreva:
explain plan for  -- 206s
       WITH
            COSTS AS (  SELECT      P.PRODUCT_NAME,
                                    SUM(O.ORDER_TOTAL) AS TOTAL
                        FROM        SOE.PRODUCT_INFORMATION P
                        INNER JOIN  SOE.ORDER_ITEMS I
                            ON      P.PRODUCT_ID = I.PRODUCT_ID
                        INNER JOIN  SOE.ORDERS O
                            ON      O.ORDER_ID = I.ORDER_ID                
                        GROUP BY    P.PRODUCT_NAME                        
                        ),
            PROD_AVG AS (   SELECT  SUM(TOTAL)/COUNT(*) AS P_AVG
                            FROM    COSTS
                        )
        SELECT      *
        FROM        COSTS
        WHERE       TOTAL > (SELECT P_AVG FROM PROD_AVG)                                                 
        ORDER BY    PRODUCT_NAME;
select * from table(dbms_xplan.display);


