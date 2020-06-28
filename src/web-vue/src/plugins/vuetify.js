import Vue from 'vue';
import Vuetify from 'vuetify/lib';
// import 'material-design-icons-iconfont/dist/material-design-icons.css'
import '@mdi/font/css/materialdesignicons.css' // Ensure you are using css-loader

Vue.use(Vuetify);

export default new Vuetify({
  icons: {
    iconfont: 'mdi',
  },
  // theme: {
  //   primary: '#2196f3',
  //   secondary: '#3f51b5',
  //   accent: '#03a9f4',
  //   error: '#f44336',
  //   warning: '#ffc107',
  //   info: '#607d8b',
  //   success: '#4caf50'
  // },
  // theme: {
  //   themes: {
  //     dark: {
  //       primary: '#2196f3',
  //       secondary: '#3f51b5',
  //       accent: '#03a9f4',
  //       error: '#f44336',
  //       warning: '#ffc107',
  //       info: '#607d8b',
  //       success: '#4caf50'
  //     }    
  //   }
  // }
});
