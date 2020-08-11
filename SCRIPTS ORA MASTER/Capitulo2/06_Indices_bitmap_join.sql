-- Obs.: Este recurso NAO funciona nas versoes Standard Edition e Express Edition

-- Forjar estatistica para simulacao
-- vamos fingir que as tabelas EMPLOYEES e DEPARTMENTS tem cem mil linhas
BEGIN
  DBMS_STATS.SET_TABLE_STATS(OWNNAME => 'HR', TABNAME => 'EMPLOYEES', NUMROWS=>100000);
  DBMS_STATS.SET_TABLE_STATS(OWNNAME => 'HR', TABNAME => 'DEPARTMENTS', NUMROWS=>100000);
END;

-- veja o plano de execucao sem IBJ
explain plan for 
    select      e.*
    from        hr.employees e
    inner join  hr.departments d
            on  e.department_id = d.department_id
    where       d.department_name = 'IT';
select * from table(dbms_xplan.display);

-- criando um IBJ na tabela EMPLOYEES pegando a coluna "department_name" (utilizada no filtro do SQL) da tabela DEPARTMENTS
create bitmap index hr.emp_bm_idx on hr.employees(d.department_name )
      from hr.employees e, hr.departments d where e.department_id = d.department_id;

-- veja novamente o plano de execucao com o IBJ
explain plan for 
    select      e.*
    from        hr.employees e
    inner join  hr.departments d
            on  e.department_id = d.department_id
    where       d.department_name = 'IT';
select * from table(dbms_xplan.display);

-- apague o indice e corrija as estatisticas das tabelas
drop index hr.emp_bm_idx;
/
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'HR', TABNAME => 'EMPLOYEES');
  DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'HR', TABNAME => 'DEPARTMENTS');
END;