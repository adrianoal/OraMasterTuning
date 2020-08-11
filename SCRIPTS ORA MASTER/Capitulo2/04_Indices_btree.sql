-- considerando que vc tera que fazer consultas frequentes filtrando NM_EMAIL, compare o plano de execucao antes e depois da criacao do indice

-- gerando o PE antes de criar o indice
EXPLAIN PLAN FOR
  SELECT  CD_CLIENTE, NM_CLIENTE, DT_NASCIMENTO 
  FROM    ECOMMERCE.CLIENTE
  WHERE   NM_EMAIL = 'sagko@com.br';
SELECT * FROM TABLE(dbms_xplan.DISPLAY);

/*
Descri��o b�sica das estat�sticas:
    ROWS: N�mero estimado de linhas resultantes de uma execu��o da opera��o examinada e que ser�o entregues a opera��o pai.
    BYTES: N�mero estimado de bytes (rows x estimativa tamanho m�dio do registro) resultantes de uma execu��o da opera��o examinada e que ser�o entregues a opera��o pai.
    COST: N�mero estimado de recursos necess�rios para uma execu��o da opera��o examinada.
    TIME: Tempo de resposta estimado (horas:minutos:segundos) para execu��o da opera��o um vez e como a coluna COST,
*/    



-- criando um indice btree na coluna NM_EMAIL da tabela ECOMMERCE.CLIENTE
CREATE INDEX ECOMMERCE.IX_CLIENTE_NMEMAIL ON ECOMMERCE.CLIENTE(NM_EMAIL);

/*
    B-tree:
     � �ndice default no Oracle, tamb�m conhecido como normal;
     � Possui estrutura de �rvore bin�ria, balanceada, e � indicado somente p/ alta cardinalidade.
    
    ? Utilizar em colunas que possuem alta cardinalidade;
    ? Segundo a Oracle, s�o eficientes em consultas que retornam at� 4% do total de linhas de uma tabela;
    ? N�o armazenam valores nulos (exceto cluster B*Tree indexes).
    ? Mais utilizado e mais comum em ambientes OLTP;
    
*/
-- pesquisar sintaxe para desabilitar o indice...
ALTER INDEX ECOMMERCE.IX_CLIENTE_NMEMAIL  REBUILD;
ALTER INDEX ECOMMERCE.IX_CLIENTE_NMEMAIL  UNUSABLE;
--------------------------------------------------------------
--Exemplo da cria��o de �ndice no Oracle em mais de um campo na tabela
CREATE INDEX nome_do_indice
   ON nome_da_tabela (nome_do_campo_onde_ficara_o_indice, nome_do_campo_onde_ficara_o_indice);


--Exemplo da altera��o de �ndice no Oracle, renomear.
ALTER INDEX nome_do_indice_atual
   RENAME TO nome_do_novo_indice;
  
  
/ 
   
--Exemplo para checar a quantidade de �ndices em uma tabela no Oracle
SELECT table_name AS �NOME DA TABELA�, count(1) AS �QTDE. DE INDICES� FROM dba_indexes WHERE owner=�SEU_SCHEMA� GROUP BY table_name;

SELECT ECOMMERCE.CLIENTE AS NOME_TABELA,
       COUNT(*)AS QTDE_INDICE
FROM dba_indexes
WHERE OWNER = 'ECOMMERCE'
GROUP BY ECOMMERCE.CLIENTE;

/
--SELECT USER FROM DUAL;   
--select * from ecommerce.cliente;
--Exemplo da exclus�o de �ndice no Oracle
DROP INDEX nome_do_indice; 
--DROP INDEX ECOMMERCE.IX_CLIENTE_NMEMAIL; 


--Exemplo de uma consulta for�ando a utiliza��o de �ndice no Oracle
SELECT INDEX (nome_do_indice)
campos_da_tabela
FROM nome_dos_campos
WHERE cl�usulas;
/
SELECT *
FROM ECOMMERCE.CLIENTE WHERE ROWNUM <2;
SELECT /*+ index(CLIENTE ECOMMERCE.IX_CLIENTE_NMEMAIL)*/
FROM CLIENTE F
WHERE F.NM_CLIENTE = 'Mof Uubju'
 AND F.CD_CLIENTE = 72



--------------------------------------------------------------

-- gerando o PE depois de criar o indice p/ comparar com o 1o. PE
EXPLAIN PLAN FOR
  SELECT  CD_CLIENTE, NM_CLIENTE, DT_NASCIMENTO 
  FROM    ECOMMERCE.CLIENTE
  WHERE   NM_EMAIL = 'sagko@com.br';
SELECT * FROM TABLE(dbms_xplan.DISPLAY);