module.exports = build => {
  return async (_trigger, args, context, resolveInfo) => {
    const { pgClient } = context;
    try {
      // assumes action statement of the form:  'EXECUTE PROCEDURE schema_name.function_name()'
      const schemaName = _trigger.actionStatement.split(' ')[2].split('.')[0];
      const functionName = _trigger.actionStatement
        .split(' ')[2]
        .split('.')[1]
        .split('(')[0];

      const sql = `
    select 
    jsonb_build_object(
      'triggerFunction', (
        jsonb_build_object(
          'id', 'function:' || n.nspname || '.' || p.proname
          ,'functionName', p.proname
          ,'functionSchema', n.nspname
          ,'resultDataType', coalesce(pg_catalog.pg_get_function_result(p.oid), 'N/A')
          ,'argumentDataTypes', coalesce(pg_catalog.pg_get_function_arguments(p.oid), 'N/A')
          ,'definition', coalesce(pg_catalog.pg_get_functiondef(p.oid)::text, 'N/A')
        )
      )
    )
  from pg_catalog.pg_proc p
  left join pg_catalog.pg_namespace n ON n.oid = p.pronamespace
  where n.nspname = '${schemaName}'
  and p.proname = '${functionName}'
  ;
`;
      // console.log('sql',sql)
      const result = await pgClient.query(sql, []);
      // console.log('result',result)
      return result.rows[0].jsonb_build_object.triggerFunction;
    } catch (e) {
      throw e;
    }
  };
};
