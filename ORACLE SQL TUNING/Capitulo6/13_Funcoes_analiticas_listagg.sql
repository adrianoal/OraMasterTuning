-- criando a funcao concatenate_list para ser usado no 1o sql:
CREATE OR REPLACE FUNCTION ECOMMERCE.concatenate_list (p_cursor IN  SYS_REFCURSOR)
  RETURN  VARCHAR2
IS
  l_return  VARCHAR2(32767); 
  l_temp    VARCHAR2(32767);
BEGIN
  LOOP
    FETCH p_cursor
    INTO  l_temp;
    EXIT WHEN p_cursor%NOTFOUND;
    l_return := l_return || ',' || l_temp;
  END LOOP;
  RETURN LTRIM(l_return, ',');
END;
/

-- Ao inves de:
EXPLAIN PLAN FOR
SELECT      P.DT_PEDIDO,
            P.CD_PEDIDO,
            I.PRODUTOS
FROM        ECOMMERCE.PEDIDO P
INNER JOIN  (SELECT      I1.CD_PEDIDO,            
                        ECOMMERCE.concatenate_list(CURSOR(SELECT I2.CD_PRODUTO 
                                                          FROM   ECOMMERCE.ITEM_PEDIDO I2 
                                                          WHERE  I2.CD_PEDIDO = I1.CD_PEDIDO
                                                          ORDER BY 1)) AS PRODUTOS
             FROM        ECOMMERCE.ITEM_PEDIDO I1
             GROUP BY    I1.CD_PEDIDO) I
    ON      P.CD_PEDIDO = I.CD_PEDIDO
WHERE       P.CD_PEDIDO = 1960
ORDER BY    1;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- Escreva:
EXPLAIN PLAN FOR 
  SELECT      P.DT_PEDIDO,
              P.CD_PEDIDO,              
              LISTAGG(I.CD_PRODUTO, ', ' )
                within group (ORDER BY 1) PRODUTOS
  FROM        ECOMMERCE.ITEM_PEDIDO I
  INNER JOIN  ECOMMERCE.PEDIDO P 
      ON      I.CD_PEDIDO = P.CD_PEDIDO
  WHERE       P.CD_PEDIDO = 1960
  GROUP BY    P.DT_PEDIDO, P.CD_PEDIDO
  ORDER BY    1;  
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
