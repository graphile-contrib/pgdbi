const express = require('express');
const path = require('path');

let pgdbiApp = express()


const myIntrospectionExtractionPlugin = (pgdbiApp) => (builder) => {
  builder.hook('build', build => {
    pgdbiApp.setBuild(build);
    return build;

  })
}

module.exports = {
  'postgraphile:options'(options, { pgPool }) {
    // Create our app
    // pgdbiApp = express();

    pgdbiApp.use(
      '/pgdbi',
      express.static(path.join(`${__dirname}`, `dist`), {
        dotfile: 'ignore',
        fallthrough: true,
        index: 'index.html',
        redirect: true,
      }),
    );

    // pgdbiApp.setBuild = build => {
    //   console.log(Object.keys(build));
    
    // }

    // Must always return from a hook function
    return {
      ...options,
      appendPlugins: [
        ...module(options.appendPlugins || []),
        
        // myIntrospectionExtractionPlugin(pgdbiApp)
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
};
