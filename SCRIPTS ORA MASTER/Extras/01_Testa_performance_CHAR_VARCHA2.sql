-- TESTANDO A PERFORMANCE DE CHAR X VARCHAR2
--DROP TABLE ECOMMERCE.CLIENTE2;

-- TESTE 1: criando a table para testes (CLIENTE2) com as colunas CHAR
CREATE TABLE ECOMMERCE.CLIENTE2
  (
    CD_CLIENTE    NUMBER NOT NULL ENABLE,
    NM_CLIENTE    CHAR(50 BYTE) NOT NULL ENABLE,
    ID_SEXO       CHAR(1 BYTE),
    TP_CLIENTE    NUMBER(1,0) NOT NULL ENABLE,
    NU_CPF_CGC    NUMBER(14,0) NOT NULL ENABLE,
    DT_NASCIMENTO DATE NOT NULL ENABLE,
    NM_EMAIL      CHAR(50 BYTE) NOT NULL ENABLE,
    NU_TELEFONE   NUMBER(10,0) NOT NULL ENABLE,
    NM_ENDERECO   CHAR(100 BYTE) NOT NULL ENABLE,
    NM_CIDADE     CHAR(50 BYTE) NOT NULL ENABLE,
    CD_UF         NUMBER NOT NULL ENABLE,
    DT_CADASTRO   DATE NOT NULL ENABLE,
    ID_STATUS     NUMBER(1,0) NOT NULL ENABLE,
    NU_CELULAR    NUMBER(10,0)
  );  
/

-- teste de performance de insercao de dados em CHAR
SET SERVEROUTPUT ON
DECLARE
  L_START         NUMBER;    
BEGIN
  L_START := DBMS_UTILITY.GET_TIME;
  INSERT INTO ECOMMERCE.CLIENTE2 SELECT * FROM ECOMMERCE.CLIENTE;
  INSERT INTO ECOMMERCE.CLIENTE2 SELECT * FROM ECOMMERCE.CLIENTE;
  INSERT INTO ECOMMERCE.CLIENTE2 SELECT * FROM ECOMMERCE.CLIENTE;  
  DBMS_OUTPUT.PUT_LINE('Tempo total das inser��o em CHAR: ' || round((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');
  -- commita inser��es
  COMMIT;    
END;
/

ANALYZE TABLE ECOMMERCE.CLIENTE2 COMPUTE STATISTICS;
/

-- teste de peformance de select em char
EXPLAIN PLAN FOR
 SELECT * FROM  ECOMMERCE.CLIENTE2 WHERE NM_CLIENTE = 'Was Snywi'; 
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
/

-- TESTANDO A PERFORMANCE DE CHAR X VARCHAR2
DROP TABLE ECOMMERCE.CLIENTE2;
/

-- TESTE 2: criando a table para testes (CLIENTE2) com as colunas VARCHAR2
CREATE TABLE ECOMMERCE.CLIENTE2
  (
    CD_CLIENTE    NUMBER NOT NULL ENABLE,
    NM_CLIENTE    VARCHAR2(50 BYTE) NOT NULL ENABLE,
    ID_SEXO       VARCHAR2(1 BYTE),
    TP_CLIENTE    NUMBER(1,0) NOT NULL ENABLE,
    NU_CPF_CGC    NUMBER(14,0) NOT NULL ENABLE,
    DT_NASCIMENTO DATE NOT NULL ENABLE,
    NM_EMAIL      VARCHAR2(50 BYTE) NOT NULL ENABLE,
    NU_TELEFONE   NUMBER(10,0) NOT NULL ENABLE,
    NM_ENDERECO   VARCHAR2(100 BYTE) NOT NULL ENABLE,
    NM_CIDADE     VARCHAR2(50 BYTE) NOT NULL ENABLE,
    CD_UF         NUMBER NOT NULL ENABLE,
    DT_CADASTRO   DATE NOT NULL ENABLE,
    ID_STATUS     NUMBER(1,0) NOT NULL ENABLE,
    NU_CELULAR    NUMBER(10,0)
  );  
/

-- teste de performance de insercao de dados em CHAR
SET SERVEROUTPUT ON
DECLARE
  L_START         NUMBER;    
BEGIN
  L_START := DBMS_UTILITY.GET_TIME;
  INSERT INTO ECOMMERCE.CLIENTE2 SELECT * FROM ECOMMERCE.CLIENTE;
  INSERT INTO ECOMMERCE.CLIENTE2 SELECT * FROM ECOMMERCE.CLIENTE;
  INSERT INTO ECOMMERCE.CLIENTE2 SELECT * FROM ECOMMERCE.CLIENTE;  
  DBMS_OUTPUT.PUT_LINE('Tempo total das inser��o em CHAR: ' || round((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');
  -- commita inser��es
  COMMIT;    
END;
/

ANALYZE TABLE ECOMMERCE.CLIENTE2 COMPUTE STATISTICS;
/

-- teste de peformance de select em char
EXPLAIN PLAN FOR
 SELECT * FROM  ECOMMERCE.CLIENTE2 WHERE NM_CLIENTE = 'Was Snywi'; 
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
/





