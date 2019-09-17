                select
                  'function' __typename
                  ,'public' || '.' ||  p.proname || '--' || replace(replace(coalesce(pg_catalog.pg_get_function_identity_arguments(p.oid), 'N/A'),', ','_'),' ',':') id
                  ,p.proname function_name
                  ,n.nspname function_schema
                  -- ,coalesce(pg_catalog.pg_get_function_result(p.oid), 'N/A') result_data_type
                  -- ,coalesce(pg_catalog.pg_get_function_arguments(p.oid), 'N/A') argument_data_types
                  -- ,coalesce(pg_catalog.pg_get_functiondef(p.oid)::text, 'N/A') definition
                  from pg_catalog.pg_proc p
                  left join pg_catalog.pg_namespace n ON n.oid = p.pronamespace
                  where n.nspname = 'public'
                  and p.proisagg = false
                  order by p.proname
