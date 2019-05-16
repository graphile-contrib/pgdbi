const clog = require('fbkt-clog');

module.exports = build => {
  return async (_table, args, context, resolveInfo) => {
    const { pgSql: sql } = build;
    try {
      const tableSchema = _table.tableSchema;
      const tableName = _table.tableName;

      return `table:${tableSchema}.${tableName}`;
    } catch (e) {
      throw e;
    }
  };
};
