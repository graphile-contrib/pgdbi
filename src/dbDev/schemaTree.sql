
select 
jsonb_pretty(
  jsonb_build_object(
    'schemata', (
      coalesce(
        array_agg(
          jsonb_build_object(
            'id', 'schema:' || s.schema_name
            ,'schemaName', s.schema_name
            ,'tables', (
              coalesce(
                array_agg(
                  jsonb_build_object(
                    'id', 'table:' || s.schema_name || ':' || t.table_name
                  )
                )
              )
            )
          )
        )
        , '{}'
      )
    )
  )
)
from information_schema.schemata s
join information_schema.tables t on t.table_schema = s.schema_name
where s.schema_name not like 'pg_%'
and s.schema_name != 'information_schema'
;