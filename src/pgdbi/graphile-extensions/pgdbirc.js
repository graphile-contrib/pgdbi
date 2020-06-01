const { makeExtendSchemaPlugin, gql } = require("graphile-utils");
const fs = require('fs')
const defaultPgdbirc = require('./pgdbirc-default')

const PGDBIRCPlugin = makeExtendSchemaPlugin(build => {
  const { pgSql: sql } = build;
  const pgdbiDir = `${process.cwd()}/.pgdbi`
  const pgdbircPath = `${pgdbiDir}/.pgdbirc.json`

  fs.mkdirSync(pgdbiDir, {recursive: true})

  const exists = fs.existsSync(pgdbircPath)
  if (!exists) {
    fs.writeFileSync(pgdbircPath, JSON.stringify(defaultPgdbirc,0,2))
  }

  return {
    typeDefs: gql`
    type PGDBIRCPayload {
      pgdbirc: JSON!
    }

    extend type Query {
      PGDBIRC: PGDBIRCPayload
    }
  `,
  resolvers: {
      Query: {
        PGDBIRC: async (
          _query,
          args,
          context,
          resolveInfo,
          { selectGraphQLResultFromTable }
        ) => {
          try {
            const pgdbirc = fs.readFileSync(pgdbircPath)
            
            return {
              pgdbirc: JSON.parse(pgdbirc)
            };
          } catch (e) {
            // Oh noes! If at first you don't succeed,
            // destroy all evidence you ever tried.
            throw e;
          }
        },
      },
    },
  };
});

module.exports = PGDBIRCPlugin
