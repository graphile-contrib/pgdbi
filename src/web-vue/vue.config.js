module.exports = {
  publicPath: '/pgdbi',
  pluginOptions: {
    apollo: {
      enableMocks: false,
      enableEngine: false
    }
  },
  devServer: {
    // proxy: {
    //   "/pg-inspector-graphql": {
    //     target: "http://localhost:6099"
    //   }
    // }
  },
  configureWebpack: {
    devtool: 'source-map'
  }
}
