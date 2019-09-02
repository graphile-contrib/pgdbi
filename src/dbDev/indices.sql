select jsonb_pretty(
  (
    select (array_to_json(array_agg(row_to_json(i))))::jsonb
    from (
      select 
        'index:' || ns.nspname || '.' || tb.relname id
        ,tb.relname table_name
        ,ns.nspname table_schema
        ,i.relname index_name
        ,ix.indexrelid
        ,ix.indrelid
        ,ix.indnatts
        ,ix.indisunique
        ,ix.indisprimary
        ,ix.indisexclusion
        ,ix.indimmediate
        ,ix.indisclustered
        ,ix.indisvalid
        ,ix.indcheckxmin
        ,ix.indisready
        ,ix.indislive
        ,ix.indisreplident
        ,ix.indkey
        ,ix.indcollation
        ,ix.indclass
        ,ix.indoption
        ,ix.indexprs
        ,ix.indpred
        ,pg_get_indexdef(ix.indexrelid) index_definition
        ,(
          select (array_to_json(array_agg(row_to_json(c))))::jsonb
          from (
            select 
              a.attname column_name,
              a.attnum indkey
            from pg_attribute a
            where a.attrelid = tb.oid 
            and a.attnum = ANY(ix.indkey)
          ) c
        ) index_columns
        -- ,(
        --   select (array_to_json(array_agg(row_to_json(c))))::jsonb
        --   from (
        --     select a.*
        --     from pg_attribute a
        --     where a.attrelid = tb.oid
        --   ) c
        -- ) index_attributes
      from 
        pg_index ix
        join pg_class tb on tb.oid = ix.indrelid
        join pg_class i on i.oid = ix.indexrelid
        join pg_namespace ns on tb.relnamespace = ns.oid
      where
        ns.nspname = 'pgdbi_dev'
      and
        tb.relname = 'sink'
      and i.relname = 'idx_fk_multi_column_with_index'
      group by
        ns.nspname
        ,tb.oid
        ,tb.relname
        ,ix.indexrelid
        ,ix.indrelid
        ,ix.indnatts
        ,ix.indisunique
        ,ix.indisprimary
        ,ix.indisexclusion
        ,ix.indimmediate
        ,ix.indisclustered
        ,ix.indisvalid
        ,ix.indcheckxmin
        ,ix.indisready
        ,ix.indislive
        ,ix.indisreplident
        ,ix.indkey
        ,ix.indcollation
        ,ix.indclass
        ,ix.indoption
        ,ix.indexprs
        ,ix.indpred
        ,i.relname
      order by
        ns.nspname
        ,tb.relname
        ,i.relname
    ) i
  )
)
;



-- SELECT * FROM pg_stat_user_indexes WHERE indexrelname = 'idx_contrived_sink_reference_with_index';


-- select * from 

-- select
--   pgc.conname
--   ,pgc.conrelid
--   ,pgn.nspname
--   ,pgcl.relname
-- from pg_catalog.pg_constraint pgc
-- join pg_catalog.pg_namespace pgn on pgc.connamespace = pgn.oid
-- join pg_class pgcl on pgcl.oid = pgc.conrelid
-- where pgc.conname like '%contrived%'
-- ;