const express = require('express');
const path = require('path');
// const { postgraphile } = require('postgraphile');


// const plugins = [
//   require('./graphile-extensions/dbSchema'),
//   require('postgraphile-plugin-connection-filter'),
//   // require('./graphile-extensions/pgIntrospectionResultsByKind')
// ];

// const schemas = ['information_schema'];
// const disableDefaultMutations = false;
// const watchPg = false;

// function PGDBI(options, pgPool) {
//   const app = express();

//   app.use(
//     '/pgdbi',
//     express.static(path.join(`${__dirname}`, `dist`), {
//       dotfile: 'ignore',
//       fallthrough: true,
//       index: 'index.html',
//       redirect: true,
//     }),
//   );

  
 
//   return {
//     app: app,
//     build: null
//   };
// }
// let pgdbiApp;

let pgdbiApp
const app = express()
app.use(
  '/pgdbi',
  express.static(path.join(`${__dirname}`, `dist`), {
    dotfile: 'ignore',
    fallthrough: true,
    index: 'index.html',
    redirect: true,
  }),
);


const myIntrospectionExtractionPlugin = (pgdbiApp) => (builder) => {
  builder.hook('build', build => {
    pgdbiApp.setBuild(build);
    return build;
  })
}

module.exports = {
  'postgraphile:options'(options, { pgPool }) {
    // Create our app
    pgdbiApp = {};

    pgdbiApp.setBuild = build => {
      this.pgIntrospectionResultsByKind = build.pgIntrospectionResultsByKind
      console.log('boom')
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
      app(incomingReq, res);

      // And abort the normal PostGraphile request processing
      return null;
    } else {
      // Continue as normal
      return incomingReq;
    }
  },
  'pgdbiApp'() {
    return pgdbiApp
  }
};
