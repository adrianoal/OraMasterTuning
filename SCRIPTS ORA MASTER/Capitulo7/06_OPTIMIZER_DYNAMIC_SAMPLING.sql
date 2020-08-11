-- apagar estatisticas do schema ecommerce:
exec dbms_stats.delete_schema_stats('ECOMMERCE');

-- veja o valor padrao do parametro OPTIMIZER_DYNAMIC_SAMPLING:
show parameter OPTIMIZER_DYNAMIC_SAMPLING

-- configure OPTIMIZER_DYNAMIC_SAMPLING=2 (valor padrao) e depois veja o PE do SQL abaixo:
ALTER SESSION SET OPTIMIZER_DYNAMIC_SAMPLING=2;

EXPLAIN PLAN FOR
    SELECT  P.DT_PEDIDO, P.VL_TOTAL, I.CD_PRODUTO
    FROM    ECOMMERCE.PEDIDO P
    JOIN    ECOMMERCE.ITEM_PEDIDO I
      ON    P.CD_PEDIDO = I.CD_PEDIDO
    WHERE ROWNUM < 999999;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- configure OPTIMIZER_DYNAMIC_SAMPLING=11 (The database determines automatically if dynamic statistics are required) e depois veja o PE do SQL acima (novamente) --> ele esta mais preciso na qtde linhas e bytes? MUDOU algo?
ALTER SESSION SET OPTIMIZER_DYNAMIC_SAMPLING=11;


-- volte o valor default:
ALTER SESSION SET OPTIMIZER_DYNAMIC_SAMPLING=2;
-- coletar novamente estatisticas do schema ecommerce:
exec dbms_stats.gather_schema_stats('ECOMMERCE');