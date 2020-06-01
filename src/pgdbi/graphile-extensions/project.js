const { makeExtendSchemaPlugin, gql } = require("graphile-utils");
const fs = require('fs')

const PGDBIRCPlugin = makeExtendSchemaPlugin(build => {
  const { pgSql: sql } = build;
  const pgdbiDir = `${process.cwd()}/.pgdbi`
  const projectPath = `${pgdbiDir}/project.json`

  return {
    typeDefs: gql`
    type ProjectPayload {
      project: JSON!
    }

    extend type Query {
      project: ProjectPayload
    }
  `,
  resolvers: {
      Query: {
        project: async (
          _query,
          args,
          context,
          resolveInfo,
          { selectGraphQLResultFromTable }
        ) => {
          try {
            const exists = fs.existsSync(projectPath)
            if (!exists) {
              throw new Error('Project file does not exist')
            }

            const project = fs.readFileSync(projectPath)
            
            return {
              project: JSON.parse(project)
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
