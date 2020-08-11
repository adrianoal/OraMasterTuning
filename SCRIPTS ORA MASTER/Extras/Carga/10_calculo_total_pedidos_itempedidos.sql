-- atualizando valor total por item
UPDATE    ECOMMERCE.ITEM_PEDIDO IP
SET       IP.VL_TOTAL = (SELECT  (P.VL_UNITARIO * I.QT_ITEM) 
                      FROM          ECOMMERCE.ITEM_PEDIDO I
                      INNER JOIN    ECOMMERCE.PRODUTO P
                          ON        I.CD_PRODUTO = P.CD_PRODUTO                      
                      where         I.CD_PEDIDO = IP.CD_PEDIDO
                      AND           I.CD_PRODUTO = IP.CD_PRODUTO)
COMMIT;
                
-- apagando pedidos que nao tinham itens
DELETE FROM ECOMMERCE.PEDIDO 
WHERE       CD_PEDIDO IN (SELECT        P.CD_PEDIDO
                          FROM          ECOMMERCE.PEDIDO P
                          left JOIN     ECOMMERCE.ITEM_PEDIDO I
                              ON        I.CD_PEDIDO = P.CD_PEDIDO
                          WHERE         I.CD_PRODUTO IS NULL)
COMMIT;

-- atualizando valor total do pedido considerando o desconto
UPDATE    ECOMMERCE.PEDIDO PED
SET       PED.VL_TOTAL =      (SELECT        SUM(I.VL_TOTAL) - PED.VL_DESCONTO
                               FROM          ECOMMERCE.ITEM_PEDIDO I                        
                               WHERE         I.CD_PEDIDO = PED.CD_PEDIDO
                               GROUP BY      I.CD_PEDIDO)
COMMIT;                              
                              
                              
                        
                        