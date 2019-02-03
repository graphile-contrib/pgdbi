const express = require("express");
const path = require("path")
const {postgraphile} = require("postgraphile");

const plugins = [
  require('postgraphile-plugin-connection-filter'),
  require('./graphile-extensions/dbSchema')
]

const connection = process.env.POSTGRES_CONNECTION
const pgdbiPort = process.env.PGDBI_PORT
const schemas = [ 'information_schema' ] //[ 'pde' ]
const disableDefaultMutations = false
const watchPg = false //process.env.WATCH_PG === 'true'

function PostgraphileDE(builder, options) {
  const app = express();

  app.use(express.static(path.join(`${__dirname}`, `dist`)))
  
  app.get('/pg-db-inspector', (req, res) => {
    res.redirect(`${__dirname}/dist/index.html`)
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
      ,graphqlRoute: '/pg-inspector-graphql'
    }
  ));

  app.listen(pgdbiPort)

  console.log(`pg-db-inspector listening on ${pgdbiPort}`)
}

function PostgraphileDELauncher(builder, options) {
  const enablePgDbInspector = options.enablePgDbInspector || false
  if (enablePgDbInspector) {
    PostgraphileDE(builder, options)
  }
}

module.exports = PostgraphileDELauncher