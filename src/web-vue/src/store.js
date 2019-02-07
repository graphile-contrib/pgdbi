import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

export default new Vuex.Store({
  plugins: [createPersistedState()],
  state: {
    schemaFilter: [],
    roleFilter: []
  },
  mutations: {
    schemaFilter (state, payload) {
      state.schemaFilter = payload.schemaFilter
    },
    roleFilter (state, payload) {
      state.roleFilter = payload.roleFilter
    },
  },
  actions: {

  }
})
