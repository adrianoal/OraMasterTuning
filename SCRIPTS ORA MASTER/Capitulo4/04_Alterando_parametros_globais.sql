-- GLOBAL PARA TODOS QUE NAO TEM VALORES PREDEFINIDOS (novos objetos + objetos em q nunca foram executados SET_SCHEMA_PREFS ou SET_TABLE_PREFS)
-- DATABASE PARA TODOS QUE POSSUEM VALORES PREDEFINIDOS
    

-- configurando percentual de linhas a serem analisadas para a coleta de estatisticas
-- A Oracle recomenda mudar ESTIMATE_PERCENT somente se a coluna tiver muitos valores dispersos
BEGIN
    DBMS_STATS.SET_GLOBAL_PREFS('ESTIMATE_PERCENT','80'); -- valor permitido entre 1 e 100 + constante DBMS_STATS.AUTO_SAMPLE_SIZE (default). Segundo a Oracle o valor default produz
                                                            -- estatisticas muito boas e um tempo 10 X mais rapido que o valor de 100%.
END;

-- configurando paralelismo:
BEGIN
    DBMS_STATS.SET_GLOBAL_PREFS('DEGREE',2);  -- ver CPU_COUNT p/ configurar valor apropriado, o default nao utiliza paralelismo.
END;

show parameter cpu_count

-- configurando percentual de linhas alteradas para permitir atualizacao (valor default eh 10):
BEGIN
    DBMS_STATS.SET_GLOBAL_PREFS('STALE_PERCENT','20'); -- Valor default eh 10%
END;

-- coletar estatisticas de objetos dependentes (indices) -- o default eh DBMS_STATS.AUTO_CASCADE, onde o Oracle decide sozinho se coleta ou nao estatistica de objeto dependente, conforme a necessidade
BEGIN
	DBMS_STATS.SET_GLOBAL_PREFS('CASCADE', 'true'); -- eh equivalente ao gather_table_stats + gather_index_stats para cada indice na tabela 
END;

-- Alterando STALE_PERCENT de um SCHEMA inteiro
BEGIN
    DBMS_STATS.SET_SCHEMA_PREFS('ECOMMERCE','STALE_PERCENT','5'); 
END;


-- Alterando STALE_PERCENT de um unico objeto
BEGIN
    DBMS_STATS.SET_TABLE_PREFS('ECOMMERCE','PEDIDO','STALE_PERCENT','5'); 
END;

-- Alterando DEGREE de um unico objeto
BEGIN
    DBMS_STATS.SET_TABLE_PREFS('ECOMMERCE','ITEM_PEDIDO','DEGREE','4'); 
END;

-- Alterando configuracao em DATABASE
BEGIN
    DBMS_STATS.SET_DATABASE_PREFS('STALE_PERCENT',20); 
END;

BEGIN
    DBMS_STATS.SET_DATABASE_PREFS('DEGREE',2); 
END;

BEGIN
    DBMS_STATS.SET_GLOBAL_PREFS('DEGREE',4);  -- ver CPU_COUNT p/ configurar valor apropriado, o default eh nao utilizar paralelismo.
END;

-- Ver preferencias atuais configuradas no nivel dos objetos (equivalente a ver DATABASE preferences):
select * from dba_tab_stat_prefs where owner in ('SOE','ECOMMERCE');

-- ver preferencias globais c/ SQL:
SELECT 
  DBMS_STATS.get_prefs(pname=>'DEGREE') degree,
  DBMS_STATS.get_prefs(pname=>'GRANULARITY') granularity,
  DBMS_STATS.get_prefs(pname=>'STALE_PERCENT') stale_percent,
  DBMS_STATS.get_prefs(pname=>'ESTIMATE_PERCENT') estimate_percent,
  DBMS_STATS.get_prefs(pname=>'CASCADE') cascade,  
  DBMS_STATS.get_prefs(pname=>'METHOD_OPT') method_opt,
  DBMS_STATS.get_prefs(pname=>'INCREMENTAL') incremental,
  DBMS_STATS.get_prefs(pname=>'CONCURRENT') concurrent  
FROM dual;

-- ver preferencias globais c/ PL/SQL:
SET ECHO OFF
SET TERMOUT ON
SET SERVEROUTPUT ON
SET TIMING OFF
DECLARE
   v1  varchar2(100);
   v2  varchar2(100);
   v3  varchar2(100);
   v4  varchar2(100);
   v5  varchar2(100);
   v6  varchar2(100);
   v7  varchar2(100);
   v8  varchar2(100);
   v9  varchar2(100);
   v10 varchar2(100);        
BEGIN
   dbms_output.put_line('Automatic Stats Gathering Job - Parameters');
   dbms_output.put_line('==========================================');
   v1 := dbms_stats.get_prefs('AUTOSTATS_TARGET');
   dbms_output.put_line(' AUTOSTATS_TARGET:  ' || v1);
   v2 := dbms_stats.get_prefs('CASCADE');
   dbms_output.put_line(' CASCADE:           ' || v2);
   v3 := dbms_stats.get_prefs('DEGREE');
   dbms_output.put_line(' DEGREE:            ' || v3);
   v4 := dbms_stats.get_prefs('ESTIMATE_PERCENT');
   dbms_output.put_line(' ESTIMATE_PERCENT:  ' || v4);
   v5 := dbms_stats.get_prefs('METHOD_OPT');
   dbms_output.put_line(' METHOD_OPT:        ' || v5);
   v6 := dbms_stats.get_prefs('NO_INVALIDATE');
   dbms_output.put_line(' NO_INVALIDATE:     ' || v6);
   v7 := dbms_stats.get_prefs('GRANULARITY');
   dbms_output.put_line(' GRANULARITY:       ' || v7);
   v8 := dbms_stats.get_prefs('PUBLISH');
   dbms_output.put_line(' PUBLISH:           ' || v8);
   v9 := dbms_stats.get_prefs('INCREMENTAL');
   dbms_output.put_line(' INCREMENTAL:       ' || v9);
   v10:= dbms_stats.get_prefs('STALE_PERCENT');
   dbms_output.put_line(' STALE_PERCENT:     ' || v10);
END;