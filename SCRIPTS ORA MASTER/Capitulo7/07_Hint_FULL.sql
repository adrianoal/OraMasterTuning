-- dependendo da situacao, FTS pode ser melhor q IS

-- alter optimizer_mode para FIRST_ROWS:
alter session set optimizer_mode = 'FIRST_ROWS';

-- veja o PE:
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

-- veja o PE com o hint FULL:
explain plan for
            SELECT      /*+ FULL(I) FULL(O) */
                        O.ORDER_DATE,
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
    
-- volte o optimizer_mode para o valor padrao:    
alter session set optimizer_mode = 'ALL_ROWS';