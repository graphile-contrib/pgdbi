module.exports = (build => {
  return async (
    _schema,
    args,
    context,
    resolveInfo
  ) => {
    const { pgSql: sql } = build;
    try {
      const schemaName = _schema.schemaName
  
      const rows =
      await resolveInfo.graphile.selectGraphQLResultFromTable(
        sql.fragment`information_schema.tables`,
        (tableAlias, sqlBuilder) => {
          sqlBuilder.where(
            sql.fragment`${tableAlias}.table_schema = ${
              sql.value(schemaName)
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