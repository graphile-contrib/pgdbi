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
  pgdbiOptions: {
    enable: true,            // true to enable pgdbi
    connection: connection,  // will throw an error if missing
    port: 5678               // optional - will default to 5678
  }
}
```

this will expose pgdbi on port 5678