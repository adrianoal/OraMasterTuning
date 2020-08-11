/*
http://docs.oracle.com/cd/B28359_01/appdev.111/b28419/d_sqlpa.htm
http://www.oracle-base.com/articles/11g/sql-performance-analyzer-11gr1.php
*/

-- criando tabela para testes
CREATE TABLE ECOMMERCE.my_objects AS SELECT * FROM all_objects;

-- coletando estatisticas da tabela
EXEC DBMS_STATS.gather_table_stats('ECOMMERCE', 'MY_OBJECTS', cascade => TRUE);

-- executando instruções SQL diversas para recuperar dados da tabela
SELECT COUNT(*) FROM ECOMMERCE.my_objects WHERE object_id <= 100;
SELECT object_name FROM ECOMMERCE.my_objects WHERE object_id = 100;
SELECT COUNT(*) FROM ECOMMERCE.my_objects WHERE object_id <= 1000;
SELECT object_name FROM ECOMMERCE.my_objects WHERE object_id = 1000;
SELECT COUNT(*) FROM ECOMMERCE.my_objects WHERE object_id BETWEEN 100 AND 1000;

-- sql tuning set: passo 1 (criação)
EXEC DBMS_SQLTUNE.create_sqlset(sqlset_name => 'spa_test_sqlset_MYOBJECTS');

-- sql tuning set (STS): passo 2 (carga)
DECLARE
  l_cursor  DBMS_SQLTUNE.sqlset_cursor;
BEGIN
  OPEN l_cursor FOR
     SELECT VALUE(a)
     FROM   TABLE(
              DBMS_SQLTUNE.select_cursor_cache(
                basic_filter   => 'sql_text LIKE ''%my_objects%'' and parsing_schema_name = ''SYS''',
                attribute_list => 'ALL')
            ) a;
                                               
 
  DBMS_SQLTUNE.load_sqlset(sqlset_name     => 'spa_test_sqlset_MYOBJECTS',
                           populate_cursor => l_cursor);
END;
/

-- verificando instruções sql do STS
SELECT sql_text, sqlset_name
FROM   dba_sqlset_statements
WHERE  UPPER(sqlset_name) = UPPER('spa_test_sqlset_MYOBJECTS');

-- criando tarefa p/ analisar STS
SET SERVEROUTPUT ON
DECLARE
  v_task VARCHAR2(64);  
BEGIN  
  v_task :=  DBMS_SQLPA.create_analysis_task(sqlset_name => 'spa_test_sqlset_MYOBJECTS');
  DBMS_OUTPUT.PUT_LINE('v_task: ' || v_task);
END;

-- executando tarefa de analise do STS
BEGIN
  DBMS_SQLPA.execute_analysis_task(
    task_name       => 'TAREFA_7887',
    execution_type  => 'test execute',
    execution_name  => 'before_change');
END;

-- criando índice na coluna que foi utilizada nas instruções sQL do STS
CREATE INDEX ECOMMERCE.my_objects_index_01 ON ECOMMERCE.my_objects(object_id);

-- coletando novamente estatistcias da tabela
EXEC DBMS_STATS.gather_table_stats('ECOMMERCE', 'MY_OBJECTS', cascade => TRUE);

-- executando tarefa de analise do STS após criaçao do índice
BEGIN
  DBMS_SQLPA.execute_analysis_task(
    task_name       => 'TAREFA_7887',
    execution_type  => 'test execute',
    execution_name  => 'after_change');
END;
/

-- comparando tarefas de analise antes e depois do índice
BEGIN
  DBMS_SQLPA.execute_analysis_task(
    task_name        => 'TAREFA_7887',
    execution_type   => 'compare performance', 
    execution_params => dbms_advisor.arglist(
                          'execution_name1', 
                          'before_change', 
                          'execution_name2', 
                          'after_change')
    );
END;
/

-- consultando relatório da analise
SELECT DBMS_SQLPA.report_analysis_task('TAREFA_7887', 'TEXT', 'ALL') FROM   dual;