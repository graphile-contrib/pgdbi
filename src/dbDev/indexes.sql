-- CREATE INDEX IF NOT EXISTS idx_soro_inventory_lot_inventory_group ON soro.inventory_lot(inventory_group_id);

-- select
--     t.relname as table_name,
--     t.relnamespace as table_schema,
--     i.relname as index_name,
--     a.attname as column_name
-- from
--     pg_class t,
--     pg_class i,
--     pg_index ix,
--     pg_attribute a
-- where
--     t.oid = ix.indrelid
--     and i.oid = ix.indexrelid
--     and a.attrelid = t.oid
--     and a.attnum = ANY(ix.indkey)
--     and t.relkind = 'r'
--     and t.relname in ('organization')
-- order by
--     t.relnamespace,
--     t.relname,
--     a.attname,
--     i.relname;



select
    ns.nspname as table_schema,
    t.relname as table_name,
    a.attname as column_name,
    i.relname as index_name
from 
  pg_index ix
  join pg_class t on t.oid = ix.indrelid
  join pg_class i on i.oid = ix.indexrelid
  join pg_namespace ns on t.relnamespace = ns.oid
  join pg_attribute a on a.attrelid = t.oid and a.attnum = ANY(ix.indkey)
where
  t.relname = 'organization'
order by
    t.relnamespace,
    t.relname,
    a.attname,
    i.relname;
