-- criar tabela destino :
CREATE TABLE ECOMMERCE.ITEM_PEDIDO3 AS SELECT * FROM ECOMMERCE.ITEM_PEDIDO WHERE 1=0;

-- execute os comandos abaixo p/ evitar problema com senha expirada do user system:
alter session set container=cdb$root;
alter user system identified by oracle container=all;
alter session set container=pdbxe;