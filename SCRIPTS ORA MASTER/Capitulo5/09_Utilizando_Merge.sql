-- Criar PK na ITEM_PEDIDO2
ALTER TABLE ECOMMERCE.ITEM_PEDIDO2 ADD CONSTRAINT PK_ITEMPEDIDO2 PRIMARY KEY (CD_PEDIDO, CD_PRODUTO) ENABLE;

-- comparar tempo do MERGE c/ tempo de um bloco PL/SQL:
SET SERVEROUTPUT ON
DECLARE 
  L_START         NUMBER;
  V_COUNT         NUMBER:=1;  
BEGIN  
  L_START := DBMS_UTILITY.GET_TIME;  
  FOR CUR IN (SELECT  CD_PEDIDO, CD_PRODUTO, QT_ITEM, VL_TOTAL
              FROM    ECOMMERCE.ITEM_PEDIDO
              WHERE   ROWNUM < 50000)
  LOOP
      SELECT  COUNT(1) INTO V_COUNT
      FROM    ECOMMERCE.ITEM_PEDIDO2 IP2
      WHERE   IP2.CD_PEDIDO = CUR.CD_PEDIDO
      AND     IP2.CD_PRODUTO = CUR.CD_PRODUTO;
                  
      IF V_COUNT > 0 THEN
        UPDATE  ECOMMERCE.ITEM_PEDIDO2 
        SET     QT_ITEM = CUR.QT_ITEM,
                VL_TOTAL = CUR.VL_TOTAL
        WHERE   CD_PEDIDO = CUR.CD_PEDIDO
        AND     CD_PRODUTO = CUR.CD_PRODUTO;
      ELSE
          INSERT INTO ECOMMERCE.ITEM_PEDIDO2 (CD_PEDIDO, CD_PRODUTO, QT_ITEM,  VL_TOTAL) 
          VALUES (CUR.CD_PEDIDO, CUR.CD_PRODUTO, CUR.QT_ITEM, CUR.VL_TOTAL);
      END IF;
  END LOOP;  
  DBMS_OUTPUT.PUT_LINE('Tempo de execucao de LOOP c/ cursor e IF (bloco PL/SQL): ' || ROUND((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');   
  ROLLBACK;
    
  L_START := DBMS_UTILITY.GET_TIME;  
  MERGE INTO ECOMMERCE.ITEM_PEDIDO2 IP2
      USING (SELECT   CD_PEDIDO, CD_PRODUTO, QT_ITEM, VL_TOTAL
              FROM    ECOMMERCE.ITEM_PEDIDO
              WHERE   ROWNUM < 50000          
            ) IP
      ON    (IP.CD_PEDIDO = IP2.CD_PEDIDO
      AND   IP.CD_PRODUTO = IP2.CD_PRODUTO)
  WHEN MATCHED THEN  
      UPDATE  
      SET     IP2.QT_ITEM = IP.QT_ITEM,
              IP2.VL_TOTAL = IP.VL_TOTAL
  WHEN NOT MATCHED THEN
      INSERT (IP2.CD_PEDIDO, IP2.CD_PRODUTO, IP2.QT_ITEM,  IP2.VL_TOTAL) 
      VALUES (IP.CD_PEDIDO, IP.CD_PRODUTO, IP.QT_ITEM, IP.VL_TOTAL);
  DBMS_OUTPUT.PUT_LINE('Tempo de execucao do MERGE: ' || ROUND((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');   
  ROLLBACK;
END;