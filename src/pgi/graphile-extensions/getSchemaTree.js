const clog = require('fbkt-clog')
const { makeExtendSchemaPlugin, gql } = require("graphile-utils");

const GetSchemaTreePlugin = makeExtendSchemaPlugin(build => {
  const { pgSql: sql } = build;
  return {
    typeDefs: gql`
    input GetDbSchemaTreeInput {
      clientMutationId: String
    }

    # interface TreeNode {
    #   id: String!
    #   name: String!
    #   children: [TreeNode]
    # }

    # type DbColumn {
    #   id: String!
    #   name: String!
    #   dataType: String!
    #   isNullable: Boolean!
    #   columnDefault: String
    # }

    # type DbTable implements TreeNode {
    #   id: String!
    #   name: String!
    # }

    # type DbSchemaChildren {
    #   tables: [DbTable]!
    # }

    # type DbSchema implements TreeNode {
    #   id: String!
    #   name: String!
    #   children: [TreeNode]!
    # }

    # type GetDbSchemaTreePayload {
    #   dbSchemas: [DbSchema]!
    # }

    type GetDbSchemaTreePayload {
      dbSchemas: JSON!
    }

    extend type Mutation {
      getDbSchemaTree(input: GetDbSchemaTreeInput!): GetDbSchemaTreePayload
    }
  `,
  resolvers: {
      Mutation: {
        getDbSchemaTree: async (
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

            const sql = `
            with schemas as (
              select schema_name as name 
              from information_schema.schemata 
              --where schema_name = 'auth'
            )
            select 
            -- jsonb_pretty(
              jsonb_build_object(
                'dbSchemas', (
                  select array_agg(
                    jsonb_build_object(
                      'id', 'schema:' || s.name,
                      'name', s.name,
                      'children', jsonb_build_array(
                        -- tables
                        jsonb_build_object(
                          'id', 'schema.tables:' || s.name,
                          'name', 'tables',
                          'children', (
                            SELECT coalesce(array_agg(jsonb_build_object(
                              'id', 'schema.table:' || s.name || '.' || t.table_name,
                              'name', t.table_name,
                              'children', jsonb_build_array(
                                jsonb_build_object(
                                  'id', 'schema.table.dependants:' || s.name  || '.' || t.table_name || '.dependants',
                                  'name', 'dependants'
                                ),
                                jsonb_build_object(
                                  'id', 'schema.table.indices:' || s.name  || '.' || t.table_name || '.indices',
                                  'name', 'indices'
                                ),
                                jsonb_build_object(
                                  'id', 'schema.table.permissions:' || s.name  || '.' || t.table_name || '.permissions',
                                  'name', 'permissions'
                                )
                              )
                            )), '{}')
                            from information_schema.tables t
                            WHERE t.table_schema = s.name
                          )
                        ),
                        -- functions
                        jsonb_build_object(
                          'id', 'schema.functions:' || s.name,
                          'name', 'functions',
                          'children', (
                            SELECT coalesce(array_agg(jsonb_build_object(
                              'id', ('schema.function:' || n.nspname || '.' || p.proname),
                              'name', (p.proname),
                              'children', jsonb_build_array(
                                jsonb_build_object(
                                  'id', 'schema.function.dependants:' || n.nspname  || '.' || p.proname || '.dependants',
                                  'name', 'dependants'
                                ),
                                jsonb_build_object(
                                  'id', 'schema.function.permissions:' || n.nspname  || '.' || p.proname || '.permissions',
                                  'name', 'permissions'
                                )
                              )
                            )), '{}')
                            FROM pg_catalog.pg_proc p
                                LEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
                            WHERE n.nspname = s.name
                          )
                        )
                      )
                    )
                  )
                  from schemas s
                )
              )
            -- )
            ;
            `;

            // clog('LET US EXEC SQL', pgClient)
            const result = await pgClient.query(sql, []);
            console.log('result', result.rows[0].jsonb_build_object)

            await pgClient.query("RELEASE SAVEPOINT graphql_mutation");

            return result.rows[0].jsonb_build_object;
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

module.exports = GetSchemaTreePlugin


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
