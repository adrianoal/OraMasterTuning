-- Obs.: Rebuild paralelizado funciona somente na versão Enterprise Edition

SET SERVEROUTPUT ON
BEGIN
-- reconstroi indices de um determinado schema, sem logging e com paralelismo (exceto LOB, IOT e DOMAIN).
    dbms_output.enable(null);
    FOR CUR_TAB IN (SELECT  'ALTER INDEX ' || OWNER || '.' || INDEX_NAME || ' REBUILD ' || 
                          DECODE(INDEX_TYPE,'DOMAIN','',' ONLINE') || ' PARALLEL 4 NOLOGGING' CMD,
                            OWNER, 
                            INDEX_NAME 
                    FROM    ALL_INDEXES
                    WHERE   OWNER = UPPER('&SCHEMA_NAME')
                    AND     index_type NOT IN ('IOT - TOP','LOB','DOMAIN')) LOOP
        EXECUTE IMMEDIATE cur_tab.CMD;
        -- reconfigura indice para não ficar habilitado com paralelismo, pois influencia negativamente nas intruções DML curtas e frequentes
        EXECUTE IMMEDIATE 'ALTER INDEX ' || CUR_TAB.OWNER || '.' || CUR_TAB.INDEX_NAME || ' NOPARALLEL';
        dbms_output.put_line(cur_tab.OWNER || '.' || cur_tab.INDEX_NAME || ' reconstruido!');
    END LOOP;
END;