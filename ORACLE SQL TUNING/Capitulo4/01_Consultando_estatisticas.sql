-- ver estatisticas de tabelas
SELECT * FROM DBA_TABLES 
WHERE OWNER IN ('SOE','ECOMMERCE') ORDER BY 1,2;

-- ver estatisticas de colunas
SELECT * FROM DBA_TAB_COL_STATISTICS
WHERE OWNER IN ('SOE','ECOMMERCE') ORDER BY 1,2;

-- ver estatisticas de indices
SELECT * FROM DBA_INDEXES 
WHERE OWNER IN ('SOE','ECOMMERCE') ORDER BY 1,2;

-- ver estatisticas adicionais de indices, tais como o clustering factor:
SELECT * FROM DBA_IND_STATISTICS 
WHERE OWNER IN ('SOE','ECOMMERCE') ORDER BY 1,2;

-- verificar atualizacoes que ainda nao constam nas estatisticas
select      table_owner, table_name, partition_name, inserts, updates, deletes, to_char(timestamp, 'yyyy/mm/dd hh24:mi:ss') AS "TIMESTAMP"            
from        dba_tab_modifications 
WHERE       table_owner IN ('SOE','ECOMMERCE')
order by    6 desc;

-- atualizar "dba_tab_modifications":
exec dbms_stats.flush_database_monitoring_info;

-- verificar historico de estatisticas coletadas (retencao PADRAO de 31 dias)
select * from dba_tab_stats_history 
WHERE owner IN ('SOE','ECOMMERCE') order by 5 desc;

-- Verificar operacoes de coletas de estatisticas que foram realizadas no BD (manuais e automaticas). Coluna NOTES contem parametros utilizados na coleta.
SELECT      OPERATION, TARGET, START_TIME, 
            (END_TIME - START_TIME) DAY(1) TO SECOND(0) AS DURATION,
            STATUS, NOTES 
FROM        DBA_OPTSTAT_OPERATIONS
ORDER BY    start_time DESC;

-- ver informacoes detalhadas sobre operacoes de coleta de estatisticas que ocorreram em um determinado periodo (novo no 12c) em formato HTML:
SELECT      DBMS_STATS.REPORT_STATS_OPERATIONS(since=> systimestamp-7, 
                                              until=> systimestamp,
                                              detail_level=> 'TYPICAL',
                                              format=> 'HTML') as report
FROM		DUAL;



