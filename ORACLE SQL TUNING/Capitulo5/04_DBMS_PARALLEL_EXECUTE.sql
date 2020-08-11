-- DROP TABLE SOE.ORDER_ITEMS2;
-- criando a tabela de testes:
CREATE TABLE SOE.ORDER_ITEMS2 AS SELECT * FROM SOE.ORDER_ITEMS WHERE ROWNUM < 9999999;  -- 52s

-- ao inves de:
UPDATE SOE.ORDER_ITEMS2  SET UNIT_PRICE = UNIT_PRICE + 10;  -- 640s

-- necessario privilegio CREATE JOB
-- nao da para fazer rollback;
-- importante: veja antes o valor de CPU_COUNT e job_queue_processes

-- execute: (378s)
declare
  v_sql VARCHAR2(1000):='UPDATE SOE.ORDER_ITEMS2 SET UNIT_PRICE = UNIT_PRICE + 10 WHERE rowid BETWEEN :start_id AND :end_id';
  v_status NUMBER;
  v_try NUMBER;
  v_nome_tarefa VARCHAR2(15):= 'TAREFA_1';
begin
  -- cria a tarefa
  DBMS_PARALLEL_EXECUTE.CREATE_TASK(v_nome_tarefa);
  
  -- divide (chunk) a tarefa por rowid da tabela
  DBMS_PARALLEL_EXECUTE.CREATE_CHUNKS_BY_ROWID(task_name => v_nome_tarefa, TABLE_OWNER => 'SOE', TABLE_NAME => 'ORDER_ITEMS2', BY_ROW => TRUE, CHUNK_SIZE => 600000);
  
  -- execute a instrucao dml com paralelismo
  DBMS_PARALLEL_EXECUTE.RUN_TASK(TASK_NAME => v_nome_tarefa, SQL_STMT => v_sql, LANGUAGE_FLAG => DBMS_SQL.Native);
  
  -- apaga a tarefa
  DBMS_PARALLEL_EXECUTE.DROP_TASK(v_nome_tarefa);
end;