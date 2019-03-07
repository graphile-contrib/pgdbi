-- select
--   user_defined_type_catalog
--   ,user_defined_type_schema
--   ,user_defined_type_name
-- from information_schema.user_defined_types;



-- select n.nspname as enum_schema,
--        t.typname as enum_name,
--        e.enumlabel as enum_value
-- from pg_type t
--    join pg_enum e on t.oid = e.enumtypid
--    join pg_catalog.pg_namespace n ON n.oid = t.typnamespace
-- -- where t.typname like 'lf%'
-- where n.nspname = 'leaf'
-- order by t.typname
--    ;


-- select jsonb_pretty(
--     jsonb_build_object(
--       'schemaEnums', (
--       coalesce(
--         array_agg(
--           jsonb_build_object(
--             'id', 'enum:' || n.nspname || '.' || t.typname
--             ,'enumName', t.typname
--             ,'enumSchema', n.nspname
--             ,'enumValues', (
--                select array_agg(e.enumlabel)
--                from pg_enum e
--                where e.enumtypid = t.oid
--             )
--           )
--          )
--         , '{}')
--     )
--   )
-- )
-- from pg_type t
-- join pg_catalog.pg_namespace n ON n.oid = t.typnamespace
-- where t.oid in (select enumtypid from pg_enum)
-- and n.nspname = 'leaf'
-- group by
-- t.typname
-- order by t.typname
-- ;


    select jsonb_build_object(
      'id', 'enum:' || n.nspname || '.' || t.typname
      ,'enumName', t.typname
      ,'enumSchema', n.nspname
      ,'enumValues', (
        with vals as(
         select e.enumlabel
         from pg_enum e
         where e.enumtypid = t.oid
         order by e.enumlabel
        )
        select array_agg(enumlabel)
        from vals
      )
    )
    from pg_type t
      join pg_catalog.pg_namespace n ON n.oid = t.typnamespace
      where t.oid in (select enumtypid from pg_enum)
and n.nspname = 'leaf'
      group by
      n.nspname
      ,t.typname
      ,t.oid
      order by 
        t.typname
      ;
