select
    -- jsonb_pretty(
      jsonb_build_object(
        'id', 'schema:' || s.schema_name,
        'name', s.schema_name
      )
      from information_schema.schemata s
      WHERE s.schema_name = 'auth'
      -- )
    ;