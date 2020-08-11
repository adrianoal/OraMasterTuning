alter system flush shared_pool;

-- veja o PE do SQL original:
EXPLAIN PLAN FOR
    SELECT * FROM HR.EMPLOYEES;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);    

-- execute o SQL original:
SELECT * FROM HR.EMPLOYEES;

-- veja o sql_id do SQL original:
SELECT  SQL_ID, SQL_FULLTEXT
FROM    V$SQL
WHERE   SQL_TEXT = 'SELECT * FROM HR.EMPLOYEES'; 

-- sql_id original = gdf7tm42kzut1

-- carregue no SPB o PE do SQL original:
declare
    v_ret number;
begin
    v_ret := dbms_spm.load_plans_from_cursor_cache(sql_id=> 'gdf7tm42kzut1');
end;

-- ver sql_handle e plan_name do SQL original:
select   b.sql_handle, b.plan_name, b.origin, b.accepted, b.enabled
from    dba_sql_plan_baselines b
where   dbms_lob.substr(sql_text,4000,1) = 'SELECT * FROM HR.EMPLOYEES';
    
-- sql_handle = SQL_9966171d4d89b8e4
-- plan_name = SQL_PLAN_9kthr3p6smf74cf314e9e
    
-- desative o SPB do SQL original:
declare
    v_ret number;
begin
    v_ret := dbms_spm.alter_sql_plan_baseline(sql_handle => 'SQL_9966171d4d89b8e4',
                                                plan_name => 'SQL_PLAN_9kthr3p6smf74cf314e9e',
                                                attribute_name => 'ENABLED',
                                                attribute_value => 'NO');
end;

-- ver se SPB do SQL original foi desativado:
select   b.sql_handle, b.plan_name, b.origin, b.accepted, b.enabled
from    dba_sql_plan_baselines b
where   dbms_lob.substr(sql_text,4000,1) = 'SELECT * FROM HR.EMPLOYEES';


--------------------------------------------------------------------------

-- veja o PE SQL alterado:
EXPLAIN PLAN FOR
    SELECT /*+ PARALLEL */ * FROM HR.EMPLOYEES;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);   

-- execute o SQL alterado:
SELECT /*+ PARALLEL */ * FROM HR.EMPLOYEES;

-- veja o sql_id e plan_hash_value do SQL alterado:
SELECT  SQL_ID, plan_hash_value, SQL_FULLTEXT
FROM    V$SQL
WHERE   SQL_TEXT = 'SELECT /*+ PARALLEL */ * FROM HR.EMPLOYEES'; 

-- sql_id alterado = 82n481mnn6tmu
-- plan_hash_value = 998304975

-- carregue no SPB o PE do SQL modificado junto com o sql_id do SQL original:
declare
    v_ret number;
begin
    v_ret := dbms_spm.load_plans_from_cursor_cache(sql_id=> '82n481mnn6tmu', -- informar aqui o sql_id do sql modificado
                                                    plan_hash_value => '998304975', -- informar aqui o plan_hash_value do sql modificado
                                                    sql_handle => 'SQL_9966171d4d89b8e4');  -- informar aqui o sql_handle do sql original
end;

-- ver sql_handle e plan_name do SQL modificado:
select   b.sql_handle, b.plan_name, b.origin, b.accepted, b.sql_text, b.enabled, b.created, b.LAST_MODIFIED
from    dba_sql_plan_baselines b
where   dbms_lob.substr(sql_text,4000,1) like 'SELECT%* FROM HR.EMPLOYEES';

-- gerar novo PE do sql original e ver q ele está usando paralelismo:
EXPLAIN PLAN FOR
    SELECT * FROM HR.EMPLOYEES;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);    

