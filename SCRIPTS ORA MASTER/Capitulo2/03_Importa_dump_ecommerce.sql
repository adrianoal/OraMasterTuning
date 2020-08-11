-- 1: executar comando abaixo no terminal do SO:
impdp system/oracle@pdbxe dumpfile=expdp_ecommerce.dmp logfile=expdp_ecommerce.log directory=orabkp

-- 2: desbloquear usuario ecommerce:
alter user ecommerce identified by ecommerce account unlock;

-- 3: coletar estatisticas dos objetos que acabaram de ser importados:
exec dbms_stats.gather_schema_stats('ECOMMERCE');
