import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import Initialize from './views/Initialize.vue'
import Table from './components/Table/Table.vue'
import Function from './components/Function.vue'
import TableSecurityView from './views/TableSecurityView.vue'
import Settings from './components/Settings/SecurityPolicySettings.vue'
import ForeignKeyIndexManager from './components/ForeignKeyIndexManager/ForeignKeyIndexManager'
import SmartCommentManager from './components/SmartCommentManager/SmartCommentManager'
import FunctionSecurityManager from './components/FunctionSecurityManager/FunctionSecurityManager'

import store from './store'

Vue.use(Router)

const router = new Router({
  scrollBehavior (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 }
    }
  },
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/initialize',
      name: 'initialize',
      component: Initialize
    },
    {
      path: '/table-security-manager',
      name: 'table-security-manager',
      component: TableSecurityView
    },
    {
      path: '/fk-index-manager',
      name: 'fk-index-manager',
      component: ForeignKeyIndexManager
    },
    {
      path: '/smart-comment-manager',
      name: 'smart-comment-manager',
      component: SmartCommentManager
    },
    {
      path: '/function-security-manager',
      name: 'function-security-manager',
      component: FunctionSecurityManager
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

router.beforeEach((to, from, next) => {
  if (store.state.managedSchemata.length === 0 && to.name !== 'initialize') {
    router.push('initialize')
  }
  next()
})
export default router