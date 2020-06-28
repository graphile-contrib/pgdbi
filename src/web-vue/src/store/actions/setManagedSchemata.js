async function setManagedSchemata({commit}, payload) {
  await commit('setManagedSchemata', payload.schemaTree)
  commit('setPgdbiOptions', payload.pgdbiOptions)
  commit('setExistingRlsPolicies', payload.rlsPolicies)
}

export default setManagedSchemata;
