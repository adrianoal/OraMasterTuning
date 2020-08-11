-- DROP TABLE  SOE.CUSTOMERS2 PURGE;
CREATE TABLE SOE.CUSTOMERS2 AS SELECT * FROM SOE.CUSTOMERS WHERE ROWNUM < 1500000;  -- 18s  28,89s
         		
--  Ao inves de DELETE execute um TRUNCATE:
DELETE FROM SOE.CUSTOMERS2; -- 18s 24,42 s

-- execute rollback para as linhas voltarem para a tabela:
ROLLBACK;  -- 38s 97,52

-- limpe a buffer cache para garantir que o TRUNCATE execute rapido (https://support.oracle.com/epmos/faces/CommunityDisplay?resultUrl=https%3A%2F%2Fcommunity.oracle.com%2Fthread%2F2813732&_afrLoop=101521741529507&resultTitle=TRUNCATE+TABLE+hangs&commId=2813732&displayIndex=5&_afrWindowMode=0&_adf.ctrl-state=vrpyacvxi_300):
alter system flush buffer_cache;    
    
-- Execute o TRUNCATE:
TRUNCATE TABLE SOE.CUSTOMERS2; -- 1.8s 2,89

SELECT * FROM  SOE.CUSTOMERS2;