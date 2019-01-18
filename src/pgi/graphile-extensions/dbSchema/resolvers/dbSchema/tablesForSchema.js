module.exports = async (
  _schema,
  args,
  context,
  resolveInfo
) => {
  const { pgClient } = context;
  try {
    const schemaName = _schema.id.split(':')[1]

    const sql = `
    select 
      jsonb_build_object(
        'tablesForSchema', (
        coalesce(
          array_agg(
            jsonb_build_object(
              'id', 'table:' || '${schemaName}' || '.' || t.table_name,
              'name', t.table_name
              )
            )
          , '{}')
        )
      )
      from information_schema.tables t
      where t.table_schema = '${schemaName}'
    ;
    `;
    const result = await pgClient.query(sql, []);
    return result.rows[0].jsonb_build_object.tablesForSchema;
  } catch (e) {
    throw e;
  }
}
