const clog = require('fbkt-clog')

module.exports = (build => {
  return async (
    _enabledRole,
    args,
    context,
    resolveInfo
  ) => {
    const { pgSql: sql } = build;
    try {
      const roleName = _enabledRole.roleName

      const rows =
      await resolveInfo.graphile.selectGraphQLResultFromTable(
        sql.fragment`information_schema.applicable_roles`,
        (tableAlias, sqlBuilder) => {
          sqlBuilder.where(
            sql.fragment`${tableAlias}.grantee = ${
              sql.value(roleName)
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
