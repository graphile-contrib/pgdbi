async function buildQuery(schemas) {
  try {
    const querySql = `
    SELECT 
      (
        select coalesce((array_to_json(array_agg(row_to_json(er))))::jsonb, '[]')
        from (
          select
            er.*
            ,(
              select coalesce((array_to_json(array_agg(row_to_json(ar))))::jsonb, '[]')
              from (
                select
                  ar.*
                from information_schema.applicable_roles ar
                where ar.grantee = er.role_name
              ) ar
            ) applicable_roles
          from information_schema.enabled_roles er
        ) er
      ) enabled_roles
      ,(
        select coalesce((array_to_json(array_agg(row_to_json(s))))::jsonb, '[]'::jsonb)
        FROM (
          select 
            s.*
            ,'schema' __typename
            ,s.schema_name id
            ,(
              select coalesce((array_to_json(array_agg(row_to_json(t))))::jsonb, '[]')
              from (
                select
                  t.*
                  ,'table' __typename
                  ,s.schema_name || '.' || t.table_name id
                  ,(
                    select (array_to_json(array_agg(row_to_json(c))))::jsonb
                    from (
                      select
                        c.*
                        ,'column' __typename
                        ,s.schema_name || '.' || t.table_name || '.' || c.column_name id
                      from information_schema.columns c
                      where c.table_schema = t.table_schema
                      and c.table_name = t.table_name
                    ) c
                  ) table_columns
                  ,(
                    select coalesce((array_to_json(array_agg(row_to_json(c))))::jsonb, '[]'::jsonb)
                    from (
                      select
                        c.*
                        ,'primary_key_constraint' __typename
                        ,s.schema_name || '.' || t.table_name || '.' || c.constraint_name id
                        ,(
                          select (array_to_json(array_agg(row_to_json(kcu))))::jsonb
                          from (
                            select
                            kcu.*
                            from information_schema.key_column_usage kcu
                            where kcu.constraint_schema = c.constraint_schema
                            and kcu.constraint_name = c.constraint_name
                          ) kcu
                        ) key_column_usage
                      from information_schema.table_constraints c
                      where c.table_schema = t.table_schema
                      and c.table_name = t.table_name
                      and c.constraint_type = 'PRIMARY KEY'
                    ) c
                  ) primary_key_constraints
                  ,(
                    select coalesce((array_to_json(array_agg(row_to_json(c))))::jsonb, '[]'::jsonb)
                      from (
                        select
                        c.*
                        ,'unique_constraint' __typename
                        ,s.schema_name || '.' || t.table_name || '.' || c.constraint_name id
                        ,(
                          select (array_to_json(array_agg(row_to_json(kcu))))::jsonb
                          from (
                            select
                            kcu.*
                            from information_schema.key_column_usage kcu
                            where kcu.constraint_schema = c.constraint_schema
                            and kcu.constraint_name = c.constraint_name
                          ) kcu
                        ) key_column_usage
                        ,pg_get_constraintdef(pgc.oid) constraint_definition
                      from information_schema.table_constraints c
                      join pg_catalog.pg_constraint pgc on pgc.conname = c.constraint_name
                      where c.table_schema = t.table_schema
                      and c.table_name = t.table_name
                      and c.constraint_type = 'UNIQUE'
                    ) c
                  ) unique_constraints
                  ,(
                    select coalesce((array_to_json(array_agg(row_to_json(i))))::jsonb, '[]'::jsonb)
                    from (
                      select 
                        i.relname id
                        ,tb.relname table_name
                        ,ns.nspname table_schema
                        ,ix.indexrelid
                        ,ix.indrelid
                        ,ix.indnatts
                        ,ix.indisunique
                        ,ix.indisprimary
                        ,ix.indisexclusion
                        ,ix.indimmediate
                        ,ix.indisclustered
                        ,ix.indisvalid
                        ,ix.indcheckxmin
                        ,ix.indisready
                        ,ix.indislive
                        ,ix.indisreplident
                        ,ix.indkey
                        ,ix.indcollation
                        ,ix.indclass
                        ,ix.indoption
                        ,ix.indexprs
                        ,ix.indpred
                        ,i.relname index_name
                        ,(
                          select coalesce((array_to_json(array_agg(row_to_json(c))))::jsonb, '[]'::jsonb)
                          from (
                            select 
                              a.attname column_name,
                              a.attnum indkey
                            from pg_attribute a
                            where a.attrelid = tb.oid and a.attnum = ANY(ix.indkey)
                          ) c
                        ) index_columns
                        ,replace((pg_get_indexdef(ix.indexrelid) || ';'),'INDEX ','INDEX IF NOT EXISTS ') index_definition
                        ,'DROP INDEX IF EXISTS ' || ns.nspname || '.' || i.relname || ';' index_drop
                      from 
                        pg_index ix
                        join pg_class tb on tb.oid = ix.indrelid
                        join pg_class i on i.oid = ix.indexrelid
                        join pg_namespace ns on tb.relnamespace = ns.oid
                      where
                        ns.nspname = t.table_schema
                      and
                        tb.relname = t.table_name
                      group by
                        ns.nspname
                        ,tb.oid
                        ,tb.relname
                        ,ix.indexrelid
                        ,ix.indrelid
                        ,ix.indnatts
                        ,ix.indisunique
                        ,ix.indisprimary
                        ,ix.indisexclusion
                        ,ix.indimmediate
                        ,ix.indisclustered
                        ,ix.indisvalid
                        ,ix.indcheckxmin
                        ,ix.indisready
                        ,ix.indislive
                        ,ix.indisreplident
                        ,ix.indkey
                        ,ix.indcollation
                        ,ix.indclass
                        ,ix.indoption
                        ,ix.indexprs
                        ,ix.indpred
                        ,i.relname
                      order by
                          ns.nspname,
                          tb.relname,
                          ix.indexrelid,
                          i.relname
                    ) i
                  ) indices
                  ,(
                    select coalesce((array_to_json(array_agg(row_to_json(p))))::jsonb, '[]'::jsonb)
                    from (
                      select
                        *
                      from pg_catalog.pg_policies p
                      where p.schemaname = t.table_schema
                      and p.tablename = t.table_name
                    ) p
                  ) policies
                  ,(
                    select coalesce((array_to_json(array_agg(row_to_json(tr))))::jsonb, '[]'::jsonb)
                    from (
                      select
                        tr.*
                        ,'trigger' __typename
                        ,s.schema_name || '.' || t.table_name || '.' || tr.trigger_name || '.' || tr.action_timing || '.' || tr.event_manipulation id
                        ,(
                          select coalesce((array_to_json(array_agg(row_to_json(tf))))::jsonb, '[]'::jsonb)
                          from (
                            select
                              'trigger_function' __typename
                              ,s.schema_name || '.' || t.table_name || '.' || tr.trigger_name || '.' || p.proname id
                              ,p.proname function_name
                              ,n.nspname function_schema
                              ,coalesce(pg_catalog.pg_get_function_result(p.oid), 'N/A') result_data_type
                              ,coalesce(pg_catalog.pg_get_function_arguments(p.oid), 'N/A') argument_data_types
                              ,coalesce(pg_catalog.pg_get_functiondef(p.oid)::text, 'N/A') definition
                              from pg_catalog.pg_proc p
                              left join pg_catalog.pg_namespace n ON n.oid = p.pronamespace
                              where n.nspname = s.schema_name
                              and p.proname = split_part(split_part(split_part(tr.action_statement::text, ' ', 3)::text, '.', 2)::text, '(', 1)::text
                          ) tf
                        ) trigger_function
                      from information_schema.triggers tr
                      where tr.event_object_schema = t.table_schema
                      and tr.event_object_table = t.table_name
                    ) tr
                  ) triggers
                  ,(
                    select coalesce((array_to_json(array_agg(row_to_json(rtg))))::jsonb, '[]'::jsonb)
                    from (
                      select
                        rtg.*
                      from information_schema.role_table_grants rtg
                      where rtg.table_schema = t.table_schema
                      and rtg.table_name = t.table_name
                    ) rtg
                  ) role_table_grants
                  ,(
                    select coalesce((array_to_json(array_agg(row_to_json(cc))))::jsonb, '[]'::jsonb)
                    from (
                      select
                        cc.*
                        ,(
                          select coalesce((array_to_json(array_agg(row_to_json(tc))))::jsonb, '[]'::jsonb)
                          from (
                            select
                              tc.*
                            from information_schema.table_constraints tc
                            where tc.constraint_schema = cc.constraint_schema
                            and tc.constraint_name = cc.constraint_name
                          ) tc
                        ) table_constraints
                      from information_schema.check_constraints cc
                      where cc.constraint_schema = t.table_schema
                      and cc.constraint_name in (
                        SELECT constraint_name
                        from information_schema.table_constraints
                        where table_name = t.table_name
                      )
                    ) cc
                  ) check_constraints
                  ,(
                    select coalesce((array_to_json(array_agg(row_to_json(rc))))::jsonb, '[]'::jsonb)
                    from (
                      select
                        rc.*
                        ,(
                          select coalesce((array_to_json(array_agg(row_to_json(rcu))))::jsonb, '[]'::jsonb)
                          from (
                            select
                              rcu.*
                            from information_schema.key_column_usage rcu
                            where rcu.constraint_schema = rc.constraint_schema
                            and rcu.constraint_name = rc.constraint_name
                          ) rcu
                        ) referencing_column_usage
                        ,(
                          select coalesce((array_to_json(array_agg(row_to_json(rcu))))::jsonb, '[]'::jsonb)
                          from (
                            select
                              rcu.*
                            from information_schema.key_column_usage rcu
                            where rcu.constraint_schema = rc.unique_constraint_schema
                            and rcu.constraint_name = rc.unique_constraint_name
                          ) rcu
                        ) referenced_column_usage
                      from information_schema.referential_constraints rc
                      where rc.constraint_schema = t.table_schema
                      and rc.constraint_name in (
                        SELECT constraint_name
                        from information_schema.table_constraints
                        where table_name = t.table_name
                        )
                    ) rc
                  ) referential_constraints
                from information_schema.tables t
                where t.table_schema = s.schema_name
              ) t
            ) schema_tables
            ,(
              select coalesce((array_to_json(array_agg(row_to_json(enums))))::jsonb, '[]')
              from (
                select
                (n.nspname || '.' || t.typname) id
                ,'enum' __typename
                ,t.typname enum_name
                ,n.nspname enum_schema
                ,(
                  with vals as(
                  select e.enumlabel
                  from pg_enum e
                  where e.enumtypid = t.oid
                  order by e.enumlabel
                  )
                  select array_agg(enumlabel)
                  from vals
                ) enum_values
              from pg_type t
              join pg_catalog.pg_namespace n ON n.oid = t.typnamespace
              where t.oid in (select enumtypid from pg_enum)
              and n.nspname = s.schema_name
              group by
                n.nspname
                ,t.typname
                ,t.oid
              order by 
                t.typname
                ) enums
            ) schema_enums
            ,(
              select coalesce((array_to_json(array_agg(row_to_json(udts))))::jsonb, '[]')
              from (
                SELECT 
                pg_catalog.format_type ( t.oid, NULL ) AS id,
                n.nspname AS udt_schema,
                t.typname AS udt_name
                ,(
                  select coalesce((array_to_json(array_agg(row_to_json(udt))))::jsonb, '[]')
                  from (
                    select
                      a.attname field_name
                      ,pg_catalog.format_type ( a_type.oid, NULL ) data_type
                    from pg_catalog.pg_attribute a
                    join pg_catalog.pg_type a_type on a_type.oid = a.atttypid
                    where a.attrelid = t.typrelid
                    order by a.attnum
                  ) udt
                ) fields
                FROM pg_catalog.pg_type t
                LEFT JOIN pg_catalog.pg_namespace n
                  ON n.oid = t.typnamespace
                WHERE t.typtype = 'c' 
                AND ( t.typrelid = 0 OR ( SELECT c.relkind = 'c'
                      FROM pg_catalog.pg_class c
                      WHERE c.oid = t.typrelid
                  )
                )
                AND NOT EXISTS
                  ( SELECT 1
                    FROM pg_catalog.pg_type el
                    WHERE el.oid = t.typelem
                    AND el.typarray = t.oid
                  )
                AND n.nspname = s.schema_name
                ORDER BY 1, 2
              ) udts
            ) schema_udts
            ,(
              select coalesce((array_to_json(array_agg(row_to_json(sf))))::jsonb, '[]'::jsonb)
              from (
                select
                  'function' __typename
                  ,n.nspname || '.' ||  p.proname || '_' || p.oid id
                  ,p.proname function_name
                  ,n.nspname function_schema
                  ,coalesce(pg_catalog.pg_get_function_result(p.oid), 'N/A') result_data_type
                  ,coalesce(pg_catalog.pg_get_function_arguments(p.oid), 'N/A') argument_data_types
                  ,coalesce(pg_catalog.pg_get_functiondef(p.oid)::text, 'N/A') definition
                  from pg_catalog.pg_proc p
                  left join pg_catalog.pg_namespace n ON n.oid = p.pronamespace
                  where n.nspname = s.schema_name
                  and p.proisagg = false
              ) sf
            ) schema_functions
          from information_schema.schemata s
          where schema_name in ('${schemas}')
        ) s
      ) schema_tree
  ;
      `
      return querySql;

  } catch (e) {
    console.log('CAUGHT ERROR', e.toString())
    throw e;
  }
}

module.exports = buildQuery