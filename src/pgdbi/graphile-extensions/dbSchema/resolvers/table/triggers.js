module.exports = build => {
  return async (_table, args, context, resolveInfo) => {
    const { pgSql: sql } = build;
    try {
      const tableSchema = _table.tableSchema;
      const tableName = _table.tableName;

      const rows = await resolveInfo.graphile.selectGraphQLResultFromTable(
        sql.fragment`information_schema.triggers`,
        (tableAlias, sqlBuilder) => {
          sqlBuilder.where(
            sql.fragment`${tableAlias}.event_object_schema = ${sql.value(
              tableSchema,
            )}`,
          );
          sqlBuilder.where(
            sql.fragment`${tableAlias}.event_object_table = ${sql.value(
              tableName,
            )}`,
          );
        },
      );

      return rows;
    } catch (e) {
      throw e;
    }
  };
};
