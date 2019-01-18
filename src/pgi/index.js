const express = require("express");
const path = require("path")
const {postgraphile} = require("postgraphile");

const plugins = [
  require('postgraphile-plugin-connection-filter'),
  require('./graphile-extensions/dbSchema')
  // require(`${__dirname}/graphile-extensions/installPde`),
  // require(`${__dirname}/graphile-extensions/devDeploy`),
  // require(`${__dirname}/graphile-extensions/execSql`),
  // require(`${__dirname}/graphile-extensions/releaseToTesting`),
  // require(`${__dirname}/graphile-extensions/releaseToStaging`),
  // require(`${__dirname}/graphile-extensions/releaseToCurrent`),
  // require(`${__dirname}/graphile-extensions/readPdeDirectory`),
]

const connection = process.env.POSTGRES_CONNECTION
const schemas = [ 'information_schema' ] //[ 'pde' ]
const disableDefaultMutations = false
const watchPg = false //process.env.WATCH_PG === 'true'

function PostgraphileDE(builder, options) {
  const app = options.app

  // app.use(express.static(path.join(`${__dirname}`, `dist`)))
  
  // app.get('/', (req, res) => {
  //   res.redirect(`/dist/index.html`)
  //   // res.redirect(`${__dirname}/dist/index.html`)
  // })
  
  app.use(postgraphile(
    connection
    ,schemas
    ,{
      dynamicJson: true
      ,showErrorStack: true
      ,extendedErrors: ['severity', 'code', 'detail', 'hint', 'positon', 'internalPosition', 'internalQuery', 'where', 'schema', 'table', 'column', 'dataType', 'constraint', 'file', 'line', 'routine']
      ,disableDefaultMutations: disableDefaultMutations
      ,appendPlugins: plugins
      ,watchPg: watchPg
      ,graphqlRoute: '/pg-inspector-graphql'
    }
  ));
}

module.exports = PostgraphileDE