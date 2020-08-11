DECLARE
  v_count NUMBER;
BEGIN
  SELECT  COUNT(1) INTO V_COUNT
  FROM    DBA_TABLES
  WHERE   OWNER = 'ECOMMERCE'
  AND     TABLE_NAME = 'ITEM_PEDIDO4';
  
  IF V_COUNT > 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLE ECOMMERCE.ITEM_PEDIDO4 PURGE';
  END IF;
END;
/

CREATE TABLE ECOMMERCE.ITEM_PEDIDO4
  (
    CD_PEDIDO  NUMBER NOT NULL ENABLE,
    CD_PRODUTO NUMBER NOT NULL ENABLE,
    QT_ITEM    NUMBER NOT NULL ENABLE,
    VL_TOTAL   NUMBER(10,2) NOT NULL ENABLE,
    CONSTRAINT PK_ITEM_PEDIDO4 PRIMARY KEY (CD_PEDIDO, CD_PRODUTO) USING INDEX COMPUTE STATISTICS NOLOGGING TABLESPACE ECOMMERCE_I ENABLE,
    CONSTRAINT FK_ITEMPEDIDO_PEDIDO4 FOREIGN KEY (CD_PEDIDO) REFERENCES ECOMMERCE.PEDIDO (CD_PEDIDO) ENABLE,
    CONSTRAINT FK_ITEMPEDIDO_PRODUTO4 FOREIGN KEY (CD_PRODUTO) REFERENCES ECOMMERCE.PRODUTO (CD_PRODUTO) ENABLE
  ) 
/

SET SERVEROUTPUT ON
DECLARE 
  L_START         NUMBER;    
BEGIN
  L_START := DBMS_UTILITY.GET_TIME;
  -- executa insert c/ constraints habilitadas e sem indices
  INSERT  INTO ECOMMERCE.ITEM_PEDIDO4
  SELECT * FROM ECOMMERCE.ITEM_PEDIDO WHERE ROWNUM < 100000;  
  DBMS_OUTPUT.PUT_LINE('INSERT c/ constraints FKs habilitadas e com indices : ' || ROUND((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');    
  -- desfaz insercao dos dados
  ROLLBACK;

  EXECUTE IMMEDIATE 'ALTER TABLE ECOMMERCE.ITEM_PEDIDO4 MODIFY CONSTRAINT FK_ITEMPEDIDO_PRODUTO4 DISABLE';
  EXECUTE IMMEDIATE 'ALTER TABLE ECOMMERCE.ITEM_PEDIDO4 MODIFY CONSTRAINT FK_ITEMPEDIDO_PEDIDO4 DISABLE';
  L_START := DBMS_UTILITY.GET_TIME;
  -- executa insert c/ constraints FKs desabilitadas
  INSERT  INTO ECOMMERCE.ITEM_PEDIDO4
  SELECT * FROM ECOMMERCE.ITEM_PEDIDO WHERE ROWNUM < 100000;  
  DBMS_OUTPUT.PUT_LINE('INSERT c/ constraints FKs desabilitadas: ' || ROUND((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');    
  -- desfaz insercao dos dados
  ROLLBACK;  

  EXECUTE IMMEDIATE 'ALTER TABLE ECOMMERCE.ITEM_PEDIDO4 MODIFY CONSTRAINT PK_ITEM_PEDIDO4 DISABLE'; -- apaga indice da PK tambem
  L_START := DBMS_UTILITY.GET_TIME;
  -- executa insert c/ todas as constraints desabilitadas e sem indices  
  INSERT INTO ECOMMERCE.ITEM_PEDIDO4
  SELECT * FROM ECOMMERCE.ITEM_PEDIDO WHERE ROWNUM < 100000;  
  DBMS_OUTPUT.PUT_LINE('INSERT c/ constraints e indices desabilitados: ' || ROUND((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');    
  -- desfaz insercao dos dados
  ROLLBACK; 
  
  L_START := DBMS_UTILITY.GET_TIME;
  EXECUTE IMMEDIATE 'ALTER TABLE ECOMMERCE.ITEM_PEDIDO4 MODIFY CONSTRAINT FK_ITEMPEDIDO_PRODUTO4 ENABLE';
  EXECUTE IMMEDIATE 'ALTER TABLE ECOMMERCE.ITEM_PEDIDO4 MODIFY CONSTRAINT FK_ITEMPEDIDO_PEDIDO4 ENABLE';
  EXECUTE IMMEDIATE 'ALTER TABLE ECOMMERCE.ITEM_PEDIDO4 MODIFY CONSTRAINT PK_ITEM_PEDIDO4 ENABLE';
  DBMS_OUTPUT.PUT_LINE('Tempo p/ reabilitar constraints e indices: ' || ROUND((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');    
END;