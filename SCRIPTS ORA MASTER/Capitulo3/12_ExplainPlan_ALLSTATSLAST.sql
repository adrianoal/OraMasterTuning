-- execute a instrucao sql
SELECT /*+ GATHER_PLAN_STATISTICS */ * -- HINT
FROM   hr.employees e, hr.departments d
WHERE  e.department_id = d.department_id
AND    e.department_id = 10;

-- veja o plano de execucao real da ultima instrucao sql executada (acrescenta colunas estimated rows (E-Rows) X actual rows (A-Rows) + Actual Time (A-Time), que possui maior precisão de tempo (incluindo centésimos de segundos):
SELECT * FROM TABLE(dbms_xplan.display_cursor(FORMAT=>'ALLSTATS LAST'));

--------------------------------------------------------------------------
-- ao inves de usar o hint GATHER_PLAN_STATISTICS vc tbem pode alterar o valor do parametro STATISTICS_LEVEL e executar o SQL sem hint:
ALTER SESSION SET STATISTICS_LEVEL = ALL;

-- execute a instrucao sql novamente, sem o hint
SELECT *
FROM   hr.employees e, hr.departments d
WHERE  e.department_id = d.department_id
AND    e.department_id = 10;

SELECT * FROM TABLE(dbms_xplan.display_cursor(FORMAT=>'ALLSTATS LAST'));

ALTER SESSION SET STATISTICS_LEVEL = TYPICAL;