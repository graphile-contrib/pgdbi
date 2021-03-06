# @graphile-contrib/pgdbi

## Installation

```
yarn add @graphile-contrib/pgdbi
```

## Usage

Currently recommended for development only; to disable in production, do not
load this plugin.

This is a [PostGraphile Server Plugin](https://www.graphile.org/postgraphile/plugins/) so you can follow the standard server plugin instructions, namely:

For the CLI, use `--plugins` to load the plugin (and remember this flag must come at the very start!)

```
postgraphile --plugins @graphile-contrib/pgdbis -c my_db
```

For PostGraphile as a library/middleware, you must use the plugin hook functionality:

```js
const pgdbi = require('@graphile-contrib/pgdbi');
const { postgraphile, makePluginHook } = require('postgraphile');

const pluginHook = makePluginHook([
  pgdbi,
  /* other server plugins can be added here */
]);

app.use(
  postgraphile(connectionString, schemas, {
    pluginHook,
  }),
);
```

You can access pgdbi at the `/pgdbi` sub path, e.g. [http://localhost:5000/pgdbi](http://localhost:5000/pgdbi).
