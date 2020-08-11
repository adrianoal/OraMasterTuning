-- Criando tabelas clone EMP e DEP
CREATE TABLE HR.EMP AS SELECT * FROM HR.EMPLOYEES;
ALTER TABLE HR.EMP ADD CONSTRAINT PK_EMP PRIMARY KEY (EMPLOYEE_ID);
CREATE TABLE HR.DEP AS SELECT * FROM HR.DEPARTMENTS;
ALTER TABLE HR.DEP ADD CONSTRAINT PK_DEP PRIMARY KEY (DEPARTMENT_ID);
ALTER TABLE HR.EMP ADD CONSTRAINT FK_EMP_DEPARTMENTID FOREIGN KEY (DEPARTMENT_ID) REFERENCES HR.DEP(DEPARTMENT_ID) ON DELETE CASCADE;

-- Execute TRUNCATE na tabela DEP para eliminar tambem as linhas correspondentes na tabela filha EMP: 
TRUNCATE TABLE HR.DEP CASCADE;