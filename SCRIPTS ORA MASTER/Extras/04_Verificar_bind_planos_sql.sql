select    sql_id, child_number, plan_hash_value,
          sql_text, 
          is_bind_sensitive, -- indica se sql � sens�vel � valores bind, quando houver histograma 
          is_bind_aware, -- indica se sql pode usar diferentes planos de execu��o para diferentes valores bind
          is_shareable, 
          executions
from      v$sql
where     sql_text like '%SELECT        COUNT(1) AS QTD_VENDAS%' -- incluir parte da instru��o SQL desejada
and       sql_text not like '%sql_text%'
and       sql_text not like '%EXPLAIN PLAN%';