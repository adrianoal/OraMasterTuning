-- 1: monitore o uso de indices (degrada em media 3%):
alter index ECOMMERCE.UK_CLIENTE_NMCLIENTE monitoring usage;

-- 2: conecte-se no BD com o usuario dono do indice e consulte a visao V$OBJECT_USAGE. Se por um longo periodo o indice nao foi utilizado, 
--    isso pode indicar que vc nao precisa dele, portanto apague-o
select index_name, table_name, monitoring, used from v$object_usage;  -- somente indices do usuario logado

-- a consulta abaixo permite ver indices de qq usuario:
select  u.username,
        t.name as table_name, io.name as index_name, 
        decode(bitand(i.flags, 65536), 0, 'NO', 'YES') as monitoring,
        decode(bitand(ou.flags, 1), 0, 'NO', 'YES') as used,
        ou.start_monitoring,
        ou.end_monitoring
from    sys.obj$ io 
JOIN    sys.object_usage ou
    ON  io.obj# = ou.obj#
JOIN    sys.ind$ i
    ON  i.obj# = ou.obj#
JOIN    sys.obj$ t
    ON  t.obj# = i.bo#
JOIN    dba_users u
    ON  u.user_id = io.owner#;

-- SQL para usar indice e verificar se posteriormente se ele foi utilizado
select * from ecommerce.cliente where nm_cliente like 'Am%';

-- comando para desabilitar monitoramento
alter index ECOMMERCE.UK_CLIENTE_NMCLIENTE nomonitoring usage;

-- consultando lista de TODOS os indices monitorados a partir do 12c (dba_object_usage MOSTRA DADOS DE INDICES DE TODOS OS USUARIOS)
select    u.owner, t.name as table_name, io.name as index_name, 
          ou.start_monitoring,
          ou.end_monitoring,
          u.used
from      sys.obj$ io
          ,sys.obj$ t
          ,sys.ind$ i
          ,sys.object_usage ou
          ,dba_object_usage u
where     i.obj# = ou.obj#
-- and    u.used = 'NO'
and       io.obj# = ou.obj#
and       t.obj# = i.bo#
and       u.index_name = io.name
and       u.TABLE_NAME = t.name;

-- antes de apagar, para ter certeza realmente que ele nao esta sendo utilizado, voce pode:
   --1: configura-lo como invisible (parametro OPTIMIZER_USE_INVISIBLE_INDEXES deve ter valor FALSE):
    alter index &owner.&index_name invisible;
   --2: configura-lo como unusable (indices ficam invalidos e sem manutencao, mas para reativa-lo eh soh fazer um REBUILD)
    alter index &owner.&index_name ununsable;

-- comando para apagar o indice, se for necessario
drop index &owner.&index_name;