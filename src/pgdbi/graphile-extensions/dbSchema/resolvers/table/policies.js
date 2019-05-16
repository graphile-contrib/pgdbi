module.exports = build => {
  return async (_table, args, context, resolveInfo) => {
    const { pgClient } = context;
    try {
      const tableSchema = _table.tableSchema;
      const tableName = _table.tableName;

      const sql = `
      select 
        jsonb_build_object(
          'tablePolicies', (
          coalesce(
            array_agg(
              jsonb_build_object(
                'schemaName', p.schemaname
                ,'tableName', p.tablename
                ,'policyName', p.policyname
                ,'roles', p.roles
                ,'cmd', p.cmd
                ,'qual', p.qual
                ,'withCheck', p.with_check
                )
              )
            , '{}')
        )
      )
      FROM pg_policies p
      where
        p.schemaname = '${tableSchema}'
      and
        p.tablename = '${tableName}'
      ;
    `;

      const result = await pgClient.query(sql, []);
      return result.rows[0].jsonb_build_object.tablePolicies;
    } catch (e) {
      throw e;
    }
  };
};
