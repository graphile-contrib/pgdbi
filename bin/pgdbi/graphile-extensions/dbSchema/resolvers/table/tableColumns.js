module.exports = build => {
  return async (_table, args, context, resolveInfo) => {
    const { pgSql: sql } = build;
    try {
      const tableSchema = _table.tableSchema;
      const tableName = _table.tableName;

      const rows = await resolveInfo.graphile.selectGraphQLResultFromTable(
        sql.fragment`information_schema.columns`,
        (tableAlias, sqlBuilder) => {
          sqlBuilder.where(
            sql.fragment`${tableAlias}.table_schema = ${sql.value(
              tableSchema,
            )}`,
          );
          sqlBuilder.where(
            sql.fragment`${tableAlias}.table_name = ${sql.value(tableName)}`,
          );
        },
      );

      return rows;
    } catch (e) {
      throw e;
    }
  };
};
