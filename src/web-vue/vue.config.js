module.exports = {
  publicPath: '/pgdbi/',
  pluginOptions: {
    apollo: {
      enableMocks: false,
      enableEngine: false
    }
  },
  devServer: {
    proxy: {
      "/pgdbi/": {
        target: "http://localhost:5099"
      }
    }
  },
  configureWebpack: {
    devtool: 'source-map'
  }
}
