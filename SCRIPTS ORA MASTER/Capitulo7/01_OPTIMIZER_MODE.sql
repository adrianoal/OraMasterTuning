-- first_rows favorece uso de indices para retornar as primeiras linhas mais rapidamente:
ALTER SESSION SET OPTIMIZER_MODE = FIRST_ROWS;

-- all_rows favorece melhor throughput (boa configuracao para hardware muito bom (Ex.: Exadata) ou OLAP):
ALTER SESSION SET OPTIMIZER_MODE = ALL_ROWS; 

-- Veja o PE abaixo com os 2 modos do otimizador:
explain plan for
            SELECT      O.ORDER_DATE,
                        O.ORDER_ID,
                        P.PRODUCT_NAME,                        
                        O.ORDER_STATUS,
                        O.ORDER_TOTAL,
                        I.QUANTITY,
                        I.UNIT_PRICE
            FROM        SOE.PRODUCT_INFORMATION P
            INNER JOIN  SOE.ORDER_ITEMS I
                ON      P.PRODUCT_ID = I.PRODUCT_ID
            INNER JOIN  SOE.ORDERS O
                ON      O.ORDER_ID = I.ORDER_ID                                                         
            ORDER BY    O.ORDER_DATE, O.ORDER_ID, P.PRODUCT_NAME;
select * from table(dbms_xplan.display);     