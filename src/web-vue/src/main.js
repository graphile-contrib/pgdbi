import Vue from 'vue';
import vuetify from './plugins/vuetify';
import App from './App.vue';
import router from './router';
import store from './store/store';
import { createProvider } from './vue-apollo';
import VueClipboard from 'vue-clipboard2';

Vue.config.productionTip = false;

Vue.use(VueClipboard);

new Vue({
  vuetify,
  router,
  store,
  apolloProvider: createProvider(),
  render: h => h(App),
}).$mount('#app');
