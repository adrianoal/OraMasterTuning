-- criando tabela com colunas que permitem NULOS por último
CREATE TABLE HR.NULO_CORRETO (
NOME VARCHAR2(50) NOT NULL,
SEXO NUMBER(1) NOT NULL,
TIPO VARCHAR2(50));
/

-- criando tabela sem qualquer critério (a scolunas que permitem valores nulos não estão por último)
CREATE TABLE HR.NULO_INCORRETO (
NOME VARCHAR2(50) NOT NULL,
TIPO VARCHAR2(50),
SEXO NUMBER(1) NOT NULL);
/
 
-- carga na tabela  NULO_CORRETO
BEGIN  
  FOR I IN 1..400000 
  LOOP
     INSERT /*+APPEND*/ INTO HR.NULO_CORRETO VALUES ('Nome ' || I, 1, 'Tipo ' || i);
     INSERT /*+APPEND*/ INTO HR.NULO_INCORRETO VALUES ('Nome ' || I, 'Tipo ' || i, 1);     
  END LOOP;
  COMMIT;
END;
/
 
-- Veja que no cabeçalho da tabela  NULO_INCORRETO gasta-se mais bytes
SELECT SEGMENT_NAME, HEADER_BLOCK BYTES, BLOCKS, EXTENTS FROM DBA_SEGMENTS
WHERE SEGMENT_NAME IN ('NULO_CORRETO', 'NULO_INCORRETO');