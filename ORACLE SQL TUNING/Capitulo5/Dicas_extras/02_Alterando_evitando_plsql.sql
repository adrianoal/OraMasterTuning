SET SERVEROUTPUT ON
DECLARE 
  L_START         NUMBER;  
BEGIN
  L_START := DBMS_UTILITY.GET_TIME;  
  
   FOR R IN (SELECT * 
             FROM   ECOMMERCE.ITEM_PEDIDO
             WHERE  CD_PRODUTO IN (1,2)
             and    ROWNUM < 1000)
   LOOP    
        IF R.CD_PRODUTO = 1 THEN
            UPDATE  ECOMMERCE.ITEM_PEDIDO IP2
            SET     IP2.VL_TOTAL = IP2.VL_TOTAL * 2
            WHERE   R.CD_PEDIDO = IP2.CD_PEDIDO
            AND     R.CD_PRODUTO = IP2.CD_PRODUTO;
        ELSIF R.CD_PRODUTO = 2 THEN
            UPDATE  ECOMMERCE.ITEM_PEDIDO IP2
            SET     IP2.VL_TOTAL = IP2.VL_TOTAL * 1.5
            WHERE   R.CD_PEDIDO = IP2.CD_PEDIDO
            AND     R.CD_PRODUTO = IP2.CD_PRODUTO;
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('UPDATE com PL/SQL + SQL: ' || ROUND((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');
    -- desfaz update
    ROLLBACK;
    
    L_START := DBMS_UTILITY.GET_TIME;  
    UPDATE  ECOMMERCE.ITEM_PEDIDO IP
    SET     VL_TOTAL = CASE IP.CD_PRODUTO
                              WHEN 1 THEN VL_TOTAL * 2
                              WHEN 2 THEN VL_TOTAL * 1.5                              
                          END
    WHERE   IP.CD_PRODUTO IN (1,2)
    and     ROWNUM < 1000;
    
    DBMS_OUTPUT.PUT_LINE('UPDATE somente com SQL: ' || ROUND((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');
    -- desfaz update
    ROLLBACK;
END;