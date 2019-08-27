  select
    c.*
    ,'unique_constraint' __typename
    -- ,s.schema_name || '.' || t.table_name || '.' || c.constraint_name id
    ,(
      select (array_to_json(array_agg(row_to_json(kcu))))::jsonb
      from (
        select
        kcu.*
        from information_schema.key_column_usage kcu
        where kcu.constraint_schema = c.constraint_schema
        and kcu.constraint_name = c.constraint_name
      ) kcu
    ) key_column_usage
    ,pg_get_constraintdef(pgc.oid) constraint_definition
  from information_schema.table_constraints c
  join pg_catalog.pg_constraint pgc on pgc.conname = c.constraint_name
  -- join pg_catalog.pg_namespace pgn on pgn.nspname = 'pgdbi_dev'
  -- join pg_catalog.pg_class tbl on tbl.relnamespace = pgn.oid and tbl.relname = 'contrived_sink_reference'
  where c.table_schema = 'pgdbi_dev'
  and c.table_name = 'contrived_sink_reference'
  and c.constraint_type = 'UNIQUE'
;

select oid, relname from pg_class where relname = 'contrived_sink_reference';

select pg_get_tabledef(574884);