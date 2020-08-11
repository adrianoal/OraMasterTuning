select dump(status) from ecommerce.tab_num ;

explain plan for
  SELECT  NM_CLIENTE, NM_UF
  FROM    ECOMMERCE.CLIENTE C
  JOIN    ECOMMERCE.UF U
    ON    C.CD_UF = U.CD_UF;
select * from table(dbms_xplan.display);


CREATE TABLE ECOMMERCE.UF2 (CD_UF CHAR(2), DS_UF VARCHAR2(20));
INSERT INTO ECOMMERCE.UF2 SELECT NM_UF, DS_UF FROM ECOMMERCE.UF;
COMMIT;


explain plan for
  SELECT  NM_CLIENTE, ds_UF
  FROM    ECOMMERCE.CLIENTE C
  JOIN    ECOMMERCE.UF U
    ON    C.CD_UF = U.CD_UF
   where nm_cliente = 'Zzv Lfgbs';
select * from table(dbms_xplan.display);

explain plan for
  SELECT  C.NM_CLIENTE, U.ds_uf
  FROM    ECOMMERCE.CLIENTE C
  JOIN    ECOMMERCE.UF2 U
    ON    C.CD_UF2 = U.CD_UF
    where nm_cliente = 'Zzv Lfgbs';
select * from table(dbms_xplan.display);



update ecommerce.cliente c set cd_uf2 = (select u.nm_uf from ecommerce.uf u where u.cd_uf = c.cd_uf);
commit;


alter table ecommerce.cliente add constraint ix_fk_uf2 foreign key (cd_uf2) references ecommerce.uf2(cd_uf);
alter table ecommerce.cliente add constraint ix_fk_uf foreign key (cd_uf) references ecommerce.uf(cd_uf);

create index ecommerce_ixuf2 on ecommerce.cliente(cd_uf2);
create index ecommerce_ixuf on ecommerce.cliente(cd_uf);

alter table
   cust_table
add constraint
   fk_cust_name FOREIGN KEY (person_name)
references
   person_table (person_name)
initially deferred deferrable;






plan FOR bem-sucedido.
PLAN_TABLE_OUTPUT                                                                                                                                                                                                                                                                                            
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 
Plan hash value: 3761181597                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                             
-----------------------------------------------------------------------------------------------                                                                                                                                                                                                              
| Id  | Operation                    | Name           | Rows  | Bytes | Cost (%CPU)| Time     |                                                                                                                                                                                                              
-----------------------------------------------------------------------------------------------                                                                                                                                                                                                              
|   0 | SELECT STATEMENT             |                | 64073 |  1689K|  2124   (1)| 00:00:26 |                                                                                                                                                                                                              
|   1 |  NESTED LOOPS                |                |       |       |            |          |                                                                                                                                                                                                              
|   2 |   NESTED LOOPS               |                | 64073 |  1689K|  2124   (1)| 00:00:26 |                                                                                                                                                                                                              
|   3 |    TABLE ACCESS FULL         | UF             |    28 |   392 |     3   (0)| 00:00:01 |                                                                                                                                                                                                              
|*  4 |    INDEX RANGE SCAN          | ECOMMERCE_IXUF |  8009 |       |     1   (0)| 00:00:01 |                                                                                                                                                                                                              
|   5 |   TABLE ACCESS BY INDEX ROWID| CLIENTE        |  2288 | 29744 |    76   (0)| 00:00:01 |                                                                                                                                                                                                              
-----------------------------------------------------------------------------------------------                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                             
Predicate Information (identified by operation id):                                                                                                                                                                                                                                                          
---------------------------------------------------                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                             
   4 - access("C"."CD_UF"="U"."CD_UF")                                                                                                                                                                                                                                                                       

 17 linhas selecionadas 
plan FOR bem-sucedido.
PLAN_TABLE_OUTPUT                                                                                                                                                                                                                                                                                            
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 
Plan hash value: 1338183918                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                             
------------------------------------------------------------------------------------------------                                                                                                                                                                                                             
| Id  | Operation                    | Name            | Rows  | Bytes | Cost (%CPU)| Time     |                                                                                                                                                                                                             
------------------------------------------------------------------------------------------------                                                                                                                                                                                                             
|   0 | SELECT STATEMENT             |                 | 64073 |  1877K|     4   (0)| 00:00:01 |                                                                                                                                                                                                             
|   1 |  NESTED LOOPS                |                 |       |       |            |          |                                                                                                                                                                                                             
|   2 |   NESTED LOOPS               |                 | 64073 |  1877K|     4   (0)| 00:00:01 |                                                                                                                                                                                                             
|   3 |    TABLE ACCESS FULL         | UF2             |    28 |   448 |     3   (0)| 00:00:01 |                                                                                                                                                                                                             
|*  4 |    INDEX RANGE SCAN          | ECOMMERCE_IXUF2 |     1 |       |     1   (0)| 00:00:01 |                                                                                                                                                                                                             
|   5 |   TABLE ACCESS BY INDEX ROWID| CLIENTE         |  2288 | 32032 |     1   (0)| 00:00:01 |                                                                                                                                                                                                             
------------------------------------------------------------------------------------------------                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                             
Predicate Information (identified by operation id):                                                                                                                                                                                                                                                          
---------------------------------------------------                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                             
   4 - access("C"."CD_UF2"="U"."CD_UF")                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                             
Note                                                                                                                                                                                                                                                                                                         
-----                                                                                                                                                                                                                                                                                                        
   - dynamic sampling used for this statement (level=2)                                                                                                                                                                                                                                                      

 21 linhas selecionadas 

