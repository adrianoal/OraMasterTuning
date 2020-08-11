set serveroutput on
declare
    v_user varchar2(100);
    v_start NUMBER;
begin
    v_start := DBMS_UTILITY.get_time;  
    for i in 1..99999
    loop
        v_user := SYS_CONTEXT('USERENV','SESSION_USER');        
    end loop;    
    DBMS_OUTPUT.PUT_LINE('Tempo chamando SYS_CONTEXT: ' || ROUND((DBMS_UTILITY.GET_TIME - v_start)/100,2) || 's');
    
    v_start := DBMS_UTILITY.get_time;  
    for i in 1..99999
    loop
        v_user := user;        
    end loop;    
    DBMS_OUTPUT.PUT_LINE('Tempo chamando USER: ' || ROUND((DBMS_UTILITY.GET_TIME - v_start)/100,2) || 's');    
end;
