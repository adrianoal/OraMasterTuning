-- Para retornar top five salary, ao inves de:
EXPLAIN PLAN FOR
  SELECT  * 
  FROM    ( SELECT      employee_id, salary
            FROM 	    HR.EMPLOYEES
            ORDER BY 	salary desc)
  WHERE   ROWNUM <= 5;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Para retornar top five salary, escreva:
EXPLAIN PLAN FOR
  SELECT 	employee_id, salary
  FROM 	    HR.EMPLOYEES
  ORDER BY 	salary DESC
  FETCH FIRST 5 ROWS ONLY;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Para retornar salarios maiores da 6 a 10 posicao, ao inves de:
EXPLAIN PLAN FOR
  SELECT  * 
  FROM    (SELECT  ROWNUM AS LINHA, employee_id, salary
            FROM    (   SELECT    employee_id, salary
                        FROM 	    HR.EMPLOYEES
                        CONNECT BY level <= 3
                        ORDER BY 	salary desc)
            )          
  WHERE   LINHA >= 6 AND LINHA <=10;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Para retornar salarios maiores da 6 a 10 posicao, escreva:
EXPLAIN PLAN FOR
  SELECT 	  employee_id, salary
  FROM 	    HR.EMPLOYEES
  CONNECT BY level <= 3
  ORDER BY 	salary DESC
  OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY; -- 23s
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);