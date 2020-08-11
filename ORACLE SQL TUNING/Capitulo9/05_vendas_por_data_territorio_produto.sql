-- VENDAS POR DATA, TERRITORIO E PRODUTO DE UM DETERMINADO MES/ANO

-- otimizar o SQL abaixo considerando que ele eh executado 1x ao dia, mas precisa retornar os dados atuais (nao pode ser historico, tem que ser tempo real)
-- sugiro testar gerando apenas o PE, pois o tempo de execucao eh muito alto
EXPLAIN PLAN FOR -- 1491s
    SELECT      TO_CHAR(O.ORDER_DATE,'DD/MM/YYYY') AS ORDERS_DATE,
                C.NLS_TERRITORY,        
                P.PRODUCT_NAME,
                SUM(I.UNIT_PRICE) TOTAL_PRICE,
                SUM(I.QUANTITY) TOTAL_QUANTITY,
                TG.DATE_TOTAL_PRICE,
                ROUND(SUM(I.UNIT_PRICE) / TG.DATE_TOTAL_PRICE * 100, 2) AS PERC_DATE_TOTAL            
    FROM        SOE.ORDERS O
    JOIN        SOE.ORDER_ITEMS I
      ON        O.ORDER_ID = I.ORDER_ID
    JOIN        SOE.PRODUCT_INFORMATION P
      ON        I.PRODUCT_ID = P.PRODUCT_ID
    JOIN        SOE.CUSTOMERS C
     ON         C.CUSTOMER_ID = O.CUSTOMER_ID
    JOIN        (
                SELECT     TO_CHAR(O2.ORDER_DATE,'DD/MM/YYYY') AS ORDERS_DATE,
                            SUM(I2.UNIT_PRICE) DATE_TOTAL_PRICE
                 FROM       SOE.ORDERS O2
                 JOIN       SOE.ORDER_ITEMS I2
                    ON      O2.ORDER_ID = I2.ORDER_ID            
                GROUP BY    TO_CHAR(O2.ORDER_DATE,'DD/MM/YYYY')
                ) TG
      ON        TG.ORDERS_DATE = TO_CHAR(O.ORDER_DATE,'DD/MM/YYYY')
    WHERE       TO_CHAR(O.ORDER_DATE, 'YYYY/MM') = '2010/03'
    GROUP BY    TO_CHAR(O.ORDER_DATE,'DD/MM/YYYY'), C.NLS_TERRITORY, P.PRODUCT_NAME, TG.DATE_TOTAL_PRICE;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);