try {
  require('./.env');
} catch (e) {
  // No envvars 🤷
}
const { postgraphile, makePluginHook } = require('postgraphile');

const plugins = [
  // require('postgraphile-plugin-connection-filter'),
];

const isProd = process.env.NODE_ENV === 'production';

const {
  POSTGRES_CONNECTION,
  POSTGRAPHILE_SCHEMAS = 'public',
  DYNAMIC_JSON = 'true',
  DISABLE_DEFAULT_MUTATIONS = null,
  WATCH_PG = isProd ? null : 'true',
  ENABLE_PGDBI = isProd ? null : 'true',
} = process.env;

if (!POSTGRES_CONNECTION) {
  throw new Error(
    "No 'POSTGRES_CONNECTION' envvar found, we don't know which database to connect to.",
  );
}

const identity = _ => _;

const connection = POSTGRES_CONNECTION;
const schemas = POSTGRAPHILE_SCHEMAS.split(',');
const dynamicJson = DYNAMIC_JSON === 'true';
const disableDefaultMutations = DISABLE_DEFAULT_MUTATIONS === 'true';
const watchPg = WATCH_PG === 'true';
const enablePgdbi = ENABLE_PGDBI === 'true';

const pluginHook = makePluginHook(
  [enablePgdbi ? require('../pgdbi') : null].filter(identity),
);

const phile =  postgraphile(connection, schemas, {
  pluginHook,
  dynamicJson: dynamicJson,
  showErrorStack: true,
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
})

module.exports = phile