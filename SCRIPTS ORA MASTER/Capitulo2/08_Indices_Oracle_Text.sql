-- ao inves de:
EXPLAIN PLAN FOR
  SELECT  * 
  FROM    ECOMMERCE.CLIENTE 
  WHERE   NM_CLIENTE LIKE '%ul%';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Execute o comando abaixo para criar o indice IX_NO_CLIENTE_OT:
create index ECOMMERCE.IX_NO_CLIENTE_OT on ECOMMERCE.CLIENTE(NM_CLIENTE) indextype is ctxsys.context;

-- Para testar o acesso ao indice, execute:
EXPLAIN PLAN FOR
  SELECT  * 
  FROM    ECOMMERCE.CLIENTE 
  WHERE   CONTAINS(NM_CLIENTE, '%ul%') > 0;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- **** CUIDADO: se o valor pesquisado ainda nao estiver no indice (programe atualizacao), a consulta nao retornara resultado esperado

-- para atualizar indices oracle text (nao precisa coletar estatisticas apos atualizacao)
exec ctx_ddl.sync_index('ECOMMERCE.IX_NO_CLIENTE_OT');

-- executar rebuild de indices oracle text:
exec CTX_DDL.OPTIMIZE_INDEX(idx_name => 'ECOMMERCE.IX_NO_CLIENTE_OT', optlevel => 'FULL');
