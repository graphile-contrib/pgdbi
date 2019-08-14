const util = require('util')
const pgdbiApp = require('../../index')

module.exports = build => {
  return async (_schema, args, context, resolveInfo) => {
    return pgdbiApp.schemaTree()
  };
};
