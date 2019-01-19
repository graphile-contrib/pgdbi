module.exports = (build => {
  return async (
    _schema,
    args,
    context,
    resolveInfo
  ) => {
    const { pgClient } = context;
    try {
    const schemaName = _schema.schemaName
  
    const sql = `
    select 
      jsonb_build_object(
        'schemaFunctions', (
        coalesce(
          array_agg(
            jsonb_build_object(
              'id', 'function:' || n.nspname || '.' || p.proname
              ,'functionName', p.proname
              ,'functionSchema', n.nspname
              )
            )
          , '{}')
      )
    )
    from pg_catalog.pg_proc p
    left join pg_catalog.pg_namespace n ON n.oid = p.pronamespace
    where n.nspname = '${schemaName}'
    ;
    `;
    const result = await pgClient.query(sql, []);
    return result.rows[0].jsonb_build_object.schemaFunctions;
  } catch (e) {
      throw e;
    }
  }
})


