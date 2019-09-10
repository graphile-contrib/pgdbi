SELECT 
  pg_catalog.format_type ( t.oid, NULL ) AS id,
  n.nspname AS udt_schema,
  t.typname AS udt_name,
  CASE
      WHEN t.typrelid != 0
      THEN CAST ( 'tuple' AS pg_catalog.text )
      WHEN t.typlen < 0
      THEN CAST ( 'var' AS pg_catalog.text )
      ELSE CAST ( t.typlen AS pg_catalog.text )
  END AS size
  ,(
    select coalesce((array_to_json(array_agg(row_to_json(udt))))::jsonb, '[]')
    from (
      select
        a.attname field_name
        ,pg_catalog.format_type ( a_type.oid, NULL )
      from pg_catalog.pg_attribute a
      join pg_catalog.pg_type a_type on a_type.oid = a.atttypid
      where a.attrelid = t.typrelid
    ) udt
  )
FROM pg_catalog.pg_type t
LEFT JOIN pg_catalog.pg_namespace n
  ON n.oid = t.typnamespace
WHERE t.typtype = 'c' 
AND ( t.typrelid = 0 OR ( SELECT c.relkind = 'c'
      FROM pg_catalog.pg_class c
      WHERE c.oid = t.typrelid
  )
)
AND NOT EXISTS
  ( SELECT 1
    FROM pg_catalog.pg_type el
    WHERE el.oid = t.typelem
    AND el.typarray = t.oid
  )
AND n.nspname = 'pgdbi_dev'
ORDER BY 1, 2;

-- WHERE ( t.typrelid = 0
--         OR ( SELECT c.relkind = 'c'
--                 FROM pg_catalog.pg_class c
--                 WHERE c.oid = t.typrelid
--             )
--     )
--     AND NOT EXISTS
--         ( SELECT 1
--             FROM pg_catalog.pg_type el
--             WHERE el.oid = t.typelem
--                 AND el.typarray = t.oid
--         )
-- --     AND n.nspname <> 'pg_catalog'
-- --     AND n.nspname <> 'information_schema'
--     AND n.nspname = 'pgdbi_dev'
--     -- AND pg_catalog.pg_type_is_visible ( t.oid )
-- ORDER BY 1, 2;


-- select 
--   *,
--   pg_catalog.format_type ( t.oid, NULL ) AS name
--   from pg_catalog.pg_type t
-- where pg_catalog.format_type ( t.oid, NULL ) = 'pgdbi_dev.fn_options';
--   where t.oid = 631231
-- ;


select * from pg_attribute where attrelid =
  (select typrelid from pg_type where typname = 'fn_options')


-- select
--   (n.nspname || '.' || t.typname) id
--   ,'enum' __typename
--   ,t.typname udt_name
--   ,n.nspname udt_schema
--   ,(
--     with vals as(
--     select e.enumlabel
--     from pg_enum e
--     where e.enumtypid = t.oid
--     order by e.enumlabel
--     )
--     select array_agg(enumlabel)
--     from vals
--   ) enum_values
-- from pg_type t
-- join pg_catalog.pg_namespace n ON n.oid = t.typnamespace
-- where t.oid in (select enumtypid from pg_enum)
-- and n.nspname = 'pgdbi_dev'
-- group by
--   n.nspname
--   ,t.typname
--   ,t.oid
-- order by 
--   t.typname
-- ;
