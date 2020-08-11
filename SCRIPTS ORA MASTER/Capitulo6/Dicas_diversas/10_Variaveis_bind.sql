-- execute conectado como SYS
create bitmap index ecommerce.ix_itempedido_cdproduto on ecommerce.item_Pedido(cd_produto);

SET SERVEROUTPUT ON
DECLARE
  V_START NUMBER;
  V_COUNT NUMBER;  
  V_SQL VARCHAR2(200);
BEGIN 
   execute immediate 'alter system flush shared_pool';

  V_SQL :=  'SELECT    COUNT(1)
             FROM      ECOMMERCE.ITEM_PEDIDO
             WHERE     CD_PRODUTO = ';

  V_START := DBMS_UTILITY.GET_TIME;
  
  FOR I IN 1..100
  LOOP
      EXECUTE IMMEDIATE V_SQL || TO_CHAR(I) INTO V_COUNT;  -- sql dinamico sempre faz hard parse    
  END LOOP; 
  
  DBMS_OUTPUT.PUT_LINE('Tempo de execucao SQL sem BIND: ' || ((DBMS_UTILITY.GET_TIME - V_START)) || 'cs');
  
  V_START := DBMS_UTILITY.GET_TIME;
  
  FOR I IN 1..100
  LOOP
      SELECT    COUNT(1) INTO V_COUNT
      FROM      ECOMMERCE.ITEM_PEDIDO
      WHERE     CD_PRODUTO = I;
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('Tempo de execucao SQL com BIND: ' || ((DBMS_UTILITY.GET_TIME - V_START)) || 'cs');
END;