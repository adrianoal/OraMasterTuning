-- gerando o PE antes de criar o indice FB
EXPLAIN PLAN FOR
    SELECT    COUNT(1)          
    FROM      ECOMMERCE.PEDIDO
    WHERE     TO_CHAR(DT_PEDIDO,'YYYY') = '2009';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- criando o indice FB (btree) na coluna DT_PEDIDO da tabela ECOMMERCE.PEDIDO
CREATE INDEX ECOMMERCE.IX_PEDIDO_DTPEDIDO ON ECOMMERCE.PEDIDO(TO_CHAR(DT_PEDIDO,'YYYY'));

-- coletando estatisticas na nova coluna virtual para gerar PE mais preciso:
EXEC  dbms_stats.gather_table_stats(OWNNAME => 'ECOMMERCE', TABNAME => 'PEDIDO', METHOD_OPT => 'FOR ALL HIDDEN COLUMNS SIZE AUTO');

-- gerando o PE depois de criar o indice FB btree
EXPLAIN PLAN FOR
    SELECT    COUNT(1)          
    FROM      ECOMMERCE.PEDIDO
    WHERE     TO_CHAR(DT_PEDIDO,'YYYY') = '2009';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- apagando indice FB btree
drop INDEX ECOMMERCE.IX_PEDIDO_DTPEDIDO;

-- criando indice FB bitmap (mais apropriado p/ esta consulta). IFB BITMAP funciona somente na versao Enterprise Edition ou Personal Edition
CREATE BITMAP INDEX ECOMMERCE.IX_PEDIDO_DTPEDIDO ON ECOMMERCE.PEDIDO(TO_CHAR(DT_PEDIDO,'YYYY'));

-- coletando estatisticas na nova coluna virtual p/ gerar PE mais preciso:
exec dbms_stats.gather_table_stats(ownname=>'ECOMMERCE',tabname=>'PEDIDO',method_opt=>'FOR ALL HIDDEN COLUMNS SIZE AUTO');

-- gerando o PE depois de criar o indice FB bitmap
EXPLAIN PLAN FOR
    SELECT    COUNT(1)          
    FROM      ECOMMERCE.PEDIDO
    WHERE     TO_CHAR(DT_PEDIDO,'YYYY') = '2009';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- apagando indice FB btree
drop INDEX ECOMMERCE.IX_PEDIDO_DTPEDIDO;

-- Qual eh o melhor plano de execucao para a consulta acima? FB b-tree ou FB bitmap?