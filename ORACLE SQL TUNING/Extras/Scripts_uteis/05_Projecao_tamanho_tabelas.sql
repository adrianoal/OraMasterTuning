SET SERVEROUTPUT ON
DECLARE 
    v_used NUMBER; 
    v_alloc NUMBER;    
BEGIN        
    DBMS_SPACE.CREATE_TABLE_COST(tablespace_name => 'USERS', avg_row_size =>'300', 
						row_count => 1000000, pct_free => 10, USED_BYTES => v_used, ALLOC_BYTES => v_alloc);
    DBMS_OUTPUT.PUT_LINE('Tamanho da tabela (mbytes): ' || to_char(round(v_used/1024/1024,2)));
    DBMS_OUTPUT.PUT_LINE('Espaço alocacao no tablespace (mbytes): ' || to_char(round(v_alloc/1024/1024,2)));
END;