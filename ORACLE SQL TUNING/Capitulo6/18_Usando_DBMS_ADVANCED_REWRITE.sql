-- insere cliente com primeiro nome igual a '007':
insert into soe.customers
select  19999997, '007', 'James Bond', nls_language, nls_territory, credit_limit, '007@bond.com', 
        account_mgr_id, customer_since, customer_class, suggestions, dob, mailshot,
        partner_mailshot, preferred_address, preferred_card
from    soe.customers where rownum =1;
commit;

-- crie um índice na coluna CUST_FIRST_NAME SOMENTE se ele ainda nao existir (foi criado no script 5 deste capitulo):
--CREATE INDEX SOE.IX_CUSTOMERS_FIRST_LAST_NAME ON SOE.CUSTOMERS(CUST_FIRST_NAME); 

-- da privs para usuurio SOE (executar conectado como SYS):
GRANT EXECUTE ON DBMS_ADVANCED_REWRITE TO SOE;
GRANT CREATE MATERIALIZED VIEW TO SOE;

explain plan for
    SELECT          *
    FROM            SOE.CUSTOMERS
    WHERE           CUST_FIRST_NAME = 007;   
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

--- *** A PARTIR DAQUI CONECTAR COMO SOE

-- criando a equivalencia:
BEGIN
  SYS.DBMS_ADVANCED_REWRITE.declare_rewrite_equivalence (
     name             => 'rewrite_cust_firstname',
     source_stmt      => 'SELECT          *
                          FROM            SOE.CUSTOMERS
                          WHERE           CUST_FIRST_NAME = 007',
     destination_stmt => 'SELECT          *
                          FROM            SOE.CUSTOMERS
                          WHERE           CUST_FIRST_NAME = ''007''',
     validate         => FALSE,
     rewrite_mode     => 'GENERAL');  -- valores possiveis: TEXT_MATCH, RECURSIVE, DISABLED, GENERAL
END;
/

-- habilite query rewrite no nivel da sessao para funcionar a reescrita da query:
ALTER SESSION SET QUERY_REWRITE_INTEGRITY = TRUSTED;
ALTER SESSION SET QUERY_REWRITE_enabled = TRUE;

-- execute a query abaixo e veja o resultado
explain plan for
    SELECT          *
    FROM            SOE.CUSTOMERS
    WHERE           CUST_FIRST_NAME = 007;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);  

-- consultar equivalencias criadas:
select * from all_rewrite_equivalences;

-- para desabilitar:
exec SYS.dbms_advanced_rewrite.alter_rewrite_equivalence('rewrite_cust_firstname', 'DISABLED');

-- para reabilitar:
exec SYS.dbms_advanced_rewrite.alter_rewrite_equivalence('rewrite_cust_firstname', 'GENERAL');

-- para apagar:
EXEC SYS.DBMS_ADVANCED_REWRITE.DROP_REWRITE_EQUIVALENCE (NAME => 'rewrite_cust_firstname');

-- apaga o indice criado:
DROP INDEX SOE.IX_CUSTOMERS_CUSTFIRSTNAME;

-- limitacoes conhecidas: nao aceita ORDER BY nos SQLs da equivalencia
