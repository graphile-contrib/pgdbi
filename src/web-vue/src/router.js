import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import Table from './components/Table/Table.vue'
import Function from './components/Function.vue'
import Security from './components/Security/SecurityPolicy.vue'
import SecurityReview from './components/Security/SecurityReview.vue'
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
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/security',
      name: 'security',
      component: Security
    },
    {
      path: '/security-review',
      name: 'security-review',
      component: SecurityReview
    },
    {
      path: '/settings',
      name: 'settings',
      component: Settings
    },
    {
      path: '/table/:id',
      name: 'table',
      component: Table,
      props: true
    },
    {
      path: '/function/:id',
      name: 'function',
      component: Function,
      props: true
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import(/* webpackChunkName: "about" */ './views/About.vue')
    }
  ]
})
