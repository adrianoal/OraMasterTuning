CREATE INDEX ECOMMERCE.IX_PEDIDO_IDSTATUS ON ECOMMERCE.PEDIDO(ID_STATUS);

-- Considerando que existe um indice na coluna ID_STATUS da tabela PEDIDO e que vc precisa visualizar todos os pedidos exceto aqueles com status 1, 2, 5

-- ao inves de:
EXPLAIN PLAN FOR
  SELECT  CD_PEDIDO, DT_PEDIDO
  FROM    ECOMMERCE.PEDIDO
  WHERE   ID_STATUS NOT IN (1, 2, 5) ;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


DROP INDEX ECOMMERCE.IX_PEDIDO_IDSTATUS;
CREATE BITMAP INDEX ECOMMERCE.IX_PEDIDO_IDSTATUS ON ECOMMERCE.PEDIDO(ID_STATUS);
exec dbms_stats.gather_table_stats('ECOMMERCE','PEDIDO');

-- execute novamente o mesmo SQL:
EXPLAIN PLAN FOR
  SELECT  CD_PEDIDO, DT_PEDIDO
  FROM    ECOMMERCE.PEDIDO
  WHERE   ID_STATUS NOT IN (1, 2, 5) ;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- ou escreva invertendo os valores:
EXPLAIN PLAN FOR
  SELECT  CD_PEDIDO, DT_PEDIDO 
  FROM    ECOMMERCE.PEDIDO
  WHERE   ID_STATUS IN (3, 4);
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- na situacao abaixo o indice sera utilizado, mesmo com o NOT, pois eh mais barato ler o indice para contar a qtde de linhas do q ler a tabela:
EXPLAIN PLAN FOR
  SELECT  count(1)
  FROM    ECOMMERCE.PEDIDO
  WHERE   ID_STATUS NOT IN (1, 2, 5) ;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

