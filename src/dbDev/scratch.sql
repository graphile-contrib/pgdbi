-- drop schema flux;

-- create schema flux;

-- revoke soro_user from app_user;

-- select * from information_schema.enabled_roles;


-- select * from information_schema.applicable_roles;


select * from soro.order_line_item limit 1;

select 
      t.relname
      , ns.nspname
      , a.attname
      , i.relname
      from 
        pg_index ix
        join pg_class t on t.oid = ix.indrelid
        join pg_class i on i.oid = ix.indexrelid
        join pg_namespace ns on t.relnamespace = ns.oid
        join pg_attribute a on a.attrelid = t.oid and a.attnum = ANY(ix.indkey)
      where
        ns.nspname = 'soro'
      and
        t.relname = 'order_line_item'
;


select 
  ns.nspname || '.' || t.relname id
  ,t.relname "tableName"
  ,ns.nspname "tableSchema"
  ,a.attname "columnName"
  ,i.relname "indexName"
from 
  pg_index ix
  join pg_class t on t.oid = ix.indrelid
  join pg_class i on i.oid = ix.indexrelid
  join pg_namespace ns on t.relnamespace = ns.oid
  join pg_attribute a on a.attrelid = t.oid and a.attnum = ANY(ix.indkey)
  where
    ns.nspname = 'soro'
  and
    t.relname = 'order_line_item'
group by
  ns.nspname,
  t.relname,
  a.attname,
  i.relname
order by
    ns.nspname,
    t.relname,
    a.attname,
    i.relname
;


