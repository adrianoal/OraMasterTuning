-- Obs.: Este recurso funciona somente na versao Enterprise Edition
CREATE TABLE SOE.ORDER_ITEMS2 AS SELECT * FROM SOE.ORDER_ITEMS WHERE 1=0;
--SELECT * FROM SOE.ORDER_ITEMS;
-- Para verificar se parallel query, dml e ddl esta habilitado no nivel da sessao veja o valor da coluna pdml_status
SELECT username, pq_status, pddl_status, pdml_status
FROM v$session
WHERE sid = sys_context('userenv','sid'); 

--  Ao inves de:
INSERT INTO SOE.ORDER_ITEMS2
SELECT * FROM SOE.ORDER_ITEMS
WHERE ROWNUM < 9999999;  -- 423.78s (todas as linhas no Enterprise), 197s (9.999.999 lihas no Express) 65,99
ROLLBACK;

--  Execute:
alter session enable parallel dml; -- [enable || FORCE]
INSERT /*+ PARALLEL(o) */ INTO SOE.ORDER_ITEMS2 o
SELECT /*+ PARALLEL(d) */ * FROM SOE.ORDER_ITEMS d
WHERE ROWNUM < 9999999;  -- 45.52s (todas as linhas no Enterprise), 175s (9.999.999 lihas no Express)
commit;

