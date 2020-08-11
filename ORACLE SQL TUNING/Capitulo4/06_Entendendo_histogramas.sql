--1: VER COLUNAS QUE POSSUEM HISTOGRAMAS na tabela CLIENTE
select    COLUMN_NAME, NUM_DISTINCT, HISTOGRAM, NUM_BUCKETS,
          to_char(LAST_ANALYZED,'yyyy-dd-mm hh24:mi:ss') LAST_ANALYZED
from      dba_tab_col_statistics
where     table_name='CLIENTE'
and       owner = 'ECOMMERCE'
AND       HISTOGRAM <> 'NONE';

-- coletar estatisticas da tabela CLIENTE gerando histogramas nas colunas que o Oracle achar q precisa
BEGIN
    DBMS_STATS.gather_table_stats('ECOMMERCE', 'CLIENTE', 
              estimate_percent => 100, method_opt => 'FOR ALL COLUMNS SIZE AUTO',
              granularity => 'ALL', cascade => TRUE);
END;

-- VER HISTOGRAMA DA COLUNA CD_UF (observar cada valor e qtde de ocorrencias dele)
SELECT    endpoint_value as valor, endpoint_number as qtd_ocorrencias
FROM      dba_histograms
WHERE     TABLE_NAME = 'CLIENTE' AND column_name = 'CD_UF';

-- Execute o comando abaixo, execute novamente a primeira consulta desse script e identifique o que ocorreu com relacao aos histogramas da tabela CLIENTE:
ANALYZE TABLE ECOMMERCE.CLIENTE COMPUTE STATISTICS;

-- deletar estatisticas de uma coluna (neste exemplo, na CD_UF):
begin
  DBMS_STATS.DELETE_COLUMN_STATS (
   ownname       => 'ECOMMERCE', 
   tabname       => 'CLIENTE', 
   colname       => 'CD_UF', 
   force         => TRUE);
end;

-- forcar criacao de histograma na coluna cd_uf da tabela cliente com ate 254 buckets:
BEGIN 
    dbms_stats.Gather_table_stats('ECOMMERCE', 'CLIENTE', 
    method_opt => 'FOR COLUMNS SIZE 254 CD_UF'); 
END; 

-- Execute NOVAMENTE o comando abaixo para matar todos os histogramas da tabela CLIENTE:
ANALYZE TABLE ECOMMERCE.CLIENTE COMPUTE STATISTICS;

-- coletar estatisticas somente de colunas com valores distribuidos nao uniformemente e que possuem indices (aquelas que realmente necessitam de histogramas), depois execute a primeira consulta desse script novamente:
-- EXECUTE O ANALYZE ANTES PARA LIMPAR TODOS OS HISTOGRAMAS E VER RESULTADO ISOLADO DO PROXIMO SCRIPT 
BEGIN 
    DBMS_STATS.gather_table_stats('ECOMMERCE', 'CLIENTE', 
                cascade => TRUE, estimate_percent => 100, 
                method_opt => 'FOR ALL INDEXED COLUMNS SIZE SKEWONLY');
END;

-- execute o script para MANTER somente os histogramas atuais DA TABELA CLIENTE:
EXEC DBMS_STATS.SET_TABLE_PREFS('ECOMMERCE', 'CLIENTE', 'METHOD_OPT','FOR ALL COLUMNS SIZE REPEAT');

-- Execute o script abaixo se quiser MANTER os histogramas atuais do BD inteiro:
EXEC DBMS_STATS.SET_GLOBAL_PREFS('METHOD_OPT','FOR ALL COLUMNS SIZE REPEAT');

-- colete estatisticas da tabela CLIENTE e veja (executando novamente o primeiro sql desse script) que agora somente os histogramas em colunas com valores nao uniforme e que possuem indices estao sendo mantidos:
EXEC DBMS_STATS.GATHER_TABLE_STATS('ECOMMERCE', 'CLIENTE');
