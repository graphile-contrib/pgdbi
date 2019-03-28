# postgraphile-db-inspector-extension

```
yarn add postraphile-db-inspector-extension
```

or 

```
npm install -S postraphile-db-inspector-extension
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