import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import mutations from './mutations/mutations'
import defaultState from './defaultState'
import orm from './orm/orm'

Vue.use(Vuex)

export default new Vuex.Store({
  plugins: [createPersistedState(), orm],
  state: defaultState,
  mutations: mutations,
  actions: {}
})
