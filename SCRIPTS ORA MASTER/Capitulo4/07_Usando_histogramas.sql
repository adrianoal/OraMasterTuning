-- ver se coluna CREDIT_LIMIT possui histograma:
select    COLUMN_NAME, NUM_DISTINCT, HISTOGRAM, NUM_BUCKETS,
          to_char(LAST_ANALYZED,'yyyy-dd-mm hh24:mi:ss') LAST_ANALYZED
from      dba_tab_col_statistics
where     table_name='CUSTOMERS'
and       owner = 'SOE'
AND       HISTOGRAM <> 'NONE'
AND       COLUMN_NAME = 'CREDIT_LIMIT';

-- criando indice na coluna CREDIT_LIMIT da tabela CUSTOMERS:
create  index SOE.IX_CUSTOMERS_TESTE on SOE.CUSTOMERS(CREDIT_LIMIT);  -- 36s

-- gerando histograma na coluna CREDIT_LIMIT da tabela CUSTOMERS
BEGIN -- 95s
    dbms_stats.Gather_table_stats('SOE', 'CUSTOMERS', 
    method_opt => 'FOR COLUMNS SIZE 254 CREDIT_LIMIT'); 
END; 

--1: verificar plano de execucao com valor que retorna poucas linhas:
EXPLAIN PLAN FOR
  SELECT  * 
  FROM    SOE.CUSTOMERS
  WHERE   CREDIT_LIMIT = 1000;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

--2: verificar plano de execucao com valor que retorna MUITAS linhas:
EXPLAIN PLAN FOR
  SELECT  * 
  FROM    SOE.CUSTOMERS
  WHERE   CREDIT_LIMIT = 6000;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

--3: verificar plano de execucao com valor que retorna MUITAS linhas FORCANDO usar INDICE (veja que o custo eh pior do sem forcar):
EXPLAIN PLAN FOR
  SELECT  /*+ FIRST_ROWS */ * 
  FROM    SOE.CUSTOMERS
  WHERE   CREDIT_LIMIT = 6000;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- apagando o indice de teste
DROP INDEX  SOE.IX_CUSTOMERS_TESTE;
