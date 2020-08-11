
-- Obs.: Este recurso funciona somente a partir do 11G versao Enterprise Edition e 18c Express Edition

-- limpar buffer cache e result cache:
ALTER SYSTEM FLUSH BUFFER_CACHE;
EXEC dbms_result_cache.flush;

-- ao inves de (demora de 50s a 100s):
explain plan for 
  SELECT    I.PRODUCT_ID, SUM(I.QUANTITY) AS QT_ITEM, SUM(O.ORDER_TOTAL) AS VL_TOTAL
  FROM      SOE.ORDER_ITEMS I
  JOIN      SOE.ORDERS O
    ON      I.ORDER_ID = O.ORDER_ID
  WHERE     I.PRODUCT_ID IN (450, 506, 465, 273, 616, 525, 371, 537, 443, 331, 495, 531, 348)
  GROUP BY  I.PRODUCT_ID;
select * from table(dbms_xplan.display);

-- escreva:
explain plan for 
SELECT    /*+ RESULT_CACHE */ I.PRODUCT_ID, SUM(I.QUANTITY) AS QT_ITEM, SUM(O.ORDER_TOTAL) AS VL_TOTAL
  FROM      SOE.ORDER_ITEMS I
  JOIN      SOE.ORDERS O
    ON      I.ORDER_ID = O.ORDER_ID
  WHERE     I.PRODUCT_ID IN (450, 506, 465, 273, 616, 525, 371, 537, 443, 331, 495, 531, 348)
  GROUP BY  I.PRODUCT_ID;
select * from table(dbms_xplan.display);


-- execute o UPDATE abaixo e veja que o SQL passara a demorar novamente, pois o result cache foi invalidado:
update SOE.ORDER_ITEMS set product_id = 450
where product_id = 450 and rownum =1;
commit;
