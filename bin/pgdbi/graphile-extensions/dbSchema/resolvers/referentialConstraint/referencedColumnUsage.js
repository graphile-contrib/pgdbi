const clog = require('fbkt-clog')

module.exports = (build => {
  return async (
    _referentialConstraint,
    args,
    context,
    resolveInfo
  ) => {
    const { pgSql: sql } = build;
    try {
      const constraintSchema = _referentialConstraint.uniqueConstraintSchema
      const constraintName = _referentialConstraint.uniqueConstraintName

      const rows =
      await resolveInfo.graphile.selectGraphQLResultFromTable(
        sql.fragment`information_schema.key_column_usage`,
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
