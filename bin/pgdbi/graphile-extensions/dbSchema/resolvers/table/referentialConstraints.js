const clog = require('fbkt-clog');

module.exports = build => {
  return async (_table, args, context, resolveInfo) => {
    const { pgSql: sql } = build;
    try {
      const constraintSchema = _table.tableSchema;
      const tableName = _table.tableName;

      const rows = await resolveInfo.graphile.selectGraphQLResultFromTable(
        sql.fragment`information_schema.referential_constraints`,
        (tableAlias, sqlBuilder) => {
          sqlBuilder.where(
            sql.fragment`${tableAlias}.constraint_schema = ${sql.value(
              constraintSchema,
            )}`,
          );
          sqlBuilder.where(
            sql.fragment`${tableAlias}.constraint_name in (
              SELECT constraint_name
              from information_schema.table_constraints
              where table_name = ${sql.value(tableName)}
            )`,
          );
        },
      );

      return rows;
    } catch (e) {
      throw e;
    }
  };
};
