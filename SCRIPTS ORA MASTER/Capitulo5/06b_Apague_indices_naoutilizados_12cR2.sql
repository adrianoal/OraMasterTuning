-- **** FUNCIONA SOMENTE NO 12CR2 ou superior

--habilitar monitoramento total dos indices:
ALTER SESSION SET "_iut_stat_collection_type"=ALL;

-- ver ultima atualizacao da "DBA_INDEX_USAGE" (ocorre a cada 15 minutos)
select * from V$INDEX_USAGE_INFO;

-- ver informacoes sobre os indices monitorados:
SELECT owner,
       name,
       total_access_count,
       total_exec_count,
       total_rows_returned,
       last_used
FROM   dba_index_usage
WHERE  owner = 'TEST'
ORDER BY 1, 2;

--voltar monitoramento padrao dos indices:
ALTER SESSION SET "_iut_stat_collection_type"=SAMPLED;



--- TESTANDO MONITORAMENTO DE INDICES:
alter session set "_iut_stat_collection_type"=ALL;

-- criando a tabela p/ testes:
create table ecommerce.table1 (id number, val1 varchar2(20), val2 varchar2(20));

-- criando indices p/ testes:
create index ecommerce.idx_id on ecommerce.table1(id);
create index ecommerce.idx_val1 on ecommerce.table1(val1);
create index ecommerce.idx_val2 on ecommerce.table1(val2);
 
-- inserindo dados na tabela de testes: 
insert into ecommerce.table1 values (1,'a','b');
insert into ecommerce.table1 values (2,'b','c');
insert into ecommerce.table1 values (3,'c','d');
insert into ecommerce.table1 values (4,'d','e');
insert into ecommerce.table1 values (5,'e','f');
insert into ecommerce.table1 values (6,'f','g');
insert into ecommerce.table1 values (7,'g','h');
insert into ecommerce.table1 values (8,'h','i');
insert into ecommerce.table1 values (9,'i','j');
insert into ecommerce.table1 values (10,'j','k');
insert into ecommerce.table1 values (11,'k','l');
commit;

-- veja o PE do SQL abaixo e execute-o em seguida:
explain plan for
    select id from ecommerce.table1 where id>1;
select * from table(dbms_xplan.display);   

-- veja o PE do SQL abaixo e execute-o em seguida: 
explain plan for
    select val1 from ecommerce.table1 where val1 !='a';
select * from table(dbms_xplan.display);  

-- veja o PE do SQL abaixo e execute-o em seguida:
explain plan for
 select val2 from ecommerce.table1 where val2 !='z';
select * from table(dbms_xplan.display);  

-- ver ultima atualizacao da "DBA_INDEX_USAGE" (ocorre a cada 15 minutos)
select * from V$INDEX_USAGE_INFO;

-- ver informacoes sobre os indices monitorados:
SELECT owner,
       name,
       total_access_count,
       total_exec_count,
       total_rows_returned,
       last_used
FROM   dba_index_usage
WHERE  owner = 'ECOMMERCE'
ORDER BY 1, 2;
