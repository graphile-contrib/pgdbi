            select 
            -- jsonb_pretty(
                jsonb_build_object(
                  'tablesForSchema', (
                  coalesce(
                    array_agg(
                      jsonb_build_object(
                        'id', 'schema.table:' || '${schemaName}' || '.' || t.table_name,
                        'name', t.table_name
                        )
                      )
                    , '{}')
                )
                )
            -- )
              from information_schema.tables t
              where t.table_schema = '${schemaName}'
            ;
