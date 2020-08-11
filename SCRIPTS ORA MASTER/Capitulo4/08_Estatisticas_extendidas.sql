-- criar estatisticas extendidas de grupo nas colunas envolvidas na condicao de pesquisa e retornar nome da coluna virtual
select  dbms_stats.create_extended_stats('SOE','CUSTOMERS','(CREDIT_LIMIT, ACCOUNT_MGR_ID)') from dual;

-- colete estatisticas na tabela:
exec dbms_stats.gather_table_stats('SOE','CUSTOMERS',METHOD_OPT=> 'for all columns size AUTO'); -- 270s

-- para ver todas as estatisticas extendidas do schema SOE:
select * from dba_stat_extensions WHERE OWNER = 'SOE';

-- apagar as estatisticas extendidas:
EXEC dbms_stats.DROP_EXTENDED_STATS('SOE','CUSTOMERS','(CREDIT_LIMIT, ACCOUNT_MGR_ID)');