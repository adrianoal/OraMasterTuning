-- configurando versao antiga do otimizador:
ALTER SESSION SET OPTIMIZER_FEATURES_ENABLE='9.2.0';

-- veja o custo do otimizador 9.2.0:
explain plan for
            SELECT      O.ORDER_DATE,
                        O.ORDER_ID,
                        P.PRODUCT_NAME,                        
                        O.ORDER_STATUS,
                        O.ORDER_TOTAL,
                        I.QUANTITY,
                        I.UNIT_PRICE
            FROM        SOE.PRODUCT_INFORMATION P
            INNER JOIN  SOE.ORDER_ITEMS I
                ON      P.PRODUCT_ID = I.PRODUCT_ID
            INNER JOIN  SOE.ORDERS O
                ON      O.ORDER_ID = I.ORDER_ID                                                         
            ORDER BY    O.ORDER_DATE, O.ORDER_ID, P.PRODUCT_NAME;
select * from table(dbms_xplan.display);    

-- configurando versao atual do otimizador:
ALTER SESSION SET OPTIMIZER_FEATURES_ENABLE='18.1.0.1';

-- veja o custo do otimizador atual:
explain plan for
            SELECT      O.ORDER_DATE,
                        O.ORDER_ID,
                        P.PRODUCT_NAME,                        
                        O.ORDER_STATUS,
                        O.ORDER_TOTAL,
                        I.QUANTITY,
                        I.UNIT_PRICE
            FROM        SOE.PRODUCT_INFORMATION P
            INNER JOIN  SOE.ORDER_ITEMS I
                ON      P.PRODUCT_ID = I.PRODUCT_ID
            INNER JOIN  SOE.ORDERS O
                ON      O.ORDER_ID = I.ORDER_ID                                                         
            ORDER BY    O.ORDER_DATE, O.ORDER_ID, P.PRODUCT_NAME;
select * from table(dbms_xplan.display);    


-- ver fixes por versao do otimizador:
select      optimizer_feature_enable,
            count(*) 
from        v$system_fix_control 
group by    optimizer_feature_enable 
order by    1 asc;

-- hint optimizer_features_enable:
select /*+ optimizer_features_enable('9.2.0') */ * from dual;