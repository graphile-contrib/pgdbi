import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

export default new Vuex.Store({
  plugins: [createPersistedState()],
  state: {
    schemaFilter: [],
    roleFilter: [],
    selectedRoleFamilies: [],
    familyPolicySets: [],
    defaultRLSQual: '(auth_fn.app_user_has_access(app_tenant_id) = true)'
  },
  mutations: {
    schemaFilter (state, payload) {
      state.schemaFilter = payload.schemaFilter
    },
    roleFilter (state, payload) {
      state.roleFilter = payload.roleFilter
    },
    selectedRoleFamilies (state, payload) {
      state.selectedRoleFamilies = payload.selectedRoleFamilies
    },
    familyPolicySets (state, payload) {
      state.familyPolicySets = payload.familyPolicySets
    },
    defaultRLSQual (state, payload) {
      state.defaultRLSQual = payload.defaultRLSQual
    }
  },
  actions: {

  }
})
