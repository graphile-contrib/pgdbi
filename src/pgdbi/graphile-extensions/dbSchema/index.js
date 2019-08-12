const clog = require('fbkt-clog');
const { makeExtendSchemaPlugin, gql } = require('graphile-utils');

const DbSchemaPlugin = makeExtendSchemaPlugin(build => {
  const { pgSql: sql } = build;
  return {
    typeDefs: gql`
      extend type Query {
        dbIntrospection: JSON!
      }
    `,
    resolvers: {
      Query: {
        dbIntrospection: require('./introspection')(build)
      },
    },
  };
});

module.exports = DbSchemaPlugin;
