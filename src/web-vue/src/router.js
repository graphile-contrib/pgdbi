import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import Table from './components/Table/Table.vue'
import Function from './components/Function.vue'
import Security from './components/Security/SecurityPolicy.vue'
// import Security from './components/Security/Security.vue'
import Settings from './components/Settings/Settings.vue'

Vue.use(Router)

export default new Router({
  routes: [
    // {
    //   path: '/',
    //   name: 'home',
    //   component: Home
    // },
    // {
    //   path: '/security',
    //   name: 'security',
    //   component: Security
    // },
    // {
    //   path: '/table/:id',
    //   name: 'table',
    //   component: Table,
    //   props: true
    // },
    // {
    //   path: '/function/:id',
    //   name: 'function',
    //   component: Function,
    //   props: true
    // },
    // {
    //   path: '/about',
    //   name: 'about',
    //   // route level code-splitting
    //   // this generates a separate chunk (about.[hash].js) for this route
    //   // which is lazy-loaded when the route is visited.
    //   component: () => import(/* webpackChunkName: "about" */ './views/About.vue')
    // },





    {
      path: '/pg-db-inspector/',
      name: 'home',
      component: Home
    },
    {
      path: '/pg-db-inspector/security',
      name: 'security',
      component: Security
    },
    {
      path: '/pg-db-inspector/settings',
      name: 'settings',
      component: Settings
    },
    {
      path: '/pg-db-inspector/table/:id',
      name: 'table',
      component: Table,
      props: true
    },
    {
      path: '/pg-db-inspector/function/:id',
      name: 'function',
      component: Function,
      props: true
    },
    {
      path: '/pg-db-inspector/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import(/* webpackChunkName: "about" */ './views/About.vue')
    }
  ]
})
