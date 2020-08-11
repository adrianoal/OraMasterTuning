-- abra uma conexao no SQL Plus e execute a instrucao abaixo p/ exibir somente PE + estatiscas da execução:
set autotrace traceonly
SELECT          C.NM_CLIENTE, P.CD_PEDIDO, P.DT_PEDIDO
FROM            ECOMMERCE.CLIENTE C
INNER JOIN      ECOMMERCE.PEDIDO P
  ON            C.CD_CLIENTE = P.CD_CLIENTE
WHERE           P.CD_PEDIDO BETWEEN 1 AND 10;

-- executar separadamente o comando abaixo:
set autotrace off