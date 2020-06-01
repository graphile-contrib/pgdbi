const { makeExtendSchemaPlugin, gql } = require("graphile-utils");
const fs = require('fs')
const pglint = require('pglint').pglint
const defaultPglintrc = require('./pglintrc-default')

const PgLintPlugin = makeExtendSchemaPlugin(build => {
  const { pgSql: sql } = build;
  const pgdbiDir = `${process.cwd()}/.pgdbi`
  const pgLintrcPath = `${pgdbiDir}/.pglintrc.json`

  fs.mkdirSync(pgdbiDir, {recursive: true})

  const exists = fs.existsSync(pgLintrcPath)
  if (!exists) {
    fs.writeFileSync(pgLintrcPath, JSON.stringify(defaultPglintrc,0,2))
  }

  return {
    typeDefs: gql`
    input PgLintInput {
      clientMutationId: String
      token: String!
      project: String!
    }

    type PgLintPayload {
      result: JSON!
    }

    type PgLintConfigPayload {
      pglintrc: JSON!
    }

    extend type Query {
      pglintrc: PgLintConfigPayload
    }

    extend type Mutation {
      PgLint(input: PgLintInput!): PgLintPayload
    }
  `,
  resolvers: {
      Query: {
        pglintrc: async (
          _mutation,
          args,
          context,
          resolveInfo,
          { selectGraphQLResultFromTable }
        ) => {
          try {
            const pglintrc = fs.readFileSync(pgLintrcPath)
            
            return {
              pglintrc: JSON.parse(pglintrc)
            };
          } catch (e) {
            // Oh noes! If at first you don't succeed,
            // destroy all evidence you ever tried.
            throw e;
          }
        }
      },
      Mutation: {
        PgLint: async (
          _mutation,
          args,
          context,
          resolveInfo,
          { selectGraphQLResultFromTable }
        ) => {
          const { pgClient } = context;
          try {
            const result = await pglint({
              connectionString: process.env.POSTGRES_CONNECTION,
              project:  args.input.project,
              token: args.input.token
            })

            fs.writeFileSync(pgLintrcPath, JSON.stringify({
              token: args.input.token,
              project: args.input.project
            },0,2))

            const parsed = result.text
              .split('\n')
              .map(t => t.trim())
              .filter(t => t !== null && t !== undefined && t !== '')

            const checks = parsed.find(t => t.indexOf('checks') > -1).split(', ')[1].replace('running', '')

            return {
              result: {
                rawResult: result,
                status: result.status,
                url: parsed.slice(-1)[0],
                id: parsed.slice(-1)[0].split('/').slice(-1)[0],
                errors: parsed.find(t => t.indexOf('errors') > -1),
                warnings: parsed.find(t => t.indexOf('warnings') > -1),
                checks: checks
              }
            };
          } catch (e) {
            // Oh noes! If at first you don't succeed,
            // destroy all evidence you ever tried.
            throw e;
          }
        }
      }
    }
  };
});

module.exports = PgLintPlugin


// the above was built from the below
// https://www.graphile.org/postgraphile/make-extend-schema-plugin/
