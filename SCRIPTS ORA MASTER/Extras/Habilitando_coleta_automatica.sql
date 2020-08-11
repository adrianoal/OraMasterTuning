-- verificando se coleta esta desabilitada no 11g:
SELECT CLIENT_NAME, STATUS FROM DBA_AUTOTASK_CLIENT WHERE CLIENT_NAME='auto optimizer stats collection';

-- habilitando a coleta de estatisticas de objetos automatica no 11g:
BEGIN
  DBMS_AUTO_TASK_ADMIN.ENABLE(
    client_name => 'auto optimizer stats collection',
    operation => NULL,
    window_name => NULL);
END;
/

