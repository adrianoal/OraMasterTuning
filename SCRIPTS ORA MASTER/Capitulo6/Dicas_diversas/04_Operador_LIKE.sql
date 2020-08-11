-- Ao inves de:
EXPLAIN PLAN FOR
    SELECT     	*
    FROM        ECOMMERCE.CLIENTE
    WHERE      	NM_CLIENTE like '%Am%';   
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- Escreva:
EXPLAIN PLAN FOR
    SELECT 	    *
    FROM        ECOMMERCE.CLIENTE 
    WHERE      	NM_CLIENTE like 'Am%';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);




create table t1 as select * from dba_objects;
create index ix_t1_objectname on t1(object_name);

-- ao inves de:
explain plan for
    select  owner, object_name
    from    t1
    where   object_name LIKE '%SEG%';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY); 

-- escreva:
explain plan for
    select  owner, object_name
    from    t1
    where   object_name in (select  object_name
                            from    t1
                            where    object_name like '%SEG%'
                            );
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY); 
