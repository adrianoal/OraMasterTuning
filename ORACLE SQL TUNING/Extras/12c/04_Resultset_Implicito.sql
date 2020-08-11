CREATE OR REPLACE PROCEDURE HR.SP_EMPLOYEES_S as 
  v_cursor sys_refcursor;
BEGIN
  open v_cursor for 
      SELECT * from HR.EMPLOYEES;
      dbms_sql.return_result(v_cursor);
END;

-- Execute a instrucao abaixo no SQL PLus
EXEC HR.SP_EMPLOYEES_S;