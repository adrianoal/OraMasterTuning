CREATE OR REPLACE FUNCTION ecommerce.calcular_valor( val IN INTEGER ) RETURN INTEGER IS
BEGIN
  RETURN CASE mod( val  , 2 ) WHEN 1 THEN 6 ELSE 3 END;
END;
/

set timing on
PROMPT SQL chamando a funcao CALCULAR_VALOR em 100 linhas por 10.000 vezes (tamanho do loop)
DECLARE
  v_res INTEGER := 0;
BEGIN
  FOR r IN 1 .. 10000 LOOP
      SELECT  sum(ecommerce.calcular_valor(ROWNUM)) val INTO v_res 
      FROM    dual CONNECT BY LEVEL <= 100;
  END LOOP;  
END;
/

PROMPT SQL fazendo o cálculo inline em 100 linhas por 10.000 vezes (tamanho do loop) 
DECLARE
  v_res INTEGER := 0;
BEGIN
  FOR r IN 1 .. 10000 LOOP
  SELECT sum( CASE mod( ROWNUM , 2 ) WHEN 1 THEN 6 ELSE 3 END ) val INTO v_res FROM dual CONNECT BY LEVEL <= 100;
  END LOOP;
END;
/
set timing off