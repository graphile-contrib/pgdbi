const clog = require('fbkt-clog')

module.exports = (build => {
  return async (
    _checkConstraint,
    args,
    context,
    resolveInfo
  ) => {
    const { pgSql: sql } = build;
    try {
      const constraintSchema = _checkConstraint.constraintSchema
      const constraintName = _checkConstraint.constraintName

      const rows =
      await resolveInfo.graphile.selectGraphQLResultFromTable(
        sql.fragment`information_schema.table_constraints`,
        (tableAlias, sqlBuilder) => {
          sqlBuilder.where(
            sql.fragment`${tableAlias}.constraint_schema = ${
              sql.value(constraintSchema)
            }`
          );
          sqlBuilder.where(
            sql.fragment`${tableAlias}.constraint_name = ${
              sql.value(constraintName)
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
