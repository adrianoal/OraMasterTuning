-- Ao inves de 
EXPLAIN PLAN FOR
    SELECT    DT_PEDIDO, cd_cliente
    FROM      ECOMMERCE.PEDIDO
    WHERE     (:VCD_PEDIDO IS NULL
              OR CD_PEDIDO = :VCD_PEDIDO)
    AND       (:VID_STATUS IS NULL
              OR ID_STATUS = :VID_STATUS);
SELECT * FROM TABLE(dbms_xplan.DISPLAY);

-- Ou ao inves de
EXPLAIN PLAN FOR
    SELECT    DT_PEDIDO, cd_cliente
    FROM      ECOMMERCE.PEDIDO
    WHERE     CD_PEDIDO = NVL(:VCD_PEDIDO, CD_PEDIDO)
    AND       ID_STATUS = NVL(:VID_STATUS, ID_STATUS);
SELECT * FROM TABLE(dbms_xplan.DISPLAY);   

-- Utilize SQL DINAMICO em pl/sql ou monte o sql na aplicacao
DECLARE 
  V_SQL VARCHAR2(1000);
  V_CDPEDIDO NUMBER := 5;
  V_IDSTATUS NUMBER := NULL;
BEGIN
  V_SQL := 'EXPLAIN PLAN FOR
                SELECT    DT_PEDIDO, cd_cliente
                FROM      ECOMMERCE.PEDIDO';                
  
  IF V_CDPEDIDO IS NOT NULL THEN
      V_SQL := V_SQL || ' WHERE CD_PEDIDO = ' || V_CDPEDIDO;
  END IF;
  
  IF V_IDSTATUS IS NOT NULL THEN
      IF V_CDPEDIDO IS NULL THEN
          V_SQL := V_SQL || ' WHERE ID_STATUS = ' || V_IDSTATUS;
      ELSE
          V_SQL := V_SQL || ' AND ID_STATUS = ' || V_IDSTATUS;
      END IF;
  END IF;
         
  EXECUTE IMMEDIATE V_SQL;
END;

-- veja o plano de execucao do sql dinamico
SELECT * FROM TABLE(dbms_xplan.DISPLAY);