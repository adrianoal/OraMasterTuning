-- Coletando estatisticas de uma tabela:
EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'ECOMMERCE', TABNAME=>'PEDIDO');  

-- Coletando estatisticas estimadas (amostragem) de um schema:
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('ECOMMERCE', estimate_percent=> 1);  -- 12,85s
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('ECOMMERCE', estimate_percent=> 100);  -- 57,03s
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('ECOMMERCE');  -- 17,74s

-- Coletando estatisticas exatas de todo o banco de dados (NAO EXECUTAR AGORA POIS DEMORA MUITO):  
EXEC DBMS_STATS.GATHER_DATABASE_STATS;