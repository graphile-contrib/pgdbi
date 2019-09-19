module.exports = build => {
  return async (_table, args, context, resolveInfo) => {
    const { pgClient } = context;
    try {
      console.log('_table', _table)
      const tableSchema = _table.tableSchema;
      const tableName = _table.tableName;

      const sql = `\d+ ${tableSchema}.${tableName};`;
      console.log('sql', sql)

      const result = await pgClient.query(sql, []);
      return result.rows[0].jsonb_build_object.tablePolicies;
    } catch (e) {
      throw e;
    }
  };
};
