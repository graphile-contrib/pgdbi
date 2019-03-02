import Vue from 'vue'
import './plugins/vuetify'
import App from './App.vue'
import router from './router'
import store from './store'
import { createProvider } from './vue-apollo'
import VueClipboard from 'vue-clipboard2'

Vue.config.productionTip = false

Vue.use(VueClipboard)

new Vue({
  router,
  store,
  apolloProvider: createProvider(),
  render: h => h(App)
}).$mount('#app')
