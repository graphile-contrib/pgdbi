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
    -- jsonb_pretty(
      jsonb_build_object(
        'dbSchemas', (
          select array_agg(
            jsonb_build_object(
              'id', 'schema:' || s.schema_name,
              'name', s.schema_name
              )
            )
          )
      )
      from information_schema.schemata s
    -- )
    ;
    `;
    const result = await pgClient.query(sql, []);
    return result.rows[0].jsonb_build_object.dbSchemas;
  } catch (e) {
    throw e;
  }
}