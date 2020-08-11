-- ver valor atual do OICA:
SHOW PARAMETER OPTIMIZER_INDEX_COST_ADJ

-- criando indices para ajudar na consulta abaixo:
CREATE INDEX ECOMMERCE.IX_ITEMPEDIDO_CDPEDIDO ON ECOMMERCE.ITEM_PEDIDO(CD_PEDIDO);
CREATE INDEX ECOMMERCE.IX_PEDIDO_DTPEDIDO ON ECOMMERCE.PEDIDO(DT_PEDIDO);

-- configurando OICA com valor 50 (valor antigamente indicado em ambientes OLTP):
ALTER SESSION SET OPTIMIZER_INDEX_COST_ADJ = 50;

-- veja o PE:
explain plan for
            SELECT      P.DT_PEDIDO,
                        P.CD_PEDIDO,
                        T.NM_PRODUTO,
                        P.ID_STATUS,
                        P.VL_TOTAL,
                        I.QT_ITEM,
                        I.VL_TOTAL AS VL_ITEM
            FROM        ECOMMERCE.PEDIDO P
            INNER JOIN  ECOMMERCE.ITEM_PEDIDO I
                ON      P.CD_PEDIDO = I.CD_PEDIDO
            INNER JOIN  ECOMMERCE.PRODUTO T            
                ON      T.CD_PRODUTO = I.CD_PRODUTO
            WHERE       P.DT_PEDIDO = TO_DATE('01/01/2000', 'DD/MM/YYYY')
            ORDER BY    P.DT_PEDIDO, P.CD_PEDIDO, T.NM_PRODUTO;
select * from table(dbms_xplan.display);   

-- configurando OICA com valor 5000:
ALTER SESSION SET OPTIMIZER_INDEX_COST_ADJ = 5000;

-- veja aumentou o custo do PE e se algum indice deixou de ser usado:
explain plan for
            SELECT      P.DT_PEDIDO,
                        P.CD_PEDIDO,
                        T.NM_PRODUTO,
                        P.ID_STATUS,
                        P.VL_TOTAL,
                        I.QT_ITEM,
                        I.VL_TOTAL AS VL_ITEM
            FROM        ECOMMERCE.PEDIDO P
            INNER JOIN  ECOMMERCE.ITEM_PEDIDO I
                ON      P.CD_PEDIDO = I.CD_PEDIDO
            INNER JOIN  ECOMMERCE.PRODUTO T            
                ON      T.CD_PRODUTO = I.CD_PRODUTO
            WHERE       P.DT_PEDIDO = TO_DATE('01/01/2000', 'DD/MM/YYYY')
            ORDER BY    P.DT_PEDIDO, P.CD_PEDIDO, T.NM_PRODUTO;
select * from table(dbms_xplan.display);    

---------------------------------------------------------------------------------------------------------------------------

-- verificar coluna "Starting oica" p/ descobrir melhor valor a ser configurado baseado no historico de trabalho do BD
-- necessario ter licenciamento da option "Diagnostics Packs" pois as visoes dba_hist* pertencem ao repositorio do AWR:
select      round(sum(a.time_waited_micro)/sum(a.total_waits)/1000000,5) "Avg Waits Full Scan Read I/O", 
            round(sum(b.time_waited_micro)/sum(b.total_waits)/1000000,5) "Avg Waits Index Read I/O",
            round((
                sum(a.total_waits) / 
                sum(a.total_waits + b.total_waits)
            ) * 100,2) "% of I/O Waits scattered" ,
            round((
                sum(b.total_waits) / 
                sum(a.total_waits + b.total_waits)
            ) * 100,2) "% of I/O Waits sequential",
            round((
                sum(b.time_waited_micro) /
                sum(b.total_waits)) / 
                (sum(a.time_waited_micro)/sum(a.total_waits)
            ) * 100,2) "Starting Value oica"
from        dba_hist_system_event a, 
            dba_hist_system_event b
where       a.snap_id = b.snap_id
and         a.event_name = 'db file scattered read'
and         b.event_name = 'db file sequential read';


-- configurando OICA com valor default:
ALTER SESSION SET OPTIMIZER_INDEX_COST_ADJ = 100;