
-- SELECT array_to_json(array_agg(row_to_json(t)))
with d as (
  SELECT array_to_json(array_agg(to_jsonb(s)), true) result
  FROM (
    select
      'schema:' || schema_name "id"
      ,schema_name "schemaName"
      ,(
        select array_to_json(array_agg(to_jsonb(t)), true)
        from (
          select
            'table:'||t.table_schema||'.'||t.table_name "id"
            ,table_schema "tableSchema"
            ,table_name "tableName"
            ,(
              select array_to_json(array_agg(to_jsonb(c)), true)
              from (
                select
                  'tableColumn:'||c.table_schema||'.'||c.table_name||'.'||c.column_name "id"
                  ,table_schema "tableSchema"
                  ,table_name "tableName"
                  ,column_name "columnName"
                from information_schema.columns c
                where c.table_schema = t.table_schema
                and c.table_name = t.table_name
              ) c
            ) "tableColumns"
          from information_schema.tables t
          where t.table_schema = s.schema_name
        ) t
      ) "schemaTables"
    from information_schema.schemata s
    where s.schema_name = 'evt'
  ) s
)
select jsonb_pretty(result::jsonb) from d
;