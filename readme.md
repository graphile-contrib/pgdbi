# postgraphile-db-inspector-extension

```
yarn add postgraphile-db-inspector-extension
```

Use as a server plugin; e.g.

```
postgraphile --plugins postgraphile-db-inspector-extensions -c my_db
```

or

```
const pgdbi = require('postgraphile-db-inspector-extension')
const {postgraphile, makePluginHook} = require("postgraphile");
const pluginHook = makePluginHook([pgdbi]);

app.use(postgraphile(connectionString, schemas, {
  pluginHook,
  enablePgdbi: true
}))
```

In library mode you must enable pgdbi in PostGraphile options:
```
enablePgdbi: true,
```

You can access pgdbi at the `/pgdbi` sub path, e.g. [http://localhost:5000/pgdbi](http://localhost:5000/pgdbi).

