/*
You can define a virtual column only on a regular heap-organized table. You can’t
define a virtual column on an index-organized table, an external table, a
temporary table, object tables, or cluster tables.
• Virtual columns can’t reference other virtual columns.
• Virtual columns can reference columns only from the table in which the virtual
column is defined.
• The output of a virtual column must be a scalar value (a single value, not a set of
values).
*/

CREATE OR REPLACE FUNCTION ecommerce.calcular_valor( val IN INTEGER ) RETURN INTEGER IS
BEGIN
  RETURN CASE mod( val  , 2 ) WHEN 1 THEN val + 6 ELSE val + 3 END;
END;
/

create table ecommerce.tab1 (col1 number);

create table ecommerce.tab2 
      (
         col1 number, 
         calculo1 AS (CASE mod( col1  , 2 ) WHEN 1 THEN col1 + 6 ELSE col1 + 3 END)
      );

create index ecommerce.ix_tab2_calculo1 on ecommerce.tab2(calculo1);      
      
insert into ecommerce.tab1 select rownum from dual connect by level <=10000;
insert into ecommerce.tab2 (col1) select rownum from dual connect by level <=10000;      
commit;

select * from ecommerce.tab2;

truncate table ecommerce.tab1;
truncate table ecommerce.tab2;

set timing on
PROMPT SQL chamando a funcao CALCULAR_VALOR em 100 linhas por 10.000 vezes (tamanho do loop)
DECLARE
  v_res INTEGER := 0;
BEGIN
  FOR r IN 1 .. 10000 LOOP
      SELECT  sum(ecommerce.calcular_valor(col1)) val INTO v_res 
      FROM    ecommerce.tab1;
  END LOOP;
  dbms_output.put_line(v_res);
END;
/

PROMPT SQL fazendo o cálculo inline em 100 linhas por 10.000 vezes (tamanho do loop) 
DECLARE
  v_res INTEGER := 0;
BEGIN
  FOR r IN 1 .. 10000 LOOP
    SELECT  sum(CASE mod( col1  , 2 ) WHEN 1 THEN 6 ELSE 3 END) INTO v_res 
    FROM    ecommerce.tab1;
  END LOOP;
dbms_output.put_line(v_res);
END;
/

PROMPT SQL fazendo o cálculo em coluna virtual em 100 linhas por 10.000 vezes (tamanho do loop) 
DECLARE
  v_res INTEGER := 0;
BEGIN
  FOR r IN 1 .. 10000 LOOP
    SELECT  sum(calculo1) INTO v_res 
    FROM    ecommerce.tab2;
  END LOOP;
dbms_output.put_line(v_res);
END;
/
set timing off

explain plan for
  select  * 
  from    ecommerce.tab2
  where   calculo1 = 1327;
select * from table(dbms_xplan.display);

explain plan for
  select  * 
  from    ecommerce.tab1
  where   (CASE mod( col1  , 2 ) WHEN 1 THEN col1 + 6 ELSE col1 + 3 END) = 1327;
select * from table(dbms_xplan.display);
