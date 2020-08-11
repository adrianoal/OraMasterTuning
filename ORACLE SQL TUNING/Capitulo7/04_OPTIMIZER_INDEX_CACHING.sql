show parameter OPTIMIZER_INDEX_CACHING

-- 1: se as queries em geral retornam poucas linhas, configure:   
ALTER SESSION SET OPTIMIZER_INDEX_CACHING = 90; -- (ou maior)
    
-- 2: se as queries em geral retornam muitas linhas, configure:    
ALTER SESSION SET OPTIMIZER_INDEX_CACHING = 0;