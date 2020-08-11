-- ENTREGUES C/ DESCONTO (SEM VALOR TOTAL)
BEGIN
  DBMS_OUTPUT.enable(null);
  FOR linha In  (select distinct cd_pedido from ecommerce.pedido)
  LOOP    
        FOR I IN 1..5
        LOOP
            INSERT INTO ECOMMERCE.ITEM_PEDIDO 
            VALUES  (LINHA.CD_PEDIDO, I, TRUNC(DBMS_RANDOM.VALUE(1,52)), 0);
        END LOOP;
  END LOOP;
  
  commit;
END;
/