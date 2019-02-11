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
const disableDefaultMutations = process.env.DISABLE_DEFAULT_MUTATIONS === 'true'
const watchPg = process.env.WATCH_PG === 'true'
const enablePgDbInspector = process.env.ENABLE_PGDBI === 'true'


const app = express();

app.use(postgraphile(
  connection
  ,schemas
  ,{
    dynamicJson: dynamicJson
    ,showErrorStack: true
    ,extendedErrors: ['severity', 'code', 'detail', 'hint', 'positon', 'internalPosition', 'internalQuery', 'where', 'schema', 'table', 'column', 'dataType', 'constraint', 'file', 'line', 'routine']
    ,disableDefaultMutations: disableDefaultMutations
    ,appendPlugins: plugins
    ,watchPg: watchPg
    ,graphileBuildOptions: {
      enablePgDbInspector: enablePgDbInspector
    }
  }
));

app.listen(port)

console.log(`listening on ${port}`)