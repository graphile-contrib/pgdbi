import Vue from 'vue';
import Router from 'vue-router';
import Home from './views/Home.vue';
import Initialize from './views/Initialize.vue';
import Table from './components/Table/Table.vue';
import Function from './components/Function/Function.vue';
import RoleManagerView from './views/RoleManagerView.vue';
import TableSecurityView from './views/TableSecurityView.vue';
import FunctionSecurityView from './views/FunctionSecurityView.vue';
import SearchView from './views/SearchView.vue';
import Settings from './components/Settings/Settings.vue';
import ForeignKeyIndexView from './views/ForeignKeyIndexView';
import SmartCommentManager from './components/SmartCommentManager/SmartCommentManager';
import ProjectExport from './components/Project/ProjectExport.vue';
import ProjectImport from './components/Project/ProjectImport.vue';
import SqitchView from './views/SqitchView.vue'
import WorkerView from './views/WorkerView.vue'
import Enum from './components/Enum/Enum.vue'
import Udt from './components/Udt/Udt.vue'

import store from './store/store';

Vue.use(Router);

const router = new Router({
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition;
    } else {
      return { x: 0, y: 0 };
    }
  },
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
    },
    {
      path: '/initialize',
      name: 'initialize',
      component: Initialize,
    },
    {
      path: '/role-manager',
      name: 'role-manager',
      component: RoleManagerView,
    },
    {
      path: '/table-security-manager',
      name: 'table-security-manager',
      component: TableSecurityView,
    },
    {
      path: '/function-security-manager',
      name: 'function-security-manager',
      component: FunctionSecurityView,
    },
    {
      path: '/search-view',
      name: 'search-view',
      component: SearchView,
    },
    {
      path: '/fk-index-manager',
      name: 'fk-index-manager',
      component: ForeignKeyIndexView,
    },
    {
      path: '/smart-comment-manager',
      name: 'smart-comment-manager',
      component: SmartCommentManager,
    },
    {
      path: '/settings',
      name: 'settings',
      component: Settings,
    },
    {
      path: '/project-export',
      name: 'project-export',
      component: ProjectExport,
    },
    {
      path: '/project-import',
      name: 'project-import',
      component: ProjectImport,
    },
    {
      path: '/sqitch',
      name: 'sqitch',
      component: SqitchView,
    },
    {
      path: '/worker',
      name: 'worker',
      component: WorkerView,
    },
    {
      path: '/table/:id',
      name: 'table',
      component: Table,
      props: true,
    },
    {
      path: '/function/:id',
      name: 'function',
      component: Function,
      props: true,
    },
    {
      path: '/enum/:id',
      name: 'enum',
      component: Enum,
      props: true,
    },
    {
      path: '/udt/:id',
      name: 'udt',
      component: Udt,
      props: true,
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () =>
        import(/* webpackChunkName: "about" */ './views/About.vue'),
    },
  ],
});

router.beforeEach((to, from, next) => {
  if (store.state.initializing && to.name !== 'initialize') {
    router.push('initialize');
  }
  next();
});
export default router;
