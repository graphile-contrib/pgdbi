const { makeExtendSchemaPlugin, gql } = require("graphile-utils");
const fs = require('fs')
const rimraf = require('rimraf')

const WriteArtifactsPlugin = makeExtendSchemaPlugin(build => {
  const { pgSql: sql } = build;
  return {
    typeDefs: gql`
    input WriteArtifactsInput {
      clientMutationId: String
      projectState: JSON!
      masterSecurityPolicy: String!
      ownershipPolicy: String!
      schemaUsageSql: String!
      masterTablePolicy: String!
      masterFunctionPolicy: String!
    }

    type WriteArtifactsPayload {
      result: JSON!
    }

    extend type Mutation {
      WriteArtifacts(input: WriteArtifactsInput!): WriteArtifactsPayload
    }
  `,
  resolvers: {
      Mutation: {
        WriteArtifacts: async (
          _mutation,
          args,
          context,
          resolveInfo,
          { selectGraphQLResultFromTable }
        ) => {
          try {
            const projectState = args.input.projectState
            const pgdbiDir = `${process.cwd()}/.pgdbi`
            const projectJsonPath = `${pgdbiDir}/project.json`
            const artifactsPath = `${pgdbiDir}/artifacts`

            await fs.writeFileSync(projectJsonPath, JSON.stringify(projectState,0,2))

            await rimraf.sync(artifactsPath)
            await fs.mkdirSync(artifactsPath)

            fs.writeFileSync(`${artifactsPath}/masterSecurityPolicy.sql`, args.input.masterSecurityPolicy)
            fs.writeFileSync(`${artifactsPath}/ownershipPolicy.sql`, args.input.ownershipPolicy)
            fs.writeFileSync(`${artifactsPath}/schemaUsageSql.sql`, args.input.schemaUsageSql)
            fs.writeFileSync(`${artifactsPath}/masterTablePolicy.sql`, args.input.masterTablePolicy)
            fs.writeFileSync(`${artifactsPath}/masterFunctionPolicy.sql`, args.input.masterFunctionPolicy)

            return {
              result: 'pizza'
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

module.exports = WriteArtifactsPlugin


// the above was built from the below
// https://www.graphile.org/postgraphile/make-extend-schema-plugin/
