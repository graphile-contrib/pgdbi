const express = require("express");
const path = require("path")
const {postgraphile} = require("postgraphile");

const plugins = [
  require('./graphile-extensions/dbSchema'),
  require('postgraphile-plugin-connection-filter')
]

const schemas = [ 'information_schema' ]
const disableDefaultMutations = false
const watchPg = false

function PostgraphileDE(options, pgPool) {
  const app = express();

  app.use('/pgdbi', express.static(path.join(`${__dirname}`, `dist`), {
    dotfile: 'ignore',
    fallthrough: true,
    index: 'index.html',
    redirect: true
  }))

  app.use(postgraphile(
    options.ownerConnectionString || pgPool
    ,schemas
    ,{
      graphqlRoute: '/pgdbi/graphql'
      ,graphiqlRoute: '/pgdbi/graphiql'
      ,dynamicJson: true
      ,showErrorStack: true
      ,extendedErrors: ['severity', 'code', 'detail', 'hint', 'positon', 'internalPosition', 'internalQuery', 'where', 'schema', 'table', 'column', 'dataType', 'constraint', 'file', 'line', 'routine']
      ,disableDefaultMutations: disableDefaultMutations
      ,appendPlugins: plugins
      ,watchPg: watchPg
      ,graphiql: true
      ,enhanceGraphiql: true
    }
  ));
  return app;
}

let pgdbiApp;

module.exports = {
  'postgraphile:options'(options, {pgPool}) {
    // Create our app
    pgdbiApp = PostgraphileDE(options, pgPool)

    // Must always return from a hook function
    return options;
  },
  'postgraphile:http:handler'(incomingReq, {options, res, next}) {
    if (pgdbiApp && (incomingReq.url === '/pgdbi' || incomingReq.url.startsWith('/pgdbi/'))) {
      // This is for us! Forward to our express app
      pgdbiApp(incomingReq, res);

      // And abort the normal PostGraphile request processing
      return null;
    } else {
      // Continue as normal
      return incomingReq;
    }
  }
}
