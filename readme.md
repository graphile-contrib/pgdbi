# postgraphile-db-inspector-extension

```
yarn add postgraphile-db-inspector-extension
```

or 

```
npm install -S postgraphile-db-inspector-extension
```

```
require('postgraphile-db-inspector-extension')
```

enable pgdbi in graphileBuildOptions
```
    graphileBuildOptions: {
      enablePgDbInspector: true
    }
```

this will expose pgdbi on port 5678