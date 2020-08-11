drop table ECOMMERCE.ITEM_PEDIDO2;

CREATE TABLE ECOMMERCE.ITEM_PEDIDO2 AS SELECT * FROM ECOMMERCE.ITEM_PEDIDO WHERE 1=0;
/

CREATE GLOBAL TEMPORARY TABLE ECOMMERCE.TMP_ITEM_PEDIDO
  (
    "CD_PEDIDO"  NUMBER NOT NULL ENABLE,
    "CD_PRODUTO" NUMBER NOT NULL ENABLE,
    "QT_ITEM"    NUMBER NOT NULL ENABLE,
    "VL_TOTAL"   NUMBER(10,2) NOT NULL ENABLE
  ) ON COMMIT DELETE ROWS; -- on commit preserve rows;
/

SET SERVEROUTPUT ON
DECLARE 
  	L_START         NUMBER;    
BEGIN 
  L_START := DBMS_UTILITY.GET_TIME;
  -- executa insert em tabela normal
  INSERT INTO ECOMMERCE.ITEM_PEDIDO2
  SELECT * FROM ECOMMERCE.ITEM_PEDIDO; 
  -- Tempo de um insert convencional 
  DBMS_OUTPUT.PUT_LINE('INSERT tabela normal: ' || round((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');  
  -- desfaz insercao dos dados
  ROLLBACK;
 
 L_START := DBMS_UTILITY.GET_TIME;
  -- executa insert em GTT
  INSERT INTO ECOMMERCE.TMP_ITEM_PEDIDO
  SELECT * FROM ECOMMERCE.ITEM_PEDIDO; 
  -- Tempo de um insert convencional 
  DBMS_OUTPUT.PUT_LINE('INSERT GTT: ' || round((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');  
  -- desfaz insercao dos dados
  ROLLBACK;
END;
/

-- mudar estatisticas da GTT no 12c para compartilhada, ao inves de SESSION:
exec dbms_stats.set_global_prefs('GLOBAL_TEMP_TABLE_STATS','SHARED');