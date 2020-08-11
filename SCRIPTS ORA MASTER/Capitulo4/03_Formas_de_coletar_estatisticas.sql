-- coleta de estatisticas padrao (baseada em amostragem automatica)
BEGIN
  DBMS_STATS.GATHER_SCHEMA_STATS (
    ownname          => UPPER('&SCHEMA_NAME'),    
    cascade          => TRUE, -- COLETA DAS TABELAS E DOS INDICES
    options          => 'GATHER AUTO'); -- o oracle (eh igual a EMPTY + stale)
END;

-- coleta de estatisticas completa (demora em media 4 vezes mais que a anterior, mas as estatisticas sao mais PRECISAS)
BEGIN
  DBMS_STATS.GATHER_SCHEMA_STATS (
    OWNNAME             => UPPER('&SCHEMA_NAME'),
    ESTIMATE_PERCENT   => 100 , -- a opcao default DBMS_STATS.AUTO_SAMPLE_SIZE melhora tempo de coleta e produz resultado satisfatorio a partir do 11G 
    CASCADE          => TRUE, -- coleta estatisticas de objetos dependentes das tabelas (indices)
    options          => 'GATHER'); -- coleta estatisticas de todos os objetos 
END;

-- coleta de estatisticas completa utilizando paralelismo
BEGIN
  DBMS_STATS.GATHER_SCHEMA_STATS (
    OWNNAME             => UPPER('&SCHEMA_NAME'),    
    DEGREE              => 2, -- este parametro permite configurar DOP (degree of parallelism) CPUs
    CASCADE             => TRUE,
    options             => 'GATHER EMPTY'); -- coleta estatisticas somente de objetos sem estatisticas
END;

BEGIN
  DBMS_STATS.GATHER_SCHEMA_STATS (
    OWNNAME             => UPPER('&SCHEMA_NAME'),    
    DEGREE              => 2, -- este parametro permite configurar DOP (degree of parallelism)
    CASCADE             => TRUE,
    options             => 'GATHER STALE'); -- coleta estatisticas somente dos objetos que estao obsoletos (% acima de STALE_PERCENT)
END;