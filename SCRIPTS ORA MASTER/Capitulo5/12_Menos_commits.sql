-- cria tabela para efetuar carga:
CREATE TABLE SOE.INV AS SELECT * FROM SOE.inventories WHERE 1=0;

-- EXECUTE o bloco abaixo e veja o tempo de cada INSERT:
SET SERVEROUTPUT ON
declare
  v_count NUMber;
  V_START NUMBER;
begin
  V_START := DBMS_UTILITY.GET_TIME;
  for linha in (SELECT  PRODUCT_ID, WAREHOUSE_ID, QUANTITY_ON_HAND
				FROM    SOE.inventories
                where rownum < 100000)
  loop
    INSERT  INTO SOE.INV
    values (LINHA.PRODUCT_ID, LINHA.WAREHOUSE_ID, LINHA.QUANTITY_ON_HAND);
    COMMIT;
  end loop;
  
  DBMS_OUTPUT.PUT_LINE('Tempo de execucao com 1 COMMIT por linha: ' || ROUND((DBMS_UTILITY.GET_TIME - v_START)/100,2) || 's');
    
  V_START := DBMS_UTILITY.GET_TIME;
  for linha in (SELECT  PRODUCT_ID, WAREHOUSE_ID, QUANTITY_ON_HAND
				FROM    SOE.inventories
                where rownum < 100000)
  loop
    INSERT  INTO SOE.INV
    values (LINHA.PRODUCT_ID, LINHA.WAREHOUSE_ID, LINHA.QUANTITY_ON_HAND);
  end loop;
  COMMIT;  
  DBMS_OUTPUT.PUT_LINE('Tempo de execucao com 1 COMMIT no final: ' || ROUND((DBMS_UTILITY.GET_TIME - v_START)/100,2) || 's');
end;