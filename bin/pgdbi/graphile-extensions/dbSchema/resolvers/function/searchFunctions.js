module.exports = build => {
  return async (_schema, args, context, resolveInfo) => {
    const { pgClient } = context;
    try {
      const searchTerm = args.searchTerm;

      const sql = `
        with procs as (
          select
            p.oid
            ,p.proname
            ,n.nspname
          from pg_proc p
          join pg_catalog.pg_namespace n ON n.oid = p.pronamespace
          where lower(p.prosrc) like '%${searchTerm}%'
          or lower(p.proname) like '%%${searchTerm}%'
        )
        select 
          jsonb_build_object(
            'searchFunctions', (
              coalesce(
                array_agg(
                  jsonb_build_object(
                    'id', 'function:' || p.nspname || '.' || p.proname
                    ,'functionName', p.proname
                    ,'functionSchema', p.nspname
                    ,'resultDataType', coalesce(pg_catalog.pg_get_function_result(p.oid), 'N/A')
                    ,'argumentDataTypes', coalesce(pg_catalog.pg_get_function_arguments(p.oid), 'N/A')
                    ,'definition', coalesce(pg_catalog.pg_get_functiondef(p.oid)::text, 'N/A')
                  )
                )
              )
            )
          )
        from procs p
        ;
      `;

      const result = await pgClient.query(sql, []);

      return result.rows[0].jsonb_build_object.searchFunctions;
    } catch (e) {
      throw e;
    }
  };
};
