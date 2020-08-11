-- Obs.: Este recurso NAO funciona nas versoes Standard Edition e Express Edition 11g (18c Express funciona)
-- considerando que vc tera que fazer consultas frequentes filtrando VL_TOTAL, compare o plano de execucao antes e depois da criacao do indice

-- gerando PE antes de criar o indice bitmap
EXPLAIN PLAN FOR
    SELECT    COUNT(1)   
    FROM      ECOMMERCE.PEDIDO
    WHERE     VL_TOTAL = 100000;
SELECT * FROM TABLE(dbms_xplan.DISPLAY);
/

-- criando indice bitmap na coluna VL_TOTAL da tabela ECOMMERCE.PEDIDO
CREATE BITMAP INDEX ECOMMERCE.IX_PEDIDO_VL_TOTAL ON ECOMMERCE.PEDIDO(VL_TOTAL);
/

-- gerando PE depois de criar o indice bitmap
EXPLAIN PLAN FOR
    SELECT    COUNT(1)   
    FROM      ECOMMERCE.PEDIDO
    WHERE     VL_TOTAL = 100000;
SELECT * FROM TABLE(dbms_xplan.DISPLAY);
/

DROP INDEX ECOMMERCE.IX_PEDIDO_VL_TOTAL;