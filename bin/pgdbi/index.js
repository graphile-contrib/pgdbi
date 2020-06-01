const express = require('express');
const path = require('path');
const { postgraphile } = require('postgraphile');
const transformBuild = require('./transformBuild')

const plugins = [
  require('./graphile-extensions/pgdbirc'),
  require('./graphile-extensions/project'),
  require('./graphile-extensions/dbSchema'),
  require('./graphile-extensions/execSql'),
  require('./graphile-extensions/writeArtifacts'),
  require('postgraphile-plugin-connection-filter'),
];

const disableDefaultMutations = false;
const watchPg = false;

function PostgraphileDE(options, pgPool) {
  const enableSqitch = options.pgdbi && options.pgdbi.enableSqitch === true
  const enableGraphileWorker = options.pgdbi && options.pgdbi.enableGraphileWorker === true

  // const schemas = `information_schema${enableSqitch ? ',sqitch' : ''}`.split(',')
  let schemas = ['information_schema']
  schemas = enableGraphileWorker ? [...schemas, 'graphile_worker'] : schemas
  schemas = enableSqitch ? [...schemas, 'sqitch'] : schemas

  const app = express();

  app.use(
    '/pgdbi',
    express.static(path.join(`${__dirname}`, `dist`), {
      dotfile: 'ignore',
      fallthrough: true,
      index: 'index.html',
      redirect: true,
    }),
  );

  app.use(
    postgraphile(options.ownerConnectionString || pgPool, schemas, {
      graphqlRoute: '/pgdbi/graphql',
      graphiqlRoute: '/pgdbi/graphiql',
      dynamicJson: true,
      showErrorStack: true,
      bodySizeLimit: '5MB',
      extendedErrors: [
        'severity',
        'code',
        'detail',
        'hint',
        'positon',
        'internalPosition',
        'internalQuery',
        'where',
        'schema',
        'table',
        'column',
        'dataType',
        'constraint',
        'file',
        'line',
        'routine',
      ],
      disableDefaultMutations: disableDefaultMutations,
      appendPlugins: plugins,
      watchPg: watchPg,
      graphiql: true,
      enhanceGraphiql: true,
    }),
  );
  return app;
}

let pgdbiApp;

const myIntrospectionExtractionPlugin = (pgdbiApp) => (builder) => {
  builder.hook('build', build => {
    pgdbiApp.setBuild(build);
    return build;
  })
}

module.exports = {
  'postgraphile:options'(options, { pgPool }) {
    // Create our app
    pgdbiApp = PostgraphileDE(options, pgPool);
    pgdbiApp.pdgbiOptions = options.pgdbi || {}

    pgdbiApp.setBuild = build => {
      pgdbiApp.schemaTree = transformBuild(build, pgPool)
    }

    // Must always return from a hook function
    return {
      ...options,
      appendPlugins: [
        ...(options.appendPlugins || []),
        
        myIntrospectionExtractionPlugin(pgdbiApp)
      ]}
      ;
  },
  'postgraphile:http:handler'(incomingReq, { options, res, next }) {
    if (
      pgdbiApp &&
      (incomingReq.url === '/pgdbi' || incomingReq.url.startsWith('/pgdbi/'))
    ) {
      // This is for us! Forward to our express app
      pgdbiApp(incomingReq, res);

      // And abort the normal PostGraphile request processing
      return null;
    } else {
      // Continue as normal
      return incomingReq;
    }
  },
  schemaTree() {
    return pgdbiApp.schemaTree
  },
  pdgbiOptions() {
    return pgdbiApp.pdgbiOptions
  }
};