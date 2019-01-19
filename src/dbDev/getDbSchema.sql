            with schemas as (
              select schema_name as name 
              from information_schema.schemata 
              --where schema_name = 'auth'
            )
            select 
            -- jsonb_pretty(
              jsonb_build_object(
                'dbSchemas', (
                  select array_agg(
                    jsonb_build_object(
                      'id', 'schema:' || s.name,
                      'name', s.name,
                      'children', jsonb_build_array(
                        -- tables
                        jsonb_build_object(
                          'id', 'schema.tables:' || s.name,
                          'name', 'tables',
                          'children', (
                            SELECT coalesce(array_agg(jsonb_build_object(
                              'id', 'schema.table:' || s.name || '.' || t.table_name,
                              'name', t.table_name,
                              'children', jsonb_build_array(
                                jsonb_build_object(
                                  'id', 'schema.table.dependants:' || s.name  || '.' || t.table_name || '.dependants',
                                  'name', 'dependants'
                                ),
                                jsonb_build_object(
                                  'id', 'schema.table.indices:' || s.name  || '.' || t.table_name || '.indices',
                                  'name', 'indices'
                                ),
                                jsonb_build_object(
                                  'id', 'schema.table.permissions:' || s.name  || '.' || t.table_name || '.permissions',
                                  'name', 'permissions'
                                )
                              )
                            )), '{}')
                            from information_schema.tables t
                            WHERE t.table_schema = s.name
                          )
                        ),
                        -- functions
                        jsonb_build_object(
                          'id', 'schema.functions:' || s.name,
                          'name', 'functions',
                          'children', (
                            SELECT coalesce(array_agg(jsonb_build_object(
                              'id', ('schema.function:' || n.nspname || '.' || p.proname),
                              'name', (p.proname),
                              'children', jsonb_build_array(
                                jsonb_build_object(
                                  'id', 'schema.function.dependants:' || n.nspname  || '.' || p.proname || '.dependants',
                                  'name', 'dependants'
                                ),
                                jsonb_build_object(
                                  'id', 'schema.function.permissions:' || n.nspname  || '.' || p.proname || '.permissions',
                                  'name', 'permissions'
                                )
                              )
                            )), '{}')
                            FROM pg_catalog.pg_proc p
                                LEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
                            WHERE n.nspname = s.name
                          )
                        )
                      )
                    )
                  )
                  from schemas s
                )
              )
            -- )
            ;



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
-- WHERE n.nspname = 'auth'
-- ORDER BY 1, 2, 4;


-- SELECT pg_catalog.pg_get_functiondef('pde.build_minor'::regproc);
