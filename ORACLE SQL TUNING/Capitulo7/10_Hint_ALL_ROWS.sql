alter session set optimizer_mode = first_rows;

-- Ao inves de:
EXPLAIN PLAN FOR
    SELECT	        e.employee_id, 
            		E.FIRST_NAME || ' ' || E.LAST_NAME EMPLOYEE_NAME, 
                    J.JOB_TITLE,                   
            		M.FIRST_NAME || ' ' || M.LAST_NAME AS MANAGER_NAME,
            		M.JOB_TITLE AS MANAGER_JOB                  
    FROM            HR.EMPLOYEES E
    LEFT JOIN       (   SELECT	    M.FIRST_NAME,  M.LAST_NAME,  M.EMPLOYEE_ID, JM.JOB_TITLE
                        FROM        HR.EMPLOYEES M  
            		    INNER JOIN  HR.JOBS JM
                      		ON      M.JOB_ID = JM.JOB_ID) M
        ON	        M.EMPLOYEE_ID = E.MANAGER_ID    
    INNER JOIN      HR.JOBS J
        ON          E.JOB_ID = J.JOB_ID;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Escreva:
EXPLAIN PLAN FOR
    SELECT	            /*+ ALL_ROWS */  e.employee_id, 
                        E.FIRST_NAME || ' ' || E.LAST_NAME EMPLOYEE_NAME, 
                        J.JOB_TITLE,                   
                        M.FIRST_NAME || ' ' || M.LAST_NAME AS MANAGER_NAME,
                        M.JOB_TITLE AS MANAGER_JOB                  
    FROM                HR.EMPLOYEES E
    LEFT JOIN           (SELECT	    M.FIRST_NAME,  M.LAST_NAME,  M.EMPLOYEE_ID, JM.JOB_TITLE
                         FROM       HR.EMPLOYEES M  
                        INNER JOIN  HR.JOBS JM
                          ON        M.JOB_ID = JM.JOB_ID) M
            ON	        M.EMPLOYEE_ID = E.MANAGER_ID    
    INNER JOIN          HR.JOBS J
            ON          E.JOB_ID = J.JOB_ID;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- volte o valor padrao:
alter session set optimizer_mode = all_rows;