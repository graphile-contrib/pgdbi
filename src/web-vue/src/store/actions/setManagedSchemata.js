async function setManagedSchemata({commit}, payload) {
  await commit('setManagedSchemata', payload.schemaTree)
  commit('setPgdbiOptions', payload.pgdbiOptions)
}

export default setManagedSchemata;
