-- coletar estatisticas de uma tabela:
EXEC DBMS_STATS.GATHER_TABLE_STATS('&SCHEMA_NAME','&TABLE_NAME');

-- coletar estatisticas de um indice:
EXEC DBMS_STATS.GATHER_INDEX_STATS('&SCHEMA_NAME','&INDEX_NAME');

-- coletar estatisticas de um schema:
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('&SCHEMA_NAME');

-- deletar estatisticas de uma tabela:
EXEC DBMS_STATS.DELETE_TABLE_STATS('&SCHEMA_NAME', '&TABLE_NAME');

-- deletar estatisticas de um schema:
EXEC DBMS_STATS.DELETE_SCHEMA_STATS('&SCHEMA_NAME');

-- ver SQL_ID, ADDRESS e HASH_VALUE de uma determinada instrucao:
SELECT SQL_ID, ADDRESS, HASH_VALUE, SQL_TEXT FROM V$SQLAREA 
WHERE SQL_TEXT LIKE '&SQL_TEXT%';

-- deletar SQL e seu PE da SGA:
exec DBMS_SHARED_POOL.PURGE ('&ADDRESS, &HASH_VALUE','C');

-- ver estatisticas de uma tabela:
SELECT * FROM DBA_TABLES WHERE OWNER = '&SCHEMA_NAME' AND TABLE_NAME = '&TABLE_NAME';

-- ver estatisticas de todas as tabelas de um schema:
SELECT * FROM DBA_TABLES WHERE OWNER = '&SCHEMA_NAME';

-- ver estatisticas de um indice:
SELECT * FROM DBA_INDEXES WHERE OWNER = '&SCHEMA_NAME' AND INDEX_NAME = '&TABLE_NAME';

-- ver PE estimado de um determinado SQL:
EXPLAIN PLAN FOR:
    <SQL>;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- ver PE real de um determinado SQL:
select * from table(dbms_xplan.display_cursor('&SQL_ID'));

-- limpar shared pool:
ALTER SYSTEM FLUSH SHARED_POOL;

-- configurar forcadamente estatisticas para uma determinada tabela (estatisticas FAKE):
EXEC DBMS_STATS.SET_TABLE_STATS(OWNNAME => '&SCHEMA_NAME', TABNAME => '&TABLE_NAME', NUMROWS => &NUM_ROWS);

-- criar indice FAKE (sem segmento):
alter session set "_USE_NOSEGMENT_INDEXES" = true;
create index <schema>.<index_name> on <schema>.<table_name>(<column_name>) nosegment;

-- tornar indice invisivel e visivel:
alter <schema>.<index_name> invisible;
alter <schema>.<index_name> visible;