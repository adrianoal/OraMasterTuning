 set serveroutput on
 --CRIACAO DE TABELAS CLONE: CONDICAO WHERE 1=2 PARA QUE SEJA COPIADA SOMENTE A ESTRUTURA DA TABELA ORIGINAL
-- TRUNCATE TABLE HR.EMP2;
CREATE TABLE HR.EMP2 AS SELECT * FROM HR.EMPLOYEES WHERE 1=2;
CREATE TABLE HR.EMP3 AS SELECT * FROM HR.EMPLOYEES WHERE 1=2;
CREATE TABLE HR.EMP4 AS SELECT * FROM HR.EMPLOYEES WHERE 1=2;

set serveroutput on      
DECLARE    
    L_START         NUMBER;
    v_count         number;
BEGIN    
    --1: pl/SQL
    L_START := DBMS_UTILITY.GET_TIME;
    
    FOR CUR IN (SELECT  *
                FROM    hr.employees
                CONNECT BY level <= 2)
    LOOP
        IF cur.salary > 10000 THEN
            INSERT INTO HR.EMP2 VALUES CUR;
        ELSIF cur.manager_id > 200 THEN
            INSERT INTO HR.EMP3 VALUES CUR;
        ELSE
            INSERT INTO HR.EMP4 values CUR;
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('BLOCO 1 (INSERT COM IF EM PL/SQL):' || ROUND((DBMS_UTILITY.GET_TIME - L_START),2) || 'cs');
    rollback;
    
    --2: INSERT MULTITABLE (somente SQL)
    L_START := DBMS_UTILITY.GET_TIME;
    
    INSERT FIRST
        WHEN salary > 10000 THEN INTO hr.emp2 VALUES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
        WHEN manager_id > 200 THEN INTO hr.emp3 VALUES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
        ELSE INTO hr.emp4 VALUES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
    SELECT  *
    FROM    hr.employees
    CONNECT BY level <= 2;
    
    DBMS_OUTPUT.PUT_LINE('BLOCO 2 (INSERT MULTITABLE):' || ROUND((DBMS_UTILITY.GET_TIME - L_START),2) || 'cs');
    rollback;    
END;