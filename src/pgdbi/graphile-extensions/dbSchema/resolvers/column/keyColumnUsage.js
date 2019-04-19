const clog = require('fbkt-clog')

module.exports = (build => {
  return async (
    _column,
    args,
    context,
    resolveInfo
  ) => {
    const { pgSql: sql } = build;
    try {
      const tableSchema = _column.tableSchema
      const tableName = _column.tableName
      const columnName = _column.columnName

      const rows =
      await resolveInfo.graphile.selectGraphQLResultFromTable(
        sql.fragment`information_schema.key_column_usage`,
        (tableAlias, sqlBuilder) => {
          sqlBuilder.where(
            sql.fragment`${tableAlias}.table_schema = ${
              sql.value(tableSchema)
            }`
          );
          sqlBuilder.where(
            sql.fragment`${tableAlias}.table_name = ${
              sql.value(tableName)
            }`
          );
          sqlBuilder.where(
            sql.fragment`${tableAlias}.column_name = ${
              sql.value(columnName)
            }`
          );
        }
      );


      return rows
    } catch (e) {
      throw e;
    }
  }
})
