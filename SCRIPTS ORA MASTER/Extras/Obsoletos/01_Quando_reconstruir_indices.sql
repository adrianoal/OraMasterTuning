-- script para reconstruir indices de um determina schema ou pelo nome dele (ref. MOS Note ID 122008.1)
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
  V_SCHEMANAME VARCHAR2(30):=UPPER('&SCHEMA_NAME');
  V_INDEXNAME VARCHAR2(30):=UPPER('&INDEX_NAME');
  V_RESULTADO VARCHAR2(4);
  V_BLEVEL NUMBER;
  V_PERC_LD NUMBER;
  v_COUNT NUMBER:=0;
BEGIN
  
    FOR I IN (SELECT  INDEX_NAME, OWNER
              FROM    DBA_INDEXES
              WHERE   OWNER = NVL(V_SCHEMANAME, OWNER)
              AND     INDEX_NAME = NVL(V_INDEXNAME,INDEX_NAME)
              AND     INDEX_TYPE = 'NORMAL'
              AND     OWNER NOT IN ('SYS','SYSTEM')
              )
    LOOP
        BEGIN
            -- coleta estatisticas do indice (necessario para ver qtde linhas deletadas)
            EXECUTE IMMEDIATE 'ANALYZE INDEX ' || I.OWNER || '.' || I.INDEX_NAME || ' COMPUTE STATISTICS';
            EXECUTE IMMEDIATE 'ANALYZE INDEX ' || I.OWNER || '.' || I.INDEX_NAME || ' VALIDATE STRUCTURE';
            
            SELECT      CASE                               
                              WHEN DECODE(S.DEL_LF_ROWS,0,0,S.DEL_LF_ROWS/S.LF_ROWS*100) >= 20 OR IND.BLEVEL > 4  THEN 'SIM'
                              ELSE 'NÃO' 
                        END AS REORGANIZE,
                        BLEVEL, 
                        ROUND(DECODE(S.DEL_LF_ROWS,0,0,S.DEL_LF_ROWS/S.LF_ROWS*100), 2)
                        INTO V_RESULTADO, V_BLEVEL, V_PERC_LD
            FROM        INDEX_STATS S
            INNER JOIN  DBA_INDEXES IND
                ON      S.NAME = IND.INDEX_NAME
            WHERE       IND.OWNER = I.OWNER;
            
            IF V_RESULTADO = 'SIM' THEN
                DBMS_OUTPUT.PUT('Reconstrua o indice ' || I.OWNER || '.' || I.INDEX_NAME || '(blevel=' || TO_CHAR(V_BLEVEL) 
                                  || ', % linhas del.=' || to_char(V_PERC_LD) || ')');
                
                DBMS_OUTPUT.PUT_LINE(': "ALTER INDEX ' || I.OWNER || '.' || I.INDEX_NAME || ' REBUILD ONLINE;"');
                V_COUNT := V_COUNT + 1;
            END IF;            
            			
            -- coleta estatistica do indice c/ DBMS_STATS (necessario apos o ANALYZE pois gera estatisticas melhores para o CBO)
			DBMS_STATS.GATHER_INDEX_STATS(i.OWNER, i.INDEX_NAME);                         
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(' Erro ao calcular indice ' || i.owner || '.' || i.index_name);
        END;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('*** Rotina executada com sucesso! Qtde de indices que necessitam de REBUILD: ' || to_char(V_COUNT) || '***');
END;