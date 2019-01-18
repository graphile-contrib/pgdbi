module.exports = async (
  _schema,
  args,
  context,
  resolveInfo
) => {
  const { pgClient } = context;
  try {
    const schemaName = args.id.split(':')[1].split('.')[0]
    const functionName = args.id.split(':')[1].split('.')[1]

    console.log('args', args)
    console.log('schemaName', schemaName)
    console.log('functionName', functionName)

    const sql = `
    select 
      jsonb_build_object(
        'functionById', (
          jsonb_build_object(
            'id', 'function:' || n.nspname || '.' || p.proname
            ,'name', p.proname
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
    console.log('sql', sql)
    const result = await pgClient.query(sql, []);
    console.log('result', result)
    return result.rows[0].jsonb_build_object.functionById;
  } catch (e) {
    throw e;
  }
}


