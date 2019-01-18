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
                      'name', s.name
                      )
                    )
                  )
              )
              from schemas s
            -- )
            ;
