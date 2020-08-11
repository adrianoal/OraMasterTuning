-- considerando que vc tera que fazer consultas frequentes filtrando NM_EMAIL, compare o plano de execucao antes e depois da criacao do indice

-- gerando o PE antes de criar o indice
EXPLAIN PLAN FOR
  SELECT  CD_CLIENTE, NM_CLIENTE, DT_NASCIMENTO 
  FROM    ECOMMERCE.CLIENTE
  WHERE   NM_EMAIL = 'sagko@com.br';
SELECT * FROM TABLE(dbms_xplan.DISPLAY);
  
-- criando um indice btree na coluna NM_EMAIL da tabela ECOMMERCE.CLIENTE
CREATE INDEX ECOMMERCE.IX_CLIENTE_NMEMAIL ON ECOMMERCE.CLIENTE(NM_EMAIL);

-- gerando o PE depois de criar o indice p/ comparar com o 1o. PE
EXPLAIN PLAN FOR
  SELECT  CD_CLIENTE, NM_CLIENTE, DT_NASCIMENTO 
  FROM    ECOMMERCE.CLIENTE
  WHERE   NM_EMAIL = 'sagko@com.br';
SELECT * FROM TABLE(dbms_xplan.DISPLAY);