-- este recurso soh otimiza valores repetidos passados na funcao

-- cria tabela para testes
CREATE TABLE hr.t2 (
  id NUMBER
);

-- insere dados repetidos em cada linha da tabela teste
INSERT /*+ APPEND */ INTO hr.t2
SELECT 1
FROM   dual
CONNECT BY level <= 100000;
COMMIT;

-- cria funcao que apenas retorna o proprio valor de entrada
CREATE OR REPLACE FUNCTION hr.slow_function (p_in IN NUMBER)
  RETURN NUMBER  
AS
BEGIN
  RETURN p_in;
END;
/

-- testar o recurso subquery scalar caching
SET SERVEROUTPUT ON
DECLARE
  l_start NUMBER;
BEGIN
  l_start := DBMS_UTILITY.get_cpu_time; 
  FOR cur_rec IN (SELECT hr.slow_function(id)
                  FROM   hr.t2)
  LOOP
    NULL;
  END LOOP;
  DBMS_OUTPUT.put_line('Regular Query   (SELECT List): ' ||
                       (DBMS_UTILITY.get_cpu_time - l_start) || ' hsecs CPU Time');

  l_start := DBMS_UTILITY.get_cpu_time; 
  FOR cur_rec IN (SELECT (SELECT hr.slow_function(id) FROM dual)
                  FROM   hr.t2)
  LOOP
    NULL;
  END LOOP;
  DBMS_OUTPUT.put_line('Scalar Subquery (SELECT List): ' ||
                       (DBMS_UTILITY.get_cpu_time - l_start) || ' hsecs CPU Time');
END;
/