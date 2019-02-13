module.exports = {
  pluginOptions: {
    apollo: {
      enableMocks: true,
      enableEngine: false
    }
  },
  devServer: {
    proxy: {
      "/pg-inspector-graphql": {
        target: "http://localhost:6099"
      }
    }
  }
}