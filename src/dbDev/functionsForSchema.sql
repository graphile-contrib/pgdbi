-- SELECT 
--   n.nspname as "Schema",
--   p.proname as "Name",
--   pg_catalog.pg_get_function_result(p.oid) as "Result data type",
--   pg_catalog.pg_get_function_arguments(p.oid) as "Argument data types",
--   pg_catalog.pg_get_functiondef(p.oid),
--  CASE
--   WHEN p.proisagg THEN 'agg'
--   WHEN p.proiswindow THEN 'window'
--   WHEN p.prorettype = 'pg_catalog.trigger'::pg_catalog.regtype THEN 'trigger'
--   ELSE 'normal'
--  END as "Type"
-- FROM pg_catalog.pg_proc p
--      LEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
-- WHERE n.nspname OPERATOR(pg_catalog.~) '^(pde)$'
-- ORDER BY 1, 2, 4;


    select 
      jsonb_build_object(
        'functionsForSchema', (
        coalesce(
          array_agg(
            jsonb_build_object(
              'id', 'function:' || n.nspname || '.' || p.proname,
              'name', p.proname,
              'resultDataType', coalesce(pg_catalog.pg_get_function_result(p.oid), 'N/A'),
              'argumentDataTypes', coalesce(pg_catalog.pg_get_function_arguments(p.oid), 'N/A'),
              'definition', coalesce(pg_catalog.pg_get_functiondef(p.oid), 'N/A')
              )
            )
          , '{}')
      )
    )
    from pg_catalog.pg_proc p
    left join pg_catalog.pg_namespace n ON n.oid = p.pronamespace
    where n.nspname = 'auth'
    ;
