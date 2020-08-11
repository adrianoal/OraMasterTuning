-- copiar arquivo item_pedido.dsv para DATA_PUMP_DIR directory em uma janela de terminal (conferir se caminho dos scripts esta correto):
cp /home/oracle/item_pedido.dsv /opt/oracle/product/18c/dbhomeXE/rdbms/log/79F1171D377568E5E0550A00276AEAD6

-- atribuir privilegios p/ usuario dono da tabela ter acesso ao diretorio (leitura e gravacao)
GRANT READ, WRITE ON DIRECTORY DATA_PUMP_DIR TO ECOMMERCE;

-- criar a tabela externa logando com o usuario ECOMMERCE:
CREATE TABLE ECOMMERCE.ITEM_PEDIDO_EXT 
        (
            cd_pedido NUMBER,
            cd_produto NUMBER,    
            qt_item NUMBER,
            vl_total NUMBER
        )
        ORGANIZATION EXTERNAL
        (
          TYPE ORACLE_LOADER
          DEFAULT DIRECTORY DATA_PUMP_DIR
          ACCESS PARAMETERS
              ( 
                RECORDS DELIMITED BY NEWLINE
                FIELDS TERMINATED BY '|' LRTRIM
              )
        LOCATION ('item_pedido.dsv')
        )  reject limit unlimited;    

-- testar tabela externa
select * from ECOMMERCE.ITEM_PEDIDO_EXT;

-- recriar tabela ECOMMERCE.ITEM_PEDIDO3 sem dados:
DROP TABLE ECOMMERCE.ITEM_PEDIDO3 PURGE;
CREATE TABLE ECOMMERCE.ITEM_PEDIDO3 AS SELECT * FROM ECOMMERCE.ITEM_PEDIDO WHERE 1=0; 

-- verificar tempo do INSERT (normalmente executa em metade do tempo do SQL LOADER do script anterior)
INSERT /*+ APPEND */ INTO ECOMMERCE.ITEM_PEDIDO3 SELECT * FROM ECOMMERCE.ITEM_PEDIDO_EXT;  -- 6,09s  3,77
COMMIT;