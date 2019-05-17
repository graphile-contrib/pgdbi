const clog = require('fbkt-clog');

module.exports = build => {
  return async (_schema, args, context, resolveInfo) => {
    const { pgSql: sql } = build;
    try {
      const schemaName = _schema.schemaName;

      return `schema:${schemaName}`;
    } catch (e) {
      throw e;
    }
  };
};
