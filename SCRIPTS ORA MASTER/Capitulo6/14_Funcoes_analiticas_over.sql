-- retornar lista de empregados, departamento e total de empregados por depto.
explain plan for
    SELECT    e.first_name || ' ' || E.LAST_NAME AS NAME,
              d.department_name,
              NULL AS TOTAL_EMP_DEP
    FROM      HR.EMPLOYEES E
    JOIN      HR.DEPARTMENTS D
      ON      E.DEPARTMENT_ID = D.DEPARTMENT_ID
    UNION ALL
    SELECT    NULL,
              d.department_name,
              COUNT(E.EMPLOYEE_ID) AS TOTAL_EMP_DEP
    FROM      HR.EMPLOYEES E
    JOIN      HR.DEPARTMENTS D
      ON      E.DEPARTMENT_ID = D.DEPARTMENT_ID
    GROUP BY  d.department_name
    ORDER BY  2, 1;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

explain plan for
    SELECT    e.first_name || ' ' || E.LAST_NAME AS NAME,
              d.department_name,
              COUNT(e.employee_id) OVER (PARTITION BY D.DEPARTMENT_ID) AS TOTAL_EMP_DEP
    FROM      HR.EMPLOYEES E
    JOIN      HR.DEPARTMENTS D
      ON      E.DEPARTMENT_ID = D.DEPARTMENT_ID;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);  