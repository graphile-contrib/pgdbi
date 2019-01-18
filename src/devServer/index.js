require('./.env')
const express = require("express");
const {postgraphile} = require("postgraphile");

const plugins = [
  require('postgraphile-plugin-connection-filter'),
  require('../pgi')
]

const port = process.env.PORT
const connection = process.env.POSTGRES_CONNECTION
const schemas = process.env.POSTGRAPHILE_SCHEMAS.split(',')
const dynamicJson = process.env.DYNAMIC_JSON === 'true'
const pgDefaultRole = process.env.DEFAULT_ROLE
const jwtSecret = process.env.JWT_SECRET
const jwtPgTypeIdentifier = process.env.JWT_PG_TYPE_IDENTIFIER
const extendedErrors = process.env.EXTENDED_ERRORS
const disableDefaultMutations = process.env.DISABLE_DEFAULT_MUTATIONS === 'false'
const enableApolloEngine = process.env.ENABLE_APOLLO_ENGINE === 'true'
const apolloApiKey = process.env.APOLLO_ENGINE_API_KEY
const watchPg = process.env.WATCH_PG === 'true'

const app = express();

app.use(postgraphile(
  connection
  ,schemas
  ,{
    enableCors: true,
    dynamicJson: dynamicJson
    // ,pgDefaultRole: pgDefaultRole
    // ,jwtSecret: jwtSecret
    // ,jwtPgTypeIdentifier: jwtPgTypeIdentifier
    ,showErrorStack: true
    ,extendedErrors: ['severity', 'code', 'detail', 'hint', 'positon', 'internalPosition', 'internalQuery', 'where', 'schema', 'table', 'column', 'dataType', 'constraint', 'file', 'line', 'routine']
    ,disableDefaultMutations: disableDefaultMutations
    ,appendPlugins: plugins
    ,watchPg: watchPg
    ,graphileBuildOptions: {
      app: app
    }
    // ,classicIds: true
  }
));

app.listen(port)

console.log(`listening on ${port}`)