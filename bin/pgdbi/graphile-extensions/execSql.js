const { makeExtendSchemaPlugin, gql } = require("graphile-utils");

const ExecSqlPlugin = makeExtendSchemaPlugin(build => {
  const { pgSql: sql } = build;
  return {
    typeDefs: gql`
    input ExecSqlInput {
      clientMutationId: String
      sql: String!
    }

    type ExecSqlPayload {
      sql: String!
      result: JSON!
    }

    extend type Mutation {
      ExecSql(input: ExecSqlInput!): ExecSqlPayload
    }
  `,
  resolvers: {
      Mutation: {
        ExecSql: async (
          _mutation,
          args,
          context,
          resolveInfo,
          { selectGraphQLResultFromTable }
        ) => {
          const { pgClient } = context;
          // Start a sub-transaction
          await pgClient.query("SAVEPOINT graphql_mutation");
          try {

            // clog('LET US EXEC SQL', pgClient)
            const result = await pgClient.query(args.input.sql, []);

            await pgClient.query("RELEASE SAVEPOINT graphql_mutation");

            return {
              sql: args.input.sql,
              result: result
            };
          } catch (e) {
            // Oh noes! If at first you don't succeed,
            // destroy all evidence you ever tried.
            await pgClient.query("ROLLBACK TO SAVEPOINT graphql_mutation");
            throw e;
          }
        },
      },
    },
  };
});

module.exports = ExecSqlPlugin


// the above was built from the below
// https://www.graphile.org/postgraphile/make-extend-schema-plugin/
