-- Obs.: Este recurso funciona somente na versao Enterprise Edition

-- Ao inves de:
explain plan for
            SELECT      O.ORDER_DATE,
                        I.PRODUCT_ID,
                        O.ORDER_ID,                                           
                        O.ORDER_STATUS,
                        O.ORDER_TOTAL,
                        I.QUANTITY,
                        I.UNIT_PRICE
            FROM        SOE.ORDER_ITEMS I                
            INNER JOIN  SOE.ORDERS O
                ON      O.ORDER_ID = I.ORDER_ID                                                         
            ORDER BY    O.ORDER_DATE, O.ORDER_ID, I.PRODUCT_ID ;
select * from table(dbms_xplan.display); 

-- Escreva:
explain plan for
            SELECT      /*+ PARALLEL(4) */ O.ORDER_DATE,
                        I.PRODUCT_ID,
                        O.ORDER_ID,                                           
                        O.ORDER_STATUS,
                        O.ORDER_TOTAL,
                        I.QUANTITY,
                        I.UNIT_PRICE
            FROM        SOE.ORDER_ITEMS I                
            INNER JOIN  SOE.ORDERS O
                ON      O.ORDER_ID = I.ORDER_ID                                                         
            ORDER BY    O.ORDER_DATE, O.ORDER_ID, I.PRODUCT_ID ;
select * from table(dbms_xplan.display);     
