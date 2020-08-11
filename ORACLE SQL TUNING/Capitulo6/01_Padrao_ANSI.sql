-- mostrar todos os empregados do relacionamento entre employees e departments + departamentos sem empregados + empregados sem departamentos

-- dialeto Oracle (FULL outer join = left join + right join)
EXPLAIN PLAN FOR
  SELECT      e.first_name || e.last_name NAME, 
              D.DEPARTMENT_NAME 
  FROM        HR.EMPLOYEES E,
              HR.DEPARTMENTS D
  WHERE       E.DEPARTMENT_ID = D.DEPARTMENT_ID (+)
  UNION 
  SELECT      e.first_name || e.last_name NAME, 
              D.DEPARTMENT_NAME 
  FROM        HR.EMPLOYEES E,
              HR.DEPARTMENTS D
  WHERE       E.DEPARTMENT_ID (+) = D.DEPARTMENT_ID;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- padrao ANSI
EXPLAIN PLAN FOR
  SELECT      E.FIRST_NAME || E.LAST_NAME NAME, 
              D.DEPARTMENT_NAME 
  FROM        HR.EMPLOYEES E
  full outer JOIN   HR.DEPARTMENTS D
      ON      E.DEPARTMENT_ID = D.DEPARTMENT_ID;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);