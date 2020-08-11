-- conceder privs necessarios para o usuario ECOMMERCE (executar conectado como SYS):
GRANT QUERY REWRITE TO ECOMMERCE;
GRANT CREATE MATERIALIZED VIEW TO ECOMMERCE;

--  ***** PARA EXECUTAR AS LINHAS DE BAIXO CONECTE-SE COMO "ECOMMERCE" ******
-- DROP  materialized view ECOMMERCE.VENDAS_MENSAIS_PRODUTO;

-- Crie a visao materializada ECOMMERCE.VENDAS_MENSAIS_PRODUTO:
create materialized view ECOMMERCE.VENDAS_MENSAIS_PRODUTO BUILD IMMEDIATE enable query rewrite
AS
SELECT      TO_CHAR(P.DT_PEDIDO,'MM/YYYY') MES_PEDIDO,            
            PR.NM_PRODUTO,
            SUM(PR.VL_UNITARIO * IP.QT_ITEM) VALOR_TOTAL_MES
FROM        ECOMMERCE.PEDIDO P
INNER JOIN  ECOMMERCE.ITEM_PEDIDO IP
    ON      IP.CD_PEDIDO = P.CD_PEDIDO
INNER JOIN  ECOMMERCE.PRODUTO PR
    ON      PR.CD_PRODUTO = IP.CD_PRODUTO
group by    TO_CHAR(P.DT_PEDIDO,'MM/YYYY'),            
            PR.NM_PRODUTO;  
            
alter session set query_rewrite_enabled=false; -- valor true eh default se OPTIMIZER_FEATURES_ENABLE eh igual a 10.0.0 ou mais

-- Analise o plano de execuçao da query:
EXPLAIN PLAN FOR
    SELECT      SUM(PR.VL_UNITARIO * IP.QT_ITEM) VALOR_TOTAL_MES,
                TO_CHAR(P.DT_PEDIDO,'MM/YYYY') MES_PEDIDO,            
                PR.NM_PRODUTO                
    FROM        ECOMMERCE.PEDIDO P
    INNER JOIN  ECOMMERCE.ITEM_PEDIDO IP
        ON      IP.CD_PEDIDO = P.CD_PEDIDO
    INNER JOIN  ECOMMERCE.PRODUTO PR
        ON      PR.CD_PRODUTO = IP.CD_PRODUTO    
    group by    TO_CHAR(P.DT_PEDIDO,'MM/YYYY'),            
                PR.NM_PRODUTO
    ORDER BY    1, 2, 3;
select * from table(DBMS_XPLAN.DISPLAY);

-- Altere os parametros de sessao query_rewrite_enabled e query_rewrite_integrity:
alter session set query_rewrite_enabled=true; -- valor true eh default se OPTIMIZER_FEATURES_ENABLE eh igual a 10.0.0 ou mais
alter session set query_rewrite_integrity=trusted; -- valor default "enforced" ignora MVs desatualizadas. valor "trusted" confia na MV e sempre a utilizará

-- EXECUTE NOVAMENTE O SQL e analise o plano de execuçao da query para verificar se ela foi reescrita pelo otimizador para utilizar a visao materializada VENDAS_DIARIAS_PRODUTO:
EXPLAIN PLAN FOR
    SELECT      SUM(PR.VL_UNITARIO * IP.QT_ITEM) VALOR_TOTAL_MES,
                TO_CHAR(P.DT_PEDIDO,'MM/YYYY') MES_PEDIDO,            
                PR.NM_PRODUTO                
    FROM        ECOMMERCE.PEDIDO P
    INNER JOIN  ECOMMERCE.ITEM_PEDIDO IP
        ON      IP.CD_PEDIDO = P.CD_PEDIDO
    INNER JOIN  ECOMMERCE.PRODUTO PR
        ON      PR.CD_PRODUTO = IP.CD_PRODUTO    
    group by    TO_CHAR(P.DT_PEDIDO,'MM/YYYY'),            
                PR.NM_PRODUTO
    ORDER BY    1, 2, 3;
select * from table(DBMS_XPLAN.DISPLAY);


-- Execute o script abaixo para atualizar uma visao materializada:
BEGIN
    -- SE METODO = 'C' entao faz atualizacao completa. Se METODO = 'F' entao faz atualizacao incremental (neste caso, eh necessario ter logs de mv´s)
    DBMS_MVIEW.REFRESH('&SCHEMA..&MV_NAME','&METODO'); 
END;

-- Execute o script abaixo para atualizar varias visoes materializada:
BEGIN
    -- SE METODO = 'C' entao faz atualizacao completa. Se METODO = 'F' entao faz atualizacao incremental (neste caso, eh necessario ter logs de mv´s)
    DBMS_MVIEW.REFRESH(list => 'SCHEMA.MV1, SCHEMA.MV2', method => 'METODO'); 
END;