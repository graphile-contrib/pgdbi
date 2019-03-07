const express = require("express");
const path = require("path")
const {postgraphile} = require("postgraphile");
const opn = require('opn')

const plugins = [
  require('./graphile-extensions/dbSchema'),
  require('postgraphile-plugin-connection-filter')
]

const connection = process.env.POSTGRES_CONNECTION
const pgdbiPort = process.env.PGDBI_PORT || 6099
const schemas = [ 'information_schema' ] //[ 'pde' ]
const disableDefaultMutations = false
const watchPg = false //process.env.WATCH_PG === 'true'

function PostgraphileDE(builder, options) {
  const app = express();

  app.use(express.static(path.join(`${__dirname}`, `dist`)))
  
  app.get('/', (req, res) => {
    res.redirect(`/dist/index.html`)
  })

  app.use(postgraphile(
    connection
    ,schemas
    ,{
      dynamicJson: true
      ,enableCors: true
      ,showErrorStack: true
      ,extendedErrors: ['severity', 'code', 'detail', 'hint', 'positon', 'internalPosition', 'internalQuery', 'where', 'schema', 'table', 'column', 'dataType', 'constraint', 'file', 'line', 'routine']
      ,disableDefaultMutations: disableDefaultMutations
      ,appendPlugins: plugins
      ,watchPg: watchPg
      ,graphiql: true
      ,enhanceGraphiql: true
    }
  ));

  app.listen(pgdbiPort)

  console.log(`pg-db-inspector listening on ${pgdbiPort}`)

  opn(`http://localhost:${pgdbiPort}/`)
}

function PostgraphileDELauncher(builder, options) {
  const enablePgDbInspector = options.enablePgDbInspector || false
  if (enablePgDbInspector) {
    console.log('wtf')
    PostgraphileDE(builder, options)
  }
}

module.exports = PostgraphileDELauncher