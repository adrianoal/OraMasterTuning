-- Ao inves de:
EXPLAIN PLAN FOR
  SELECT        SUBSTR(P.CD_PEDIDO, 10),
                IP.QT_ITEM, 
                SUBSTR(IP.CD_PEDIDO, 1)
  FROM          ECOMMERCE.PEDIDO P
  INNER JOIN    ECOMMERCE.ITEM_PEDIDO IP
      ON        TO_NUMBER (SUBSTR(P.CD_PEDIDO, 10)) = TO_NUMBER(SUBSTR(IP.CD_PEDIDO, 10))
  WHERE         P.CD_PEDIDO = 3;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

--Escreva:
EXPLAIN PLAN FOR
  SELECT        P.CD_PEDIDO, 
                IP.QT_ITEM
  FROM          ECOMMERCE.PEDIDO P
  INNER JOIN    ECOMMERCE.ITEM_PEDIDO IP
        ON      P.CD_PEDIDO = IP.CD_PEDIDO
  WHERE         P.CD_PEDIDO = 3;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


CREATE INDEX ECOMMERCE.IX_PEDIDO_DTPEDIDO ON ECOMMERCE.PEDIDO(DT_PEDIDO);

-- Ao inves de usar funcao na coluna DT_PEDIDO:
EXPLAIN PLAN FOR
    SELECT      *
    FROM        ECOMMERCE.PEDIDO
    WHERE       TO_CHAR(DT_PEDIDO,'dd/mm/yyyy') = '08/04/2009';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Use uma funcao no lado oposto, no valor hard code. Isso possibilita UTILIZAR UM INDICE NA COLUNA DT_PEDIDO:
EXPLAIN PLAN FOR
    SELECT      *
    FROM        ECOMMERCE.PEDIDO 
    WHERE       DT_PEDIDO BETWEEN TO_DATE('08/04/2009 00:00:00','dd/mm/yyyy hh24:mi:ss') AND TO_DATE('08/04/2009 23:59:59','dd/mm/yyyy hh24:mi:ss');
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);