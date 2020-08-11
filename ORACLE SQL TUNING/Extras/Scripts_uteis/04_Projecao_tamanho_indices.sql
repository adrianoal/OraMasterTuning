SET SERVEROUTPUT ON
DECLARE 
    v_used NUMBER; 
    v_alloc NUMBER;        
BEGIN
    DBMS_SPACE.CREATE_INDEX_COST('CREATE INDEX HR.IX_EMPLOYEE_FIRSTNAME ON HR.EMPLOYEES(FIRST_NAME)', v_used, v_alloc);
    DBMS_OUTPUT.PUT_LINE('Projecao tamanho indice (byte):' || TO_CHAR(v_used));
    DBMS_OUTPUT.PUT_LINE('Projecao alocacao tablespace (bytes):' || TO_CHAR(v_alloc));
END;


-- A tabela do indice deve existir
-- O calculo do tamanho do indice depende de estatisticas coletadas no segmento da tabela
-- A ausencia de estatisticas ou estatisticas desatualizadas influenciara em resultados imprecisos