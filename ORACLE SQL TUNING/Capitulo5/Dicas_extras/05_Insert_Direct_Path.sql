create table hr.emp_origem as select * from hr.employees where 1=0;
create table hr.emp_destino as select * from hr.employees where 1=0;
/

INSERT INTO HR.emp_origem
SELECT * FROM HR.EMPLOYEES E CONNECT BY level <= 3;
/

-- executar o script abaixo e comparar tempo das 3 execucoes (insert convencion, append e append c/ nologging:
SET SERVEROUTPUT ON
DECLARE 
  	L_START         NUMBER;    
BEGIN 
  EXECUTE IMMEDIATE 'ALTER TABLE HR.emp_destino LOGGING';

  L_START := DBMS_UTILITY.GET_TIME;
  -- executa insert convencional
  INSERT INTO HR.emp_destino
  SELECT * FROM HR.emp_origem;
  -- Tempo de um insert convencional 
  DBMS_OUTPUT.PUT_LINE('INSERT convencional: ' || round((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');  
  -- desfaz insercao dos dados
  execute immediate 'TRUNCATE TABLE HR.emp_destino';
  
  L_START := DBMS_UTILITY.GET_TIME;  
  -- executa insert direct path
  INSERT  /*+ APPEND */ INTO HR.emp_destino
  SELECT /*+ NO_GATHER_OPTIMIZER_STATISTICS */ * FROM HR.emp_origem;
  DBMS_OUTPUT.PUT_LINE('INSERT c/ direct path: ' || round((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');
  execute immediate 'TRUNCATE TABLE HR.emp_destino';
  
  EXECUTE IMMEDIATE 'ALTER TABLE HR.emp_destino NOLOGGING';
  
  L_START := DBMS_UTILITY.GET_TIME;  
  -- executa insert direct path c/ minimal logging
  INSERT  /*+ APPEND */ INTO HR.emp_destino
  SELECT /*+ NO_GATHER_OPTIMIZER_STATISTICS */ * FROM HR.emp_origem;
  DBMS_OUTPUT.PUT_LINE('INSERT c/ direct path e minimal logging: ' || round((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');
  execute immediate 'TRUNCATE TABLE HR.emp_destino';
END;