-- limpar table ITEM_PEDIDO2 e ver se ela tem PK
truncate table ECOMMERCE.item_pedido2;

-- carregar tabela ITEM_PEDIDO2 c/ linhas duplicadas
insert into ECOMMERCE.item_pedido2 select * from ECOMMERCE.item_pedido where rownum < 10000;
insert into ECOMMERCE.item_pedido2 select * from ECOMMERCE.item_pedido where rownum < 10000;
commit;

exec dbms_stats.gather_table_stats('ECOMMERCE','ITEM_PEDIDO2');

-- ao inves de:
explain plan for
    DELETE FROM ECOMMERCE.item_pedido2  
    WHERE RowID NOT IN 
            (SELECT     MIN(RowID) 
             FROM       ECOMMERCE.item_pedido2 
             GROUP BY   cd_pedido, cd_produto);
select * from table(dbms_xplan.display);

-- execute:
explain plan for
    DELETE FROM ECOMMERCE.item_pedido2 A 
    WHERE a.rowid IN ( SELECT   min(B.rowid)
                       FROM     ECOMMERCE.item_pedido2  B 
                       WHERE    A.cd_pedido = B.cd_pedido 
                       AND      A.cd_produto = B.cd_produto);
select * from table(dbms_xplan.display);