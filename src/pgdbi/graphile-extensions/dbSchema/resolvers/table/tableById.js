module.exports = build => {
  return async (_schema, args, context, resolveInfo) => {
    const { pgSql: sql } = build;
    try {
      const tableSchema = args.id.split(':')[1].split('.')[0];
      const tableName = args.id.split(':')[1].split('.')[1];

      // console.log('args', args)
      // console.log('tableSchema', tableSchema)
      // console.log('tableName', tableName)

      const rows = await resolveInfo.graphile.selectGraphQLResultFromTable(
        sql.fragment`information_schema.tables`,
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

      return rows[0];
    } catch (e) {
      throw e;
    }
  };
};
