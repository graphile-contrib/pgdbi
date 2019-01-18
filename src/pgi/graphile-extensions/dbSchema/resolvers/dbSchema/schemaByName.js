module.exports = async (
  _query,
  args,
  context,
  resolveInfo
) => {
  const { pgClient } = context;
  try {
    const sql = `
    select 
      jsonb_build_object(
        'id', 'schema:' || s.schema_name,
        'name', s.schema_name
      )
    from information_schema.schemata s
    where s.schema_name = '${args.schemaName}'
    ;
    `;
    const result = await pgClient.query(sql, []);
    return result.rows[0].jsonb_build_object;
  } catch (e) {
    throw e;
  }
}