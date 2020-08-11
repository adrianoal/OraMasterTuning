-- deletar e bloquear coleta de estatisticas para um objeto
BEGIN
  DBMS_STATS.DELETE_TABLE_STATS('ECOMMERCE','UF');
  DBMS_STATS.LOCK_TABLE_STATS('ECOMMERCE','UF');
END;
/


-- permite coletar estatisticas automaticas em multiplas tabelas e multiplas particoes diferentes concorrentemente, separando o trabalho em diversos jobs:
BEGIN
    DBMS_STATS.SET_GLOBAL_PREFS('CONCURRENT','AUTOMATIC'); 
	
END;

-- permite coletar estatisticas somente de particoes que sofreram atualizacoes e nao a tabela particionada inteira
BEGIN
    DBMS_STATS.SET_GLOBAL_PREFS('INCREMENTAL','TRUE'); 
END;



