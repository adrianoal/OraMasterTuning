-- AQUI SIMULAREMOS COMO VER O PE DE UM SQL QQ, QUE NAO FOI EXECUTADA NA SUA SESSAO

-- execute a instrucao sql
SELECT *
FROM   hr.employees e, hr.departments d
WHERE  e.department_id = d.department_id
AND    e.department_id = 10;

-- qdo o SQL for de outra sessao identifique o sql_id da instrucao sql executada anteriormente
select  sql_id, sql_fulltext 
from    v$sqlstats 
where   sql_text = 'SELECT * FROM   hr.employees e, hr.departments d WHERE  e.department_id = d.department_id AND    e.department_id = 10';

-- veja o plano de execucao real da instrucao sql executada anteriormente
SELECT * FROM TABLE(dbms_xplan.display_cursor('&sql_id'));