EXPLAIN PLAN SET STATEMENT_ID = 'sql1' FOR
  SELECT *
  FROM   hr.employees e, hr.departments d
  WHERE  e.department_id = d.department_id
  AND    e.department_id = 10;
  
EXPLAIN PLAN SET STATEMENT_ID = 'sql2' FOR
  SELECT *
  FROM   hr.employees e, hr.departments d
  WHERE  e.department_id = d.department_id
  AND    e.department_id = 10;

select      LPAD(' ',2*(LEVEL-1))||operation "OPERATION", options "OPTIONS",
            DECODE(TO_CHAR(id),'0','COST = ' || NVL(TO_CHAR(position),'n/a'),
                object_name) "OBJECTNAME", id ||'-'|| NVL(parent_id, 0)||'-'||
                NVL(position, 0) " ORDER", optimizer "OPT"
from        plan_table
start with  id = 0
and         statement_id='sql1'
connect by  prior id = parent_id
and         statement_id='sql1';
