-- crie a visao VW_EMP:
CREATE or REPLACE VIEW HR.VW_EMP AS 
    SELECT      e.*, d.department_name
    FROM        hr.employees e    
    INNER JOIN  hr.departments d
        ON      e.department_id = d.department_id
    WHERE       e.department_id=100;

-- execute um sql na visao, sem interferencia do query transformer (que faz um "predicate pushing")
EXPLAIN PLAN FOR 
  SELECT    /*+ NO_QUERY_TRANSFORMATION */ E.FIRST_NAME, E.LAST_NAME, E.EMAIL, e.department_name
  FROM      HR.VW_EMP E
  WHERE     last_name = 'Chen';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- execute o sql na visao e veja o novo PE (com menos passos e menos bytes)
EXPLAIN PLAN FOR 
  SELECT    E.FIRST_NAME, E.LAST_NAME, E.EMAIL, e.department_name
  FROM      HR.VW_EMP E
  WHERE     last_name = 'Chen';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Para mais info, consulte: http://www.dba-oracle.com/t_tuning_sql_execution_views.htm