const clog = require('fbkt-clog');

module.exports = build => {
  return async (_table, args, context, resolveInfo) => {
    const { pgSql: sql } = build;
    try {
      const tableSchema = _table.tableSchema;
      const tableName = _table.tableName;

      const rows = await resolveInfo.graphile.selectGraphQLResultFromTable(
        sql.fragment`information_schema.table_constraints`,
        (tableAlias, sqlBuilder) => {
          sqlBuilder.where(
            sql.fragment`${tableAlias}.table_name = ${sql.value(tableName)}`,
          );
          sqlBuilder.where(
            sql.fragment`${tableAlias}.table_schema = ${sql.value(
              tableSchema,
            )}`,
          );

          sqlBuilder.where(
            sql.fragment`${tableAlias}.constraint_type = ${sql.value(
              'PRIMARY KEY',
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
