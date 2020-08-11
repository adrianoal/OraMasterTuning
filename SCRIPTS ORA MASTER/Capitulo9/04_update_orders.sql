-- Otimizar SQL abaixo considerando que esta demorando e gerando contencao.
-- Para testar entre na pasta /home/oracle da VM e execute o comando abaixo:
--    ./executa_update_orders_batch.sh
-- NAO ALTERE OS ARQUIVOS .SH - MONITORE COM O ORATOP (oratop -f -i / as sysdba), EM OUTRA JANELA, A EXECUCAO DO SCRIPT QUE ESTA SENDO EXECUTADO
    UPDATE  SOE.ORDERS
    SET     ORDER_STATUS = 5
    WHERE   order_id IN (
                            SELECT  order_id 
                            FROM    SOE.ORDERS
                            WHERE   ORDER_TOTAL = 5000
                            );
/
