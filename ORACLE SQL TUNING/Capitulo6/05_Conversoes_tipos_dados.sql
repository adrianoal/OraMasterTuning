-- apague tabelas nao mais utilizadas:
drop table soe.order_items2 purge;
drop table soe.orders2 purge;
drop table soe.customers2 purge;
drop index SOE.IX_CUSTOMERS_FIRST_LAST_NAME;

-- crie um índice na coluna a ser filtrada nos proximos SQLs:
CREATE INDEX SOE.IX_CUSTOMERS_FIRST_LAST_NAME ON SOE.CUSTOMERS(CUST_FIRST_NAME); 

-- Para utilizar um indice em uma coluna chamada NM_CLIENTE, do tipo VARCHAR2, evite a seguinte instrucao:        
EXPLAIN PLAN FOR
    SELECT          *
    FROM            SOE.CUSTOMERS
    WHERE           CUST_FIRST_NAME = 3;   
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Escreva:
EXPLAIN PLAN FOR
    SELECT          *
    FROM            SOE.CUSTOMERS
    WHERE           CUST_FIRST_NAME = '3';   
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
   
-- OU escreva:
EXPLAIN PLAN FOR
  SELECT          *
    FROM            SOE.CUSTOMERS
    WHERE           CUST_FIRST_NAME = TO_CHAR(3);  
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
