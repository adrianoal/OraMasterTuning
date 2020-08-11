-- CONSULTA REALIZADA EM MEDIA 10X POR MINUTO:

-- otimize o SQL abaixo retornando exatamente os mesmos dados do SQL original:
explain plan for
SELECT  O.ORDER_DATE, O.ORDER_ID, O.ORDER_TOTAL, O.ORDER_STATUS, I.PRODUCT_ID, I.QUANTITY, I.UNIT_PRICE
FROM    SOE.ORDER_ITEMS I
JOIN    SOE.ORDERS O 
  ON    I.ORDER_ID = O.ORDER_ID
WHERE   O.ORDER_ID = 4030147;
select * from table(dbms_xplan.display);
