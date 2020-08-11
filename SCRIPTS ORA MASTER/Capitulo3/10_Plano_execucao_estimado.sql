-- ver plano de execucao estimado basico (BASIC):
EXPLAIN PLAN FOR
	SELECT          C.NM_CLIENTE, P.CD_PEDIDO, P.DT_PEDIDO
	FROM            ECOMMERCE.CLIENTE C
    INNER JOIN      ECOMMERCE.PEDIDO P
	  ON            C.CD_CLIENTE = P.CD_CLIENTE
	WHERE           P.CD_PEDIDO BETWEEN 1 AND 10;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(NULL, NULL, 'TYPICAL'));

-- ver plano de execucao estimado padrao, que é igual a TYPICAL:
EXPLAIN PLAN FOR
	SELECT          C.NM_CLIENTE, P.CD_PEDIDO, P.DT_PEDIDO
	FROM            ECOMMERCE.CLIENTE C
    INNER JOIN      ECOMMERCE.PEDIDO P
	  ON            C.CD_CLIENTE = P.CD_CLIENTE
	WHERE           P.CD_PEDIDO BETWEEN 1 AND 10;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- ver plano de execucao estimado completo (ALL), exibindo a mais a seção "Query block Name ..." + "Column Projection Information:
EXPLAIN PLAN FOR
	SELECT          C.NM_CLIENTE, P.CD_PEDIDO, P.DT_PEDIDO
	FROM            ECOMMERCE.CLIENTE C
    INNER JOIN      ECOMMERCE.PEDIDO P
	  ON            C.CD_CLIENTE = P.CD_CLIENTE
	WHERE           P.CD_PEDIDO BETWEEN 1 AND 10;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(NULL, NULL, 'ALL'));

