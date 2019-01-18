const clog = require('fbkt-clog')
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

// const MyRegisterUserMutationPlugin =
// makeExtendSchemaPlugin(build => {
//   const { pgSql: sql } = build;
//   return {
//     typeDefs: gql`
//       input RegisterUserInput {
//         name: String!
//         email: String!
//         bio: String
//       }

//       type RegisterUserPayload {
//         user: User @recurseDataGenerators
//         query: Query
//       }

//       extend type Mutation {
//         registerUser(input: RegisterUserInput!):
//           RegisterUserPayload
//       }
//     `,
//     resolvers: {
//       Mutation: {
//         registerUser: async (
//           _query,
//           args,
//           context,
//           resolveInfo,
//           { selectGraphQLResultFromTable }
//         ) => {
//           const { pgClient } = context;
//           // Start a sub-transaction
//           await pgClient.query("SAVEPOINT graphql_mutation");
//           try {

//             // Our custom logic to register the user:
//             const result = await pgClient.query(args.input.sql,
//               [
//               ]
//             );

//             clog('result', result)

//             // Now we fetch the result that the GraphQL
//             // client requested, using the new user
//             // account as the source of the data. You
//             // should always use
//             // `selectGraphQLResultFromTable` if you
//             // return database data from your custom
//             // field.
//             // const [row] =
//             //   await selectGraphQLResultFromTable(
//             //     sql.fragment`app_public.users`,
//             //     (tableAlias, sqlBuilder) => {
//             //       sqlBuilder.where(
//             //         sql.fragment`${tableAlias}.id = ${
//             //           sql.value(user.id)
//             //         }`
//             //       );
//             //     }
//             //   );

//               // Success! Write the user to the database.
//             await pgClient.query("RELEASE SAVEPOINT graphql_mutation");

//             // We pass the fetched result via the
//             // `user` field to match the
//             // @recurseDataGenerators directive
//             // used above. GraphQL mutation
//             // payloads typically have additional
//             // fields.
//             return {
//               user: row,
//               query: build.$$isQuery,
//             };
//           } catch (e) {
//             // Oh noes! If at first you don't succeed,
//             // destroy all evidence you ever tried.
//             await pgClient.query("ROLLBACK TO SAVEPOINT graphql_mutation");
//             throw e;
//           }
//         },
//       },
//     },
//   };
// });
