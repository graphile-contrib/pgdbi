
    -- select jsonb_pretty(
    --     jsonb_build_object(
    --       'functionsForSchema', (
    --       coalesce(
    --         array_agg(
    --           jsonb_build_object(
    --             'id', 'function:' || n.nspname || '.' || p.proname
    --             ,'name', p.proname
    --             -- ,'resultDataType', coalesce(pg_catalog.pg_get_function_result(p.oid), 'N/A')
    --             -- ,'argumentDataTypes', coalesce(pg_catalog.pg_get_function_arguments(p.oid), 'N/A')
    --             ,'definition', coalesce(pg_catalog.pg_get_functiondef(p.oid), 'N/A')
    --             )
    --           )
    --         , '{}')
    --     )
    --   )
    -- )
    -- from pg_catalog.pg_proc p
    -- left join pg_catalog.pg_namespace n ON n.oid = p.pronamespace
    -- -- where n.nspname = 'auth'
    -- where n.nspname = 'soro'
    -- and (
    --   p.proname like '%into soro.order_info%'
    --   or
    --   coalesce(pg_catalog.pg_get_functiondef(p.oid), 'N/A') like '%into soro.order_info%'
    -- )
    -- ;



-- select
--   'id', 'function:' || n.nspname || '.' || p.proname
--   ,'name', p.proname
--   -- ,'resultDataType', coalesce(pg_catalog.pg_get_function_result(p.oid), 'N/A')
--   -- ,'argumentDataTypes', coalesce(pg_catalog.pg_get_function_arguments(p.oid), 'N/A')
--   -- ,'definition', coalesce(pg_catalog.pg_get_functiondef(p.oid), 'N/A')
-- from pg_catalog.pg_proc p
-- left join pg_catalog.pg_namespace n ON n.oid = p.pronamespace
-- -- where n.nspname = 'auth'
-- where n.nspname = 'soro'
-- and (
--   p.proname like '%into soro.order_info%'
--   or
--   pg_catalog.pg_get_functiondef(p.oid) like '%into soro.order_info%'
-- )

-- select * from pg_proc where proname = 'pause_quote';

-- select proname,prosrc from pg_proc where prosrc like '%soro.order_info%';

with procs as (
  select
    p.oid
    ,p.proname
    ,n.nspname
  from pg_proc p
  join pg_catalog.pg_namespace n ON n.oid = p.pronamespace
  where lower(p.prosrc) like '%into soro.order_info%'
  or lower(p.proname) like '%commun%'
)
select 
  jsonb_build_object(
    'schemaFunctions', (
      coalesce(
        array_agg(
          jsonb_build_object(
            'id', 'function:' || p.nspname || '.' || p.proname
            ,'functionName', p.proname
            ,'functionSchema', p.nspname
            -- ,'resultDataType', coalesce(pg_catalog.pg_get_function_result(p.oid), 'N/A')
            -- ,'argumentDataTypes', coalesce(pg_catalog.pg_get_function_arguments(p.oid), 'N/A')
            -- ,'definition', coalesce(pg_catalog.pg_get_functiondef(p.oid)::text, 'N/A')
          )
        )
      )
    )
  )
from procs p
;