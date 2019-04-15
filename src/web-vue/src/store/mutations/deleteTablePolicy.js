function deleteTablePolicy(state, payload) {
  const policyDefinitionId = payload.policyDefinitionId

  const otherPolicies = state.policies.filter(p => p.id !== policyDefinitionId)

  state.policies = [...otherPolicies].sort(function(a,b){ return a.id < b.id})

  state.managedSchemata = state.managedSchemata.map(
    schema => {
      return {
        ...schema,
        schemaTables: schema.schemaTables.map(
          table => {
            return {
              ...table,
              policyDefinitionId: state.defaultPolicy.id
            }
          }
        )
      }
    }
  )
}

export default deleteTablePolicy